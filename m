Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3939D1F404
	for <e@80x24.org>; Sat, 21 Apr 2018 16:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753279AbeDUQ4Y (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 12:56:24 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43301 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753092AbeDUQ4X (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 12:56:23 -0400
Received: by mail-lf0-f66.google.com with SMTP id v207-v6so9180163lfa.10
        for <git@vger.kernel.org>; Sat, 21 Apr 2018 09:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ha8zsfI+blXO+v85WkoPMtcQGKgvwEpNpqOPQHI/sPQ=;
        b=JwmefQHIWb7Gvd3HGuUCh5gF0eid2OM8SUilRUrMyv2Vz48xMciYpM6atHxn6VvaSY
         VhDvEZUc+6HlRHnrT+YvjtcJ/0ebD3W2NcbnTjVv0yBFdnOaGf2wgok2d7B5xVbq40pP
         G3p4xw88nFjrOzReB6/R/ca+STvxOk1qYKa81SjubhFYuUl2P+3aloRb/LBoNcHZkZAU
         LOXDbvj63qDfxuS/Q79+cUrH9KtRCgHDoXdMdclprdlfXwbLgiI50p+2sWhq+uFXteas
         /F44fthdjURI1YWH+zGwMFeYQ3nWuhC9pI20wx0NDzMvOVF2+co1ve8OggP1wVumMHSl
         gs2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ha8zsfI+blXO+v85WkoPMtcQGKgvwEpNpqOPQHI/sPQ=;
        b=QBBQXPiMJVAcPjGYv/W7LUMfcFnssQM0sCYMblOHljnHzsaXHBEJPr1XuCDCGuNido
         2L6F2miNQmMLveZCLZWgE5D1cwlVhM/a7uJGY5EaMEqI+gadLg6ajoWcz22wFdIAR4Wa
         R4T1ItZ7XExVJ626cbPEz/j6Lzd4UMNXTmrd0FZoppRZsZ7tS+aHfqCDwDJMYYXnDQ90
         gm9Nc+ENEG8TVws+/Yt35fZKojeHxgMQiax902GGrgj0TWs1VRzTMA9n8PjQbTSjtI4h
         tJoSxRiOl6IkDl5EHpFZO9EqlE4CypJFFfajYO47pf+v6oO98+Rt4vXjb0BL6yAhFpQy
         p80Q==
X-Gm-Message-State: ALQs6tAhYe4RHkdIyme1/2AaSrJnwJ0/JvneyjlnHT5tPeGaCCrEcJL7
        pqlfsqvMgKWbYbwpXe80J/hxRg==
X-Google-Smtp-Source: AB8JxZo5+AebODkKQKyHnsE//L6D9EeRPEmAT3ISS/Ji2TvlCWW4qf0cr1foSqnZScHyFKwhf4K3cg==
X-Received: by 10.46.137.10 with SMTP id d10mr2244538lji.57.1524329781452;
        Sat, 21 Apr 2018 09:56:21 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id 77sm250255ljz.53.2018.04.21.09.56.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Apr 2018 09:56:20 -0700 (PDT)
Date:   Sat, 21 Apr 2018 18:56:18 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     git@vger.kernel.org, gitster@pobox.com, philipoakley@iee.org,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: Re: [PATCH v3 0/6] Keep all info in command-list.txt in git binary
Message-ID: <20180421165618.GA30287@duynguyen.home>
References: <20180415164238.9107-1-pclouds@gmail.com>
 <20180421165414.30051-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180421165414.30051-1-pclouds@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 21, 2018 at 06:54:08PM +0200, Nguyễn Thái Ngọc Duy wrote:
> Changes:
> 
> - remove the deprecated column in command-list.txt. My change break it
>   anyway if anyone uses it.
> - fix up failed tests that I marked in the RFC and kinda forgot about it.
> - fix bashisms in generate-cmdlist.sh
> - fix segfaul in "git help"

Sorry I forgot the interdiff

diff --git a/command-list.txt b/command-list.txt
index 0809a19184..1835f1a928 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -9,7 +9,7 @@ history      grow, mark and tweak your common history
 remote       collaborate (see also: git help workflows)
 
 ### command list (do not change this line)
-# command name                          category [deprecated] [common]
+# command name                          category                [common]
 git-add                                 mainporcelain           worktree
 git-am                                  mainporcelain
 git-annotate                            ancillaryinterrogators
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9f17703aa7..7d17ca23f6 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -835,19 +835,23 @@ __git_complete_strategy ()
 }
 
 __git_commands () {
-	if test -n "${GIT_TESTING_COMMAND_COMPLETION:-}"
+	if test -n "$GIT_TESTING_COMPLETION"
 	then
-		printf "%s" "${GIT_TESTING_COMMAND_COMPLETION}"
+		case "$1" in
+		porcelain)
+			printf "%s" "$GIT_TESTING_PORCELAIN_COMMAND_LIST";;
+		all)
+			printf "%s" "$GIT_TESTING_ALL_COMMAND_LIST";;
+		esac
 	else
 		git --list-cmds=$1
 	fi
 }
 
