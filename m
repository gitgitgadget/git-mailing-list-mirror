Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F85C20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 20:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752433AbdASUiq (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 15:38:46 -0500
Received: from mout.gmx.net ([212.227.17.22]:53598 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751132AbdASUhk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 15:37:40 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M6SE3-1cJoqS13v9-00ySGi; Thu, 19
 Jan 2017 21:30:55 +0100
Date:   Thu, 19 Jan 2017 21:30:40 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Paul Sbarra <sbarra.paul@gmail.com>
Subject: [PATCH v6 3/3] Retire the scripted difftool
In-Reply-To: <cover.1484857756.git.johannes.schindelin@gmx.de>
Message-ID: <1524ca797a20370fb3568dcd43116b01dda1d588.1484857756.git.johannes.schindelin@gmx.de>
References: <cover.1484668473.git.johannes.schindelin@gmx.de> <cover.1484857756.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:rk1Gdxf2zdYGAMb9Q+SE6pzOsIGOox675bAjqesZrNS9jG1fhBv
 jR1OAjljDgDLzFXivz57B/fe/8AWdYcz4DFVoak6/u0QJLmy4tJaYBaDe0ZJkZOVcMaYfkz
 0M3TJ5iDgti3SCPcdKbuBV6g8jXkgLX5+/987+drRf7nF0yIgV6GLSvrvvkeytxHGui1m13
 jbbGi9bvL8XijvfyHsM4g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MZQkKVN248g=:e6LR5iy5K/Ph6zsUf+48CB
 jneIvKR0BQvFDqkavsW+WmA64ZQc/zBS+im85pVAJVtUwKVrd+J2Upfa9in3a4f/5V/WoyyZD
 Ae4o0ktZJSj8lnKpB97psr2X3A9jeRF7j4V3EJYOsVh1ZqgBYX6fmfE4xbT04YHWywdiCzBxm
 f6SNoU1meL+sLay70vS+R9tWmlL327ds/8OuxeRsp1EErNSJcXcf6fcVZ2zeklk51oL5Gaf1R
 LkIUl7k1FHZX1iWrPG6Yp4kiq/KHA6MfcvalM0QTAIX07Vm05yy59FvqS5OSHMH1FTtXSaoa8
 VqyjhMiRaSFxRO8SnxhD0duqaKwonL2duBNBRj99YvVZZR0IRLyPeTc7S/gSluDDBWyEVaxqu
 VWEzM14/zkO4rlK/h+BM56wOylVEzbJUl18SrSL3Gk5q60bSq1l0XQqXJL7XoB2t63ZCVOObB
 OwLJxSApbodohTD465aDxufXdCOPpTnIpBtOMPWN0cLvZCdYei/itK7KS/sZZidwQAr22UHYi
 1ncGwTSd1NjwAUg3WK81nULKkHDIMP1wq8FlHuU5Jtg/DjOZZHM5YO5WwIIRYr60pqAO7bA6C
 G9XTAC65WNlVCy3rDZATkhpewPuZHASFx+7b9g9G/b43MMNrVAApTb6p4G+8d+l11M/aaIGxo
 nPv3WZhDouzc7ppgohxPAYHpSGle/wTVNwNvKwZ4mKX6CUY/7KfF6Yte79uE10Z2UwKAWg9jl
 ghsNVrhl3RFzsGTmWoYBpazHWTTQJyZY8sb6p0TqgaafT0bw0p44jUEmkFQVzH591Ci4FUzF4
 YXCVE9dHI8jgqiZrNVygWWM20EHykFhXFXfoV+Txl/BsgVYJeYAN/xZWJ6FJRMOzUIzYc8+LA
 U4kwv+nsrYDz+fJt4LY/3xzrsAVCEuv3Sn59EitdS2VEYoXQmxMjrTNMLNv2yNsDiVUDE5ITO
 yWZ3T5Z7/8Jyp9+zArL/CIIoHajAgT/4v07yEsBuJJ0M4g68qdjgZYI7OAmSV6ZTjUfy1by5O
 Wz8DFJiVxxanNuquuz66Q14=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It served its purpose, but now we have a builtin difftool. Time for the
Perl script to enjoy Florida.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitignore                                         |  1 -
 Makefile                                           |  1 -
 builtin/difftool.c                                 | 41 ----------
 .../examples/git-difftool.perl                     |  0
 git.c                                              |  7 +-
 t/t7800-difftool.sh                                | 94 +++++++++++-----------
 6 files changed, 47 insertions(+), 97 deletions(-)
 rename git-legacy-difftool.perl => contrib/examples/git-difftool.perl (100%)

diff --git a/.gitignore b/.gitignore
index 5555ae025b..6722f78f9a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -76,7 +76,6 @@
 /git-init-db
 /git-interpret-trailers
 /git-instaweb
-/git-legacy-difftool
 /git-log
 /git-ls-files
 /git-ls-remote
diff --git a/Makefile b/Makefile
index 8cf5bef034..e9aa6ae57c 100644
--- a/Makefile
+++ b/Makefile
@@ -522,7 +522,6 @@ SCRIPT_LIB += git-sh-setup
 SCRIPT_LIB += git-sh-i18n
 
 SCRIPT_PERL += git-add--interactive.perl
-SCRIPT_PERL += git-legacy-difftool.perl
 SCRIPT_PERL += git-archimport.perl
 SCRIPT_PERL += git-cvsexportcommit.perl
 SCRIPT_PERL += git-cvsimport.perl
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 2115e548a5..42ad9e804a 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -616,30 +616,6 @@ static int run_file_diff(int prompt, const char *prefix,
 	exit(ret);
 }
 
-/*
- * NEEDSWORK: this function can go once the legacy-difftool Perl script is
- * retired.
- *
- * We intentionally avoid reading the config directly here, to avoid messing up
- * the GIT_* environment variables when we need to fall back to exec()ing the
- * Perl script.
- */
-static int use_builtin_difftool(void) {
-	struct child_process cp = CHILD_PROCESS_INIT;
-	struct strbuf out = STRBUF_INIT;
-	int ret;
-
-	argv_array_pushl(&cp.args,
-			 "config", "--bool", "difftool.usebuiltin", NULL);
-	cp.git_cmd = 1;
-	if (capture_command(&cp, &out, 6))
-		return 0;
-	strbuf_trim(&out);
-	ret = !strcmp("true", out.buf);
-	strbuf_release(&out);
-	return ret;
-}
-
 int cmd_difftool(int argc, const char **argv, const char *prefix)
 {
 	int use_gui_tool = 0, dir_diff = 0, prompt = -1, symlinks = 0,
@@ -671,23 +647,6 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	/*
-	 * NEEDSWORK: Once the builtin difftool has been tested enough
-	 * and git-legacy-difftool.perl is retired to contrib/, this preamble
-	 * can be removed.
-	 */
-	if (!use_builtin_difftool()) {
-		const char *path = mkpath("%s/git-legacy-difftool",
-					  git_exec_path());
-
-		if (sane_execvp(path, (char **)argv) < 0)
-			die_errno("could not exec %s", path);
-
-		return 0;
-	}
-	prefix = setup_git_directory();
-	trace_repo_setup(prefix);
-	setup_work_tree();
 	/* NEEDSWORK: once we no longer spawn anything, remove this */
 	setenv(GIT_DIR_ENVIRONMENT, absolute_path(get_git_dir()), 1);
 	setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(get_git_work_tree()), 1);
diff --git a/git-legacy-difftool.perl b/contrib/examples/git-difftool.perl
similarity index 100%
rename from git-legacy-difftool.perl
rename to contrib/examples/git-difftool.perl
diff --git a/git.c b/git.c
index c58181e5ef..bd4d668a21 100644
--- a/git.c
+++ b/git.c
@@ -424,12 +424,7 @@ static struct cmd_struct commands[] = {
 	{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE },
 	{ "diff-index", cmd_diff_index, RUN_SETUP },
 	{ "diff-tree", cmd_diff_tree, RUN_SETUP },
-	/*
-	 * NEEDSWORK: Once the redirection to git-legacy-difftool.perl in
-	 * builtin/difftool.c has been removed, this entry should be changed to
-	 * RUN_SETUP | NEED_WORK_TREE
-	 */
-	{ "difftool", cmd_difftool },
+	{ "difftool", cmd_difftool, RUN_SETUP | NEED_WORK_TREE },
 	{ "fast-export", cmd_fast_export, RUN_SETUP },
 	{ "fetch", cmd_fetch, RUN_SETUP },
 	{ "fetch-pack", cmd_fetch_pack, RUN_SETUP },
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index e94910c563..aa0ef02597 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -23,10 +23,8 @@ prompt_given ()
 	test "$prompt" = "Launch 'test-tool' [Y/n]? branch"
 }
 
-# NEEDSWORK: lose all the PERL prereqs once legacy-difftool is retired.
-
 # Create a file on master and change it on branch
-test_expect_success PERL 'setup' '
+test_expect_success 'setup' '
 	echo master >file &&
 	git add file &&
 	git commit -m "added file" &&
@@ -38,7 +36,7 @@ test_expect_success PERL 'setup' '
 '
 
 # Configure a custom difftool.<tool>.cmd and use it
-test_expect_success PERL 'custom commands' '
+test_expect_success 'custom commands' '
 	difftool_test_setup &&
 	test_config difftool.test-tool.cmd "cat \"\$REMOTE\"" &&
 	echo master >expect &&
@@ -51,21 +49,21 @@ test_expect_success PERL 'custom commands' '
 	test_cmp expect actual
 '
 
-test_expect_success PERL 'custom tool commands override built-ins' '
+test_expect_success 'custom tool commands override built-ins' '
 	test_config difftool.vimdiff.cmd "cat \"\$REMOTE\"" &&
 	echo master >expect &&
 	git difftool --tool vimdiff --no-prompt branch >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success PERL 'difftool ignores bad --tool values' '
+test_expect_success 'difftool ignores bad --tool values' '
 	: >expect &&
 	test_must_fail \
 		git difftool --no-prompt --tool=bad-tool branch >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success PERL 'difftool forwards arguments to diff' '
+test_expect_success 'difftool forwards arguments to diff' '
 	difftool_test_setup &&
 	>for-diff &&
 	git add for-diff &&
@@ -78,40 +76,40 @@ test_expect_success PERL 'difftool forwards arguments to diff' '
 	rm for-diff
 '
 
-test_expect_success PERL 'difftool ignores exit code' '
+test_expect_success 'difftool ignores exit code' '
 	test_config difftool.error.cmd false &&
 	git difftool -y -t error branch
 '
 
-test_expect_success PERL 'difftool forwards exit code with --trust-exit-code' '
+test_expect_success 'difftool forwards exit code with --trust-exit-code' '
 	test_config difftool.error.cmd false &&
 	test_must_fail git difftool -y --trust-exit-code -t error branch
 '
 
-test_expect_success PERL 'difftool forwards exit code with --trust-exit-code for built-ins' '
+test_expect_success 'difftool forwards exit code with --trust-exit-code for built-ins' '
 	test_config difftool.vimdiff.path false &&
 	test_must_fail git difftool -y --trust-exit-code -t vimdiff branch
 '
 
-test_expect_success PERL 'difftool honors difftool.trustExitCode = true' '
+test_expect_success 'difftool honors difftool.trustExitCode = true' '
 	test_config difftool.error.cmd false &&
 	test_config difftool.trustExitCode true &&
 	test_must_fail git difftool -y -t error branch
 '
 
-test_expect_success PERL 'difftool honors difftool.trustExitCode = false' '
+test_expect_success 'difftool honors difftool.trustExitCode = false' '
 	test_config difftool.error.cmd false &&
 	test_config difftool.trustExitCode false &&
 	git difftool -y -t error branch
 '
 
-test_expect_success PERL 'difftool ignores exit code with --no-trust-exit-code' '
+test_expect_success 'difftool ignores exit code with --no-trust-exit-code' '
 	test_config difftool.error.cmd false &&
 	test_config difftool.trustExitCode true &&
 	git difftool -y --no-trust-exit-code -t error branch
 '
 
-test_expect_success PERL 'difftool stops on error with --trust-exit-code' '
+test_expect_success 'difftool stops on error with --trust-exit-code' '
 	test_when_finished "rm -f for-diff .git/fail-right-file" &&
 	test_when_finished "git reset -- for-diff" &&
 	write_script .git/fail-right-file <<-\EOF &&
@@ -126,13 +124,13 @@ test_expect_success PERL 'difftool stops on error with --trust-exit-code' '
 	test_cmp expect actual
 '
 
-test_expect_success PERL 'difftool honors exit status if command not found' '
+test_expect_success 'difftool honors exit status if command not found' '
 	test_config difftool.nonexistent.cmd i-dont-exist &&
 	test_config difftool.trustExitCode false &&
 	test_must_fail git difftool -y -t nonexistent branch
 '
 
-test_expect_success PERL 'difftool honors --gui' '
+test_expect_success 'difftool honors --gui' '
 	difftool_test_setup &&
 	test_config merge.tool bogus-tool &&
 	test_config diff.tool bogus-tool &&
@@ -143,7 +141,7 @@ test_expect_success PERL 'difftool honors --gui' '
 	test_cmp expect actual
 '
 
-test_expect_success PERL 'difftool --gui last setting wins' '
+test_expect_success 'difftool --gui last setting wins' '
 	difftool_test_setup &&
 	: >expect &&
 	git difftool --no-prompt --gui --no-gui >actual &&
@@ -157,7 +155,7 @@ test_expect_success PERL 'difftool --gui last setting wins' '
 	test_cmp expect actual
 '
 
-test_expect_success PERL 'difftool --gui works without configured diff.guitool' '
+test_expect_success 'difftool --gui works without configured diff.guitool' '
 	difftool_test_setup &&
 	echo branch >expect &&
 	git difftool --no-prompt --gui branch >actual &&
@@ -165,7 +163,7 @@ test_expect_success PERL 'difftool --gui works without configured diff.guitool'
 '
 
 # Specify the diff tool using $GIT_DIFF_TOOL
-test_expect_success PERL 'GIT_DIFF_TOOL variable' '
+test_expect_success 'GIT_DIFF_TOOL variable' '
 	difftool_test_setup &&
 	git config --unset diff.tool &&
 	echo branch >expect &&
@@ -175,7 +173,7 @@ test_expect_success PERL 'GIT_DIFF_TOOL variable' '
 
 # Test the $GIT_*_TOOL variables and ensure
 # that $GIT_DIFF_TOOL always wins unless --tool is specified
-test_expect_success PERL 'GIT_DIFF_TOOL overrides' '
+test_expect_success 'GIT_DIFF_TOOL overrides' '
 	difftool_test_setup &&
 	test_config diff.tool bogus-tool &&
 	test_config merge.tool bogus-tool &&
@@ -193,7 +191,7 @@ test_expect_success PERL 'GIT_DIFF_TOOL overrides' '
 
 # Test that we don't have to pass --no-prompt to difftool
 # when $GIT_DIFFTOOL_NO_PROMPT is true
-test_expect_success PERL 'GIT_DIFFTOOL_NO_PROMPT variable' '
+test_expect_success 'GIT_DIFFTOOL_NO_PROMPT variable' '
 	difftool_test_setup &&
 	echo branch >expect &&
 	GIT_DIFFTOOL_NO_PROMPT=true git difftool branch >actual &&
@@ -202,7 +200,7 @@ test_expect_success PERL 'GIT_DIFFTOOL_NO_PROMPT variable' '
 
 # git-difftool supports the difftool.prompt variable.
 # Test that GIT_DIFFTOOL_PROMPT can override difftool.prompt = false
-test_expect_success PERL 'GIT_DIFFTOOL_PROMPT variable' '
+test_expect_success 'GIT_DIFFTOOL_PROMPT variable' '
 	difftool_test_setup &&
 	test_config difftool.prompt false &&
 	echo >input &&
@@ -212,7 +210,7 @@ test_expect_success PERL 'GIT_DIFFTOOL_PROMPT variable' '
 '
 
 # Test that we don't have to pass --no-prompt when difftool.prompt is false
-test_expect_success PERL 'difftool.prompt config variable is false' '
+test_expect_success 'difftool.prompt config variable is false' '
 	difftool_test_setup &&
 	test_config difftool.prompt false &&
 	echo branch >expect &&
@@ -221,7 +219,7 @@ test_expect_success PERL 'difftool.prompt config variable is false' '
 '
 
 # Test that we don't have to pass --no-prompt when mergetool.prompt is false
-test_expect_success PERL 'difftool merge.prompt = false' '
+test_expect_success 'difftool merge.prompt = false' '
 	difftool_test_setup &&
 	test_might_fail git config --unset difftool.prompt &&
 	test_config mergetool.prompt false &&
@@ -231,7 +229,7 @@ test_expect_success PERL 'difftool merge.prompt = false' '
 '
 
 # Test that the -y flag can override difftool.prompt = true
-test_expect_success PERL 'difftool.prompt can overridden with -y' '
+test_expect_success 'difftool.prompt can overridden with -y' '
 	difftool_test_setup &&
 	test_config difftool.prompt true &&
 	echo branch >expect &&
@@ -240,7 +238,7 @@ test_expect_success PERL 'difftool.prompt can overridden with -y' '
 '
 
 # Test that the --prompt flag can override difftool.prompt = false
-test_expect_success PERL 'difftool.prompt can overridden with --prompt' '
+test_expect_success 'difftool.prompt can overridden with --prompt' '
 	difftool_test_setup &&
 	test_config difftool.prompt false &&
 	echo >input &&
@@ -250,7 +248,7 @@ test_expect_success PERL 'difftool.prompt can overridden with --prompt' '
 '
 
 # Test that the last flag passed on the command-line wins
-test_expect_success PERL 'difftool last flag wins' '
+test_expect_success 'difftool last flag wins' '
 	difftool_test_setup &&
 	echo branch >expect &&
 	git difftool --prompt --no-prompt branch >actual &&
@@ -263,7 +261,7 @@ test_expect_success PERL 'difftool last flag wins' '
 
 # git-difftool falls back to git-mergetool config variables
 # so test that behavior here
-test_expect_success PERL 'difftool + mergetool config variables' '
+test_expect_success 'difftool + mergetool config variables' '
 	test_config merge.tool test-tool &&
 	test_config mergetool.test-tool.cmd "cat \$LOCAL" &&
 	echo branch >expect &&
@@ -277,49 +275,49 @@ test_expect_success PERL 'difftool + mergetool config variables' '
 	test_cmp expect actual
 '
 
-test_expect_success PERL 'difftool.<tool>.path' '
+test_expect_success 'difftool.<tool>.path' '
 	test_config difftool.tkdiff.path echo &&
 	git difftool --tool=tkdiff --no-prompt branch >output &&
 	lines=$(grep file output | wc -l) &&
 	test "$lines" -eq 1
 '
 
-test_expect_success PERL 'difftool --extcmd=cat' '
+test_expect_success 'difftool --extcmd=cat' '
 	echo branch >expect &&
 	echo master >>expect &&
 	git difftool --no-prompt --extcmd=cat branch >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success PERL 'difftool --extcmd cat' '
+test_expect_success 'difftool --extcmd cat' '
 	echo branch >expect &&
 	echo master >>expect &&
 	git difftool --no-prompt --extcmd=cat branch >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success PERL 'difftool -x cat' '
+test_expect_success 'difftool -x cat' '
 	echo branch >expect &&
 	echo master >>expect &&
 	git difftool --no-prompt -x cat branch >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success PERL 'difftool --extcmd echo arg1' '
+test_expect_success 'difftool --extcmd echo arg1' '
 	echo file >expect &&
 	git difftool --no-prompt \
 		--extcmd sh\ -c\ \"echo\ \$1\" branch >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success PERL 'difftool --extcmd cat arg1' '
+test_expect_success 'difftool --extcmd cat arg1' '
 	echo master >expect &&
 	git difftool --no-prompt \
 		--extcmd sh\ -c\ \"cat\ \$1\" branch >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success PERL 'difftool --extcmd cat arg2' '
+test_expect_success 'difftool --extcmd cat arg2' '
 	echo branch >expect &&
 	git difftool --no-prompt \
 		--extcmd sh\ -c\ \"cat\ \$2\" branch >actual &&
@@ -327,7 +325,7 @@ test_expect_success PERL 'difftool --extcmd cat arg2' '
 '
 
 # Create a second file on master and a different version on branch
-test_expect_success PERL 'setup with 2 files different' '
+test_expect_success 'setup with 2 files different' '
 	echo m2 >file2 &&
 	git add file2 &&
 	git commit -m "added file2" &&
@@ -339,7 +337,7 @@ test_expect_success PERL 'setup with 2 files different' '
 	git checkout master
 '
 
-test_expect_success PERL 'say no to the first file' '
+test_expect_success 'say no to the first file' '
 	(echo n && echo) >input &&
 	git difftool -x cat branch <input >output &&
 	grep m2 output &&
@@ -348,7 +346,7 @@ test_expect_success PERL 'say no to the first file' '
 	! grep branch output
 '
 
-test_expect_success PERL 'say no to the second file' '
+test_expect_success 'say no to the second file' '
 	(echo && echo n) >input &&
 	git difftool -x cat branch <input >output &&
 	grep master output &&
@@ -357,7 +355,7 @@ test_expect_success PERL 'say no to the second file' '
 	! grep br2 output
 '
 
-test_expect_success PERL 'ending prompt input with EOF' '
+test_expect_success 'ending prompt input with EOF' '
 	git difftool -x cat branch </dev/null >output &&
 	! grep master output &&
 	! grep branch output &&
@@ -365,12 +363,12 @@ test_expect_success PERL 'ending prompt input with EOF' '
 	! grep br2 output
 '
 
-test_expect_success PERL 'difftool --tool-help' '
+test_expect_success 'difftool --tool-help' '
 	git difftool --tool-help >output &&
 	grep tool output
 '
 
-test_expect_success PERL 'setup change in subdirectory' '
+test_expect_success 'setup change in subdirectory' '
 	git checkout master &&
 	mkdir sub &&
 	echo master >sub/sub &&
@@ -384,11 +382,11 @@ test_expect_success PERL 'setup change in subdirectory' '
 '
 
 run_dir_diff_test () {
-	test_expect_success PERL "$1 --no-symlinks" "
+	test_expect_success "$1 --no-symlinks" "
 		symlinks=--no-symlinks &&
 		$2
 	"
-	test_expect_success PERL,SYMLINKS "$1 --symlinks" "
+	test_expect_success SYMLINKS "$1 --symlinks" "
 		symlinks=--symlinks &&
 		$2
 	"
@@ -510,7 +508,7 @@ do
 done >actual
 EOF
 
-test_expect_success PERL,SYMLINKS 'difftool --dir-diff --symlink without unstaged changes' '
+test_expect_success SYMLINKS 'difftool --dir-diff --symlink without unstaged changes' '
 	cat >expect <<-EOF &&
 	file
 	$PWD/file
@@ -547,7 +545,7 @@ write_script modify-file <<\EOF
 echo "new content" >file
 EOF
 
-test_expect_success PERL 'difftool --no-symlinks does not overwrite working tree file ' '
+test_expect_success 'difftool --no-symlinks does not overwrite working tree file ' '
 	echo "orig content" >file &&
 	git difftool --dir-diff --no-symlinks --extcmd "$PWD/modify-file" branch &&
 	echo "new content" >expect &&
@@ -560,7 +558,7 @@ echo "tmp content" >"$2/file" &&
 echo "$2" >tmpdir
 EOF
 
-test_expect_success PERL 'difftool --no-symlinks detects conflict ' '
+test_expect_success 'difftool --no-symlinks detects conflict ' '
 	(
 		TMPDIR=$TRASH_DIRECTORY &&
 		export TMPDIR &&
@@ -573,7 +571,7 @@ test_expect_success PERL 'difftool --no-symlinks detects conflict ' '
 	)
 '
 
-test_expect_success PERL 'difftool properly honors gitlink and core.worktree' '
+test_expect_success 'difftool properly honors gitlink and core.worktree' '
 	git submodule add ./. submod/ule &&
 	test_config -C submod/ule diff.tool checktrees &&
 	test_config -C submod/ule difftool.checktrees.cmd '\''
@@ -587,7 +585,7 @@ test_expect_success PERL 'difftool properly honors gitlink and core.worktree' '
 	)
 '
 
-test_expect_success PERL,SYMLINKS 'difftool --dir-diff symlinked directories' '
+test_expect_success SYMLINKS 'difftool --dir-diff symlinked directories' '
 	git init dirlinks &&
 	(
 		cd dirlinks &&
-- 
2.11.0.windows.3
