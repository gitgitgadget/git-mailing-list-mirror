Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEC271F6BF
	for <e@80x24.org>; Sat,  3 Sep 2016 14:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753593AbcICOpd (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Sep 2016 10:45:33 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35904 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753342AbcICOp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Sep 2016 10:45:27 -0400
Received: by mail-pf0-f193.google.com with SMTP id a143so3849899pfa.3
        for <git@vger.kernel.org>; Sat, 03 Sep 2016 07:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dWoGiPX6Wcsqqe6mGecqysah3fUaqrSL9k6bMbnHJwM=;
        b=waKonBOhoBRsPcORRNb3ekjcvuxh7sBDr0y4xU2fZ+/0xBVCyteWHlkGzLwxEX/6mB
         nYdE7QblCuFa/X+Q0Yiipo0yzOiMnUfS649TTlk160Z+V9fp2yRxsiFGAP+IDQrTjBhw
         rEm/EmqJf+FzlSVg0L98qx0h2z+95mgze0qAc1wSsa9TDgs+6rGjyKKfRzfciJvHN8NG
         WUY6F9m0Bsg+bSyKl+eOQ/6hiXS0Ud70o//JI8SZpGGG9vPt5HjXpqEa+R5duIEvI0/H
         597V2EN9kPfrJfm86nHMrORW5iSDcjWegitkdJLq3E4OK0ItFL3Pft2hWpSdDQmD2lBl
         ogGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dWoGiPX6Wcsqqe6mGecqysah3fUaqrSL9k6bMbnHJwM=;
        b=muc+tUwhs2cUmgC8XH+2rw2zTW8AArf4a08JKw37CWhzN0oxfA8GEuSLV4Zb3UgJlR
         TcIVqOfuisalkVwQLeUCubHzQRIMrAgHVmhpwzS53IpjJ92SchMEKJGkW8JVeE/zD0/W
         vEjOkQa1H7txxJ3IfmxOZl5BRLsxYOo/zPbZ54rgrF81D/3rQFwhl7uK1dGSuLiAnkq/
         X7Gb7PPExrb8XcGF0z773G7v9yx3okDK8esAu/qmT3rBM9pR7orcI/b0ZtEhvEeGK1GP
         sI40kOiXZvmC9zz4wxZX0h8Lu8Xy6mrM4YA2sOIR4h6Mx1VEOLvNfcWj09+l3tWuxxXe
         hIbA==
X-Gm-Message-State: AE9vXwPJ/XnEMpH0qneO1HTGInccq1ttw2cwUvY7iNnMjpMQNO3mHaEvGoaoijIY5fVl+w==
X-Received: by 10.98.5.133 with SMTP id 127mr46266354pff.40.1472913896909;
        Sat, 03 Sep 2016 07:44:56 -0700 (PDT)
Received: from localhost.localdomain (i60-35-214-133.s41.a017.ap.plala.or.jp. [60.35.214.133])
        by smtp.gmail.com with ESMTPSA id p74sm6755840pfk.68.2016.09.03.07.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 03 Sep 2016 07:44:56 -0700 (PDT)
From:   Satoshi Yasushima <s.yasushima@gmail.com>
To:     git@vger.kernel.org
Cc:     Pat Thoyts <patthoyts@users.sourceforge.net>,
        Satothi Yasushima <s.yasushima@gmail.com>
Subject: [PATCH 5/6] git-gui: Update Japanese translation
Date:   Sat,  3 Sep 2016 23:43:41 +0900
Message-Id: <1472913822-9088-5-git-send-email-s.yasushima@gmail.com>
X-Mailer: git-send-email 2.8.2.windows.1
In-Reply-To: <1472913822-9088-1-git-send-email-s.yasushima@gmail.com>
References: <1472913822-9088-1-git-send-email-s.yasushima@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Satoshi Yasushima <s.yasushima@gmail.com>
---
 po/ja.po | 77 +++++++++++++++++++++++++++++-----------------------------------
 1 file changed, 35 insertions(+), 42 deletions(-)

diff --git a/po/ja.po b/po/ja.po
index 23974cc..deaf8e3 100644
--- a/po/ja.po
+++ b/po/ja.po
@@ -102,6 +102,8 @@ msgstr "準備完了"
 msgid ""
 "Display limit (gui.maxfilesdisplayed = %s) reached, not showing all %s files."
 msgstr ""
+"表示可能な限界 (gui.maxfilesdisplayed = %s) に達しため、全体で%s個のファイル"
+"を表示できません"
 
 #: git-gui.sh:2101
 msgid "Unmodified"
@@ -128,23 +130,20 @@ msgid "File type changed, not staged"
 msgstr "ファイル型変更、コミット未予定"
 
 #: git-gui.sh:2109 git-gui.sh:2110
-#, fuzzy
 msgid "File type changed, old type staged for commit"
-msgstr "ファイル型変更、コミット未予定"
+msgstr "ファイル型変更、旧型コミット予定済"
 
 #: git-gui.sh:2111
 msgid "File type changed, staged"
 msgstr "ファイル型変更、コミット予定済"
 
 #: git-gui.sh:2112
-#, fuzzy
 msgid "File type change staged, modification not staged"
-msgstr "ファイル型変更、コミット未予定"
+msgstr "ファイル型変更コミット予定済、変更コミット未予定"
 
 #: git-gui.sh:2113
-#, fuzzy
 msgid "File type change staged, file missing"
-msgstr "ファイル型変更、コミット予定済"
+msgstr "ファイル型変更コミット予定済、ファイル無し"
 
 #: git-gui.sh:2115
 msgid "Untracked, not staged"
@@ -408,10 +407,9 @@ msgstr "SSH キーを表示"
 
 #: git-gui.sh:3014 git-gui.sh:3146
 msgid "Usage"
-msgstr ""
+msgstr "使い方"
 
 #: git-gui.sh:3095 lib/blame.tcl:573
-#, fuzzy
 msgid "Error"
 msgstr "エラー"
 
@@ -1112,9 +1110,8 @@ msgid "Find Text..."
 msgstr "テキストを検索"
 
 #: lib/blame.tcl:288
-#, fuzzy
 msgid "Goto Line..."
-msgstr "複製…"
+msgstr "指定行に移動…"
 
 #: lib/blame.tcl:297
 msgid "Do Full Copy Detection"
@@ -1310,7 +1307,7 @@ msgstr "共有(最高速・非推奨・バックアップ無し)"
 
 #: lib/choose_repository.tcl:545
 msgid "Recursively clone submodules too"
-msgstr ""
+msgstr "サブモジュールも再帰的に複製する"
 
 #: lib/choose_repository.tcl:579 lib/choose_repository.tcl:626
 #: lib/choose_repository.tcl:772 lib/choose_repository.tcl:842
@@ -1435,12 +1432,11 @@ msgstr "ファイル"
 
 #: lib/choose_repository.tcl:981
 msgid "Cannot clone submodules."
-msgstr ""
+msgstr "サブモジュールが複製できません。"
 
 #: lib/choose_repository.tcl:990
-#, fuzzy
 msgid "Cloning submodules"
-msgstr "%s から複製しています"
+msgstr "サブモジュールを複製しています"
 
 #: lib/choose_repository.tcl:1015
 msgid "Initial file checkout failed."
@@ -1515,11 +1511,11 @@ msgstr "前"
 
 #: lib/search.tcl:52
 msgid "RegExp"
-msgstr ""
+msgstr "正規表現"
 
 #: lib/search.tcl:54
 msgid "Case"
-msgstr ""
+msgstr "大文字小文字を区別"
 
 #: lib/status_bar.tcl:87
 #, tcl-format
@@ -1635,9 +1631,9 @@ msgid "Running %s requires a selected file."
 msgstr "ファイルを選択してから %s を起動してください。"
 
 #: lib/tools.tcl:91
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Are you sure you want to run %1$s on file \"%2$s\"?"
-msgstr "本当に %s を起動しますか?"
+msgstr "本当にファイル \"%2$s\"で %1$s を起動しますか?"
 
 #: lib/tools.tcl:95
 #, tcl-format
@@ -1817,16 +1813,15 @@ msgstr "トラッキングブランチを合わせる"
 
 #: lib/option.tcl:151
 msgid "Use Textconv For Diffs and Blames"
-msgstr ""
+msgstr "diff と注釈に textconv を使う"
 
 #: lib/option.tcl:152
 msgid "Blame Copy Only On Changed Files"
 msgstr "変更されたファイルのみコピー検知を行なう"
 
 #: lib/option.tcl:153
-#, fuzzy
 msgid "Maximum Length of Recent Repositories List"
-msgstr "最近使ったリポジトリ"
+msgstr "最近使ったリポジトリ一覧の上限"
 
 #: lib/option.tcl:154
 msgid "Minimum Letters To Blame Copy On"
@@ -1842,7 +1837,7 @@ msgstr "diff の文脈行数"
 
 #: lib/option.tcl:157
 msgid "Additional Diff Parameters"
-msgstr ""
+msgstr "diff の追加引数"
 
 #: lib/option.tcl:158
 msgid "Commit Message Text Width"
@@ -1858,19 +1853,19 @@ msgstr "ファイル内容のデフォールトエンコーディング"
 
 #: lib/option.tcl:161
 msgid "Warn before committing to a detached head"
-msgstr ""
+msgstr "分離 HEAD のコミット前に警告する"
 
 #: lib/option.tcl:162
 msgid "Staging of untracked files"
-msgstr ""
+msgstr "管理外のファイルをコミット予定する"
 
 #: lib/option.tcl:163
 msgid "Show untracked files"
-msgstr ""
+msgstr "管理外のファイルを表示する"
 
 #: lib/option.tcl:164
 msgid "Tab spacing"
-msgstr ""
+msgstr "タブ幅"
 
 #: lib/option.tcl:210
 msgid "Change"
@@ -1979,22 +1974,19 @@ msgstr "%s から削除されたトラッキング・ブランチを刈ってい
 
 #: lib/transport.tcl:25
 msgid "fetch all remotes"
-msgstr ""
+msgstr "すべてのリモートを取得"
 
 #: lib/transport.tcl:26
-#, fuzzy
 msgid "Fetching new changes from all remotes"
-msgstr "%s から新しい変更をフェッチしています"
+msgstr "すべてのリモートから新しい変更をフェッチしています"
 
 #: lib/transport.tcl:40
-#, fuzzy
 msgid "remote prune all remotes"
-msgstr "リモート刈込 %s"
+msgstr "リモート刈込 すべてのリモート"
 
 #: lib/transport.tcl:41
-#, fuzzy
 msgid "Pruning tracking branches deleted from all remotes"
-msgstr "%s から削除されたトラッキング・ブランチを刈っています"
+msgstr "すべてのリモートから削除されたトラッキング・ブランチを刈っています"
 
 #: lib/transport.tcl:54 lib/transport.tcl:92 lib/transport.tcl:110
 #: lib/remote_add.tcl:162
@@ -2247,7 +2239,7 @@ msgstr "コミットに %s を加えています"
 #: lib/index.tcl:380
 #, tcl-format
 msgid "Stage %d untracked files?"
-msgstr ""
+msgstr "管理外の %d ファイルをコミット予定としますか？"
 
 #: lib/index.tcl:428
 #, tcl-format
@@ -2452,6 +2444,13 @@ msgid ""
 " \n"
 " Do you really want to proceed with your Commit?"
 msgstr ""
+"分離 HEAD での変更をコミットしようとしています。"
+"これは潜在的に危険な行為で、理由は別のブランチへの切り替えで"
+"変更が消失し、reflog からの事後復旧も困難となるためです。"
+"おそらくこのコミットはキャンセルし新しく作成したブランチで"
+"行うべきです。\n"
+"\n"
+" 本当にコミットを続行しますか？"
 
 #: lib/commit.tcl:290
 msgid "Calling commit-msg hook..."
@@ -2593,11 +2592,11 @@ msgstr "%2$s にある %1$s をセットアップします"
 
 #: lib/line.tcl:17
 msgid "Goto Line:"
-msgstr ""
+msgstr "行番号"
 
 #: lib/line.tcl:23
 msgid "Go"
-msgstr ""
+msgstr "移動"
 
 #: lib/branch_create.tcl:23
 msgid "Create Branch"
@@ -2681,9 +2680,3 @@ msgstr "スペルチェッカーが予想外の EOF を返しました"
 #: lib/spellcheck.tcl:392
 msgid "Spell Checker Failed"
 msgstr "スペルチェック失敗"
-
-#~ msgid "Displaying only %s of %s files."
-#~ msgstr "全体で%s個の内の%sファイルだけ表示しています"
-
-#~ msgid "Case-Sensitive"
-#~ msgstr "大文字小文字を区別"
-- 
2.8.2.windows.1

