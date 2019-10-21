Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C9A41F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 13:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbfJUN4h (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 09:56:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34606 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfJUN4d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 09:56:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id t16so8982731wrr.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 06:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=93/QW8f/tOZmX6NXocIlbXxnEZXrvgmNhHngCIFSYBw=;
        b=dJn1HhTeduxBjkq6vHX5rxKu82Dum/tgps5E/CbCuemfxufsQoVxWap50mj+dkefnY
         eSoG2vFvipXym2inhD28Ww8s26kGCfRJ5QKTTmJcaeKrVIFfpD312EGzdlsHqRbvoTEa
         /fWbWauktK4MX39/wDRkVVY9r4OF9BPQ157tE9SkBOr5QfzkGN01YztrfsemwRs7V8Tb
         i3raP0N3M2q1rw6LyM6MqTZUAlUlbgGKxgY+Vdf8z4w/FEj8WJi7cPWaZ3p/zaHdBlYv
         vGJYrY8Wot2+Q1kZbUhpr3k3tpD6b9i1cxWXq1tTKjXj5tHzeC+/eppA6NavXe7WvNAV
         du/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=93/QW8f/tOZmX6NXocIlbXxnEZXrvgmNhHngCIFSYBw=;
        b=W0w7nCUUkua0kSSbDS07WIpe85luD2wVXcSlKWlzGucUL6XqQ2aGFbcM1Nb7HCbAVF
         J//zT04Ura35qfg+pqo63OFXgSJg8EgHqnSU+aN8EKi+MsjxZbUlv1q2glAUeV6eKoNm
         Wmzp7tva2AjK1UYRp7Osnc9p2lK9FJpIbf0U+6rOr5114Q72AVty58IwJLqsLDf6+788
         Ce6xU5w4ZzKeOxcKb9GoJTp5c7YjVXIDyAI1ILCxx0EM+cvTosLFebSxegWQtmM9/KJf
         eK9CkqEnCUwTvQV79s2OKTdylqZbOZ8jjalryUREPw1I33f9n4dh1GjsijCNhc91zyHf
         Lnag==
X-Gm-Message-State: APjAAAWQcM7hd8DPAiownvQ7lK0sAP0IKX9gTrPwwLxRTHjM0kDCtGnI
        9ZuIo9vtEv1tqeZ/PK3sD+5LjbHo
X-Google-Smtp-Source: APXvYqz+spJXpZVIsLfUWSEBpVulJ1DZ03+uzTUvKwaqcV9VbYsWQGY4bSpnvoPCAAHypwvPTmiNrg==
X-Received: by 2002:a5d:65cf:: with SMTP id e15mr12498187wrw.391.1571666188988;
        Mon, 21 Oct 2019 06:56:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n3sm15803694wrr.50.2019.10.21.06.56.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 06:56:28 -0700 (PDT)
Message-Id: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Oct 2019 13:56:09 +0000
Subject: [PATCH v5 00/17] New sparse-checkout builtin and "cone" mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, jon@jonsimons.org, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

V4 UPDATE: Rebased on latest master to include ew/hashmap and
ds/include-exclude in the base.

This series makes the sparse-checkout feature more user-friendly. While
there, I also present a way to use a limited set of patterns to gain a
significant performance boost in very large repositories.

Sparse-checkout is only documented as a subsection of the read-tree docs
[1], which makes the feature hard to discover. Users have trouble navigating
the feature, especially at clone time [2], and have even resorted to
creating their own helper tools [3].

This series attempts to solve these problems using a new builtin. Here is a
sample workflow to give a feeling for how it can work:

In an existing repo:

$ git sparse-checkout init
$ ls
myFile1.txt myFile2.txt
$ git sparse-checkout set "/*" "!/*/" /myFolder/
$ ls
myFile1.txt myFile2.txt myFolder
$ ls myFolder
a.c a.h
$ git sparse-checkout disable
$ ls
hiddenFolder myFile1.txt myFile2.txt myFolder

At clone time:

$ git clone --sparse origin repo
$ cd repo
$ ls
myFile1.txt myFile2.txt
$ git sparse-checkout set "/*" "!/*/" /myFolder/
$ ls
myFile1.txt myFile2.txt myFolder

Here are some more specific details:

 * git sparse-checkout init enables core.sparseCheckout and populates the
   sparse-checkout file with patterns that match only the files at root.
   
   
 * git clone learns the --sparse argument to run git sparse-checkout init 
   before the first checkout.
   
   
 * git sparse-checkout set reads patterns from the arguments, or with
   --stdin reads patterns from stdin one per line, then writes them to the
   sparse-checkout file and refreshes the working directory.
   
   
 * git sparse-checkout disable removes the patterns from the sparse-checkout
   file, disables core.sparseCheckout, and refills the working directory.
   
   
 * git sparse-checkout list lists the contents of the sparse-checkout file.
   
   

The documentation for the sparse-checkout feature can now live primarily
with the git-sparse-checkout documentation.

Cone Mode
=========

What really got me interested in this area is a performance problem. If we
have N patterns in the sparse-checkout file and M entries in the index, then
we can perform up to O(N * M) pattern checks in clear_ce_flags(). This
quadratic growth is not sustainable in a repo with 1,000+ patterns and
1,000,000+ index entries.

To solve this problem, I propose a new, more restrictive mode to
sparse-checkout: "cone mode". In this mode, all patterns are based on prefix
matches at a directory level. This can then use hashsets for fast
performance -- O(M) instead of O(N*M). My hashset implementation is based on
the virtual filesystem hook in the VFS for Git custom code [4].

In cone mode, a user specifies a list of folders which the user wants every
file inside. In addition, the cone adds all blobs that are siblings of the
folders in the directory path to that folder. This makes the directories
look "hydrated" as a user drills down to those recursively-closed folders.
These directories are called "parent" folders, as a file matches them only
if the file's immediate parent is that directory.

When building a prototype of this feature, I used a separate file to contain
the list of recursively-closed folders and built the hashsets dynamically
based on that file. In this implementation, I tried to maximize the amount
of backwards-compatibility by storing all data in the sparse-checkout file
using patterns recognized by earlier Git versions.

For example, if we add A/B/C as a recursive folder, then we add the
following patterns to the sparse-checkout file:

/*
!/*/
/A/
!/A/*/
/A/B/
!/A/B/*/
/A/B/C/

The alternating positive/negative patterns say "include everything in this
folder, but exclude everything another level deeper". The final pattern has
no matching negation, so is a recursively closed pattern.

Note that I have some basic warnings to try and check that the
sparse-checkout file doesn't match what would be written by a cone-mode add.
In such a case, Git writes a warning to stderr and continues with the old
pattern matching algorithm. These checks are currently very barebones, and
would need to be updated with more robust checks for things like regex
characters in the middle of the pattern. As review moves forward (and if we
don't change the data storage) then we could spend more time on this.

Thanks, -Stolee

Updates in v2, relative to the RFC:

 * Instead of an 'add' subcommand, use a 'set' subcommand. We can consider
   adding 'add' and/or 'remove' subcommands later.
   
   
 * 'set' reads from the arguments by default. '--stdin' option is available.
   
   
 * A new performance-oriented commit is added at the end.
   
   
 * Patterns no longer end with a trailing asterisk except for the first "/*"
   pattern.
   
   
 * References to a "bug" (that was really a strange GVFS interaction in
   microsoft/git) around deleting outside the cone are removed.
   
   

Updates in v3:

 * The bad interaction with "cone mode" and .gitignore files is fixed. A
   test is added in the last patch.
   
   
 * Several patches are added that make the feature more robust. One
   sanitizes user input, another few add progress indicators, and another
   more prevent users from getting in bad states due to working directory
   changes or concurrent processes.
   
   
 * Updated several docs and commit messages according to feedback. Thanks,
   Elijah!
   
   

Updates in V4:

 * Updated hashmap API usage to respond to ew/hashmap
   
   
 * Responded to detailed review by Elijah. Thanks!
   
   
 * Marked the feature as experimental in git-sparse-checkout.txt the same
   way that git-switch.txt does.
   
   

Updates in V5:

 * The 'set' subcommand now enables the core.sparseCheckout config setting
   (unless the checkout fails).
   
   
 * If the in-process unpack_trees() fails with the new patterns, the
   index.lock file is rolled back before the replay of the old
   sparse-checkout patterns.
   
   
 * Some documentation fixes, f(d)open->xf(d)open calls, and other nits.
   Thanks everyone!
   
   

Things to leave for future patches:

 1. Integrate in 'git worktree add' to copy the sparse-checkout file to a
    worktree-specific file.
    
    
 2. More robustness around detecting non-cone patterns with wildcards in the
    middle of the line.
    
    
 3. 'git clone --sparse-cone' to clone into "cone mode" sparse-checkouts
    (i.e. set 'core.sparseCheckoutCone=true'). This may not be
    super-valuable, as it only starts changing behavior when someone calls
    'git sparse-checkout set', but may be interesting.
    
    

[1] https://git-scm.com/docs/git-read-tree#_sparse_checkoutSparse-checkout
documentation in git-read-tree.

[2] https://stackoverflow.com/a/4909267/127088Is it possible to do a sparse
checkout without checking out the whole repository first?

[3] http://www.marcoyuen.com/articles/2016/06/07/git-sparse.htmlA blog post
of a user's extra "git-sparse" helper.

[4] 
https://github.com/git/git/compare/fc5fd706ff733392053e6180086a4d7f96acc2af...01204f24c5349aa2fb0c474546d768946d315dab
The virtual filesystem hook in microsoft/git.

Derrick Stolee (16):
  sparse-checkout: create builtin with 'list' subcommand
  sparse-checkout: create 'init' subcommand
  clone: add --sparse mode
  sparse-checkout: 'set' subcommand
  sparse-checkout: add '--stdin' option to set subcommand
  sparse-checkout: create 'disable' subcommand
  sparse-checkout: add 'cone' mode
  sparse-checkout: use hashmaps for cone patterns
  sparse-checkout: init and set in cone mode
  unpack-trees: hash less in cone mode
  unpack-trees: add progress to clear_ce_flags()
  read-tree: show progress by default
  sparse-checkout: sanitize for nested folders
  sparse-checkout: update working directory in-process
  sparse-checkout: write using lockfile
  sparse-checkout: cone mode should not interact with .gitignore

Jeff Hostetler (1):
  trace2: add region in clear_ce_flags

 .gitignore                            |   1 +
 Documentation/config/core.txt         |  10 +-
 Documentation/git-clone.txt           |   8 +-
 Documentation/git-read-tree.txt       |   2 +-
 Documentation/git-sparse-checkout.txt | 153 ++++++++
 Makefile                              |   1 +
 builtin.h                             |   1 +
 builtin/clone.c                       |  27 ++
 builtin/read-tree.c                   |   3 +-
 builtin/sparse-checkout.c             | 488 ++++++++++++++++++++++++++
 cache.h                               |   6 +-
 command-list.txt                      |   1 +
 config.c                              |   5 +
 dir.c                                 | 207 ++++++++++-
 dir.h                                 |  36 ++
 environment.c                         |   1 +
 git.c                                 |   1 +
 t/t1091-sparse-checkout-builtin.sh    | 293 ++++++++++++++++
 unpack-trees.c                        | 110 ++++--
 unpack-trees.h                        |   3 +-
 20 files changed, 1309 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/git-sparse-checkout.txt
 create mode 100644 builtin/sparse-checkout.c
 create mode 100755 t/t1091-sparse-checkout-builtin.sh


base-commit: 108b97dc372828f0e72e56bbb40cae8e1e83ece6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-316%2Fderrickstolee%2Fsparse-checkout%2Fupstream-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-316/derrickstolee/sparse-checkout/upstream-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/316

Range-diff vs v4:

  1:  63626e1097 !  1:  55c306a73a sparse-checkout: create builtin with 'list' subcommand
     @@ -54,7 +54,7 @@
       +++ b/Documentation/git-sparse-checkout.txt
      @@
      +git-sparse-checkout(1)
     -+=======================
     ++======================
      +
      +NAME
      +----
     @@ -75,7 +75,9 @@
      +Initialize and modify the sparse-checkout configuration, which reduces
      +the checkout to a set of directories given by a list of prefixes.
      +
     -+THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
     ++THIS COMMAND IS EXPERIMENTAL. ITS BEHAVIOR, AND THE BEHAVIOR OF OTHER
     ++COMMANDS IN THE PRESENCE OF SPARSE-CHECKOUTS, WILL LIKELY CHANGE IN
     ++THE FUTURE.
      +
      +
      +COMMANDS
     @@ -85,7 +87,7 @@
      +
      +
      +SPARSE CHECKOUT
     -+----------------
     ++---------------
      +
      +"Sparse checkout" allows populating the working directory sparsely.
      +It uses the skip-worktree bit (see linkgit:git-update-index[1]) to tell
     @@ -180,7 +182,7 @@
      +#include "strbuf.h"
      +
      +static char const * const builtin_sparse_checkout_usage[] = {
     -+	N_("git sparse-checkout [list]"),
     ++	N_("git sparse-checkout list"),
      +	NULL
      +};
      +
     @@ -257,6 +259,18 @@
      +			   builtin_sparse_checkout_options);
      +}
      
     + diff --git a/command-list.txt b/command-list.txt
     + --- a/command-list.txt
     + +++ b/command-list.txt
     +@@
     + git-show-ref                            plumbinginterrogators
     + git-sh-i18n                             purehelpers
     + git-sh-setup                            purehelpers
     ++git-sparse-checkout                     mainporcelain           worktree
     + git-stash                               mainporcelain
     + git-stage                                                               complete
     + git-status                              mainporcelain           info
     +
       diff --git a/git.c b/git.c
       --- a/git.c
       +++ b/git.c
     @@ -301,7 +315,7 @@
      +
      +test_expect_success 'git sparse-checkout list (empty)' '
      +	git -C repo sparse-checkout list >list 2>err &&
     -+	test_line_count = 0 list &&
     ++	test_must_be_empty list &&
      +	test_i18ngrep "this worktree is not sparse (sparse-checkout file may not exist)" err
      +'
      +
     @@ -313,13 +327,8 @@
      +		**/a
      +		!*bin*
      +	EOF
     ++	cp repo/.git/info/sparse-checkout expect &&
      +	git -C repo sparse-checkout list >list &&
     -+	cat >expect <<-EOF &&
     -+		/folder1/*
     -+		/deep/
     -+		**/a
     -+		!*bin*
     -+	EOF
      +	test_cmp expect list
      +'
      +
  2:  65d26de1c2 !  2:  a161cee0df sparse-checkout: create 'init' subcommand
     @@ -37,7 +37,7 @@
      +`core.sparseCheckout` setting in the worktree-specific config file.
       
       SPARSE CHECKOUT
     - ----------------
     + ---------------
      
       diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
       --- a/builtin/sparse-checkout.c
     @@ -46,8 +46,8 @@
       #include "strbuf.h"
       
       static char const * const builtin_sparse_checkout_usage[] = {
     --	N_("git sparse-checkout [list]"),
     -+	N_("git sparse-checkout [init|list]"),
     +-	N_("git sparse-checkout list"),
     ++	N_("git sparse-checkout (init|list)"),
       	NULL
       };
       
     @@ -121,7 +121,7 @@
      +	}
      +
      +	/* initial mode: all blobs at root */
     -+	fp = fopen(sparse_filename, "w");
     ++	fp = xfopen(sparse_filename, "w");
      +	free(sparse_filename);
      +	fprintf(fp, "/*\n!/*/\n");
      +	fclose(fp);
  3:  e59ed7128f =  3:  cd150853b7 clone: add --sparse mode
  4:  502b4b08f0 !  4:  7d9d66a89f sparse-checkout: 'set' subcommand
     @@ -11,6 +11,11 @@
          extracted from cmd_sparse_checkout() to make it easier to implement
          'add' and/or 'remove' subcommands in the future.
      
     +    If the core.sparseCheckout config setting is disabled, then enable
     +    the config setting in the worktree config. If we set the config
     +    this way and the sparse-checkout fails, then re-disable the config
     +    setting.
     +
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
     @@ -23,10 +28,11 @@
      +'set'::
      +	Write a set of patterns to the sparse-checkout file, as given as
      +	a list of arguments following the 'set' subcommand. Update the
     -+	working directory to match the new patterns.
     ++	working directory to match the new patterns. Enable the
     ++	core.sparseCheckout config setting if it is not already enabled.
      +
       SPARSE CHECKOUT
     - ----------------
     + ---------------
       
      
       diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
     @@ -36,8 +42,8 @@
       #include "strbuf.h"
       
       static char const * const builtin_sparse_checkout_usage[] = {
     --	N_("git sparse-checkout [init|list]"),
     -+	N_("git sparse-checkout [init|list|set] <options>"),
     +-	N_("git sparse-checkout (init|list)"),
     ++	N_("git sparse-checkout (init|list|set) <options>"),
       	NULL
       };
       
     @@ -65,13 +71,23 @@
      +	int i;
      +	struct pattern_list pl;
      +	int result;
     ++	int set_config = 0;
      +	memset(&pl, 0, sizeof(pl));
      +
      +	for (i = 1; i < argc; i++)
      +		add_pattern(argv[i], empty_base, 0, &pl, 0);
      +
     ++	if (!core_apply_sparse_checkout) {
     ++		sc_set_config(MODE_ALL_PATTERNS);
     ++		core_apply_sparse_checkout = 1;
     ++		set_config = 1;
     ++	}
     ++
      +	result = write_patterns_and_update(&pl);
      +
     ++	if (result && set_config)
     ++		sc_set_config(MODE_NO_PATTERNS);
     ++
      +	clear_pattern_list(&pl);
      +	return result;
      +}
     @@ -96,6 +112,19 @@
       	test_cmp expect dir
       '
       
     ++test_expect_success 'set enables config' '
     ++	git init empty-config &&
     ++	(
     ++		cd empty-config &&
     ++		test_commit test file &&
     ++		test_path_is_missing .git/config.worktree &&
     ++		test_must_fail git sparse-checkout set nothing &&
     ++		test_i18ngrep "sparseCheckout = false" .git/config.worktree &&
     ++		git sparse-checkout set "/*" &&
     ++		test_i18ngrep "sparseCheckout = true" .git/config.worktree
     ++	)
     ++'
     ++
      +test_expect_success 'set sparse-checkout using builtin' '
      +	git -C repo sparse-checkout set "/*" "!/*/" "*folder*" &&
      +	cat >expect <<-EOF &&
  5:  2852cf8e11 !  5:  0e08898dcb sparse-checkout: add '--stdin' option to set subcommand
     @@ -14,18 +14,6 @@
       diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
       --- a/builtin/sparse-checkout.c
       +++ b/builtin/sparse-checkout.c
     -@@
     - 	char *sparse_filename;
     - 	FILE *fp;
     - 
     -+	if (!core_apply_sparse_checkout) {
     -+		warning(_("core.sparseCheckout is disabled, so changes to the sparse-checkout file will have no effect"));
     -+		warning(_("run 'git sparse-checkout init' to enable the sparse-checkout feature"));
     -+	}
     -+
     - 	sparse_filename = get_sparse_checkout_filename();
     - 	fp = fopen(sparse_filename, "w");
     - 	write_patterns_to_file(fp, pl);
      @@
       	return update_working_directory();
       }
     @@ -42,9 +30,10 @@
       static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
       {
       	static const char *empty_base = "";
     - 	int i;
     +@@
       	struct pattern_list pl;
       	int result;
     + 	int set_config = 0;
      +
      +	static struct option builtin_sparse_checkout_set_options[] = {
      +		OPT_BOOL(0, "stdin", &set_opts.use_stdin,
     @@ -74,8 +63,8 @@
      +			add_pattern(argv[i], empty_base, 0, &pl, 0);
      +	}
       
     - 	result = write_patterns_and_update(&pl);
     - 
     + 	if (!core_apply_sparse_checkout) {
     + 		sc_set_config(MODE_ALL_PATTERNS);
      
       diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
       --- a/t/t1091-sparse-checkout-builtin.sh
     @@ -84,20 +73,6 @@
       	test_cmp expect dir
       '
       
     -+test_expect_success 'warn if core.sparseCheckout is disabled' '
     -+	test_when_finished git -C repo config --worktree core.sparseCheckout true &&
     -+	git -C repo config --worktree core.sparseCheckout false &&
     -+	git -C repo sparse-checkout set folder1 2>err &&
     -+	test_i18ngrep "core.sparseCheckout is disabled" err
     -+'
     -+
     - test_expect_success 'set sparse-checkout using builtin' '
     - 	git -C repo sparse-checkout set "/*" "!/*/" "*folder*" &&
     - 	cat >expect <<-EOF &&
     -@@
     - 	test_cmp expect dir
     - '
     - 
      +test_expect_success 'set sparse-checkout using --stdin' '
      +	cat >expect <<-EOF &&
      +		/*
  6:  55f95f290e !  6:  c48535cd5c sparse-checkout: create 'disable' subcommand
     @@ -13,15 +13,15 @@
       --- a/Documentation/git-sparse-checkout.txt
       +++ b/Documentation/git-sparse-checkout.txt
      @@
     - 	a list of arguments following the 'set' subcommand. Update the
     - 	working directory to match the new patterns.
     + 	working directory to match the new patterns. Enable the
     + 	core.sparseCheckout config setting if it is not already enabled.
       
      +'disable'::
      +	Remove the sparse-checkout file, set `core.sparseCheckout` to
      +	`false`, and restore the working directory to include all files.
      +
       SPARSE CHECKOUT
     - ----------------
     + ---------------
       
      @@
       on this file. The files matching the patterns in the file will
     @@ -68,8 +68,8 @@
       #include "strbuf.h"
       
       static char const * const builtin_sparse_checkout_usage[] = {
     --	N_("git sparse-checkout [init|list|set] <options>"),
     -+	N_("git sparse-checkout [init|list|set|disable] <options>"),
     +-	N_("git sparse-checkout (init|list|set) <options>"),
     ++	N_("git sparse-checkout (init|list|set|disable) <options>"),
       	NULL
       };
       
     @@ -86,7 +86,7 @@
      +		die(_("failed to change config"));
      +
      +	sparse_filename = get_sparse_checkout_filename();
     -+	fp = fopen(sparse_filename, "w");
     ++	fp = xfopen(sparse_filename, "w");
      +	fprintf(fp, "/*\n");
      +	fclose(fp);
      +
  7:  3d8f2f2007 =  7:  44b0245e65 trace2: add region in clear_ce_flags
  8:  03dc0ed716 =  8:  121d878882 sparse-checkout: add 'cone' mode
  9:  28606a152c !  9:  ff2a59bfff sparse-checkout: use hashmaps for cone patterns
     @@ -22,9 +22,9 @@
          Running 'git read-tree -mu HEAD' on this file had the following
          performance:
      
     -            core.sparseCheckout=false: 0.21 s (0.00 s)
     -             core.sparseCheckout=true: 3.75 s (3.50 s)
     -             core.sparseCheckout=cone: 0.23 s (0.01 s)
     +        core.sparseCheckout=false: 0.21 s (0.00 s)
     +         core.sparseCheckout=true: 3.75 s (3.50 s)
     +     core.sparseCheckoutCone=true: 0.23 s (0.01 s)
      
          The times in parentheses above correspond to the time spent
          in the first clear_ce_flags() call, according to the trace2
 10:  2ea3d8819b ! 10:  0258ee8026 sparse-checkout: init and set in cone mode
     @@ -32,7 +32,7 @@
      +#include "string-list.h"
       
       static char const * const builtin_sparse_checkout_usage[] = {
     - 	N_("git sparse-checkout [init|list|set|disable] <options>"),
     + 	N_("git sparse-checkout (init|list|set|disable) <options>"),
      @@
       enum sparse_checkout_mode {
       	MODE_NO_PATTERNS = 0,
     @@ -250,7 +250,7 @@
      +		}
       	}
       
     - 	result = write_patterns_and_update(&pl);
     + 	if (!core_apply_sparse_checkout) {
      
       diff --git a/dir.c b/dir.c
       --- a/dir.c
 11:  fefd1e1744 = 11:  7b5c5bad2d unpack-trees: hash less in cone mode
 12:  034fbd31bd = 12:  386f4f8eb5 unpack-trees: add progress to clear_ce_flags()
 13:  27aa9d22f0 = 13:  a229e1ee0c read-tree: show progress by default
 14:  44c3078029 = 14:  f03bb23305 sparse-checkout: sanitize for nested folders
 15:  9ccec3ca9a ! 15:  d7af75672b sparse-checkout: update working directory in-process
     @@ -14,6 +14,12 @@
          reading from the sparse-checkout file. This allows us to test a
          proposed change to the file before writing to it.
      
     +    An earlier version of this patch included a bug when the 'set' command
     +    failed due to the "Sparse checkout leaves no entry on working directory"
     +    error. It would not rollback the index.lock file, so the replay of the
     +    old sparse-checkout specification would fail. A test in t1091 now
     +    covers that scenario.
     +
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       diff --git a/builtin/read-tree.c b/builtin/read-tree.c
     @@ -43,7 +49,7 @@
      +#include "unpack-trees.h"
       
       static char const * const builtin_sparse_checkout_usage[] = {
     - 	N_("git sparse-checkout [init|list|set|disable] <options>"),
     + 	N_("git sparse-checkout (init|list|set|disable) <options>"),
      @@
       	return 0;
       }
     @@ -64,6 +70,7 @@
      -	if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
      -		error(_("failed to update index with new sparse-checkout paths"));
      -		result = 1;
     +-	}
      +	if (repo_read_index_unmerged(r))
      +		die(_("You need to resolve your current index first"));
      +
     @@ -99,7 +106,8 @@
      +	if (!result) {
      +		prime_cache_tree(r, r->index, tree);
      +		write_locked_index(r->index, &lock_file, COMMIT_LOCK);
     - 	}
     ++	} else
     ++		rollback_lock_file(&lock_file);
       
      -	argv_array_clear(&argv);
       	return result;
     @@ -133,12 +141,7 @@
       	char *sparse_filename;
       	FILE *fp;
      +	int result;
     - 
     - 	if (!core_apply_sparse_checkout) {
     - 		warning(_("core.sparseCheckout is disabled, so changes to the sparse-checkout file will have no effect"));
     - 		warning(_("run 'git sparse-checkout init' to enable the sparse-checkout feature"));
     - 	}
     - 
     ++
      +	result = update_working_directory(pl);
      +
      +	if (result) {
     @@ -146,10 +149,9 @@
      +		update_working_directory(NULL);
      +		return result;
      +	}
     -+
     + 
       	sparse_filename = get_sparse_checkout_filename();
       	fp = fopen(sparse_filename, "w");
     - 
      @@
       		write_patterns_to_file(fp, pl);
       
     @@ -203,6 +205,19 @@
      +	EOF
      +	test_cmp dir expect
      +'
     ++
     ++test_expect_success 'revert to old sparse-checkout on empty update' '
     ++	git init empty-test &&
     ++	(
     ++		echo >file &&
     ++		git add file &&
     ++		git commit -m "test" &&
     ++		test_must_fail git sparse-checkout set nothing 2>err &&
     ++		test_i18ngrep "Sparse checkout leaves no entry on working directory" err &&
     ++		test_i18ngrep ! ".git/index.lock" err &&
     ++		git sparse-checkout set file
     ++	)
     ++'
      +
       test_done
      
 16:  d0421ef7b2 ! 16:  88eff318e0 sparse-checkout: write using lockfile
     @@ -24,9 +24,6 @@
      +	struct lock_file lk = LOCK_INIT;
       	int result;
       
     - 	if (!core_apply_sparse_checkout) {
     -@@
     - 
       	result = update_working_directory(pl);
       
      +	sparse_filename = get_sparse_checkout_filename();
     @@ -44,7 +41,7 @@
       
      -	sparse_filename = get_sparse_checkout_filename();
      -	fp = fopen(sparse_filename, "w");
     -+	fp = fdopen(fd, "w");
     ++	fp = xfdopen(fd, "w");
       
       	if (core_sparse_checkout_cone)
       		write_cone_to_file(fp, pl);
     @@ -62,7 +59,7 @@
       --- a/t/t1091-sparse-checkout-builtin.sh
       +++ b/t/t1091-sparse-checkout-builtin.sh
      @@
     - 	test_cmp dir expect
     + 	)
       '
       
      +test_expect_success 'fail when lock is taken' '
 17:  ed1f148763 = 17:  ab20c11d71 sparse-checkout: cone mode should not interact with .gitignore

-- 
gitgitgadget
