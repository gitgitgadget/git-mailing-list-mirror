Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED8AC433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 17:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbiBPRCq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 12:02:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbiBPRCp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 12:02:45 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD027A66EE
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 09:02:32 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id w11so4550797wra.4
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 09:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=+hmYIOLP0Z4e2LRu+NEOpgy/4ecWGatyyxztWd3hGvk=;
        b=AvcfaJ9oQSMOzBK+Crs77OJgmMsr0WMmuH316GDKz0np6okxmMQd1ANlJMGmsqNwoV
         GTwmXpkgF/9bDefewYaO1/ti0sVw038ltnegnKJr4VErLxAFexs4lDJIPXSZB0mwadCk
         1wBq9KPMJwqDtBQ6slM/T9Y8lG1YaTW/F/9RlvTcp+QEhAJr0ES4viIPKyrF8V8gpVDt
         pbqIOttl0xys6mM6rDxBECQZ2M/1sAUtZ60+lCB5zRndXfWE6xhm4rJ8npqipFaEM7Np
         q+f18JT/t789xxjrQME7ts6K4R2asZHxcBeERMIsahQ3lR1UlGltAwt/s+UyOoLUF+kq
         TY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+hmYIOLP0Z4e2LRu+NEOpgy/4ecWGatyyxztWd3hGvk=;
        b=qgMn3YYLggJJdZI40xRQLvPA/kjlLXEzCxHEOexGAF6VmA49Gp88UrcaWV3XkLsfrn
         ITaPRRwUSNPI1YzQhSVgxymEGnotGMmU6z0EKqkv8zyaSc1J/jguYdabeoWlcEl3IiKV
         abymN/+GkwdGCkrJYeslvTJ4nra77O3VdUETTsJBcP0WOqnuJybD8bZLyeIQNjkJweEt
         6qSthj2IO/ETDoZRyCwM01KzlUA+Vc/t0bfIBcXMQN2mQzFI2NfdBH7uNVqP470NnwZ/
         c7KRhFCuIOyex3hu9jRZuWt9ZjUPKSeOFzlZTcd3SNv7mdwvRLAF2S2+bxW/GF4rKiLJ
         wNEg==
X-Gm-Message-State: AOAM533cPwYQd/RREupRG2spO+BK/ZMCrOORyj4N6rO3xMpr+QuuONWC
        WeFUhufNRFNdAz6r2FyjGbV1B27JR8Q=
X-Google-Smtp-Source: ABdhPJziC+1Ukhq9GBOOMpreWpnybmCea7PokHRCUcc8pumlnrvCLq4RitDguRIMRf89rDainexeKg==
X-Received: by 2002:a5d:64e2:0:b0:1e8:e8e:c134 with SMTP id g2-20020a5d64e2000000b001e80e8ec134mr2822847wri.537.1645030950998;
        Wed, 16 Feb 2022 09:02:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u12sm21858977wrw.32.2022.02.16.09.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 09:02:30 -0800 (PST)
Message-Id: <pull.1147.git.1645030949730.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Feb 2022 17:02:29 +0000
Subject: [PATCH] add usage-strings ci check and amend remaining usage strings
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhra303 <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhra303 <chakrabortyabhradeep79@gmail.com>

Usage strings for git (sub)command flags has a style guide that
suggests - first letter should not capitalized (unless requied)
and it should skip full-stop at the end of line. But there are
some files where usage-strings do not follow the above mentioned
guide. Moreover, there are no checks to verify if all usage strings
are following the guide/convention or not.

Amend the usage strings that don't follow the convention/guide and
add a `CI` check for checking the usage strings (whether the first
letter is capital or it ends with full-stop). If the `check` find
such strings then print those strings and return a non-zero status.

