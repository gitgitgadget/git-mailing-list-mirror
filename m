From: =?ISO-2022-JP?B?GyRCMC1LYkxuNkxDY0w1GyhC?= 
	<devil.tamachan@gmail.com>
Subject: [PATCH 4/4] Update Japanese translation (Git-gui)
Date: Fri, 19 Jul 2013 02:15:50 +0900
Message-ID: <CAPM==H+fCx3k-iL2x4GQLtVxg662CqiPuD0g4v2+_a8MTrG4gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 18 19:15:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzro4-0004ei-0y
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 19:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933013Ab3GRRPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 13:15:52 -0400
Received: from mail-ve0-f182.google.com ([209.85.128.182]:61255 "EHLO
	mail-ve0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932394Ab3GRRPv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 13:15:51 -0400
Received: by mail-ve0-f182.google.com with SMTP id ox1so2695115veb.41
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 10:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=ltn+sHYEEJKXMnLlmeyPSX8JnrTfmJ9fcy9O++g8aYU=;
        b=AwUikrARWVTTIIfJ/7PW3ZJXpaUGDaD5dKoM+fryNqWFKn90w6UG2SJP71UQsdngrF
         0LMMN5G7T2Bavo+ZeKWQNZd9P3Mfe5ZRFBi+a2q07gPC71vaXr8oMYzMRgMmBrFotP8y
         LilPn3AHq6S31Wce/czUmWDSUsldqnXOUgg+hNxbMJRCOhX4QsArig6fTwR01TmqSlnc
         SAgEShqsjY0b637/LAQngRLnG/zUjJDSheENnQoDUHMJE3+FaZ0yvhmwOWxT4hzQMoMR
         kFFI23dZ8A0XprXxZetb5H5XxbjXguwfDi5RZPFk9CpxEU0xnx9nXHG22MYTq/KmrcVK
         TSig==
X-Received: by 10.59.0.2 with SMTP id au2mr4387784ved.83.1374167750452; Thu,
 18 Jul 2013 10:15:50 -0700 (PDT)
Received: by 10.221.24.7 with HTTP; Thu, 18 Jul 2013 10:15:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230706>

Signed-off-by: Yamada Saburo <devil.tamachan@gmail.com>
---
 git-gui/po/ja.po | 153 ++++++++++++++++++++++++++-----------------------------
 1 file changed, 73 insertions(+), 80 deletions(-)

diff --git a/git-gui/po/ja.po b/git-gui/po/ja.po
index 0bbe504..05215b9 100644
--- a/git-gui/po/ja.po
+++ b/git-gui/po/ja.po
@@ -7,14 +7,17 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2013-07-10 02:45+0900\n"
+"POT-Creation-Date: 2013-07-10 03:38+0900\n"
 "PO-Revision-Date: 2010-02-02 19:03+0900\n"
-"Last-Translator: しらいし ななこ <nanako3@lavabit.com>\n"
+"Last-Translator: しらいし ななこ <nanako3@lavabit.com>, Yamada Saburo
<devil.tamachan@gmail.com>\n"
 "Language-Team: Japanese\n"
 "Language: \n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=UTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
+"Plural-Forms: nplurals=1; plural=0;\n"
+"X-Language: ja_JP\n"
+"X-Source-Language: C\n"

 #: git-gui.sh:859
 #, tcl-format
@@ -29,8 +32,8 @@ msgstr "主フォント"
 msgid "Diff/Console Font"
 msgstr "diff/コンソール・フォント"

-#: git-gui.sh:926 git-gui.sh:940 git-gui.sh:953 git-gui.sh:1043
-#: git-gui.sh:1062 git-gui.sh:3094
+#: git-gui.sh:926 git-gui.sh:940 git-gui.sh:953 git-gui.sh:1043 git-gui.sh:1062
+#: git-gui.sh:3094
 msgid "git-gui: fatal error"
 msgstr "git-gui: 致命的なエラー"

@@ -124,26 +127,23 @@ msgstr "コミット予定済、ファイル無し"

 #: git-gui.sh:2087
 msgid "File type changed, not staged"
-msgstr "ファイル型変更、コミット未予定"
+msgstr "ファイルタイプ変更、コミット未予定"

 #: git-gui.sh:2088 git-gui.sh:2089
-#, fuzzy
 msgid "File type changed, old type staged for commit"
-msgstr "ファイル型変更、コミット未予定"
+msgstr "ファイルタイプ変更、コミット予定の形式が古い"

 #: git-gui.sh:2090
 msgid "File type changed, staged"
-msgstr "ファイル型変更、コミット予定済"
+msgstr "ファイルタイプ変更、コミット予定済"

 #: git-gui.sh:2091
-#, fuzzy
 msgid "File type change staged, modification not staged"
-msgstr "ファイル型変更、コミット未予定"
+msgstr "ファイルタイプの変更はコミット予定済、内容の変更はコミット未予定"

 #: git-gui.sh:2092
-#, fuzzy
 msgid "File type change staged, file missing"
-msgstr "ファイル型変更、コミット予定済"
+msgstr "ファイルタイプの変更はコミット予定済、ファイルが見つからない"

 #: git-gui.sh:2094
 msgid "Untracked, not staged"
@@ -403,19 +403,16 @@ msgstr "SSH キーを表示"

 #: git-gui.sh:2983 git-gui.sh:3115
 msgid "Usage"
-msgstr ""
+msgstr "使用状況"

 #: git-gui.sh:3064 lib/blame.tcl:573
-#, fuzzy
 msgid "Error"
 msgstr "エラー"

 #: git-gui.sh:3095
 #, tcl-format
 msgid "fatal: cannot stat path %s: No such file or directory"
-msgstr ""
-"致命的: パス %s が stat できません。そのようなファイルやディレクトリはありま"
-"せん"
+msgstr "致命的: パス %s が stat できません。そのようなファイルやディレクトリはありません"

 #: git-gui.sh:3128
 msgid "Current Branch:"
@@ -614,9 +611,8 @@ msgid "Find Text..."
 msgstr "テキストを検索"

 #: lib/blame.tcl:288
-#, fuzzy
 msgid "Goto Line..."
-msgstr "複製…"
+msgstr "指定行へ移動"

 #: lib/blame.tcl:297
 msgid "Do Full Copy Detection"
@@ -715,12 +711,11 @@ msgstr "ブランチをチェックアウト"
 msgid "Checkout"
 msgstr "チェックアウト"

-#: lib/branch_checkout.tcl:30 lib/branch_create.tcl:37
-#: lib/branch_delete.tcl:34 lib/branch_rename.tcl:32 lib/browser.tcl:292
-#: lib/checkout_op.tcl:579 lib/choose_font.tcl:45 lib/merge.tcl:174
-#: lib/option.tcl:127 lib/remote_add.tcl:34 lib/remote_branch_delete.tcl:43
-#: lib/tools_dlg.tcl:41 lib/tools_dlg.tcl:202 lib/tools_dlg.tcl:345
-#: lib/transport.tcl:141
+#: lib/branch_checkout.tcl:30 lib/branch_create.tcl:37 lib/branch_delete.tcl:34
+#: lib/branch_rename.tcl:32 lib/browser.tcl:292 lib/checkout_op.tcl:579
+#: lib/choose_font.tcl:45 lib/merge.tcl:174 lib/option.tcl:127
+#: lib/remote_add.tcl:34 lib/remote_branch_delete.tcl:43 lib/tools_dlg.tcl:41
+#: lib/tools_dlg.tcl:202 lib/tools_dlg.tcl:345 lib/transport.tcl:141
 msgid "Cancel"
 msgstr "中止"

@@ -970,8 +965,7 @@ msgid ""
 msgstr ""
 "最後にスキャンした状態はリポジトリの状態と合致しません。\n"
 "\n"
-"最後にスキャンして以後、別の Git プログラムがリポジトリを変更しています。現在"
-"のブランチを変更する前に、再スキャンが必要です。\n"
+"最後にスキャンして以後、別の Git プログラムがリポジトリを変更しています。現在のブランチを変更する前に、再スキャンが必要です。\n"
 "\n"
 "自動的に再スキャンを開始します。\n"

@@ -1007,8 +1001,7 @@ msgid ""
 msgstr ""
 "ローカル・ブランチから離れます。\n"
 "\n"
-"ブランチ上に滞まりたいときは、この「分離されたチェックアウト」から新規ブラン"
-"チを開始してください。"
+"ブランチ上に滞まりたいときは、この「分離されたチェックアウト」から新規ブランチを開始してください。"

 #: lib/checkout_op.tcl:503 lib/checkout_op.tcl:507
 #, tcl-format
@@ -1045,8 +1038,7 @@ msgid ""
 msgstr ""
 "現在のブランチを設定できません。\n"
 "\n"
-"作業ディレクトリは部分的にしか切り替わっていません。ファイルの更新には成功し"
-"ましたが、 Git の内部データを更新できませんでした。\n"
+"作業ディレクトリは部分的にしか切り替わっていません。ファイルの更新には成功しましたが、 Git の内部データを更新できませんでした。\n"
 "起こるはずのないエラーです。あきらめて %s を終了します。"

 #: lib/choose_font.tcl:41
@@ -1350,8 +1342,7 @@ msgid ""
 msgstr ""
 "訂正するコミットがそもそもありません。\n"
 "\n"
-"これから作るのは最初のコミットです。その前にはまだ訂正するようなコミットはあ"
-"りません。\n"
+"これから作るのは最初のコミットです。その前にはまだ訂正するようなコミットはありません。\n"

 #: lib/commit.tcl:18
 msgid ""
@@ -1363,8 +1354,7 @@ msgid ""
 msgstr ""
 "マージ中にコミットの訂正はできません。\n"
 "\n"
-"現在はまだマージの途中です。先にこのマージを中止しないと、前のコミットの訂正"
-"はできません\n"
+"現在はまだマージの途中です。先にこのマージを中止しないと、前のコミットの訂正はできません\n"

 #: lib/commit.tcl:48
 msgid "Error loading commit data for amend:"
@@ -1394,8 +1384,7 @@ msgid ""
 msgstr ""
 "最後にスキャンした状態はリポジトリの状態と合致しません。\n"
 "\n"
-"最後にスキャンして以後、別の Git プログラムがリポジトリを変更しています。新し"
-"くコミットする前に、再スキャンが必要です。\n"
+"最後にスキャンして以後、別の Git プログラムがリポジトリを変更しています。新しくコミットする前に、再スキャンが必要です。\n"
 "\n"
 "自動的に再スキャンを開始します。\n"

@@ -1409,8 +1398,7 @@ msgid ""
 msgstr ""
 "マージしていないファイルはコミットできません。\n"
 "\n"
-"ファイル %s にはマージ衝突が残っています。まず解決してコミット予定に加える必"
-"要があります。\n"
+"ファイル %s にはマージ衝突が残っています。まず解決してコミット予定に加える必要があります。\n"

 #: lib/commit.tcl:181
 #, tcl-format
@@ -1468,6 +1456,11 @@ msgid ""
 " \n"
 " Do you really want to proceed with your Commit?"
 msgstr ""
+"あなたはdetached "
+"head状態でコミットしようとしています。これは危険な操作です。もし続行すれば、他ブランチへ切り替えた際に変更を失ったり、reflogで変更を復元することが困難になります。あなたは次の操作をするべきです。1.
"
+"このコミットをキャンセルする。2. 新しいブランチを作り、コミットし直す。\n"
+"\n"
+"本当にこの危険なコミットを実行しますか？"

 #: lib/commit.tcl:290
 msgid "Calling commit-msg hook..."
@@ -1611,8 +1604,7 @@ msgstr ""
 "\n"
 "%s には変更がありません。\n"
 "\n"
-"このファイルの変更時刻は他のアプリケーションによって更新されていますがファイ"
-"ル内容には変更がありません。\n"
+"このファイルの変更時刻は他のアプリケーションによって更新されていますがファイル内容には変更がありません。\n"
 "\n"
 "同様な状態のファイルを探すために、自動的に再スキャンを開始します。"

@@ -1736,9 +1728,7 @@ msgstr "索引エラー"
 msgid ""
 "Updating the Git index failed.  A rescan will be automatically started to "
 "resynchronize git-gui."
-msgstr ""
-"GIT インデックスの更新が失敗しました。git-gui と同期をとるために再スキャンし"
-"ます。"
+msgstr "GIT インデックスの更新が失敗しました。git-gui と同期をとるために再スキャンします。"

 #: lib/index.tcl:30
 msgid "Continue"
@@ -1765,7 +1755,7 @@ msgstr "コミットに %s を加えています"
 #: lib/index.tcl:380
 #, tcl-format
 msgid "Stage %d untracked files?"
-msgstr ""
+msgstr "%d 個の新規ファイルがあります。コミット予定してもいいですか？"

 #: lib/index.tcl:428
 #, tcl-format
@@ -1796,11 +1786,11 @@ msgstr "%s にした変更を元に戻します"

 #: lib/line.tcl:17
 msgid "Goto Line:"
-msgstr ""
+msgstr "指定行へ移動:"

 #: lib/line.tcl:23
 msgid "Go"
-msgstr ""
+msgstr "移動"

 #: lib/merge.tcl:13
 msgid ""
@@ -1823,8 +1813,7 @@ msgid ""
 msgstr ""
 "最後にスキャンした状態はリポジトリの状態と合致しません。\n"
 "\n"
-"最後にスキャンして以後、別の Git プログラムがリポジトリを変更しています。マー"
-"ジを開始する前に、再スキャンが必要です。\n"
+"最後にスキャンして以後、別の Git プログラムがリポジトリを変更しています。マージを開始する前に、再スキャンが必要です。\n"
 "\n"
 "自動的に再スキャンを開始します。\n"

@@ -1842,8 +1831,7 @@ msgstr ""
 "\n"
 "ファイル %s にはマージ中の衝突が残っています。\n"
 "\n"
-"このファイルの衝突を解決し、コミット予定に加えて、コミットすることでマージを"
-"完了します。そうやって始めて、新たなマージを開始できるようになります。\n"
+"このファイルの衝突を解決し、コミット予定に加えて、コミットすることでマージを完了します。そうやって始めて、新たなマージを開始できるようになります。\n"

 #: lib/merge.tcl:55
 #, tcl-format
@@ -1859,8 +1847,7 @@ msgstr ""
 "\n"
 "ファイル %s は変更中です。\n"
 "\n"
-"現在のコミットを完了してからマージを開始して下さい。そうする方がマージに失敗"
-"したときの回復が楽です。\n"
+"現在のコミットを完了してからマージを開始して下さい。そうする方がマージに失敗したときの回復が楽です。\n"

 #: lib/merge.tcl:108
 #, tcl-format
@@ -1973,8 +1960,7 @@ msgstr ""
 #: lib/mergetool.tcl:45
 #, tcl-format
 msgid "File %s seems to have unresolved conflicts, still stage?"
-msgstr ""
-"ファイル %s には解決していない競合部分がまだあるようですが、いいですか?"
+msgstr "ファイル %s には解決していない競合部分がまだあるようですが、いいですか?"

 #: lib/mergetool.tcl:60
 #, tcl-format
@@ -2056,7 +2042,7 @@ msgstr "%s リポジトリ"

 #: lib/option.tcl:134
 msgid "Global (All Repositories)"
-msgstr "大域（全てのリポジトリ）"
+msgstr "標準設定（全てのリポジトリ）"

 #: lib/option.tcl:140
 msgid "User Name"
@@ -2068,15 +2054,15 @@ msgstr "電子メールアドレス"

 #: lib/option.tcl:143
 msgid "Summarize Merge Commits"
-msgstr "マージコミットの要約"
+msgstr "マージコミットの要約 (--summary)"

 #: lib/option.tcl:144
 msgid "Merge Verbosity"
-msgstr "マージの冗長度"
+msgstr "マージのエラー出力レベル (0-5, 標準2、最高5)(merge.verbosity)"

 #: lib/option.tcl:145
 msgid "Show Diffstat After Merge"
-msgstr "マージ後に diffstat を表示"
+msgstr "マージ後に変更量のグラフを表示 (git diff --stat)"

 #: lib/option.tcl:146
 msgid "Use Merge Tool"
@@ -2088,7 +2074,7 @@ msgstr "ファイル変更時刻を信頼する"

 #: lib/option.tcl:149
 msgid "Prune Tracking Branches During Fetch"
-msgstr "リモートから変更を取得 (fetch) したとき、リモートで削除済みのブランチを削除する"
+msgstr "リモートから変更取得 (fetch) したとき、リモートで削除済みのブランチを削除する"

 #: lib/option.tcl:150
 msgid "Match Tracking Branches"
@@ -2096,7 +2082,7 @@ msgstr "トラッキングブランチを合わせる"

 #: lib/option.tcl:151
 msgid "Use Textconv For Diffs and Blames"
-msgstr ""
+msgstr "DiffとBlameでTextConvを使用する"

 #: lib/option.tcl:152
 msgid "Blame Copy Only On Changed Files"
@@ -2104,19 +2090,19 @@ msgstr "変更されたファイルのみコピー検知を行なう"

 #: lib/option.tcl:153
 msgid "Minimum Letters To Blame Copy On"
-msgstr "コピーを検知する最少文字数"
+msgstr "他ファイルから移動/コピーを検知する最少文字数 (標準値40)"

 #: lib/option.tcl:154
 msgid "Blame History Context Radius (days)"
-msgstr "註釈する履歴半径（日数）"
+msgstr "Blameの表示範囲（前後日数）"

 #: lib/option.tcl:155
 msgid "Number of Diff Context Lines"
-msgstr "diff の文脈行数"
+msgstr "差分表示で表示する未変更行数 (変更行の前x行、後x行の未変更行を表示)"

 #: lib/option.tcl:156
 msgid "Additional Diff Parameters"
-msgstr ""
+msgstr "Diffの追加パラメータ"

 #: lib/option.tcl:157
 msgid "Commit Message Text Width"
@@ -2128,15 +2114,27 @@ msgstr "新しいブランチ名のテンプレート"

 #: lib/option.tcl:159
 msgid "Default File Contents Encoding"
-msgstr "ファイル内容のデフォールトエンコーディング"
+msgstr "ファイル内容のデフォルト文字コード"

 #: lib/option.tcl:160
 msgid "Warn before committing to a detached head"
-msgstr ""
+msgstr "detached head状態でコミットする前に警告する"

 #: lib/option.tcl:161
 msgid "Staging of untracked files"
-msgstr ""
+msgstr "追加されたファイルをコミット予定する"
+
+#: lib/option.tcl:161
+msgid "yes"
+msgstr "常に入れる"
+
+#: lib/option.tcl:161
+msgid "no"
+msgstr "常に入れない"
+
+#: lib/option.tcl:161
+msgid "ask"
+msgstr "毎回確認"

 #: lib/option.tcl:207
 msgid "Change"
@@ -2291,9 +2289,7 @@ msgstr ""
 msgid ""
 "One or more of the merge tests failed because you have not fetched the "
 "necessary commits.  Try fetching from %s first."
-msgstr ""
-"必要なコミットが不足しているために、マージ検査が失敗しました。まず %s から"
-"フェッチして下さい。"
+msgstr "必要なコミットが不足しているために、マージ検査が失敗しました。まず %s からフェッチして下さい。"

 #: lib/remote_branch_delete.tcl:208
 msgid "Please select one or more branches to delete."
@@ -2343,11 +2339,11 @@ msgstr "前"

 #: lib/search.tcl:52
 msgid "RegExp"
-msgstr ""
+msgstr "正規表現"

 #: lib/search.tcl:54
 msgid "Case"
-msgstr ""
+msgstr "小/大文字を区別"

 #: lib/shortcut.tcl:21 lib/shortcut.tcl:62
 msgid "Cannot write shortcut:"
@@ -2545,9 +2541,9 @@ msgid "Running %s requires a selected file."
 msgstr "ファイルを選択してから %s を起動してください。"

 #: lib/tools.tcl:91
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Are you sure you want to run %1$s on file \"%2$s\"?"
-msgstr "本当に %s を起動しますか?"
+msgstr "\"%2$s\" ファイルを %1$s で実行してよろしいですか?"

 #: lib/tools.tcl:95
 #, tcl-format
@@ -2591,20 +2587,17 @@ msgstr "%s から削除されたブランチを削除中"

 #: lib/transport.tcl:25
 msgid "fetch all remotes"
-msgstr ""
+msgstr "すべてのリモートレポジトリから変更取得"

 #: lib/transport.tcl:26
-#, fuzzy
 msgid "Fetching new changes from all remotes"
-msgstr "%s から新しい変更をフェッチしています"
+msgstr "すべてのリモートレポジトリの新しい変更を取得(fetch)しています"

 #: lib/transport.tcl:40
-#, fuzzy
 msgid "remote prune all remotes"
 msgstr "全リモートレポジトリの削除済ブランチを削除中"

 #: lib/transport.tcl:41
-#, fuzzy
 msgid "Pruning tracking branches deleted from all remotes"
 msgstr "全リモートレポジトリから削除されたブランチを削除中"

--
1.8.1.msysgit.1
