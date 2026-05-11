cask "ducktype" do
  version "0.45.0"
  sha256 "8f040d51047b47c061f18f3bd95d6156f2b081172101b13a123a26f5e5509923"

  url "https://updates.duck-type.com/stable/v#{version}/DuckType.dmg"
  name "DuckType"
  desc "Voice-to-text dictation and meeting transcription app"
  homepage "https://duck-type.com/"

  livecheck do
    url "https://updates.duck-type.com/stable/latest-darwin-aarch64.json"
    strategy :json do |json|
      json["version"]
    end
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: ">= :big_sur"

  app "DuckType.app"
  binary "#{appdir}/DuckType.app/Contents/MacOS/ducktype-cli"

  uninstall launchctl:  "DuckType",
            quit:       "com.duck-type",
            delete:     "~/Library/LaunchAgents/DuckType.plist",
            on_upgrade: :quit

  zap trash: "~/Library/Preferences/com.duck-type.plist"

  caveats <<~EOS
    DuckType stores your dictations, recordings, settings, models, and logs in:
      ~/.ducktype

    Homebrew uninstall and zap leave this folder in place so your data is not
    deleted accidentally. Delete it manually only if you want to permanently
    remove your local DuckType data.
  EOS
end