Also provide a script that takes an optional argument (a valid <tree>
string), to check the usage strings in the given <tree> (`HEAD` is
the default argument).

Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
    add usage-strings ci check and amend remaining usage strings
    
    This patch series completely fixes #636.
    
    The issue is about amending the usage-strings (for command flags such as
    -h, -v etc.) which do not follow the style convention/guide. There was a
    PR [https://github.com/gitgitgadget/git/pull/920] addressing this issue
    but as Johannes [https://github.com/dscho] said in his comment
    [https://github.com/gitgitgadget/git/issues/636#issuecomment-1018660439],
    there are some files that still have those kind of usage strings.
    Johannes also suggested to add a CI check under ci/test-documentation.sh
    to check the usage strings.
    
    So, in this patch, all remaining usage strings are corrected. I also
    added a check-usage-strings target in Makefile which can be used to
    check usage strings. It uses check-usage-strings.sh.
    
     1. If check-usage-strings.sh is run on a valid git repo - it will check
        the validity of usage-strings in the tree specified by an argument
        or in the HEAD if no argument provided.
     2. If the current repo is not a git repo (i.e. if it doesn't find any
        .git folder), it will check the usage string in the current root
        directory.
    
    For the first case, output of make check-usage-strings or
    ./check-usage-strings.sh would be similar to -
    
    HEAD:builtin/bisect--helper.c:1212                        N_("use <cmd>... to automatically bisect."), BISECT_RUN),
    HEAD:builtin/submodule--helper.c:1877            OPT__QUIET(&quiet, "Suppress output for cloning a submodule"),
    
    
    If an argument provided - ./check-usage-strings.sh 'v2.34.0' , it will
    search for usage-strings in v2.34.0 and v2.34.0 will be prefixed before
    filenames instead of HEAD.
    
    In the second case, output would be similar to -
    
    diff.c:5596                            N_("select files by diff type."),
    diff.c:5599               N_("Output to a specific file"),
    builtin/branch.c:666            OPT_BIT('C', NULL, &copy, N_("copy a branch, even if target exists."), 2),
    make: *** [check-usage-strings] Error 1
    
    
    Note in the last case - arguments provided to it will be useless.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1147%2FAbhra303%2Fusage_command_amend-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1147/Abhra303/usage_command_amend-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1147

 Makefile                    |  5 +++++
 builtin/bisect--helper.c    |  2 +-
 builtin/reflog.c            |  6 +++---
 builtin/submodule--helper.c |  2 +-
 check-usage-strings.sh      | 33 +++++++++++++++++++++++++++++++++
 ci/test-documentation.sh    |  1 +
 diff.c                      |  2 +-
 t/helper/test-run-command.c |  6 +++---
 8 files changed, 48 insertions(+), 9 deletions(-)
 create mode 100755 check-usage-strings.sh

diff --git a/Makefile b/Makefile
index 186f9ab6190..93faed51da0 100644
--- a/Makefile
+++ b/Makefile
@@ -3416,6 +3416,11 @@ check-docs::
 check-builtins::
 	./check-builtins.sh
 
+### Make sure all the usage strings follow usage string style guide
+#
+check-usage-strings::
+	./check-usage-strings.sh
+
 ### Test suite coverage testing
 #
 .PHONY: coverage coverage-clean coverage-compile coverage-test coverage-report
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 28a2e6a5750..614d95b022c 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1209,7 +1209,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "bisect-visualize", &cmdmode,
 			 N_("visualize the bisection"), BISECT_VISUALIZE),
 		OPT_CMDMODE(0, "bisect-run", &cmdmode,
-			 N_("use <cmd>... to automatically bisect."), BISECT_RUN),
+			 N_("use <cmd>... to automatically bisect"), BISECT_RUN),
 		OPT_BOOL(0, "no-log", &nolog,
 			 N_("no log for BISECT_WRITE")),
 		OPT_END()
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 85b838720c3..28372c5e2b5 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -600,7 +600,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "updateref", &flags,
 			N_("update the reference to the value of the top reflog entry"),
 			EXPIRE_REFLOGS_UPDATE_REF),
-		OPT_BOOL(0, "verbose", &verbose, N_("print extra information on screen.")),
+		OPT_BOOL(0, "verbose", &verbose, N_("print extra information on screen")),
 		OPT_CALLBACK_F(0, "expire", &cmd, N_("timestamp"),
 			       N_("prune entries older than the specified time"),
 			       PARSE_OPT_NONEG,
@@ -613,7 +613,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 			 N_("prune any reflog entries that point to broken commits")),
 		OPT_BOOL(0, "all", &do_all, N_("process the reflogs of all references")),
 		OPT_BOOL(1, "single-worktree", &all_worktrees,
-			 N_("limits processing to reflogs from the current worktree only.")),
+			 N_("limits processing to reflogs from the current worktree only")),
 		OPT_END()
 	};
 
