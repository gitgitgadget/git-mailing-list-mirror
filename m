Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7780F20986
	for <e@80x24.org>; Thu,  6 Oct 2016 09:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967007AbcJFJHe (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 05:07:34 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35005 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967004AbcJFJH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 05:07:27 -0400
Received: by mail-lf0-f68.google.com with SMTP id s64so690507lfs.2
        for <git@vger.kernel.org>; Thu, 06 Oct 2016 02:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=oRUpcEoriNoXlkNDk3pTLdWEUW/t55yKSgsKMe6UFTI=;
        b=yT0WRz1Z10br9q3bw5d+cqcP/vDqtRt8WynAj03t4IuTfsBTRTS/GINoYi9cX7n02o
         Y5qUW4dWMXq8HD3h2pVIgMO8jirZeg1bS0eySucARE2wOMZdUaSQoyM00BD66RaZ85lQ
         +2GQbgReZ/Lv5tjUnDAqygoYmPd8tf64GXPqaA+eP1fqqwAuAyH0KbwkyN06FOQH4LSe
         S+liHETuiyY3fMrMfbbaH3LBraZbdyDb8l3kWjLcqYbVh0zIfOU/w3YX9gvQDJDHI3Oq
         l3LuvSD1gPjUgeq7WpSZq11d1v0NRhEKfkltAbWMtCIiYdqSlHj7KQ912R+ZazEGUs1N
         9BjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oRUpcEoriNoXlkNDk3pTLdWEUW/t55yKSgsKMe6UFTI=;
        b=Bz9HPFkSjcpaH3ZS/Kb3kXQCy4xYLQoYK//P+e8GGDgctT7v5nLLRgmBgkksX+N00P
         T0197fXfkDk7LQcUULwTFSh5L8B8y6WlzlV44O9geKFiNW1xd5qPSUFngMS4SiWCMyWV
         pD/GFTHcq1iQsJKfsq/KF9FtobntmPvT150MwjdrzEop7EwrantYZM8USDJ1GKT3qpaX
         AY5xyB8VQTPwi9/wpAZymXkOaHV47fjlV+amYrXz7KX4hLkkPf8rjpMS/GRWFi9A6h/F
         kdFl175JU9EjHQAAidqjwKpI9iqa6JvThaoeHhlJo+UiBRzu+hnf6woNrlneEm/Cwrvc
         DvZQ==
X-Gm-Message-State: AA6/9RlNPds4UzO77GuWcYbqVltsvg9zVz1ZzQrU08BeGE43xLXXiD5eT6M/mGS9UUurtA==
X-Received: by 10.46.5.215 with SMTP id 206mr5875083ljf.65.1475744844384;
        Thu, 06 Oct 2016 02:07:24 -0700 (PDT)
Received: from Prog004.devcubestudio.com (mail.devcubestudio.com. [193.93.53.184])
        by smtp.gmail.com with ESMTPSA id u13sm2175596lja.12.2016.10.06.02.07.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Oct 2016 02:07:23 -0700 (PDT)
From:   Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
To:     git@vger.kernel.org
Cc:     Pat Thoyts <patthoyts@users.sourceforge.net>,
        Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
Subject: [PATCH] git-gui: Update translation template
Date:   Thu,  6 Oct 2016 12:06:54 +0300
Message-Id: <20161006090654.27296-1-dimitriy.ryazantcev@gmail.com>
X-Mailer: git-send-email 2.9.0.windows.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
---
 po/git-gui.pot | 2203 +++++++++++++++++++++++++++++++-------------------------
 1 file changed, 1205 insertions(+), 998 deletions(-)

diff --git a/po/git-gui.pot b/po/git-gui.pot
index 0c94f9c..634af68 100644
--- a/po/git-gui.pot
+++ b/po/git-gui.pot
@@ -8,41 +8,42 @@ msgid ""
 msgstr ""
 "Project-Id-Version: PACKAGE VERSION\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2010-01-26 15:47-0800\n"
+"POT-Creation-Date: 2016-10-06 12:00+0300\n"
 "PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
 "Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
 "Language-Team: LANGUAGE <LL@li.org>\n"
+"Language: \n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=CHARSET\n"
 "Content-Transfer-Encoding: 8bit\n"
 
-#: git-gui.sh:41 git-gui.sh:793 git-gui.sh:807 git-gui.sh:820 git-gui.sh:903
-#: git-gui.sh:922
-msgid "git-gui: fatal error"
-msgstr ""
-
-#: git-gui.sh:743
+#: git-gui.sh:865
 #, tcl-format
 msgid "Invalid font specified in %s:"
 msgstr ""
 
-#: git-gui.sh:779
+#: git-gui.sh:919
 msgid "Main Font"
 msgstr ""
 
-#: git-gui.sh:780
+#: git-gui.sh:920
 msgid "Diff/Console Font"
 msgstr ""
 
-#: git-gui.sh:794
+#: git-gui.sh:935 git-gui.sh:949 git-gui.sh:962 git-gui.sh:1052 git-gui.sh:1071
+#: git-gui.sh:3147
+msgid "git-gui: fatal error"
+msgstr ""
+
+#: git-gui.sh:936
 msgid "Cannot find git in PATH."
 msgstr ""
 
-#: git-gui.sh:821
+#: git-gui.sh:963
 msgid "Cannot parse Git version string:"
 msgstr ""
 
-#: git-gui.sh:839
+#: git-gui.sh:988
 #, tcl-format
 msgid ""
 "Git version cannot be determined.\n"
@@ -54,473 +55,501 @@ msgid ""
 "Assume '%s' is version 1.5.0?\n"
 msgstr ""
 
-#: git-gui.sh:1128
+#: git-gui.sh:1285
 msgid "Git directory not found:"
 msgstr ""
 
-#: git-gui.sh:1146
+#: git-gui.sh:1319
 msgid "Cannot move to top of working directory:"
 msgstr ""
 
-#: git-gui.sh:1154
+#: git-gui.sh:1327
 msgid "Cannot use bare repository:"
 msgstr ""
 
-#: git-gui.sh:1162
+#: git-gui.sh:1335
 msgid "No working directory"
 msgstr ""
 
-#: git-gui.sh:1334 lib/checkout_op.tcl:306
+#: git-gui.sh:1507 lib/checkout_op.tcl:306
 msgid "Refreshing file status..."
 msgstr ""
 
-#: git-gui.sh:1390
+#: git-gui.sh:1567
 msgid "Scanning for modified files ..."
 msgstr ""
 
-#: git-gui.sh:1454
+#: git-gui.sh:1645
 msgid "Calling prepare-commit-msg hook..."
 msgstr ""
 
-#: git-gui.sh:1471
+#: git-gui.sh:1662
 msgid "Commit declined by prepare-commit-msg hook."
 msgstr ""
 
-#: git-gui.sh:1629 lib/browser.tcl:246
+#: git-gui.sh:1820 lib/browser.tcl:252
 msgid "Ready."
 msgstr ""
 
-#: git-gui.sh:1787
+#: git-gui.sh:1984
 #, tcl-format
-msgid "Displaying only %s of %s files."
+msgid ""
+"Display limit (gui.maxfilesdisplayed = %s) reached, not showing all %s files."
 msgstr ""
 
-#: git-gui.sh:1913
+#: git-gui.sh:2107
 msgid "Unmodified"
 msgstr ""
 
-#: git-gui.sh:1915
+#: git-gui.sh:2109
 msgid "Modified, not staged"
 msgstr ""
 
-#: git-gui.sh:1916 git-gui.sh:1924
+#: git-gui.sh:2110 git-gui.sh:2122
 msgid "Staged for commit"
 msgstr ""
 
-#: git-gui.sh:1917 git-gui.sh:1925
+#: git-gui.sh:2111 git-gui.sh:2123
 msgid "Portions staged for commit"
 msgstr ""
 
-#: git-gui.sh:1918 git-gui.sh:1926
+#: git-gui.sh:2112 git-gui.sh:2124
 msgid "Staged for commit, missing"
 msgstr ""
 
-#: git-gui.sh:1920
+#: git-gui.sh:2114
 msgid "File type changed, not staged"
 msgstr ""
 
-#: git-gui.sh:1921
+#: git-gui.sh:2115 git-gui.sh:2116
+msgid "File type changed, old type staged for commit"
+msgstr ""
+
+#: git-gui.sh:2117
 msgid "File type changed, staged"
 msgstr ""
 
-#: git-gui.sh:1923
+#: git-gui.sh:2118
+msgid "File type change staged, modification not staged"
+msgstr ""
+
+#: git-gui.sh:2119
+msgid "File type change staged, file missing"
+msgstr ""
+
+#: git-gui.sh:2121
 msgid "Untracked, not staged"
 msgstr ""
 
-#: git-gui.sh:1928
+#: git-gui.sh:2126
 msgid "Missing"
 msgstr ""
 
-#: git-gui.sh:1929
+#: git-gui.sh:2127
 msgid "Staged for removal"
 msgstr ""
 
-#: git-gui.sh:1930
+#: git-gui.sh:2128
 msgid "Staged for removal, still present"
 msgstr ""
 
-#: git-gui.sh:1932 git-gui.sh:1933 git-gui.sh:1934 git-gui.sh:1935
-#: git-gui.sh:1936 git-gui.sh:1937
+#: git-gui.sh:2130 git-gui.sh:2131 git-gui.sh:2132 git-gui.sh:2133
+#: git-gui.sh:2134 git-gui.sh:2135
 msgid "Requires merge resolution"
 msgstr ""
 
-#: git-gui.sh:1972
+#: git-gui.sh:2170
 msgid "Starting gitk... please wait..."
 msgstr ""
 
-#: git-gui.sh:1984
+#: git-gui.sh:2182
 msgid "Couldn't find gitk in PATH"
 msgstr ""
 
-#: git-gui.sh:2043
+#: git-gui.sh:2241
 msgid "Couldn't find git gui in PATH"
 msgstr ""
 
-#: git-gui.sh:2455 lib/choose_repository.tcl:36
+#: git-gui.sh:2676 lib/choose_repository.tcl:41
 msgid "Repository"
 msgstr ""
 
-#: git-gui.sh:2456
+#: git-gui.sh:2677
 msgid "Edit"
 msgstr ""
 
-#: git-gui.sh:2458 lib/choose_rev.tcl:561
+#: git-gui.sh:2679 lib/choose_rev.tcl:567
 msgid "Branch"
 msgstr ""
 
-#: git-gui.sh:2461 lib/choose_rev.tcl:548
+#: git-gui.sh:2682 lib/choose_rev.tcl:554
 msgid "Commit@@noun"
 msgstr ""
 
-#: git-gui.sh:2464 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:168
+#: git-gui.sh:2685 lib/merge.tcl:127 lib/merge.tcl:174
 msgid "Merge"
 msgstr ""
 
-#: git-gui.sh:2465 lib/choose_rev.tcl:557
+#: git-gui.sh:2686 lib/choose_rev.tcl:563
 msgid "Remote"
 msgstr ""
 
-#: git-gui.sh:2468
+#: git-gui.sh:2689
 msgid "Tools"
 msgstr ""
 
-#: git-gui.sh:2477
+#: git-gui.sh:2698
 msgid "Explore Working Copy"
 msgstr ""
 
-#: git-gui.sh:2483
+#: git-gui.sh:2704
+msgid "Git Bash"
+msgstr ""
+
+#: git-gui.sh:2714
 msgid "Browse Current Branch's Files"
 msgstr ""
 
-#: git-gui.sh:2487
+#: git-gui.sh:2718
 msgid "Browse Branch Files..."
 msgstr ""
 
-#: git-gui.sh:2492
+#: git-gui.sh:2723
 msgid "Visualize Current Branch's History"
 msgstr ""
 
-#: git-gui.sh:2496
+#: git-gui.sh:2727
 msgid "Visualize All Branch History"
 msgstr ""
 
-#: git-gui.sh:2503
+#: git-gui.sh:2734
 #, tcl-format
 msgid "Browse %s's Files"
 msgstr ""
 
-#: git-gui.sh:2505
+#: git-gui.sh:2736
 #, tcl-format
 msgid "Visualize %s's History"
 msgstr ""
 
-#: git-gui.sh:2510 lib/database.tcl:27 lib/database.tcl:67
+#: git-gui.sh:2741 lib/database.tcl:40
 msgid "Database Statistics"
 msgstr ""
 
-#: git-gui.sh:2513 lib/database.tcl:34
+#: git-gui.sh:2744 lib/database.tcl:33
 msgid "Compress Database"
 msgstr ""
 
-#: git-gui.sh:2516
+#: git-gui.sh:2747
 msgid "Verify Database"
 msgstr ""
 
-#: git-gui.sh:2523 git-gui.sh:2527 git-gui.sh:2531 lib/shortcut.tcl:8
-#: lib/shortcut.tcl:40 lib/shortcut.tcl:72
+#: git-gui.sh:2754 git-gui.sh:2758 git-gui.sh:2762
 msgid "Create Desktop Icon"
 msgstr ""
 
-#: git-gui.sh:2539 lib/choose_repository.tcl:183 lib/choose_repository.tcl:191
+#: git-gui.sh:2770 lib/choose_repository.tcl:193 lib/choose_repository.tcl:201
 msgid "Quit"
 msgstr ""
 
-#: git-gui.sh:2547
+#: git-gui.sh:2778
 msgid "Undo"
 msgstr ""
 
-#: git-gui.sh:2550
+#: git-gui.sh:2781
 msgid "Redo"
 msgstr ""
 
-#: git-gui.sh:2554 git-gui.sh:3109
+#: git-gui.sh:2785 git-gui.sh:3399
 msgid "Cut"
 msgstr ""
 
-#: git-gui.sh:2557 git-gui.sh:3112 git-gui.sh:3186 git-gui.sh:3259
+#: git-gui.sh:2788 git-gui.sh:3402 git-gui.sh:3476 git-gui.sh:3562
 #: lib/console.tcl:69
 msgid "Copy"
 msgstr ""
 
-#: git-gui.sh:2560 git-gui.sh:3115
+#: git-gui.sh:2791 git-gui.sh:3405
 msgid "Paste"
 msgstr ""
 
-#: git-gui.sh:2563 git-gui.sh:3118 lib/branch_delete.tcl:26
-#: lib/remote_branch_delete.tcl:38
+#: git-gui.sh:2794 git-gui.sh:3408 lib/remote_branch_delete.tcl:39
+#: lib/branch_delete.tcl:28
 msgid "Delete"
 msgstr ""
 
-#: git-gui.sh:2567 git-gui.sh:3122 git-gui.sh:3263 lib/console.tcl:71
+#: git-gui.sh:2798 git-gui.sh:3412 git-gui.sh:3566 lib/console.tcl:71
 msgid "Select All"
 msgstr ""
 
-#: git-gui.sh:2576
+#: git-gui.sh:2807
 msgid "Create..."
 msgstr ""
 
-#: git-gui.sh:2582
+#: git-gui.sh:2813
 msgid "Checkout..."
 msgstr ""
 
-#: git-gui.sh:2588
+#: git-gui.sh:2819
 msgid "Rename..."
 msgstr ""
 
-#: git-gui.sh:2593
+#: git-gui.sh:2824
 msgid "Delete..."
 msgstr ""
 
-#: git-gui.sh:2598
+#: git-gui.sh:2829
 msgid "Reset..."
 msgstr ""
 
-#: git-gui.sh:2608
+#: git-gui.sh:2839
 msgid "Done"
 msgstr ""
 
-#: git-gui.sh:2610
+#: git-gui.sh:2841
 msgid "Commit@@verb"
 msgstr ""
 
-#: git-gui.sh:2619 git-gui.sh:3050
+#: git-gui.sh:2850 git-gui.sh:3335
 msgid "New Commit"
 msgstr ""
 
-#: git-gui.sh:2627 git-gui.sh:3057
+#: git-gui.sh:2858 git-gui.sh:3342
 msgid "Amend Last Commit"
 msgstr ""
 
-#: git-gui.sh:2637 git-gui.sh:3011 lib/remote_branch_delete.tcl:99
+#: git-gui.sh:2868 git-gui.sh:3296 lib/remote_branch_delete.tcl:101
 msgid "Rescan"
 msgstr ""
 
-#: git-gui.sh:2643
+#: git-gui.sh:2874
 msgid "Stage To Commit"
 msgstr ""
 
-#: git-gui.sh:2649
+#: git-gui.sh:2880
 msgid "Stage Changed Files To Commit"
 msgstr ""
 
-#: git-gui.sh:2655
+#: git-gui.sh:2886
 msgid "Unstage From Commit"
 msgstr ""
 
-#: git-gui.sh:2661 lib/index.tcl:412
+#: git-gui.sh:2892 lib/index.tcl:442
 msgid "Revert Changes"
 msgstr ""
 
-#: git-gui.sh:2669 git-gui.sh:3310 git-gui.sh:3341
+#: git-gui.sh:2900 git-gui.sh:3613 git-gui.sh:3644
 msgid "Show Less Context"
 msgstr ""
 
-#: git-gui.sh:2673 git-gui.sh:3314 git-gui.sh:3345
+#: git-gui.sh:2904 git-gui.sh:3617 git-gui.sh:3648
 msgid "Show More Context"
 msgstr ""
 
-#: git-gui.sh:2680 git-gui.sh:3024 git-gui.sh:3133
+#: git-gui.sh:2911 git-gui.sh:3309 git-gui.sh:3423
 msgid "Sign Off"
 msgstr ""
 
-#: git-gui.sh:2696
+#: git-gui.sh:2927
 msgid "Local Merge..."
 msgstr ""
 
-#: git-gui.sh:2701
+#: git-gui.sh:2932
 msgid "Abort Merge..."
 msgstr ""
 
-#: git-gui.sh:2713 git-gui.sh:2741
+#: git-gui.sh:2944 git-gui.sh:2972
 msgid "Add..."
 msgstr ""
 
-#: git-gui.sh:2717
+#: git-gui.sh:2948
 msgid "Push..."
 msgstr ""
 
-#: git-gui.sh:2721
+#: git-gui.sh:2952
 msgid "Delete Branch..."
 msgstr ""
 
-#: git-gui.sh:2731 git-gui.sh:3292
+#: git-gui.sh:2962 git-gui.sh:3595
 msgid "Options..."
 msgstr ""
 
-#: git-gui.sh:2742
+#: git-gui.sh:2973
 msgid "Remove..."
 msgstr ""
 
-#: git-gui.sh:2751 lib/choose_repository.tcl:50
+#: git-gui.sh:2982 lib/choose_repository.tcl:55
 msgid "Help"
 msgstr ""
 
-#: git-gui.sh:2755 git-gui.sh:2759 lib/about.tcl:14
-#: lib/choose_repository.tcl:44 lib/choose_repository.tcl:53
+#: git-gui.sh:2986 git-gui.sh:2990 lib/about.tcl:14
+#: lib/choose_repository.tcl:49 lib/choose_repository.tcl:58
 #, tcl-format
 msgid "About %s"
 msgstr ""
 
-#: git-gui.sh:2783
+#: git-gui.sh:3014
 msgid "Online Documentation"
 msgstr ""
 
-#: git-gui.sh:2786 lib/choose_repository.tcl:47 lib/choose_repository.tcl:56
+#: git-gui.sh:3017 lib/choose_repository.tcl:52 lib/choose_repository.tcl:61
 msgid "Show SSH Key"
 msgstr ""
 
-#: git-gui.sh:2893
+#: git-gui.sh:3032 git-gui.sh:3164
+msgid "usage:"
+msgstr ""
+
+#: git-gui.sh:3036 git-gui.sh:3168
+msgid "Usage"
+msgstr ""
+
+#: git-gui.sh:3117 lib/blame.tcl:573
+msgid "Error"
+msgstr ""
+
+#: git-gui.sh:3148
 #, tcl-format
 msgid "fatal: cannot stat path %s: No such file or directory"
 msgstr ""
 
-#: git-gui.sh:2926
+#: git-gui.sh:3181
 msgid "Current Branch:"
 msgstr ""
 
-#: git-gui.sh:2947
-msgid "Staged Changes (Will Commit)"
+#: git-gui.sh:3206
+msgid "Unstaged Changes"
 msgstr ""
 
-#: git-gui.sh:2967
-msgid "Unstaged Changes"
+#: git-gui.sh:3228
+msgid "Staged Changes (Will Commit)"
 msgstr ""
 
-#: git-gui.sh:3017
+#: git-gui.sh:3302
 msgid "Stage Changed"
 msgstr ""
 
-#: git-gui.sh:3036 lib/transport.tcl:104 lib/transport.tcl:193
+#: git-gui.sh:3321 lib/transport.tcl:137
 msgid "Push"
 msgstr ""
 
-#: git-gui.sh:3071
+#: git-gui.sh:3356
 msgid "Initial Commit Message:"
 msgstr ""
 
-#: git-gui.sh:3072
+#: git-gui.sh:3357
 msgid "Amended Commit Message:"
 msgstr ""
 
-#: git-gui.sh:3073
+#: git-gui.sh:3358
 msgid "Amended Initial Commit Message:"
 msgstr ""
 
-#: git-gui.sh:3074
+#: git-gui.sh:3359
 msgid "Amended Merge Commit Message:"
 msgstr ""
 
-#: git-gui.sh:3075
+#: git-gui.sh:3360
 msgid "Merge Commit Message:"
 msgstr ""
 
-#: git-gui.sh:3076
+#: git-gui.sh:3361
 msgid "Commit Message:"
 msgstr ""
 
-#: git-gui.sh:3125 git-gui.sh:3267 lib/console.tcl:73
+#: git-gui.sh:3415 git-gui.sh:3570 lib/console.tcl:73
 msgid "Copy All"
 msgstr ""
 
-#: git-gui.sh:3149 lib/blame.tcl:104
+#: git-gui.sh:3439 lib/blame.tcl:105
 msgid "File:"
 msgstr ""
 
-#: git-gui.sh:3255
+#: git-gui.sh:3558
 msgid "Refresh"
 msgstr ""
 
-#: git-gui.sh:3276
+#: git-gui.sh:3579
 msgid "Decrease Font Size"
 msgstr ""
 
-#: git-gui.sh:3280
+#: git-gui.sh:3583
 msgid "Increase Font Size"
 msgstr ""
 
-#: git-gui.sh:3288 lib/blame.tcl:281
+#: git-gui.sh:3591 lib/blame.tcl:294
 msgid "Encoding"
 msgstr ""
 
-#: git-gui.sh:3299
+#: git-gui.sh:3602
 msgid "Apply/Reverse Hunk"
 msgstr ""
 
-#: git-gui.sh:3304
+#: git-gui.sh:3607
 msgid "Apply/Reverse Line"
 msgstr ""
 
-#: git-gui.sh:3323
+#: git-gui.sh:3626
 msgid "Run Merge Tool"
 msgstr ""
 
-#: git-gui.sh:3328
+#: git-gui.sh:3631
 msgid "Use Remote Version"
 msgstr ""
 
-#: git-gui.sh:3332
+#: git-gui.sh:3635
 msgid "Use Local Version"
 msgstr ""
 
-#: git-gui.sh:3336
+#: git-gui.sh:3639
 msgid "Revert To Base"
 msgstr ""
 
-#: git-gui.sh:3354
+#: git-gui.sh:3657
 msgid "Visualize These Changes In The Submodule"
 msgstr ""
 
-#: git-gui.sh:3358
+#: git-gui.sh:3661
 msgid "Visualize Current Branch History In The Submodule"
 msgstr ""
 
-#: git-gui.sh:3362
+#: git-gui.sh:3665
 msgid "Visualize All Branch History In The Submodule"
 msgstr ""
 
-#: git-gui.sh:3367
+#: git-gui.sh:3670
 msgid "Start git gui In The Submodule"
 msgstr ""
 
-#: git-gui.sh:3389
+#: git-gui.sh:3705
 msgid "Unstage Hunk From Commit"
 msgstr ""
 
-#: git-gui.sh:3391
+#: git-gui.sh:3707
 msgid "Unstage Lines From Commit"
 msgstr ""
 
-#: git-gui.sh:3393
+#: git-gui.sh:3709
 msgid "Unstage Line From Commit"
 msgstr ""
 
-#: git-gui.sh:3396
+#: git-gui.sh:3712
 msgid "Stage Hunk For Commit"
 msgstr ""
 
-#: git-gui.sh:3398
+#: git-gui.sh:3714
 msgid "Stage Lines For Commit"
 msgstr ""
 
-#: git-gui.sh:3400
+#: git-gui.sh:3716
 msgid "Stage Line For Commit"
 msgstr ""
 
-#: git-gui.sh:3424
+#: git-gui.sh:3741
 msgid "Initializing..."
 msgstr ""
 
-#: git-gui.sh:3541
+#: git-gui.sh:3886
 #, tcl-format
 msgid ""
 "Possible environment issues exist.\n"
@@ -531,14 +560,14 @@ msgid ""
 "\n"
 msgstr ""
 
-#: git-gui.sh:3570
+#: git-gui.sh:3915
 msgid ""
 "\n"
 "This is due to a known issue with the\n"
 "Tcl binary distributed by Cygwin."
 msgstr ""
 
-#: git-gui.sh:3575
+#: git-gui.sh:3920
 #, tcl-format
 msgid ""
 "\n"
@@ -549,244 +578,278 @@ msgid ""
 "~/.gitconfig file.\n"
 msgstr ""
 
-#: lib/about.tcl:26
-msgid "git-gui - a graphical user interface for Git."
-msgstr ""
-
-#: lib/blame.tcl:72
-msgid "File Viewer"
-msgstr ""
-
-#: lib/blame.tcl:78
-msgid "Commit:"
-msgstr ""
-
-#: lib/blame.tcl:271
-msgid "Copy Commit"
-msgstr ""
-
-#: lib/blame.tcl:275
-msgid "Find Text..."
+#: lib/merge.tcl:13
+msgid ""
+"Cannot merge while amending.\n"
+"\n"
+"You must finish amending this commit before starting any type of merge.\n"
 msgstr ""
 
-#: lib/blame.tcl:284
-msgid "Do Full Copy Detection"
+#: lib/merge.tcl:27
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.  A "
+"rescan must be performed before a merge can be performed.\n"
+"\n"
+"The rescan will be automatically started now.\n"
 msgstr ""
 
-#: lib/blame.tcl:288
-msgid "Show History Context"
+#: lib/merge.tcl:45
+#, tcl-format
+msgid ""
+"You are in the middle of a conflicted merge.\n"
+"\n"
+"File %s has merge conflicts.\n"
+"\n"
+"You must resolve them, stage the file, and commit to complete the current "
+"merge.  Only then can you begin another merge.\n"
 msgstr ""
 
-#: lib/blame.tcl:291
-msgid "Blame Parent Commit"
+#: lib/merge.tcl:55
+#, tcl-format
+msgid ""
+"You are in the middle of a change.\n"
+"\n"
+"File %s is modified.\n"
+"\n"
+"You should complete the current commit before starting a merge.  Doing so "
+"will help you abort a failed merge, should the need arise.\n"
 msgstr ""
 
-#: lib/blame.tcl:450
+#: lib/merge.tcl:108
 #, tcl-format
-msgid "Reading %s..."
+msgid "%s of %s"
 msgstr ""
 
-#: lib/blame.tcl:557
-msgid "Loading copy/move tracking annotations..."
+#: lib/merge.tcl:126
+#, tcl-format
+msgid "Merging %s and %s..."
 msgstr ""
 
-#: lib/blame.tcl:577
-msgid "lines annotated"
+#: lib/merge.tcl:137
+msgid "Merge completed successfully."
 msgstr ""
 
-#: lib/blame.tcl:769
-msgid "Loading original location annotations..."
+#: lib/merge.tcl:139
+msgid "Merge failed.  Conflict resolution is required."
 msgstr ""
 
-#: lib/blame.tcl:772
-msgid "Annotation complete."
+#: lib/merge.tcl:156
+#, tcl-format
+msgid "%s (%s): Merge"
 msgstr ""
 
-#: lib/blame.tcl:802
-msgid "Busy"
+#: lib/merge.tcl:164
+#, tcl-format
+msgid "Merge Into %s"
 msgstr ""
 
-#: lib/blame.tcl:803
-msgid "Annotation process is already running."
+#: lib/merge.tcl:170 lib/checkout_op.tcl:567 lib/tools_dlg.tcl:336
+msgid "Visualize"
 msgstr ""
 
-#: lib/blame.tcl:842
-msgid "Running thorough copy detection..."
+#: lib/merge.tcl:178 lib/remote_branch_delete.tcl:43 lib/branch_delete.tcl:34
+#: lib/checkout_op.tcl:579 lib/branch_rename.tcl:32 lib/tools_dlg.tcl:41
+#: lib/tools_dlg.tcl:202 lib/tools_dlg.tcl:345 lib/option.tcl:127
+#: lib/transport.tcl:141 lib/choose_font.tcl:45 lib/branch_checkout.tcl:30
+#: lib/browser.tcl:292 lib/remote_add.tcl:34 lib/branch_create.tcl:37
+msgid "Cancel"
 msgstr ""
 
-#: lib/blame.tcl:910
-msgid "Loading annotation..."
+#: lib/merge.tcl:183
+msgid "Revision To Merge"
 msgstr ""
 
-#: lib/blame.tcl:963
-msgid "Author:"
+#: lib/merge.tcl:218
+msgid ""
+"Cannot abort while amending.\n"
+"\n"
+"You must finish amending this commit.\n"
 msgstr ""
 
-#: lib/blame.tcl:967
-msgid "Committer:"
+#: lib/merge.tcl:228
+msgid ""
+"Abort merge?\n"
+"\n"
+"Aborting the current merge will cause *ALL* uncommitted changes to be lost.\n"
+"\n"
+"Continue with aborting the current merge?"
 msgstr ""
 
-#: lib/blame.tcl:972
-msgid "Original File:"
+#: lib/merge.tcl:234
+msgid ""
+"Reset changes?\n"
+"\n"
+"Resetting the changes will cause *ALL* uncommitted changes to be lost.\n"
+"\n"
+"Continue with resetting the current changes?"
 msgstr ""
 
-#: lib/blame.tcl:1020
-msgid "Cannot find HEAD commit:"
+#: lib/merge.tcl:245
+msgid "Aborting"
 msgstr ""
 
-#: lib/blame.tcl:1075
-msgid "Cannot find parent commit:"
+#: lib/merge.tcl:245
+msgid "files reset"
 msgstr ""
 
-#: lib/blame.tcl:1090
-msgid "Unable to display parent"
+#: lib/merge.tcl:273
+msgid "Abort failed."
 msgstr ""
 
-#: lib/blame.tcl:1091 lib/diff.tcl:320
-msgid "Error loading diff:"
+#: lib/merge.tcl:275
+msgid "Abort completed.  Ready."
 msgstr ""
 
-#: lib/blame.tcl:1231
-msgid "Originally By:"
+#: lib/error.tcl:20
+#, tcl-format
+msgid "%s: error"
 msgstr ""
 
-#: lib/blame.tcl:1237
-msgid "In File:"
+#: lib/error.tcl:36
+#, tcl-format
+msgid "%s: warning"
 msgstr ""
 
-#: lib/blame.tcl:1242
-msgid "Copied Or Moved Here By:"
+#: lib/error.tcl:80
+#, tcl-format
+msgid "%s hook failed:"
 msgstr ""
 
-#: lib/branch_checkout.tcl:14 lib/branch_checkout.tcl:19
-msgid "Checkout Branch"
+#: lib/error.tcl:96
+msgid "You must correct the above errors before committing."
 msgstr ""
 
-#: lib/branch_checkout.tcl:23
-msgid "Checkout"
+#: lib/error.tcl:116
+#, tcl-format
+msgid "%s (%s): error"
 msgstr ""
 
-#: lib/branch_checkout.tcl:27 lib/branch_create.tcl:35
-#: lib/branch_delete.tcl:32 lib/branch_rename.tcl:30 lib/browser.tcl:282
-#: lib/checkout_op.tcl:579 lib/choose_font.tcl:43 lib/merge.tcl:172
-#: lib/option.tcl:125 lib/remote_add.tcl:32 lib/remote_branch_delete.tcl:42
-#: lib/tools_dlg.tcl:40 lib/tools_dlg.tcl:204 lib/tools_dlg.tcl:352
-#: lib/transport.tcl:108
-msgid "Cancel"
+#: lib/date.tcl:25
+#, tcl-format
+msgid "Invalid date from Git: %s"
 msgstr ""
 
-#: lib/branch_checkout.tcl:32 lib/browser.tcl:287 lib/tools_dlg.tcl:328
-msgid "Revision"
+#: lib/encoding.tcl:443
+msgid "Default"
 msgstr ""
 
-#: lib/branch_checkout.tcl:36 lib/branch_create.tcl:69 lib/option.tcl:280
-msgid "Options"
+#: lib/encoding.tcl:448
+#, tcl-format
+msgid "System (%s)"
 msgstr ""
 
-#: lib/branch_checkout.tcl:39 lib/branch_create.tcl:92
-msgid "Fetch Tracking Branch"
+#: lib/encoding.tcl:459 lib/encoding.tcl:465
+msgid "Other"
 msgstr ""
 
-#: lib/branch_checkout.tcl:44
-msgid "Detach From Local Branch"
+#: lib/remote_branch_delete.tcl:29
+#, tcl-format
+msgid "%s (%s): Delete Branch Remotely"
 msgstr ""
 
-#: lib/branch_create.tcl:22
-msgid "Create Branch"
+#: lib/remote_branch_delete.tcl:34
+msgid "Delete Branch Remotely"
 msgstr ""
 
-#: lib/branch_create.tcl:27
-msgid "Create New Branch"
+#: lib/remote_branch_delete.tcl:48
+msgid "From Repository"
 msgstr ""
 
-#: lib/branch_create.tcl:31 lib/choose_repository.tcl:381
-msgid "Create"
+#: lib/remote_branch_delete.tcl:51 lib/transport.tcl:165
+msgid "Remote:"
 msgstr ""
 
-#: lib/branch_create.tcl:40
-msgid "Branch Name"
+#: lib/remote_branch_delete.tcl:72 lib/transport.tcl:187
+msgid "Arbitrary Location:"
 msgstr ""
 
-#: lib/branch_create.tcl:43 lib/remote_add.tcl:39 lib/tools_dlg.tcl:50
-msgid "Name:"
+#: lib/remote_branch_delete.tcl:88
+msgid "Branches"
 msgstr ""
 
-#: lib/branch_create.tcl:58
-msgid "Match Tracking Branch Name"
+#: lib/remote_branch_delete.tcl:110
+msgid "Delete Only If"
 msgstr ""
 
-#: lib/branch_create.tcl:66
-msgid "Starting Revision"
+#: lib/remote_branch_delete.tcl:112
+msgid "Merged Into:"
 msgstr ""
 
-#: lib/branch_create.tcl:72
-msgid "Update Existing Branch:"
+#: lib/remote_branch_delete.tcl:120 lib/branch_delete.tcl:53
+msgid "Always (Do not perform merge checks)"
 msgstr ""
 
-#: lib/branch_create.tcl:75
-msgid "No"
+#: lib/remote_branch_delete.tcl:153
+msgid "A branch is required for 'Merged Into'."
 msgstr ""
 
-#: lib/branch_create.tcl:80
-msgid "Fast Forward Only"
+#: lib/remote_branch_delete.tcl:185
+#, tcl-format
+msgid ""
+"The following branches are not completely merged into %s:\n"
+"\n"
+" - %s"
 msgstr ""
 
-#: lib/branch_create.tcl:85 lib/checkout_op.tcl:571
-msgid "Reset"
+#: lib/remote_branch_delete.tcl:190
+#, tcl-format
+msgid ""
+"One or more of the merge tests failed because you have not fetched the "
+"necessary commits.  Try fetching from %s first."
 msgstr ""
 
-#: lib/branch_create.tcl:97
-msgid "Checkout After Creation"
+#: lib/remote_branch_delete.tcl:208
+msgid "Please select one or more branches to delete."
 msgstr ""
 
-#: lib/branch_create.tcl:131
-msgid "Please select a tracking branch."
+#: lib/remote_branch_delete.tcl:218 lib/branch_delete.tcl:115
+msgid ""
+"Recovering deleted branches is difficult.\n"
+"\n"
+"Delete the selected branches?"
 msgstr ""
 
-#: lib/branch_create.tcl:140
+#: lib/remote_branch_delete.tcl:227
 #, tcl-format
-msgid "Tracking branch %s is not a branch in the remote repository."
+msgid "Deleting branches from %s"
 msgstr ""
 
-#: lib/branch_create.tcl:153 lib/branch_rename.tcl:86
-msgid "Please supply a branch name."
+#: lib/remote_branch_delete.tcl:300
+msgid "No repository selected."
 msgstr ""
 
-#: lib/branch_create.tcl:164 lib/branch_rename.tcl:106
+#: lib/remote_branch_delete.tcl:305
 #, tcl-format
-msgid "'%s' is not an acceptable branch name."
+msgid "Scanning %s..."
 msgstr ""
 
-#: lib/branch_delete.tcl:15
-msgid "Delete Branch"
+#: lib/branch_delete.tcl:16
+#, tcl-format
+msgid "%s (%s): Delete Branch"
 msgstr ""
 
-#: lib/branch_delete.tcl:20
+#: lib/branch_delete.tcl:21
 msgid "Delete Local Branch"
 msgstr ""
 
-#: lib/branch_delete.tcl:37
+#: lib/branch_delete.tcl:39
 msgid "Local Branches"
 msgstr ""
 
-#: lib/branch_delete.tcl:52
+#: lib/branch_delete.tcl:51
 msgid "Delete Only If Merged Into"
 msgstr ""
 
-#: lib/branch_delete.tcl:54 lib/remote_branch_delete.tcl:119
-msgid "Always (Do not perform merge checks)"
-msgstr ""
-
 #: lib/branch_delete.tcl:103
 #, tcl-format
 msgid "The following branches are not completely merged into %s:"
 msgstr ""
 
-#: lib/branch_delete.tcl:115 lib/remote_branch_delete.tcl:217
-msgid ""
-"Recovering deleted branches is difficult.\n"
-"\n"
-"Delete the selected branches?"
+#: lib/branch_delete.tcl:131
+#, tcl-format
+msgid " - %s:"
 msgstr ""
 
 #: lib/branch_delete.tcl:141
@@ -796,61 +859,62 @@ msgid ""
 "%s"
 msgstr ""
 
-#: lib/branch_rename.tcl:14 lib/branch_rename.tcl:22
-msgid "Rename Branch"
+#: lib/choose_rev.tcl:52
+msgid "This Detached Checkout"
 msgstr ""
 
-#: lib/branch_rename.tcl:26
-msgid "Rename"
+#: lib/choose_rev.tcl:60
+msgid "Revision Expression:"
 msgstr ""
 
-#: lib/branch_rename.tcl:36
-msgid "Branch:"
+#: lib/choose_rev.tcl:72
+msgid "Local Branch"
 msgstr ""
 
-#: lib/branch_rename.tcl:39
-msgid "New Name:"
+#: lib/choose_rev.tcl:77
+msgid "Tracking Branch"
 msgstr ""
 
-#: lib/branch_rename.tcl:75
-msgid "Please select a branch to rename."
+#: lib/choose_rev.tcl:82 lib/choose_rev.tcl:544
+msgid "Tag"
 msgstr ""
 
-#: lib/branch_rename.tcl:96 lib/checkout_op.tcl:202
+#: lib/choose_rev.tcl:321
 #, tcl-format
-msgid "Branch '%s' already exists."
+msgid "Invalid revision: %s"
 msgstr ""
 
-#: lib/branch_rename.tcl:117
-#, tcl-format
-msgid "Failed to rename '%s'."
+#: lib/choose_rev.tcl:342
+msgid "No revision selected."
 msgstr ""
 
-#: lib/browser.tcl:17
-msgid "Starting..."
+#: lib/choose_rev.tcl:350
+msgid "Revision expression is empty."
 msgstr ""
 
-#: lib/browser.tcl:26
-msgid "File Browser"
+#: lib/choose_rev.tcl:537
+msgid "Updated"
 msgstr ""
 
-#: lib/browser.tcl:126 lib/browser.tcl:143
-#, tcl-format
-msgid "Loading %s..."
+#: lib/choose_rev.tcl:565
+msgid "URL"
 msgstr ""
 
-#: lib/browser.tcl:187
-msgid "[Up To Parent]"
+#: lib/console.tcl:59
+msgid "Working... please wait..."
 msgstr ""
 
-#: lib/browser.tcl:267 lib/browser.tcl:273
-msgid "Browse Branch Files"
+#: lib/console.tcl:81 lib/checkout_op.tcl:146 lib/database.tcl:30
+#: lib/sshkey.tcl:55
+msgid "Close"
 msgstr ""
 
-#: lib/browser.tcl:278 lib/choose_repository.tcl:398
-#: lib/choose_repository.tcl:486 lib/choose_repository.tcl:497
-#: lib/choose_repository.tcl:1028
-msgid "Browse"
+#: lib/console.tcl:186
+msgid "Success"
+msgstr ""
+
+#: lib/console.tcl:200
+msgid "Error: Command Failed"
 msgstr ""
 
 #: lib/checkout_op.tcl:85
@@ -863,11 +927,6 @@ msgstr ""
 msgid "fatal: Cannot resolve %s"
 msgstr ""
 
-#: lib/checkout_op.tcl:146 lib/console.tcl:81 lib/database.tcl:31
-#: lib/sshkey.tcl:53
-msgid "Close"
-msgstr ""
-
 #: lib/checkout_op.tcl:175
 #, tcl-format
 msgid "Branch '%s' does not exist."
@@ -878,6 +937,11 @@ msgstr ""
 msgid "Failed to configure simplified git-pull for '%s'."
 msgstr ""
 
+#: lib/checkout_op.tcl:202 lib/branch_rename.tcl:102
+#, tcl-format
+msgid "Branch '%s' already exists."
+msgstr ""
+
 #: lib/checkout_op.tcl:229
 #, tcl-format
 msgid ""
@@ -961,8 +1025,8 @@ msgstr ""
 msgid "Reset '%s'?"
 msgstr ""
 
-#: lib/checkout_op.tcl:567 lib/merge.tcl:164 lib/tools_dlg.tcl:343
-msgid "Visualize"
+#: lib/checkout_op.tcl:571 lib/branch_create.tcl:85
+msgid "Reset"
 msgstr ""
 
 #: lib/checkout_op.tcl:635
@@ -976,1193 +1040,1338 @@ msgid ""
 "This should not have occurred.  %s will now close and give up."
 msgstr ""
 
-#: lib/choose_font.tcl:39
-msgid "Select"
+#: lib/blame.tcl:73
+#, tcl-format
+msgid "%s (%s): File Viewer"
 msgstr ""
 
-#: lib/choose_font.tcl:53
-msgid "Font Family"
+#: lib/blame.tcl:79
+msgid "Commit:"
 msgstr ""
 
-#: lib/choose_font.tcl:74
-msgid "Font Size"
+#: lib/blame.tcl:280
+msgid "Copy Commit"
 msgstr ""
 
-#: lib/choose_font.tcl:91
-msgid "Font Example"
+#: lib/blame.tcl:284
+msgid "Find Text..."
 msgstr ""
 
-#: lib/choose_font.tcl:103
-msgid ""
-"This is example text.\n"
-"If you like this text, it can be your font."
+#: lib/blame.tcl:288
+msgid "Goto Line..."
+msgstr ""
+
+#: lib/blame.tcl:297
+msgid "Do Full Copy Detection"
+msgstr ""
+
+#: lib/blame.tcl:301
+msgid "Show History Context"
+msgstr ""
+
+#: lib/blame.tcl:304
+msgid "Blame Parent Commit"
+msgstr ""
+
+#: lib/blame.tcl:466
+#, tcl-format
+msgid "Reading %s..."
+msgstr ""
+
+#: lib/blame.tcl:594
+msgid "Loading copy/move tracking annotations..."
+msgstr ""
+
+#: lib/blame.tcl:614
+msgid "lines annotated"
+msgstr ""
+
+#: lib/blame.tcl:806
+msgid "Loading original location annotations..."
+msgstr ""
+
+#: lib/blame.tcl:809
+msgid "Annotation complete."
+msgstr ""
+
+#: lib/blame.tcl:839
+msgid "Busy"
+msgstr ""
+
+#: lib/blame.tcl:840
+msgid "Annotation process is already running."
+msgstr ""
+
+#: lib/blame.tcl:879
+msgid "Running thorough copy detection..."
+msgstr ""
+
+#: lib/blame.tcl:947
+msgid "Loading annotation..."
+msgstr ""
+
+#: lib/blame.tcl:1000
+msgid "Author:"
+msgstr ""
+
+#: lib/blame.tcl:1004
+msgid "Committer:"
+msgstr ""
+
+#: lib/blame.tcl:1009
+msgid "Original File:"
+msgstr ""
+
+#: lib/blame.tcl:1057
+msgid "Cannot find HEAD commit:"
+msgstr ""
+
+#: lib/blame.tcl:1112
+msgid "Cannot find parent commit:"
+msgstr ""
+
+#: lib/blame.tcl:1127
+msgid "Unable to display parent"
 msgstr ""
 
-#: lib/choose_repository.tcl:28
+#: lib/blame.tcl:1128 lib/diff.tcl:358
+msgid "Error loading diff:"
+msgstr ""
+
+#: lib/blame.tcl:1269
+msgid "Originally By:"
+msgstr ""
+
+#: lib/blame.tcl:1275
+msgid "In File:"
+msgstr ""
+
+#: lib/blame.tcl:1280
+msgid "Copied Or Moved Here By:"
+msgstr ""
+
+#: lib/about.tcl:26
+msgid "git-gui - a graphical user interface for Git."
+msgstr ""
+
+#: lib/choose_repository.tcl:33
 msgid "Git Gui"
 msgstr ""
 
-#: lib/choose_repository.tcl:87 lib/choose_repository.tcl:386
+#: lib/choose_repository.tcl:92 lib/choose_repository.tcl:412
 msgid "Create New Repository"
 msgstr ""
 
-#: lib/choose_repository.tcl:93
+#: lib/choose_repository.tcl:98
 msgid "New..."
 msgstr ""
 
-#: lib/choose_repository.tcl:100 lib/choose_repository.tcl:471
+#: lib/choose_repository.tcl:105 lib/choose_repository.tcl:496
 msgid "Clone Existing Repository"
 msgstr ""
 
-#: lib/choose_repository.tcl:106
+#: lib/choose_repository.tcl:116
 msgid "Clone..."
 msgstr ""
 
-#: lib/choose_repository.tcl:113 lib/choose_repository.tcl:1016
+#: lib/choose_repository.tcl:123 lib/choose_repository.tcl:1064
 msgid "Open Existing Repository"
 msgstr ""
 
-#: lib/choose_repository.tcl:119
+#: lib/choose_repository.tcl:129
 msgid "Open..."
 msgstr ""
 
-#: lib/choose_repository.tcl:132
+#: lib/choose_repository.tcl:142
 msgid "Recent Repositories"
 msgstr ""
 
-#: lib/choose_repository.tcl:138
+#: lib/choose_repository.tcl:148
 msgid "Open Recent Repository:"
 msgstr ""
 
-#: lib/choose_repository.tcl:306 lib/choose_repository.tcl:313
-#: lib/choose_repository.tcl:320
+#: lib/choose_repository.tcl:316 lib/choose_repository.tcl:323
+#: lib/choose_repository.tcl:330
 #, tcl-format
 msgid "Failed to create repository %s:"
 msgstr ""
 
-#: lib/choose_repository.tcl:391
+#: lib/choose_repository.tcl:407 lib/branch_create.tcl:33
+msgid "Create"
+msgstr ""
+
+#: lib/choose_repository.tcl:417
 msgid "Directory:"
 msgstr ""
 
-#: lib/choose_repository.tcl:423 lib/choose_repository.tcl:550
-#: lib/choose_repository.tcl:1052
+#: lib/choose_repository.tcl:422 lib/choose_repository.tcl:509
+#: lib/choose_repository.tcl:518 lib/choose_repository.tcl:1074
+#: lib/browser.tcl:288
+msgid "Browse"
+msgstr ""
+
+#: lib/choose_repository.tcl:447 lib/choose_repository.tcl:573
+#: lib/choose_repository.tcl:1098
 msgid "Git Repository"
 msgstr ""
 
-#: lib/choose_repository.tcl:448
+#: lib/choose_repository.tcl:472
 #, tcl-format
 msgid "Directory %s already exists."
 msgstr ""
 
-#: lib/choose_repository.tcl:452
+#: lib/choose_repository.tcl:476
 #, tcl-format
 msgid "File %s already exists."
 msgstr ""
 
-#: lib/choose_repository.tcl:466
+#: lib/choose_repository.tcl:491
 msgid "Clone"
 msgstr ""
 
-#: lib/choose_repository.tcl:479
+#: lib/choose_repository.tcl:504
 msgid "Source Location:"
 msgstr ""
 
-#: lib/choose_repository.tcl:490
+#: lib/choose_repository.tcl:513
 msgid "Target Directory:"
 msgstr ""
 
-#: lib/choose_repository.tcl:502
+#: lib/choose_repository.tcl:523
 msgid "Clone Type:"
 msgstr ""
 
-#: lib/choose_repository.tcl:508
+#: lib/choose_repository.tcl:528
 msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
 msgstr ""
 
-#: lib/choose_repository.tcl:514
+#: lib/choose_repository.tcl:533
 msgid "Full Copy (Slower, Redundant Backup)"
 msgstr ""
 
-#: lib/choose_repository.tcl:520
+#: lib/choose_repository.tcl:538
 msgid "Shared (Fastest, Not Recommended, No Backup)"
 msgstr ""
 
-#: lib/choose_repository.tcl:556 lib/choose_repository.tcl:603
-#: lib/choose_repository.tcl:749 lib/choose_repository.tcl:819
-#: lib/choose_repository.tcl:1058 lib/choose_repository.tcl:1066
+#: lib/choose_repository.tcl:545
+msgid "Recursively clone submodules too"
+msgstr ""
+
+#: lib/choose_repository.tcl:579 lib/choose_repository.tcl:626
+#: lib/choose_repository.tcl:772 lib/choose_repository.tcl:842
+#: lib/choose_repository.tcl:1104 lib/choose_repository.tcl:1112
 #, tcl-format
 msgid "Not a Git repository: %s"
 msgstr ""
 
-#: lib/choose_repository.tcl:592
+#: lib/choose_repository.tcl:615
 msgid "Standard only available for local repository."
 msgstr ""
 
-#: lib/choose_repository.tcl:596
+#: lib/choose_repository.tcl:619
 msgid "Shared only available for local repository."
 msgstr ""
 
-#: lib/choose_repository.tcl:617
+#: lib/choose_repository.tcl:640
 #, tcl-format
 msgid "Location %s already exists."
 msgstr ""
 
-#: lib/choose_repository.tcl:628
+#: lib/choose_repository.tcl:651
 msgid "Failed to configure origin"
 msgstr ""
 
-#: lib/choose_repository.tcl:640
+#: lib/choose_repository.tcl:663
 msgid "Counting objects"
 msgstr ""
 
-#: lib/choose_repository.tcl:641
+#: lib/choose_repository.tcl:664
 msgid "buckets"
 msgstr ""
 
-#: lib/choose_repository.tcl:665
+#: lib/choose_repository.tcl:688
 #, tcl-format
 msgid "Unable to copy objects/info/alternates: %s"
 msgstr ""
 
-#: lib/choose_repository.tcl:701
+#: lib/choose_repository.tcl:724
 #, tcl-format
 msgid "Nothing to clone from %s."
 msgstr ""
 
-#: lib/choose_repository.tcl:703 lib/choose_repository.tcl:917
-#: lib/choose_repository.tcl:929
+#: lib/choose_repository.tcl:726 lib/choose_repository.tcl:940
+#: lib/choose_repository.tcl:952
 msgid "The 'master' branch has not been initialized."
 msgstr ""
 
-#: lib/choose_repository.tcl:716
+#: lib/choose_repository.tcl:739
 msgid "Hardlinks are unavailable.  Falling back to copying."
 msgstr ""
 
-#: lib/choose_repository.tcl:728
+#: lib/choose_repository.tcl:751
 #, tcl-format
 msgid "Cloning from %s"
 msgstr ""
 
-#: lib/choose_repository.tcl:759
+#: lib/choose_repository.tcl:782
 msgid "Copying objects"
 msgstr ""
 
-#: lib/choose_repository.tcl:760
+#: lib/choose_repository.tcl:783
 msgid "KiB"
 msgstr ""
 
-#: lib/choose_repository.tcl:784
+#: lib/choose_repository.tcl:807
 #, tcl-format
 msgid "Unable to copy object: %s"
 msgstr ""
 
-#: lib/choose_repository.tcl:794
+#: lib/choose_repository.tcl:817
 msgid "Linking objects"
 msgstr ""
 
-#: lib/choose_repository.tcl:795
+#: lib/choose_repository.tcl:818
 msgid "objects"
 msgstr ""
 
-#: lib/choose_repository.tcl:803
+#: lib/choose_repository.tcl:826
 #, tcl-format
 msgid "Unable to hardlink object: %s"
 msgstr ""
 
-#: lib/choose_repository.tcl:858
+#: lib/choose_repository.tcl:881
 msgid "Cannot fetch branches and objects.  See console output for details."
 msgstr ""
 
-#: lib/choose_repository.tcl:869
+#: lib/choose_repository.tcl:892
 msgid "Cannot fetch tags.  See console output for details."
 msgstr ""
 
-#: lib/choose_repository.tcl:893
+#: lib/choose_repository.tcl:916
 msgid "Cannot determine HEAD.  See console output for details."
 msgstr ""
 
-#: lib/choose_repository.tcl:902
+#: lib/choose_repository.tcl:925
 #, tcl-format
 msgid "Unable to cleanup %s"
 msgstr ""
 
-#: lib/choose_repository.tcl:908
+#: lib/choose_repository.tcl:931
 msgid "Clone failed."
 msgstr ""
 
-#: lib/choose_repository.tcl:915
+#: lib/choose_repository.tcl:938
 msgid "No default branch obtained."
 msgstr ""
 
-#: lib/choose_repository.tcl:926
+#: lib/choose_repository.tcl:949
 #, tcl-format
 msgid "Cannot resolve %s as a commit."
 msgstr ""
 
-#: lib/choose_repository.tcl:938
+#: lib/choose_repository.tcl:961
 msgid "Creating working directory"
 msgstr ""
 
-#: lib/choose_repository.tcl:939 lib/index.tcl:67 lib/index.tcl:130
-#: lib/index.tcl:198
+#: lib/choose_repository.tcl:962 lib/index.tcl:70 lib/index.tcl:136
+#: lib/index.tcl:207
 msgid "files"
 msgstr ""
 
-#: lib/choose_repository.tcl:968
+#: lib/choose_repository.tcl:981
+msgid "Cannot clone submodules."
+msgstr ""
+
+#: lib/choose_repository.tcl:990
+msgid "Cloning submodules"
+msgstr ""
+
+#: lib/choose_repository.tcl:1015
 msgid "Initial file checkout failed."
 msgstr ""
 
-#: lib/choose_repository.tcl:1011
+#: lib/choose_repository.tcl:1059
 msgid "Open"
 msgstr ""
 
-#: lib/choose_repository.tcl:1021
+#: lib/choose_repository.tcl:1069
 msgid "Repository:"
 msgstr ""
 
-#: lib/choose_repository.tcl:1072
+#: lib/choose_repository.tcl:1118
 #, tcl-format
 msgid "Failed to open repository %s:"
 msgstr ""
 
-#: lib/choose_rev.tcl:53
-msgid "This Detached Checkout"
+#: lib/branch_rename.tcl:15
+#, tcl-format
+msgid "%s (%s): Rename Branch"
 msgstr ""
 
-#: lib/choose_rev.tcl:60
-msgid "Revision Expression:"
+#: lib/branch_rename.tcl:23
+msgid "Rename Branch"
 msgstr ""
 
-#: lib/choose_rev.tcl:74
-msgid "Local Branch"
+#: lib/branch_rename.tcl:28
+msgid "Rename"
 msgstr ""
 
-#: lib/choose_rev.tcl:79
-msgid "Tracking Branch"
+#: lib/branch_rename.tcl:38
+msgid "Branch:"
 msgstr ""
 
-#: lib/choose_rev.tcl:84 lib/choose_rev.tcl:538
-msgid "Tag"
+#: lib/branch_rename.tcl:46
+msgid "New Name:"
 msgstr ""
 
-#: lib/choose_rev.tcl:317
-#, tcl-format
-msgid "Invalid revision: %s"
+#: lib/branch_rename.tcl:81
+msgid "Please select a branch to rename."
 msgstr ""
 
-#: lib/choose_rev.tcl:338
-msgid "No revision selected."
+#: lib/branch_rename.tcl:92 lib/branch_create.tcl:154
+msgid "Please supply a branch name."
 msgstr ""
 
-#: lib/choose_rev.tcl:346
-msgid "Revision expression is empty."
+#: lib/branch_rename.tcl:112 lib/branch_create.tcl:165
+#, tcl-format
+msgid "'%s' is not an acceptable branch name."
 msgstr ""
 
-#: lib/choose_rev.tcl:531
-msgid "Updated"
+#: lib/branch_rename.tcl:123
+#, tcl-format
+msgid "Failed to rename '%s'."
 msgstr ""
 
-#: lib/choose_rev.tcl:559
-msgid "URL"
+#: lib/shortcut.tcl:8 lib/shortcut.tcl:43 lib/shortcut.tcl:75
+#, tcl-format
+msgid "%s (%s): Create Desktop Icon"
 msgstr ""
 
-#: lib/commit.tcl:9
-msgid ""
-"There is nothing to amend.\n"
-"\n"
-"You are about to create the initial commit.  There is no commit before this "
-"to amend.\n"
+#: lib/shortcut.tcl:24 lib/shortcut.tcl:65
+msgid "Cannot write shortcut:"
 msgstr ""
 
-#: lib/commit.tcl:18
-msgid ""
-"Cannot amend while merging.\n"
-"\n"
-"You are currently in the middle of a merge that has not been fully "
-"completed.  You cannot amend the prior commit unless you first abort the "
-"current merge activity.\n"
+#: lib/shortcut.tcl:140
+msgid "Cannot write icon:"
 msgstr ""
 
-#: lib/commit.tcl:48
-msgid "Error loading commit data for amend:"
+#: lib/search.tcl:48
+msgid "Find:"
 msgstr ""
 
-#: lib/commit.tcl:75
-msgid "Unable to obtain your identity:"
+#: lib/search.tcl:50
+msgid "Next"
 msgstr ""
 
-#: lib/commit.tcl:80
-msgid "Invalid GIT_COMMITTER_IDENT:"
+#: lib/search.tcl:51
+msgid "Prev"
 msgstr ""
 
-#: lib/commit.tcl:129
-#, tcl-format
-msgid "warning: Tcl does not support encoding '%s'."
+#: lib/search.tcl:52
+msgid "RegExp"
 msgstr ""
 
-#: lib/commit.tcl:149
-msgid ""
-"Last scanned state does not match repository state.\n"
-"\n"
-"Another Git program has modified this repository since the last scan.  A "
-"rescan must be performed before another commit can be created.\n"
-"\n"
-"The rescan will be automatically started now.\n"
+#: lib/search.tcl:54
+msgid "Case"
 msgstr ""
 
-#: lib/commit.tcl:172
+#: lib/status_bar.tcl:87
 #, tcl-format
-msgid ""
-"Unmerged files cannot be committed.\n"
-"\n"
-"File %s has merge conflicts.  You must resolve them and stage the file "
-"before committing.\n"
+msgid "%s ... %*i of %*i %s (%3i%%)"
 msgstr ""
 
-#: lib/commit.tcl:180
+#: lib/tools_dlg.tcl:22
 #, tcl-format
-msgid ""
-"Unknown file state %s detected.\n"
-"\n"
-"File %s cannot be committed by this program.\n"
+msgid "%s (%s): Add Tool"
 msgstr ""
 
-#: lib/commit.tcl:188
-msgid ""
-"No changes to commit.\n"
-"\n"
-"You must stage at least 1 file before you can commit.\n"
+#: lib/tools_dlg.tcl:28
+msgid "Add New Tool Command"
 msgstr ""
 
-#: lib/commit.tcl:203
-msgid ""
-"Please supply a commit message.\n"
-"\n"
-"A good commit message has the following format:\n"
-"\n"
-"- First line: Describe in one sentence what you did.\n"
-"- Second line: Blank\n"
-"- Remaining lines: Describe why this change is good.\n"
+#: lib/tools_dlg.tcl:34
+msgid "Add globally"
 msgstr ""
 
-#: lib/commit.tcl:234
-msgid "Calling pre-commit hook..."
+#: lib/tools_dlg.tcl:37 lib/remote_add.tcl:30
+msgid "Add"
 msgstr ""
 
-#: lib/commit.tcl:249
-msgid "Commit declined by pre-commit hook."
+#: lib/tools_dlg.tcl:46
+msgid "Tool Details"
 msgstr ""
 
-#: lib/commit.tcl:272
-msgid "Calling commit-msg hook..."
+#: lib/tools_dlg.tcl:49
+msgid "Use '/' separators to create a submenu tree:"
 msgstr ""
 
-#: lib/commit.tcl:287
-msgid "Commit declined by commit-msg hook."
+#: lib/tools_dlg.tcl:51 lib/remote_add.tcl:41 lib/branch_create.tcl:44
+msgid "Name:"
 msgstr ""
 
-#: lib/commit.tcl:300
-msgid "Committing changes..."
+#: lib/tools_dlg.tcl:60
+msgid "Command:"
 msgstr ""
 
-#: lib/commit.tcl:316
-msgid "write-tree failed:"
+#: lib/tools_dlg.tcl:71
+msgid "Show a dialog before running"
 msgstr ""
 
-#: lib/commit.tcl:317 lib/commit.tcl:361 lib/commit.tcl:382
-msgid "Commit failed."
+#: lib/tools_dlg.tcl:77
+msgid "Ask the user to select a revision (sets $REVISION)"
 msgstr ""
 
-#: lib/commit.tcl:334
-#, tcl-format
-msgid "Commit %s appears to be corrupt"
+#: lib/tools_dlg.tcl:82
+msgid "Ask the user for additional arguments (sets $ARGS)"
 msgstr ""
 
-#: lib/commit.tcl:339
-msgid ""
-"No changes to commit.\n"
-"\n"
-"No files were modified by this commit and it was not a merge commit.\n"
-"\n"
-"A rescan will be automatically started now.\n"
+#: lib/tools_dlg.tcl:89
+msgid "Don't show the command output window"
 msgstr ""
 
-#: lib/commit.tcl:346
-msgid "No changes to commit."
+#: lib/tools_dlg.tcl:94
+msgid "Run only if a diff is selected ($FILENAME not empty)"
 msgstr ""
 
-#: lib/commit.tcl:360
-msgid "commit-tree failed:"
+#: lib/tools_dlg.tcl:118
+msgid "Please supply a name for the tool."
 msgstr ""
 
-#: lib/commit.tcl:381
-msgid "update-ref failed:"
+#: lib/tools_dlg.tcl:126
+#, tcl-format
+msgid "Tool '%s' already exists."
 msgstr ""
 
-#: lib/commit.tcl:469
+#: lib/tools_dlg.tcl:148
 #, tcl-format
-msgid "Created commit %s: %s"
+msgid ""
+"Could not add tool:\n"
+"%s"
 msgstr ""
 
-#: lib/console.tcl:59
-msgid "Working... please wait..."
+#: lib/tools_dlg.tcl:187
+#, tcl-format
+msgid "%s (%s): Remove Tool"
 msgstr ""
 
-#: lib/console.tcl:186
-msgid "Success"
+#: lib/tools_dlg.tcl:193
+msgid "Remove Tool Commands"
 msgstr ""
 
-#: lib/console.tcl:200
-msgid "Error: Command Failed"
+#: lib/tools_dlg.tcl:198
+msgid "Remove"
 msgstr ""
 
-#: lib/database.tcl:43
-msgid "Number of loose objects"
+#: lib/tools_dlg.tcl:231
+msgid "(Blue denotes repository-local tools)"
 msgstr ""
 
-#: lib/database.tcl:44
-msgid "Disk space used by loose objects"
+#: lib/tools_dlg.tcl:283
+#, tcl-format
+msgid "%s (%s):"
 msgstr ""
 
-#: lib/database.tcl:45
-msgid "Number of packed objects"
+#: lib/tools_dlg.tcl:292
+#, tcl-format
+msgid "Run Command: %s"
 msgstr ""
 
-#: lib/database.tcl:46
-msgid "Number of packs"
+#: lib/tools_dlg.tcl:306
+msgid "Arguments"
 msgstr ""
 
-#: lib/database.tcl:47
-msgid "Disk space used by packed objects"
+#: lib/tools_dlg.tcl:321 lib/branch_checkout.tcl:35 lib/browser.tcl:297
+msgid "Revision"
 msgstr ""
 
-#: lib/database.tcl:48
-msgid "Packed objects waiting for pruning"
+#: lib/tools_dlg.tcl:341
+msgid "OK"
 msgstr ""
 
-#: lib/database.tcl:49
-msgid "Garbage files"
+#: lib/tools.tcl:76
+#, tcl-format
+msgid "Running %s requires a selected file."
 msgstr ""
 
-#: lib/database.tcl:72
-msgid "Compressing the object database"
+#: lib/tools.tcl:92
+#, tcl-format
+msgid "Are you sure you want to run %1$s on file \"%2$s\"?"
 msgstr ""
 
-#: lib/database.tcl:83
-msgid "Verifying the object database with fsck-objects"
+#: lib/tools.tcl:96
+#, tcl-format
+msgid "Are you sure you want to run %s?"
 msgstr ""
 
-#: lib/database.tcl:107
+#: lib/tools.tcl:118
 #, tcl-format
-msgid ""
-"This repository currently has approximately %i loose objects.\n"
-"\n"
-"To maintain optimal performance it is strongly recommended that you compress "
-"the database.\n"
-"\n"
-"Compress the database now?"
+msgid "Tool: %s"
 msgstr ""
 
-#: lib/date.tcl:25
+#: lib/tools.tcl:119
 #, tcl-format
-msgid "Invalid date from Git: %s"
+msgid "Running: %s"
 msgstr ""
 
-#: lib/diff.tcl:64
+#: lib/tools.tcl:158
 #, tcl-format
-msgid ""
-"No differences detected.\n"
-"\n"
-"%s has no changes.\n"
-"\n"
-"The modification date of this file was updated by another application, but "
-"the content within the file was not changed.\n"
-"\n"
-"A rescan will be automatically started to find other files which may have "
-"the same state."
+msgid "Tool completed successfully: %s"
 msgstr ""
 
-#: lib/diff.tcl:104
+#: lib/tools.tcl:160
 #, tcl-format
-msgid "Loading diff of %s..."
+msgid "Tool failed: %s"
 msgstr ""
 
-#: lib/diff.tcl:125
-msgid ""
-"LOCAL: deleted\n"
-"REMOTE:\n"
+#: lib/mergetool.tcl:8
+msgid "Force resolution to the base version?"
 msgstr ""
 
-#: lib/diff.tcl:130
-msgid ""
-"REMOTE: deleted\n"
-"LOCAL:\n"
+#: lib/mergetool.tcl:9
+msgid "Force resolution to this branch?"
 msgstr ""
 
-#: lib/diff.tcl:137
-msgid "LOCAL:\n"
+#: lib/mergetool.tcl:10
+msgid "Force resolution to the other branch?"
 msgstr ""
 
-#: lib/diff.tcl:140
-msgid "REMOTE:\n"
+#: lib/mergetool.tcl:14
+#, tcl-format
+msgid ""
+"Note that the diff shows only conflicting changes.\n"
+"\n"
+"%s will be overwritten.\n"
+"\n"
+"This operation can be undone only by restarting the merge."
 msgstr ""
 
-#: lib/diff.tcl:202 lib/diff.tcl:319
+#: lib/mergetool.tcl:45
 #, tcl-format
-msgid "Unable to display %s"
+msgid "File %s seems to have unresolved conflicts, still stage?"
 msgstr ""
 
-#: lib/diff.tcl:203
-msgid "Error loading file:"
+#: lib/mergetool.tcl:60
+#, tcl-format
+msgid "Adding resolution for %s"
 msgstr ""
 
-#: lib/diff.tcl:210
-msgid "Git Repository (subproject)"
+#: lib/mergetool.tcl:141
+msgid "Cannot resolve deletion or link conflicts using a tool"
 msgstr ""
 
-#: lib/diff.tcl:222
-msgid "* Binary file (not showing content)."
+#: lib/mergetool.tcl:146
+msgid "Conflict file does not exist"
 msgstr ""
 
-#: lib/diff.tcl:227
+#: lib/mergetool.tcl:246
+#, tcl-format
+msgid "Not a GUI merge tool: '%s'"
+msgstr ""
+
+#: lib/mergetool.tcl:275
+#, tcl-format
+msgid "Unsupported merge tool '%s'"
+msgstr ""
+
+#: lib/mergetool.tcl:310
+msgid "Merge tool is already running, terminate it?"
+msgstr ""
+
+#: lib/mergetool.tcl:330
 #, tcl-format
 msgid ""
-"* Untracked file is %d bytes.\n"
-"* Showing only first %d bytes.\n"
+"Error retrieving versions:\n"
+"%s"
 msgstr ""
 
-#: lib/diff.tcl:233
+#: lib/mergetool.tcl:350
 #, tcl-format
 msgid ""
+"Could not start the merge tool:\n"
 "\n"
-"* Untracked file clipped here by %s.\n"
-"* To see the entire file, use an external editor.\n"
+"%s"
 msgstr ""
 
-#: lib/diff.tcl:482
-msgid "Failed to unstage selected hunk."
+#: lib/mergetool.tcl:354
+msgid "Running merge tool..."
 msgstr ""
 
-#: lib/diff.tcl:489
-msgid "Failed to stage selected hunk."
+#: lib/mergetool.tcl:382 lib/mergetool.tcl:390
+msgid "Merge tool failed."
 msgstr ""
 
-#: lib/diff.tcl:568
-msgid "Failed to unstage selected line."
+#: lib/option.tcl:11
+#, tcl-format
+msgid "Invalid global encoding '%s'"
 msgstr ""
 
-#: lib/diff.tcl:576
-msgid "Failed to stage selected line."
+#: lib/option.tcl:19
+#, tcl-format
+msgid "Invalid repo encoding '%s'"
 msgstr ""
 
-#: lib/encoding.tcl:443
-msgid "Default"
+#: lib/option.tcl:119
+msgid "Restore Defaults"
 msgstr ""
 
-#: lib/encoding.tcl:448
+#: lib/option.tcl:123
+msgid "Save"
+msgstr ""
+
+#: lib/option.tcl:133
 #, tcl-format
-msgid "System (%s)"
+msgid "%s Repository"
 msgstr ""
 
-#: lib/encoding.tcl:459 lib/encoding.tcl:465
-msgid "Other"
+#: lib/option.tcl:134
+msgid "Global (All Repositories)"
 msgstr ""
 
-#: lib/error.tcl:20 lib/error.tcl:114
-msgid "error"
+#: lib/option.tcl:140
+msgid "User Name"
 msgstr ""
 
-#: lib/error.tcl:36
-msgid "warning"
+#: lib/option.tcl:141
+msgid "Email Address"
 msgstr ""
 
-#: lib/error.tcl:94
-msgid "You must correct the above errors before committing."
+#: lib/option.tcl:143
+msgid "Summarize Merge Commits"
 msgstr ""
 
-#: lib/index.tcl:6
-msgid "Unable to unlock the index."
+#: lib/option.tcl:144
+msgid "Merge Verbosity"
 msgstr ""
 
-#: lib/index.tcl:15
-msgid "Index Error"
+#: lib/option.tcl:145
+msgid "Show Diffstat After Merge"
 msgstr ""
 
-#: lib/index.tcl:17
-msgid ""
-"Updating the Git index failed.  A rescan will be automatically started to "
-"resynchronize git-gui."
+#: lib/option.tcl:146
+msgid "Use Merge Tool"
 msgstr ""
 
-#: lib/index.tcl:28
-msgid "Continue"
+#: lib/option.tcl:148
+msgid "Trust File Modification Timestamps"
 msgstr ""
 
-#: lib/index.tcl:31
-msgid "Unlock Index"
+#: lib/option.tcl:149
+msgid "Prune Tracking Branches During Fetch"
 msgstr ""
 
-#: lib/index.tcl:289
-#, tcl-format
-msgid "Unstaging %s from commit"
+#: lib/option.tcl:150
+msgid "Match Tracking Branches"
 msgstr ""
 
-#: lib/index.tcl:328
-msgid "Ready to commit."
+#: lib/option.tcl:151
+msgid "Use Textconv For Diffs and Blames"
 msgstr ""
 
-#: lib/index.tcl:341
-#, tcl-format
-msgid "Adding %s"
+#: lib/option.tcl:152
+msgid "Blame Copy Only On Changed Files"
 msgstr ""
 
-#: lib/index.tcl:398
-#, tcl-format
-msgid "Revert changes in file %s?"
+#: lib/option.tcl:153
+msgid "Maximum Length of Recent Repositories List"
 msgstr ""
 
-#: lib/index.tcl:400
-#, tcl-format
-msgid "Revert changes in these %i files?"
+#: lib/option.tcl:154
+msgid "Minimum Letters To Blame Copy On"
 msgstr ""
 
-#: lib/index.tcl:408
-msgid "Any unstaged changes will be permanently lost by the revert."
+#: lib/option.tcl:155
+msgid "Blame History Context Radius (days)"
 msgstr ""
 
-#: lib/index.tcl:411
-msgid "Do Nothing"
+#: lib/option.tcl:156
+msgid "Number of Diff Context Lines"
 msgstr ""
 
-#: lib/index.tcl:429
-msgid "Reverting selected files"
+#: lib/option.tcl:157
+msgid "Additional Diff Parameters"
 msgstr ""
 
-#: lib/index.tcl:433
-#, tcl-format
-msgid "Reverting %s"
+#: lib/option.tcl:158
+msgid "Commit Message Text Width"
 msgstr ""
 
-#: lib/merge.tcl:13
-msgid ""
-"Cannot merge while amending.\n"
-"\n"
-"You must finish amending this commit before starting any type of merge.\n"
+#: lib/option.tcl:159
+msgid "New Branch Name Template"
 msgstr ""
 
-#: lib/merge.tcl:27
-msgid ""
-"Last scanned state does not match repository state.\n"
-"\n"
-"Another Git program has modified this repository since the last scan.  A "
-"rescan must be performed before a merge can be performed.\n"
-"\n"
-"The rescan will be automatically started now.\n"
+#: lib/option.tcl:160
+msgid "Default File Contents Encoding"
 msgstr ""
 
-#: lib/merge.tcl:45
-#, tcl-format
-msgid ""
-"You are in the middle of a conflicted merge.\n"
-"\n"
-"File %s has merge conflicts.\n"
-"\n"
-"You must resolve them, stage the file, and commit to complete the current "
-"merge.  Only then can you begin another merge.\n"
+#: lib/option.tcl:161
+msgid "Warn before committing to a detached head"
 msgstr ""
 
-#: lib/merge.tcl:55
-#, tcl-format
-msgid ""
-"You are in the middle of a change.\n"
-"\n"
-"File %s is modified.\n"
-"\n"
-"You should complete the current commit before starting a merge.  Doing so "
-"will help you abort a failed merge, should the need arise.\n"
+#: lib/option.tcl:162
+msgid "Staging of untracked files"
 msgstr ""
 
-#: lib/merge.tcl:107
-#, tcl-format
-msgid "%s of %s"
+#: lib/option.tcl:163
+msgid "Show untracked files"
+msgstr ""
+
+#: lib/option.tcl:164
+msgid "Tab spacing"
 msgstr ""
 
-#: lib/merge.tcl:120
+#: lib/option.tcl:182 lib/option.tcl:197 lib/option.tcl:220 lib/option.tcl:282
+#: lib/database.tcl:57
 #, tcl-format
-msgid "Merging %s and %s..."
+msgid "%s:"
 msgstr ""
 
-#: lib/merge.tcl:131
-msgid "Merge completed successfully."
+#: lib/option.tcl:210
+msgid "Change"
 msgstr ""
 
-#: lib/merge.tcl:133
-msgid "Merge failed.  Conflict resolution is required."
+#: lib/option.tcl:254
+msgid "Spelling Dictionary:"
 msgstr ""
 
-#: lib/merge.tcl:158
+#: lib/option.tcl:284
+msgid "Change Font"
+msgstr ""
+
+#: lib/option.tcl:288
 #, tcl-format
-msgid "Merge Into %s"
+msgid "Choose %s"
 msgstr ""
 
-#: lib/merge.tcl:177
-msgid "Revision To Merge"
+#: lib/option.tcl:294
+msgid "pt."
 msgstr ""
 
-#: lib/merge.tcl:212
-msgid ""
-"Cannot abort while amending.\n"
-"\n"
-"You must finish amending this commit.\n"
+#: lib/option.tcl:308
+msgid "Preferences"
 msgstr ""
 
-#: lib/merge.tcl:222
-msgid ""
-"Abort merge?\n"
-"\n"
-"Aborting the current merge will cause *ALL* uncommitted changes to be lost.\n"
-"\n"
-"Continue with aborting the current merge?"
+#: lib/option.tcl:310 lib/branch_checkout.tcl:39 lib/branch_create.tcl:69
+msgid "Options"
 msgstr ""
 
-#: lib/merge.tcl:228
-msgid ""
-"Reset changes?\n"
-"\n"
-"Resetting the changes will cause *ALL* uncommitted changes to be lost.\n"
-"\n"
-"Continue with resetting the current changes?"
+#: lib/option.tcl:345
+msgid "Failed to completely save options:"
 msgstr ""
 
-#: lib/merge.tcl:239
-msgid "Aborting"
+#: lib/database.tcl:42
+msgid "Number of loose objects"
 msgstr ""
 
-#: lib/merge.tcl:239
-msgid "files reset"
+#: lib/database.tcl:43
+msgid "Disk space used by loose objects"
 msgstr ""
 
-#: lib/merge.tcl:267
-msgid "Abort failed."
+#: lib/database.tcl:44
+msgid "Number of packed objects"
 msgstr ""
 
-#: lib/merge.tcl:269
-msgid "Abort completed.  Ready."
+#: lib/database.tcl:45
+msgid "Number of packs"
 msgstr ""
 
-#: lib/mergetool.tcl:8
-msgid "Force resolution to the base version?"
+#: lib/database.tcl:46
+msgid "Disk space used by packed objects"
 msgstr ""
 
-#: lib/mergetool.tcl:9
-msgid "Force resolution to this branch?"
+#: lib/database.tcl:47
+msgid "Packed objects waiting for pruning"
 msgstr ""
 
-#: lib/mergetool.tcl:10
-msgid "Force resolution to the other branch?"
+#: lib/database.tcl:48
+msgid "Garbage files"
 msgstr ""
 
-#: lib/mergetool.tcl:14
+#: lib/database.tcl:66
+#, tcl-format
+msgid "%s (%s): Database Statistics"
+msgstr ""
+
+#: lib/database.tcl:72
+msgid "Compressing the object database"
+msgstr ""
+
+#: lib/database.tcl:83
+msgid "Verifying the object database with fsck-objects"
+msgstr ""
+
+#: lib/database.tcl:107
 #, tcl-format
 msgid ""
-"Note that the diff shows only conflicting changes.\n"
+"This repository currently has approximately %i loose objects.\n"
 "\n"
-"%s will be overwritten.\n"
+"To maintain optimal performance it is strongly recommended that you compress "
+"the database.\n"
 "\n"
-"This operation can be undone only by restarting the merge."
+"Compress the database now?"
 msgstr ""
 
-#: lib/mergetool.tcl:45
+#: lib/transport.tcl:6 lib/remote_add.tcl:132
 #, tcl-format
-msgid "File %s seems to have unresolved conflicts, still stage?"
+msgid "fetch %s"
 msgstr ""
 
-#: lib/mergetool.tcl:60
+#: lib/transport.tcl:7
 #, tcl-format
-msgid "Adding resolution for %s"
+msgid "Fetching new changes from %s"
 msgstr ""
 
-#: lib/mergetool.tcl:141
-msgid "Cannot resolve deletion or link conflicts using a tool"
+#: lib/transport.tcl:18
+#, tcl-format
+msgid "remote prune %s"
 msgstr ""
 
-#: lib/mergetool.tcl:146
-msgid "Conflict file does not exist"
+#: lib/transport.tcl:19
+#, tcl-format
+msgid "Pruning tracking branches deleted from %s"
 msgstr ""
 
-#: lib/mergetool.tcl:264
-#, tcl-format
-msgid "Not a GUI merge tool: '%s'"
+#: lib/transport.tcl:25
+msgid "fetch all remotes"
+msgstr ""
+
+#: lib/transport.tcl:26
+msgid "Fetching new changes from all remotes"
+msgstr ""
+
+#: lib/transport.tcl:40
+msgid "remote prune all remotes"
+msgstr ""
+
+#: lib/transport.tcl:41
+msgid "Pruning tracking branches deleted from all remotes"
 msgstr ""
 
-#: lib/mergetool.tcl:268
+#: lib/transport.tcl:54 lib/transport.tcl:92 lib/transport.tcl:110
+#: lib/remote_add.tcl:162
 #, tcl-format
-msgid "Unsupported merge tool '%s'"
+msgid "push %s"
 msgstr ""
 
-#: lib/mergetool.tcl:303
-msgid "Merge tool is already running, terminate it?"
+#: lib/transport.tcl:55
+#, tcl-format
+msgid "Pushing changes to %s"
 msgstr ""
 
-#: lib/mergetool.tcl:323
+#: lib/transport.tcl:93
 #, tcl-format
-msgid ""
-"Error retrieving versions:\n"
-"%s"
+msgid "Mirroring to %s"
 msgstr ""
 
-#: lib/mergetool.tcl:343
+#: lib/transport.tcl:111
 #, tcl-format
-msgid ""
-"Could not start the merge tool:\n"
-"\n"
-"%s"
+msgid "Pushing %s %s to %s"
 msgstr ""
 
-#: lib/mergetool.tcl:347
-msgid "Running merge tool..."
+#: lib/transport.tcl:132
+msgid "Push Branches"
 msgstr ""
 
-#: lib/mergetool.tcl:375 lib/mergetool.tcl:383
-msgid "Merge tool failed."
+#: lib/transport.tcl:147
+msgid "Source Branches"
 msgstr ""
 
-#: lib/option.tcl:11
-#, tcl-format
-msgid "Invalid global encoding '%s'"
+#: lib/transport.tcl:162
+msgid "Destination Repository"
 msgstr ""
 
-#: lib/option.tcl:19
-#, tcl-format
-msgid "Invalid repo encoding '%s'"
+#: lib/transport.tcl:205
+msgid "Transfer Options"
 msgstr ""
 
-#: lib/option.tcl:117
-msgid "Restore Defaults"
+#: lib/transport.tcl:207
+msgid "Force overwrite existing branch (may discard changes)"
 msgstr ""
 
-#: lib/option.tcl:121
-msgid "Save"
+#: lib/transport.tcl:211
+msgid "Use thin pack (for slow network connections)"
 msgstr ""
 
-#: lib/option.tcl:131
+#: lib/transport.tcl:215
+msgid "Include tags"
+msgstr ""
+
+#: lib/transport.tcl:229
 #, tcl-format
-msgid "%s Repository"
+msgid "%s (%s): Push"
 msgstr ""
 
-#: lib/option.tcl:132
-msgid "Global (All Repositories)"
+#: lib/choose_font.tcl:41
+msgid "Select"
 msgstr ""
 
-#: lib/option.tcl:138
-msgid "User Name"
+#: lib/choose_font.tcl:55
+msgid "Font Family"
 msgstr ""
 
-#: lib/option.tcl:139
-msgid "Email Address"
+#: lib/choose_font.tcl:76
+msgid "Font Size"
 msgstr ""
 
-#: lib/option.tcl:141
-msgid "Summarize Merge Commits"
+#: lib/choose_font.tcl:93
+msgid "Font Example"
 msgstr ""
 
-#: lib/option.tcl:142
-msgid "Merge Verbosity"
+#: lib/choose_font.tcl:105
+msgid ""
+"This is example text.\n"
+"If you like this text, it can be your font."
 msgstr ""
 
-#: lib/option.tcl:143
-msgid "Show Diffstat After Merge"
+#: lib/remote.tcl:200
+msgid "Push to"
 msgstr ""
 
-#: lib/option.tcl:144
-msgid "Use Merge Tool"
+#: lib/remote.tcl:218
+msgid "Remove Remote"
 msgstr ""
 
-#: lib/option.tcl:146
-msgid "Trust File Modification Timestamps"
+#: lib/remote.tcl:223
+msgid "Prune from"
 msgstr ""
 
-#: lib/option.tcl:147
-msgid "Prune Tracking Branches During Fetch"
+#: lib/remote.tcl:228
+msgid "Fetch from"
 msgstr ""
 
-#: lib/option.tcl:148
-msgid "Match Tracking Branches"
+#: lib/diff.tcl:77
+#, tcl-format
+msgid ""
+"No differences detected.\n"
+"\n"
+"%s has no changes.\n"
+"\n"
+"The modification date of this file was updated by another application, but "
+"the content within the file was not changed.\n"
+"\n"
+"A rescan will be automatically started to find other files which may have "
+"the same state."
 msgstr ""
 
-#: lib/option.tcl:149
-msgid "Blame Copy Only On Changed Files"
+#: lib/diff.tcl:117
+#, tcl-format
+msgid "Loading diff of %s..."
 msgstr ""
 
-#: lib/option.tcl:150
-msgid "Minimum Letters To Blame Copy On"
+#: lib/diff.tcl:143
+msgid ""
+"LOCAL: deleted\n"
+"REMOTE:\n"
 msgstr ""
 
-#: lib/option.tcl:151
-msgid "Blame History Context Radius (days)"
+#: lib/diff.tcl:148
+msgid ""
+"REMOTE: deleted\n"
+"LOCAL:\n"
 msgstr ""
 
-#: lib/option.tcl:152
-msgid "Number of Diff Context Lines"
+#: lib/diff.tcl:155
+msgid "LOCAL:\n"
 msgstr ""
 
-#: lib/option.tcl:153
-msgid "Commit Message Text Width"
+#: lib/diff.tcl:158
+msgid "REMOTE:\n"
 msgstr ""
 
-#: lib/option.tcl:154
-msgid "New Branch Name Template"
+#: lib/diff.tcl:220 lib/diff.tcl:357
+#, tcl-format
+msgid "Unable to display %s"
 msgstr ""
 
-#: lib/option.tcl:155
-msgid "Default File Contents Encoding"
+#: lib/diff.tcl:221
+msgid "Error loading file:"
 msgstr ""
 
-#: lib/option.tcl:203
-msgid "Change"
+#: lib/diff.tcl:227
+msgid "Git Repository (subproject)"
 msgstr ""
 
-#: lib/option.tcl:230
-msgid "Spelling Dictionary:"
+#: lib/diff.tcl:239
+msgid "* Binary file (not showing content)."
 msgstr ""
 
-#: lib/option.tcl:254
-msgid "Change Font"
+#: lib/diff.tcl:244
+#, tcl-format
+msgid ""
+"* Untracked file is %d bytes.\n"
+"* Showing only first %d bytes.\n"
 msgstr ""
 
-#: lib/option.tcl:258
+#: lib/diff.tcl:250
 #, tcl-format
-msgid "Choose %s"
+msgid ""
+"\n"
+"* Untracked file clipped here by %s.\n"
+"* To see the entire file, use an external editor.\n"
 msgstr ""
 
-#: lib/option.tcl:264
-msgid "pt."
+#: lib/diff.tcl:580
+msgid "Failed to unstage selected hunk."
 msgstr ""
 
-#: lib/option.tcl:278
-msgid "Preferences"
+#: lib/diff.tcl:587
+msgid "Failed to stage selected hunk."
 msgstr ""
 
-#: lib/option.tcl:314
-msgid "Failed to completely save options:"
+#: lib/diff.tcl:666
+msgid "Failed to unstage selected line."
 msgstr ""
 
-#: lib/remote.tcl:163
-msgid "Remove Remote"
+#: lib/diff.tcl:674
+msgid "Failed to stage selected line."
 msgstr ""
 
-#: lib/remote.tcl:168
-msgid "Prune from"
+#: lib/commit.tcl:9
+msgid ""
+"There is nothing to amend.\n"
+"\n"
+"You are about to create the initial commit.  There is no commit before this "
+"to amend.\n"
 msgstr ""
 
-#: lib/remote.tcl:173
-msgid "Fetch from"
+#: lib/commit.tcl:18
+msgid ""
+"Cannot amend while merging.\n"
+"\n"
+"You are currently in the middle of a merge that has not been fully "
+"completed.  You cannot amend the prior commit unless you first abort the "
+"current merge activity.\n"
 msgstr ""
 
-#: lib/remote.tcl:215
-msgid "Push to"
+#: lib/commit.tcl:48
+msgid "Error loading commit data for amend:"
 msgstr ""
 
-#: lib/remote_add.tcl:19
-msgid "Add Remote"
+#: lib/commit.tcl:75
+msgid "Unable to obtain your identity:"
 msgstr ""
 
-#: lib/remote_add.tcl:24
-msgid "Add New Remote"
+#: lib/commit.tcl:80
+msgid "Invalid GIT_COMMITTER_IDENT:"
+msgstr ""
+
+#: lib/commit.tcl:129
+#, tcl-format
+msgid "warning: Tcl does not support encoding '%s'."
+msgstr ""
+
+#: lib/commit.tcl:149
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.  A "
+"rescan must be performed before another commit can be created.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+
+#: lib/commit.tcl:173
+#, tcl-format
+msgid ""
+"Unmerged files cannot be committed.\n"
+"\n"
+"File %s has merge conflicts.  You must resolve them and stage the file "
+"before committing.\n"
 msgstr ""
 
-#: lib/remote_add.tcl:28 lib/tools_dlg.tcl:36
-msgid "Add"
+#: lib/commit.tcl:181
+#, tcl-format
+msgid ""
+"Unknown file state %s detected.\n"
+"\n"
+"File %s cannot be committed by this program.\n"
 msgstr ""
 
-#: lib/remote_add.tcl:37
-msgid "Remote Details"
+#: lib/commit.tcl:189
+msgid ""
+"No changes to commit.\n"
+"\n"
+"You must stage at least 1 file before you can commit.\n"
 msgstr ""
 
-#: lib/remote_add.tcl:50
-msgid "Location:"
+#: lib/commit.tcl:204
+msgid ""
+"Please supply a commit message.\n"
+"\n"
+"A good commit message has the following format:\n"
+"\n"
+"- First line: Describe in one sentence what you did.\n"
+"- Second line: Blank\n"
+"- Remaining lines: Describe why this change is good.\n"
 msgstr ""
 
-#: lib/remote_add.tcl:62
-msgid "Further Action"
+#: lib/commit.tcl:235
+msgid "Calling pre-commit hook..."
 msgstr ""
 
-#: lib/remote_add.tcl:65
-msgid "Fetch Immediately"
+#: lib/commit.tcl:250
+msgid "Commit declined by pre-commit hook."
 msgstr ""
 
-#: lib/remote_add.tcl:71
-msgid "Initialize Remote Repository and Push"
+#: lib/commit.tcl:269
+msgid ""
+"You are about to commit on a detached head. This is a potentially dangerous "
+"thing to do because if you switch to another branch you will lose your "
+"changes and it can be difficult to retrieve them later from the reflog. You "
+"should probably cancel this commit and create a new branch to continue.\n"
+" \n"
+" Do you really want to proceed with your Commit?"
 msgstr ""
 
-#: lib/remote_add.tcl:77
-msgid "Do Nothing Else Now"
+#: lib/commit.tcl:290
+msgid "Calling commit-msg hook..."
 msgstr ""
 
-#: lib/remote_add.tcl:101
-msgid "Please supply a remote name."
+#: lib/commit.tcl:305
+msgid "Commit declined by commit-msg hook."
 msgstr ""
 
-#: lib/remote_add.tcl:114
-#, tcl-format
-msgid "'%s' is not an acceptable remote name."
+#: lib/commit.tcl:318
+msgid "Committing changes..."
 msgstr ""
 
-#: lib/remote_add.tcl:125
-#, tcl-format
-msgid "Failed to add remote '%s' of location '%s'."
+#: lib/commit.tcl:334
+msgid "write-tree failed:"
 msgstr ""
 
-#: lib/remote_add.tcl:133 lib/transport.tcl:6
-#, tcl-format
-msgid "fetch %s"
+#: lib/commit.tcl:335 lib/commit.tcl:382 lib/commit.tcl:403
+msgid "Commit failed."
 msgstr ""
 
-#: lib/remote_add.tcl:134
+#: lib/commit.tcl:352
 #, tcl-format
-msgid "Fetching the %s"
+msgid "Commit %s appears to be corrupt"
 msgstr ""
 
-#: lib/remote_add.tcl:157
-#, tcl-format
-msgid "Do not know how to initialize repository at location '%s'."
+#: lib/commit.tcl:357
+msgid ""
+"No changes to commit.\n"
+"\n"
+"No files were modified by this commit and it was not a merge commit.\n"
+"\n"
+"A rescan will be automatically started now.\n"
 msgstr ""
 
-#: lib/remote_add.tcl:163 lib/transport.tcl:25 lib/transport.tcl:63
-#: lib/transport.tcl:81
-#, tcl-format
-msgid "push %s"
+#: lib/commit.tcl:364
+msgid "No changes to commit."
 msgstr ""
 
-#: lib/remote_add.tcl:164
-#, tcl-format
-msgid "Setting up the %s (at %s)"
+#: lib/commit.tcl:381
+msgid "commit-tree failed:"
 msgstr ""
 
-#: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
-msgid "Delete Branch Remotely"
+#: lib/commit.tcl:402
+msgid "update-ref failed:"
 msgstr ""
 
-#: lib/remote_branch_delete.tcl:47
-msgid "From Repository"
+#: lib/commit.tcl:495
+#, tcl-format
+msgid "Created commit %s: %s"
 msgstr ""
 
-#: lib/remote_branch_delete.tcl:50 lib/transport.tcl:134
-msgid "Remote:"
+#: lib/branch_checkout.tcl:16
+#, tcl-format
+msgid "%s (%s): Checkout Branch"
 msgstr ""
 
-#: lib/remote_branch_delete.tcl:66 lib/transport.tcl:149
-msgid "Arbitrary Location:"
+#: lib/branch_checkout.tcl:21
+msgid "Checkout Branch"
 msgstr ""
 
-#: lib/remote_branch_delete.tcl:84
-msgid "Branches"
+#: lib/branch_checkout.tcl:26
+msgid "Checkout"
 msgstr ""
 
-#: lib/remote_branch_delete.tcl:109
-msgid "Delete Only If"
+#: lib/branch_checkout.tcl:42 lib/branch_create.tcl:92
+msgid "Fetch Tracking Branch"
 msgstr ""
 
-#: lib/remote_branch_delete.tcl:111
-msgid "Merged Into:"
+#: lib/branch_checkout.tcl:47
+msgid "Detach From Local Branch"
 msgstr ""
 
-#: lib/remote_branch_delete.tcl:152
-msgid "A branch is required for 'Merged Into'."
+#: lib/index.tcl:6
+msgid "Unable to unlock the index."
 msgstr ""
 
-#: lib/remote_branch_delete.tcl:184
-#, tcl-format
-msgid ""
-"The following branches are not completely merged into %s:\n"
-"\n"
-" - %s"
+#: lib/index.tcl:17
+msgid "Index Error"
 msgstr ""
 
-#: lib/remote_branch_delete.tcl:189
-#, tcl-format
+#: lib/index.tcl:19
 msgid ""
-"One or more of the merge tests failed because you have not fetched the "
-"necessary commits.  Try fetching from %s first."
+"Updating the Git index failed.  A rescan will be automatically started to "
+"resynchronize git-gui."
 msgstr ""
 
-#: lib/remote_branch_delete.tcl:207
-msgid "Please select one or more branches to delete."
+#: lib/index.tcl:30
+msgid "Continue"
 msgstr ""
 
-#: lib/remote_branch_delete.tcl:226
-#, tcl-format
-msgid "Deleting branches from %s"
+#: lib/index.tcl:33
+msgid "Unlock Index"
 msgstr ""
 
-#: lib/remote_branch_delete.tcl:292
-msgid "No repository selected."
+#: lib/index.tcl:294
+msgid "Unstaging selected files from commit"
 msgstr ""
 
-#: lib/remote_branch_delete.tcl:297
+#: lib/index.tcl:298
 #, tcl-format
-msgid "Scanning %s..."
-msgstr ""
-
-#: lib/search.tcl:21
-msgid "Find:"
-msgstr ""
-
-#: lib/search.tcl:23
-msgid "Next"
-msgstr ""
-
-#: lib/search.tcl:24
-msgid "Prev"
-msgstr ""
-
-#: lib/search.tcl:25
-msgid "Case-Sensitive"
+msgid "Unstaging %s from commit"
 msgstr ""
 
-#: lib/shortcut.tcl:21 lib/shortcut.tcl:62
-msgid "Cannot write shortcut:"
+#: lib/index.tcl:337
+msgid "Ready to commit."
 msgstr ""
 
-#: lib/shortcut.tcl:137
-msgid "Cannot write icon:"
+#: lib/index.tcl:346
+msgid "Adding selected files"
 msgstr ""
 
-#: lib/spellcheck.tcl:57
-msgid "Unsupported spell checker"
+#: lib/index.tcl:350
+#, tcl-format
+msgid "Adding %s"
 msgstr ""
 
-#: lib/spellcheck.tcl:65
-msgid "Spell checking is unavailable"
+#: lib/index.tcl:380
+#, tcl-format
+msgid "Stage %d untracked files?"
 msgstr ""
 
-#: lib/spellcheck.tcl:68
-msgid "Invalid spell checking configuration"
+#: lib/index.tcl:388
+msgid "Adding all changed files"
 msgstr ""
 
-#: lib/spellcheck.tcl:70
+#: lib/index.tcl:428
 #, tcl-format
-msgid "Reverting dictionary to %s."
+msgid "Revert changes in file %s?"
 msgstr ""
 
-#: lib/spellcheck.tcl:73
-msgid "Spell checker silently failed on startup"
+#: lib/index.tcl:430
+#, tcl-format
+msgid "Revert changes in these %i files?"
 msgstr ""
 
-#: lib/spellcheck.tcl:80
-msgid "Unrecognized spell checker"
+#: lib/index.tcl:438
+msgid "Any unstaged changes will be permanently lost by the revert."
 msgstr ""
 
-#: lib/spellcheck.tcl:186
-msgid "No Suggestions"
+#: lib/index.tcl:441
+msgid "Do Nothing"
 msgstr ""
 
-#: lib/spellcheck.tcl:388
-msgid "Unexpected EOF from spell checker"
+#: lib/index.tcl:459
+msgid "Reverting selected files"
 msgstr ""
 
-#: lib/spellcheck.tcl:392
-msgid "Spell Checker Failed"
+#: lib/index.tcl:463
+#, tcl-format
+msgid "Reverting %s"
 msgstr ""
 
 #: lib/sshkey.tcl:31
@@ -2178,19 +2387,19 @@ msgstr ""
 msgid "Generate Key"
 msgstr ""
 
-#: lib/sshkey.tcl:56
+#: lib/sshkey.tcl:58
 msgid "Copy To Clipboard"
 msgstr ""
 
-#: lib/sshkey.tcl:70
+#: lib/sshkey.tcl:72
 msgid "Your OpenSSH Public Key"
 msgstr ""
 
-#: lib/sshkey.tcl:78
+#: lib/sshkey.tcl:80
 msgid "Generating..."
 msgstr ""
 
-#: lib/sshkey.tcl:84
+#: lib/sshkey.tcl:86
 #, tcl-format
 msgid ""
 "Could not start ssh-keygen:\n"
@@ -2198,197 +2407,195 @@ msgid ""
 "%s"
 msgstr ""
 
-#: lib/sshkey.tcl:111
+#: lib/sshkey.tcl:113
 msgid "Generation failed."
 msgstr ""
 
-#: lib/sshkey.tcl:118
+#: lib/sshkey.tcl:120
 msgid "Generation succeeded, but no keys found."
 msgstr ""
 
-#: lib/sshkey.tcl:121
+#: lib/sshkey.tcl:123
 #, tcl-format
 msgid "Your key is in: %s"
 msgstr ""
 
-#: lib/status_bar.tcl:83
-#, tcl-format
-msgid "%s ... %*i of %*i %s (%3i%%)"
+#: lib/browser.tcl:17
+msgid "Starting..."
 msgstr ""
 
-#: lib/tools.tcl:75
+#: lib/browser.tcl:27
 #, tcl-format
-msgid "Running %s requires a selected file."
+msgid "%s (%s): File Browser"
 msgstr ""
 
-#: lib/tools.tcl:90
+#: lib/browser.tcl:132 lib/browser.tcl:149
 #, tcl-format
-msgid "Are you sure you want to run %s?"
+msgid "Loading %s..."
 msgstr ""
 
-#: lib/tools.tcl:110
-#, tcl-format
-msgid "Tool: %s"
+#: lib/browser.tcl:193
+msgid "[Up To Parent]"
 msgstr ""
 
-#: lib/tools.tcl:111
+#: lib/browser.tcl:275
 #, tcl-format
-msgid "Running: %s"
+msgid "%s (%s): Browse Branch Files"
 msgstr ""
 
-#: lib/tools.tcl:149
-#, tcl-format
-msgid "Tool completed successfully: %s"
+#: lib/browser.tcl:282
+msgid "Browse Branch Files"
 msgstr ""
 
-#: lib/tools.tcl:151
+#: lib/remote_add.tcl:20
 #, tcl-format
-msgid "Tool failed: %s"
+msgid "%s (%s): Add Remote"
 msgstr ""
 
-#: lib/tools_dlg.tcl:22
-msgid "Add Tool"
+#: lib/remote_add.tcl:25
+msgid "Add New Remote"
 msgstr ""
 
-#: lib/tools_dlg.tcl:28
-msgid "Add New Tool Command"
+#: lib/remote_add.tcl:39
+msgid "Remote Details"
 msgstr ""
 
-#: lib/tools_dlg.tcl:33
-msgid "Add globally"
+#: lib/remote_add.tcl:50
+msgid "Location:"
 msgstr ""
 
-#: lib/tools_dlg.tcl:45
-msgid "Tool Details"
+#: lib/remote_add.tcl:60
+msgid "Further Action"
 msgstr ""
 
-#: lib/tools_dlg.tcl:48
-msgid "Use '/' separators to create a submenu tree:"
+#: lib/remote_add.tcl:63
+msgid "Fetch Immediately"
 msgstr ""
 
-#: lib/tools_dlg.tcl:61
-msgid "Command:"
+#: lib/remote_add.tcl:69
+msgid "Initialize Remote Repository and Push"
 msgstr ""
 
-#: lib/tools_dlg.tcl:74
-msgid "Show a dialog before running"
+#: lib/remote_add.tcl:75
+msgid "Do Nothing Else Now"
 msgstr ""
 
-#: lib/tools_dlg.tcl:80
-msgid "Ask the user to select a revision (sets $REVISION)"
+#: lib/remote_add.tcl:100
+msgid "Please supply a remote name."
 msgstr ""
 
-#: lib/tools_dlg.tcl:85
-msgid "Ask the user for additional arguments (sets $ARGS)"
+#: lib/remote_add.tcl:113
+#, tcl-format
+msgid "'%s' is not an acceptable remote name."
 msgstr ""
 
-#: lib/tools_dlg.tcl:92
-msgid "Don't show the command output window"
+#: lib/remote_add.tcl:124
+#, tcl-format
+msgid "Failed to add remote '%s' of location '%s'."
 msgstr ""
 
-#: lib/tools_dlg.tcl:97
-msgid "Run only if a diff is selected ($FILENAME not empty)"
+#: lib/remote_add.tcl:133
+#, tcl-format
+msgid "Fetching the %s"
 msgstr ""
 
-#: lib/tools_dlg.tcl:121
-msgid "Please supply a name for the tool."
+#: lib/remote_add.tcl:156
+#, tcl-format
+msgid "Do not know how to initialize repository at location '%s'."
 msgstr ""
 
-#: lib/tools_dlg.tcl:129
+#: lib/remote_add.tcl:163
 #, tcl-format
-msgid "Tool '%s' already exists."
+msgid "Setting up the %s (at %s)"
 msgstr ""
 
-#: lib/tools_dlg.tcl:151
-#, tcl-format
-msgid ""
-"Could not add tool:\n"
-"%s"
+#: lib/line.tcl:17
+msgid "Goto Line:"
 msgstr ""
 
-#: lib/tools_dlg.tcl:190
-msgid "Remove Tool"
+#: lib/line.tcl:23
+msgid "Go"
 msgstr ""
 
-#: lib/tools_dlg.tcl:196
-msgid "Remove Tool Commands"
+#: lib/branch_create.tcl:23
+#, tcl-format
+msgid "%s (%s): Create Branch"
 msgstr ""
 
-#: lib/tools_dlg.tcl:200
-msgid "Remove"
+#: lib/branch_create.tcl:28
+msgid "Create New Branch"
 msgstr ""
 
-#: lib/tools_dlg.tcl:236
-msgid "(Blue denotes repository-local tools)"
+#: lib/branch_create.tcl:42
+msgid "Branch Name"
 msgstr ""
 
-#: lib/tools_dlg.tcl:297
-#, tcl-format
-msgid "Run Command: %s"
+#: lib/branch_create.tcl:57
+msgid "Match Tracking Branch Name"
 msgstr ""
 
-#: lib/tools_dlg.tcl:311
-msgid "Arguments"
+#: lib/branch_create.tcl:66
+msgid "Starting Revision"
 msgstr ""
 
-#: lib/tools_dlg.tcl:348
-msgid "OK"
+#: lib/branch_create.tcl:72
+msgid "Update Existing Branch:"
 msgstr ""
 
-#: lib/transport.tcl:7
-#, tcl-format
-msgid "Fetching new changes from %s"
+#: lib/branch_create.tcl:75
+msgid "No"
 msgstr ""
 
-#: lib/transport.tcl:18
-#, tcl-format
-msgid "remote prune %s"
+#: lib/branch_create.tcl:80
+msgid "Fast Forward Only"
 msgstr ""
 
-#: lib/transport.tcl:19
-#, tcl-format
-msgid "Pruning tracking branches deleted from %s"
+#: lib/branch_create.tcl:97
+msgid "Checkout After Creation"
 msgstr ""
 
-#: lib/transport.tcl:26
-#, tcl-format
-msgid "Pushing changes to %s"
+#: lib/branch_create.tcl:132
+msgid "Please select a tracking branch."
 msgstr ""
 
-#: lib/transport.tcl:64
+#: lib/branch_create.tcl:141
 #, tcl-format
-msgid "Mirroring to %s"
+msgid "Tracking branch %s is not a branch in the remote repository."
 msgstr ""
 
-#: lib/transport.tcl:82
-#, tcl-format
-msgid "Pushing %s %s to %s"
+#: lib/spellcheck.tcl:57
+msgid "Unsupported spell checker"
 msgstr ""
 
-#: lib/transport.tcl:100
-msgid "Push Branches"
+#: lib/spellcheck.tcl:65
+msgid "Spell checking is unavailable"
 msgstr ""
 
-#: lib/transport.tcl:114
-msgid "Source Branches"
+#: lib/spellcheck.tcl:68
+msgid "Invalid spell checking configuration"
 msgstr ""
 
-#: lib/transport.tcl:131
-msgid "Destination Repository"
+#: lib/spellcheck.tcl:70
+#, tcl-format
+msgid "Reverting dictionary to %s."
 msgstr ""
 
-#: lib/transport.tcl:169
-msgid "Transfer Options"
+#: lib/spellcheck.tcl:73
+msgid "Spell checker silently failed on startup"
 msgstr ""
 
-#: lib/transport.tcl:171
-msgid "Force overwrite existing branch (may discard changes)"
+#: lib/spellcheck.tcl:80
+msgid "Unrecognized spell checker"
 msgstr ""
 
-#: lib/transport.tcl:175
-msgid "Use thin pack (for slow network connections)"
+#: lib/spellcheck.tcl:186
+msgid "No Suggestions"
 msgstr ""
 
-#: lib/transport.tcl:179
-msgid "Include tags"
+#: lib/spellcheck.tcl:388
+msgid "Unexpected EOF from spell checker"
+msgstr ""
+
+#: lib/spellcheck.tcl:392
+msgid "Spell Checker Failed"
 msgstr ""
-- 
2.9.0.windows.1