-__git_list_all_commands ()
+__git_list_commands ()
 {
 	local i IFS=" "$'\n'
-	local category=${1-all}
-	for i in $(__git_commands $category)
+	for i in $(__git_commands $1)
 	do
 		case $i in
 		*--*)             : helper pattern;;
@@ -860,14 +864,14 @@ __git_all_commands=
 __git_compute_all_commands ()
 {
 	test -n "$__git_all_commands" ||
-	__git_all_commands=$(__git_list_all_commands)
+	__git_all_commands=$(__git_list_commands all)
 }
 
 __git_porcelain_commands=
 __git_compute_porcelain_commands ()
 {
 	test -n "$__git_porcelain_commands" ||
-	__git_porcelain_commands=$(__git_list_all_commands porcelain)
+	__git_porcelain_commands=$(__git_list_commands porcelain)
 }
 
 # Lists all set config variables starting with the given section prefix,
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index e35f3e357b..86d59419b3 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -36,7 +36,7 @@ sed -n '
 	' "$1"
 printf '};\n\n'
 
-echo "#define GROUP_NONE 0xff /* no common group */"
+echo "#define GROUP_NONE 0xff"
 n=0
 while read grp
 do
@@ -45,15 +45,6 @@ do
 done <"$grps"
 echo
 
-echo '/*'
-printf 'static const char *cmd_categories[] = {\n'
-category_list "$1" |
-while read category; do
-	printf '\t\"'$category'\",\n'
-done
-printf '\tNULL\n};\n\n'
-echo '*/'
-
 n=0
 category_list "$1" |
 while read category; do
@@ -68,10 +59,11 @@ sort |
 while read cmd category tags
 do
 	if [ "$category" = guide ]; then
-		name=${cmd/git}
+		prefix=git
 	else
-		name=${cmd/git-}
+		prefix=git-
 	fi
+	name=$(echo $cmd | sed "s/^${prefix}//")
 	sed -n '
 		/^NAME/,/'"$cmd"'/H
 		${
diff --git a/help.c b/help.c
index a44f4a113e..88127fdd6f 100644
--- a/help.c
+++ b/help.c
@@ -201,7 +201,8 @@ static void extract_common_cmds(struct cmdname_help **p_common_cmds,
 	for (i = 0; i < ARRAY_SIZE(command_list); i++) {
 		const struct cmdname_help *cmd = command_list + i;
 
-		if (cmd->category != CAT_mainporcelain)
+		if (cmd->category != CAT_mainporcelain ||
+		    cmd->group == GROUP_NONE)
 			continue;
 
 		common_cmds[nr++] = *cmd;
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index fd2a7f27dc..53208ab20e 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -25,6 +25,15 @@ test_expect_success "setup" '
 	EOF
 '
 
+# make sure to exercise these code paths, the output is a bit tricky
+# to verify
+test_expect_success 'basic help commands' '
+	git help >/dev/null &&
+	git help -a >/dev/null &&
+	git help -g >/dev/null &&
+	git help -av >/dev/null
+'
+
 test_expect_success "works for commands and guides by default" '
 	configure_help &&
 	git help status &&
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 4bfd26ddf9..5a23a46fcf 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -13,7 +13,7 @@ complete ()
 	return 0
 }
 
-# Be careful when updating this list:
+# Be careful when updating these lists:
 #
 # (1) The build tree may have build artifact from different branch, or
 #     the user's $PATH may have a random executable that may begin
@@ -30,7 +30,9 @@ complete ()
 #     completion for "git <TAB>", and a plumbing is excluded.  "add",
 #     "filter-branch" and "ls-files" are listed for this.
 
-GIT_TESTING_COMMAND_COMPLETION='add checkout check-attr filter-branch ls-files'
+GIT_TESTING_COMPLETION=t
+GIT_TESTING_ALL_COMMAND_LIST='add checkout check-attr filter-branch ls-files'
+GIT_TESTING_PORCELAIN_COMMAND_LIST='add checkout filter-branch'
 
 . "$GIT_BUILD_DIR/contrib/completion/git-completion.bash"
 
@@ -1208,6 +1210,8 @@ test_expect_success 'basic' '
 	grep -q "^add \$" out &&
 	# script
 	grep -q "^filter-branch \$" out &&
+	# plumbing
+	! grep -q "^ls-files \$" out &&
 
 	run_completion "git f" &&
 	! grep -q -v "^f" out
@@ -1270,7 +1274,7 @@ test_expect_success 'general options' '
 	test_completion "git --no-r" "--no-replace-objects "
 '
 
-test_expect_failure 'general options plus command' '
+test_expect_success 'general options plus command' '
 	test_completion "git --version check" "checkout " &&
 	test_completion "git --paginate check" "checkout " &&
 	test_completion "git --git-dir=foo check" "checkout " &&