@@ -736,7 +736,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "updateref", &flags,
 			N_("update the reference to the value of the top reflog entry"),
 			EXPIRE_REFLOGS_UPDATE_REF),
-		OPT_BOOL(0, "verbose", &verbose, N_("print extra information on screen.")),
+		OPT_BOOL(0, "verbose", &verbose, N_("print extra information on screen")),
 		OPT_END()
 	};
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c5d3fc3817f..9864ec1427d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1874,7 +1874,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "depth", &clone_data.depth,
 			   N_("string"),
 			   N_("depth for shallow clones")),
-		OPT__QUIET(&quiet, "Suppress output for cloning a submodule"),
+		OPT__QUIET(&quiet, "suppress output for cloning a submodule"),
 		OPT_BOOL(0, "progress", &progress,
 			   N_("force cloning progress")),
 		OPT_BOOL(0, "require-init", &require_init,
diff --git a/check-usage-strings.sh b/check-usage-strings.sh
new file mode 100755
index 00000000000..a4028e0d00d
--- /dev/null
+++ b/check-usage-strings.sh
@@ -0,0 +1,33 @@
+{
+  if test -d ".git"
+  then
+    rev=${1:-"HEAD"}
+    for entry in $(git grep -l 'struct option .* = {$' "$rev" -- \*.c);
+    do
+      git show "$entry" |
+      sed -n '/struct option .* = {/,/OPT_END/{=;p;}' |
+      sed "N;s/^\\([0-9]*\\)\\n/$(echo "$entry" | sed 's/\//\\&/g'):\\1/";
+    done
+  else
+    for entry in $(grep -rl --include="*.c" 'struct option .* = {$' . );
+    do
+      cat "$entry" |
+      sed -n '/struct option .* = {/,/OPT_END/{=;p;}' |
+      sed "N;s/^\\([0-9]*\\)\\n/$(echo "$entry" | sed -e 's/\//\\&/g' -e 's/^\.\\\///'):\\1/";
+    done
+  fi
+} |
+grep -Pe '((?<!OPT_GROUP\(N_\(|OPT_GROUP\()"(?!GPG|DEPRECATED|SHA1|HEAD)[A-Z]|(?<!"|\.\.)\.")' |
+{
+  status=0
+  while read content;
+  do
+    if test -n "$content"
+    then
+      echo "$content";
+      status=1;
+    fi
+  done
+
+  exit $status
+}
diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index de41888430a..f66848dfc66 100755
--- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -15,6 +15,7 @@ filter_log () {
 }
 
 make check-builtins
+make check-usage-strings
 make check-docs
 
 # Build docs with AsciiDoc
diff --git a/diff.c b/diff.c
index c862771a589..000be3bf232 100644
--- a/diff.c
+++ b/diff.c
@@ -5596,7 +5596,7 @@ static void prep_parse_options(struct diff_options *options)
 			       N_("select files by diff type"),
 			       PARSE_OPT_NONEG, diff_opt_diff_filter),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
-		  N_("Output to a specific file"),
+		  N_("output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
 
 		OPT_END()
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 913775a14b7..8f370cd89f1 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -221,9 +221,9 @@ static int quote_stress_test(int argc, const char **argv)
 	struct strbuf out = STRBUF_INIT;
 	struct strvec args = STRVEC_INIT;
 	struct option options[] = {
-		OPT_INTEGER('n', "trials", &trials, "Number of trials"),
-		OPT_INTEGER('s', "skip", &skip, "Skip <n> trials"),
-		OPT_BOOL('m', "msys2", &msys2, "Test quoting for MSYS2's sh"),
+		OPT_INTEGER('n', "trials", &trials, "number of trials"),
+		OPT_INTEGER('s', "skip", &skip, "skip <n> trials"),
+		OPT_BOOL('m', "msys2", &msys2, "test quoting for MSYS2's sh"),
 		OPT_END()
 	};
 	const char * const usage[] = {

base-commit: b80121027d1247a0754b3cc46897fee75c050b44
-- 
gitgitgadget
