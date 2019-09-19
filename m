Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7B691F463
	for <e@80x24.org>; Thu, 19 Sep 2019 14:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388977AbfISOnR (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 10:43:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33611 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732395AbfISOnP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 10:43:15 -0400
Received: by mail-wm1-f67.google.com with SMTP id r17so7347947wme.0
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 07:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hCi4iWc0w+r8GmMrDNTshKqVwjfJ2JmXXhmbnYNSYGA=;
        b=Wbj+apO19Y7E4GNx08VjZrpkEtvm2X7mJvwlDMRuSYQmZd7+E1/vrJTXIlf/WZHXvC
         /0wBIRZvLSyqYWtBexKoNpaLmNOoZjnrVFYMCJ9SnN26NeTZ9tZapTE0fUIzYfmvlH6u
         bj6UOu4UMrKcSIWvWC4hkYIPnK/fcpYfp/CNVArzQfRvsrpSTErLwPlhOxo6R+m6mOGX
         cHJ3ArmT7pz+ieOH7sJYo6r88L5uzFCRoTJPxov8utMDTb5bXaISH0LwIqBE8HTCglWG
         LECULVER/9gvr2jB2huEwCPzQWU0EZ2xmbYBCQW/DzYeX4I/tbVU8kvBhPlV3XGkuNqr
         LMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hCi4iWc0w+r8GmMrDNTshKqVwjfJ2JmXXhmbnYNSYGA=;
        b=eMLFTXO1dDCDJDYKzIGagRuytplbQDC79Gyj4o6Vdu8PMilNqgOEkMA3jm8kycDYy1
         Fv3pyLfsdeJm07hKx/bPuA3QxJU6O3/iH2zqv5JVybc1UAoXOAjfv9HySmPcoYymBT2W
         /akDBkc1q8xM5RdetFp7ninzy2H5Nf0+K902keqxaiV1JcFUcPNsPMv8xxg5K6yYHQAi
         Be3Jvz5jT1DItSpPRzOaQdENuTliZvXt9pSzPBLqVifjyeBwEtYsnnr8OamvjZ9nNMtz
         DF0VCymmcIxfu+W8N2z5hvpQfRStdtznqWQBYu4287P8OaMirra0NVI8MklesXAlyuQ2
         MZXA==
X-Gm-Message-State: APjAAAXxquI2iwV/kZLDWymNULi9s0nMXs92IIcrrT2nbSoHcNiWM1MH
        nVLYtGNG9cTlXBLW0hN/FcXWtkl6
X-Google-Smtp-Source: APXvYqxEIx/tB79VYbNfCbIk1M9gXaPjg7h1/mCnmzI/Vr1/n3Erq4YJ3LXb9/1dI4S8KX4Iv4NKXw==
X-Received: by 2002:a05:600c:22d9:: with SMTP id 25mr2990395wmg.133.1568904190177;
        Thu, 19 Sep 2019 07:43:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q3sm10708445wrm.86.2019.09.19.07.43.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 07:43:09 -0700 (PDT)
Date:   Thu, 19 Sep 2019 07:43:09 -0700 (PDT)
X-Google-Original-Date: Thu, 19 Sep 2019 14:42:57 GMT
Message-Id: <pull.316.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.git.gitgitgadget@gmail.com>
References: <pull.316.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 00/11] New sparse-checkout builtin and "cone" mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

Derrick Stolee (10):
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

Jeff Hostetler (1):
  trace2: add region in clear_ce_flags

 .gitignore                            |   1 +
 Documentation/config/core.txt         |   7 +-
 Documentation/git-clone.txt           |   8 +-
 Documentation/git-read-tree.txt       |   2 +-
 Documentation/git-sparse-checkout.txt | 148 ++++++++++
 Makefile                              |   1 +
 builtin.h                             |   1 +
 builtin/clone.c                       |  27 ++
 builtin/sparse-checkout.c             | 395 ++++++++++++++++++++++++++
 cache.h                               |   4 +-
 config.c                              |   5 +
 dir.c                                 | 173 ++++++++++-
 dir.h                                 |  31 ++
 environment.c                         |   1 +
 git.c                                 |   1 +
 t/t1091-sparse-checkout-builtin.sh    | 231 +++++++++++++++
 unpack-trees.c                        |  48 ++--
 17 files changed, 1055 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/git-sparse-checkout.txt
 create mode 100644 builtin/sparse-checkout.c
 create mode 100755 t/t1091-sparse-checkout-builtin.sh


base-commit: 468ce99b77a0efaf1ace4c31a7b0a7d036fd9ca1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-316%2Fderrickstolee%2Fsparse-checkout%2Fupstream-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-316/derrickstolee/sparse-checkout/upstream-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/316

Range-diff vs v1:

  1:  c37b5f2c29 !  1:  dbaf3de88e sparse-checkout: create builtin with 'list' subcommand
     @@ -15,16 +15,18 @@
          builtin will be the preferred mechanism for manipulating the
          sparse-checkout file and syncing the working directory.
      
     -    For now, create the basics of the builtin. Includes a single
     -    subcommand, "git sparse-checkout list", that lists the patterns
     -    currently in the sparse-checkout file. Test that these patterns
     -    are parsed and written correctly to the output.
     +    The `$GIT_DIR/info/sparse-checkout` file defines the skip-
     +    worktree reference bitmap. When Git updates the working
     +    directory, it updates the skip-worktree bits in the index
     +    based on this file and removes or restores files in the
     +    working copy to match.
      
          The documentation provided is adapted from the "git read-tree"
          documentation with a few edits for clarity in the new context.
          Extra sections are added to hint toward a future change to
     -    a moer restricted pattern set.
     +    a more restricted pattern set.
      
     +    Helped-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       diff --git a/.gitignore b/.gitignore
     @@ -114,8 +116,8 @@
      +files.
      +
      +While `$GIT_DIR/info/sparse-checkout` is usually used to specify what
     -+files are in, you can also specify what files are _not_ in, using
     -+negate patterns. For example, to remove the file `unwanted`:
     ++files are included, you can also specify what files are _not_ included,
     ++using negative patterns. For example, to remove the file `unwanted`:
      +
      +----------------
      +/*
     @@ -191,29 +193,24 @@
      +	NULL
      +};
      +
     -+struct opts_sparse_checkout {
     -+	const char *subcommand;
     -+	int read_stdin;
     -+} opts;
     -+
      +static char *get_sparse_checkout_filename(void)
      +{
      +	return git_pathdup("info/sparse-checkout");
      +}
      +
     -+static void write_excludes_to_file(FILE *fp, struct exclude_list *el)
     ++static void write_patterns_to_file(FILE *fp, struct pattern_list *pl)
      +{
      +	int i;
      +
     -+	for (i = 0; i < el->nr; i++) {
     -+		struct exclude *x = el->excludes[i];
     ++	for (i = 0; i < pl->nr; i++) {
     ++		struct path_pattern *p = pl->patterns[i];
      +
     -+		if (x->flags & EXC_FLAG_NEGATIVE)
     ++		if (p->flags & PATTERN_FLAG_NEGATIVE)
      +			fprintf(fp, "!");
      +
     -+		fprintf(fp, "%s", x->pattern);
     ++		fprintf(fp, "%s", p->pattern);
      +
     -+		if (x->flags & EXC_FLAG_MUSTBEDIR)
     ++		if (p->flags & PATTERN_FLAG_MUSTBEDIR)
      +			fprintf(fp, "/");
      +
      +		fprintf(fp, "\n");
     @@ -222,23 +219,23 @@
      +
      +static int sparse_checkout_list(int argc, const char **argv)
      +{
     -+	struct exclude_list el;
     ++	struct pattern_list pl;
      +	char *sparse_filename;
      +	int res;
      +
     -+	memset(&el, 0, sizeof(el));
     ++	memset(&pl, 0, sizeof(pl));
      +
      +	sparse_filename = get_sparse_checkout_filename();
     -+	res = add_excludes_from_file_to_list(sparse_filename, "", 0, &el, NULL);
     ++	res = add_patterns_from_file_to_list(sparse_filename, "", 0, &pl, NULL);
      +	free(sparse_filename);
      +
      +	if (res < 0) {
     -+		warning(_("failed to parse sparse-checkout file; it may not exist"));
     ++		warning(_("this worktree is not sparse (sparse-checkout file may not exist)"));
      +		return 0;
      +	}
      +
     -+	write_excludes_to_file(stdout, &el);
     -+	clear_exclude_list(&el);
     ++	write_patterns_to_file(stdout, &pl);
     ++	clear_pattern_list(&pl);
      +
      +	return 0;
      +}
     @@ -253,12 +250,13 @@
      +		usage_with_options(builtin_sparse_checkout_usage,
      +				   builtin_sparse_checkout_options);
      +
     -+	git_config(git_default_config, NULL);
      +	argc = parse_options(argc, argv, prefix,
      +			     builtin_sparse_checkout_options,
      +			     builtin_sparse_checkout_usage,
      +			     PARSE_OPT_STOP_AT_NON_OPTION);
      +
     ++	git_config(git_default_config, NULL);
     ++
      +	if (argc > 0) {
      +		if (!strcmp(argv[0], "list"))
      +			return sparse_checkout_list(argc, argv);
     @@ -313,7 +311,7 @@
      +test_expect_success 'git sparse-checkout list (empty)' '
      +	git -C repo sparse-checkout list >list 2>err &&
      +	test_line_count = 0 list &&
     -+	test_i18ngrep "failed to parse sparse-checkout file; it may not exist" err
     ++	test_i18ngrep "this worktree is not sparse (sparse-checkout file may not exist)" err
      +'
      +
      +test_expect_success 'git sparse-checkout list (populated)' '
     @@ -335,4 +333,4 @@
      +'
      +
      +test_done
     - \ No newline at end of file
     ++
  2:  e6e982e5a6 !  2:  412211f5dd sparse-checkout: create 'init' subcommand
     @@ -51,7 +51,7 @@
       	return 0;
       }
       
     -+static int sc_read_tree(void)
     ++static int update_working_directory(void)
      +{
      +	struct argv_array argv = ARGV_ARRAY_INIT;
      +	int result = 0;
     @@ -69,45 +69,25 @@
      +static int sc_enable_config(void)
      +{
      +	struct argv_array argv = ARGV_ARRAY_INIT;
     -+	int result = 0;
     -+	argv_array_pushl(&argv, "config", "--add", "core.sparseCheckout", "true", NULL);
      +
     -+	if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
     -+		error(_("failed to enable core.sparseCheckout"));
     -+		result = 1;
     ++	if (git_config_set_gently("extensions.worktreeConfig", "true")) {
     ++		error(_("failed to set extensions.worktreeConfig setting"));
     ++		return 1;
      +	}
      +
     -+	argv_array_clear(&argv);
     -+	return result;
     -+}
     -+
     -+static int delete_directory(const struct object_id *oid, struct strbuf *base,
     -+		const char *pathname, unsigned mode, int stage, void *context)
     -+{
     -+	struct strbuf dirname = STRBUF_INIT;
     -+	struct stat sb;
     -+
     -+	strbuf_addstr(&dirname, the_repository->worktree);
     -+	strbuf_addch(&dirname, '/');
     -+	strbuf_addstr(&dirname, pathname);
     -+
     -+	if (stat(dirname.buf, &sb) || !(sb.st_mode & S_IFDIR))
     -+		return 0;
     ++	argv_array_pushl(&argv, "config", "--worktree", "core.sparseCheckout", "true", NULL);
      +
     -+	if (remove_dir_recursively(&dirname, 0))
     -+		warning(_("failed to remove directory '%s'"),
     -+			dirname.buf);
     ++	if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
     ++		error(_("failed to enable core.sparseCheckout"));
     ++		return 1;
     ++	}
      +
     -+	strbuf_release(&dirname);
      +	return 0;
      +}
      +
      +static int sparse_checkout_init(int argc, const char **argv)
      +{
     -+	struct tree *t;
     -+	struct object_id oid;
     -+	struct exclude_list el;
     -+	static struct pathspec pathspec;
     ++	struct pattern_list pl;
      +	char *sparse_filename;
      +	FILE *fp;
      +	int res;
     @@ -115,10 +95,10 @@
      +	if (sc_enable_config())
      +		return 1;
      +
     -+	memset(&el, 0, sizeof(el));
     ++	memset(&pl, 0, sizeof(pl));
      +
      +	sparse_filename = get_sparse_checkout_filename();
     -+	res = add_excludes_from_file_to_list(sparse_filename, "", 0, &el, NULL);
     ++	res = add_patterns_from_file_to_list(sparse_filename, "", 0, &pl, NULL);
      +
      +	/* If we already have a sparse-checkout file, use it. */
      +	if (res >= 0) {
     @@ -129,28 +109,11 @@
      +	/* initial mode: all blobs at root */
      +	fp = fopen(sparse_filename, "w");
      +	free(sparse_filename);
     -+	fprintf(fp, "/*\n!/*/*\n");
     ++	fprintf(fp, "/*\n!/*/\n");
      +	fclose(fp);
      +
     -+	/* remove all directories in the root, if tracked by Git */
     -+	if (get_oid("HEAD", &oid)) {
     -+		/* assume we are in a fresh repo */
     -+		return 0;
     -+	}
     -+
     -+	t = parse_tree_indirect(&oid);
     -+
     -+	parse_pathspec(&pathspec, PATHSPEC_ALL_MAGIC &
     -+				  ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL),
     -+		       PATHSPEC_PREFER_CWD,
     -+		       "", NULL);
     -+
     -+	if (read_tree_recursive(the_repository, t, "", 0, 0, &pathspec,
     -+				delete_directory, NULL))
     -+		return 1;
     -+
      +reset_dir:
     -+	return sc_read_tree();
     ++	return update_working_directory();
      +}
      +
       int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
     @@ -177,7 +140,7 @@
      +	git -C repo sparse-checkout init &&
      +	cat >expect <<-EOF &&
      +		/*
     -+		!/*/*
     ++		!/*/
      +	EOF
      +	test_cmp expect repo/.git/info/sparse-checkout &&
      +	git -C repo config --list >config &&
     @@ -191,27 +154,28 @@
      +	git -C repo sparse-checkout list >actual &&
      +	cat >expect <<-EOF &&
      +		/*
     -+		!/*/*
     ++		!/*/
      +	EOF
      +	test_cmp expect actual
      +'
      +
      +test_expect_success 'init with existing sparse-checkout' '
     -+	echo "/folder1/*" >> repo/.git/info/sparse-checkout &&
     ++	echo "*folder*" >> repo/.git/info/sparse-checkout &&
      +	git -C repo sparse-checkout init &&
      +	cat >expect <<-EOF &&
      +		/*
     -+		!/*/*
     -+		/folder1/*
     ++		!/*/
     ++		*folder*
      +	EOF
      +	test_cmp expect repo/.git/info/sparse-checkout &&
      +	ls repo >dir  &&
      +	cat >expect <<-EOF &&
      +		a
      +		folder1
     ++		folder2
      +	EOF
      +	test_cmp expect dir
      +'
      +
       test_done
     - \ No newline at end of file
     + 
  3:  4ccd36b396 !  3:  fef41b794a clone: add --sparse mode
     @@ -13,13 +13,18 @@
          sparse-checkout file to include the following patterns:
      
                  /*
     -            !/*/*
     +            !/*/
      
          These patterns include every file in the root directory, but
          no directories. This allows a repo to include files like a
          README or a bootstrapping script to grow enlistments from that
          point.
      
     +    During the 'git sparse-checkout init' call, we must first look
     +    to see if HEAD is valid, or else we will fail while trying to
     +    update the working directory. The first checkout will actually
     +    update the working directory correctly.
     +
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
     @@ -107,6 +112,30 @@
       
       	strbuf_addf(&default_refspec, "+%s*:%s*", src_ref_prefix,
      
     + diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
     + --- a/builtin/sparse-checkout.c
     + +++ b/builtin/sparse-checkout.c
     +@@
     + 	char *sparse_filename;
     + 	FILE *fp;
     + 	int res;
     ++	struct object_id oid;
     + 
     + 	if (sc_enable_config())
     + 		return 1;
     +@@
     + 	fprintf(fp, "/*\n!/*/\n");
     + 	fclose(fp);
     + 
     ++	if (get_oid("HEAD", &oid)) {
     ++		/* assume we are in a fresh repo */
     ++		return 0;
     ++	}
     ++
     + reset_dir:
     + 	return update_working_directory();
     + }
     +
       diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
       --- a/t/t1091-sparse-checkout-builtin.sh
       +++ b/t/t1091-sparse-checkout-builtin.sh
     @@ -119,7 +148,7 @@
      +	git -C clone sparse-checkout list >actual &&
      +	cat >expect <<-EOF &&
      +		/*
     -+		!/*/*
     ++		!/*/
      +	EOF
      +	test_cmp expect actual &&
      +	ls clone >dir &&
     @@ -128,4 +157,4 @@
      +'
      +
       test_done
     - \ No newline at end of file
     + 
  4:  0f095e85d5 !  4:  9a78f9ea0f sparse-checkout: 'add' subcommand
     @@ -1,14 +1,15 @@
      Author: Derrick Stolee <dstolee@microsoft.com>
      
     -    sparse-checkout: 'add' subcommand
     +    sparse-checkout: 'set' subcommand
      
     -    The 'git sparse-checkout add' subcommand takes a list of patterns
     -    over stdin and writes them to the sparse-checkout file. Then, it
     +    The 'git sparse-checkout set' subcommand takes a list of patterns
     +    as arguments and writes them to the sparse-checkout file. Then, it
          updates the working directory using 'git read-tree -mu HEAD'.
      
     -    Note: if a user adds a negative pattern that would lead to the
     -    removal of a non-empty directory, then Git may not delete that
     -    directory (on Windows).
     +    The 'set' subcommand will replace the entire contents of the
     +    sparse-checkout file. The write_patterns_and_update() method is
     +    extracted from cmd_sparse_checkout() to make it easier to implement
     +    'add' and/or 'remove' subcommands in the future.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ -19,9 +20,10 @@
       	by Git. Add patterns to the sparse-checkout file to
       	repopulate the working directory.
       
     -+'add'::
     -+	Add a set of patterns to the sparse-checkout file, as given over
     -+	stdin. Updates the working directory to match the new patterns.
     ++'set'::
     ++	Write a set of patterns to the sparse-checkout file, as given as
     ++	a list of arguments following the 'set' subcommand. Update the
     ++	working directory to match the new patterns.
      +
       SPARSE CHECKOUT
       ----------------
     @@ -35,40 +37,39 @@
       
       static char const * const builtin_sparse_checkout_usage[] = {
      -	N_("git sparse-checkout [init|list]"),
     -+	N_("git sparse-checkout [init|add|list]"),
     ++	N_("git sparse-checkout [init|list|set] <options>"),
       	NULL
       };
       
      @@
     - 	return sc_read_tree();
     + 	return update_working_directory();
       }
       
     -+static int sparse_checkout_add(int argc, const char **argv)
     ++static int write_patterns_and_update(struct pattern_list *pl)
      +{
     -+	struct exclude_list el;
      +	char *sparse_filename;
      +	FILE *fp;
     -+	struct strbuf line = STRBUF_INIT;
     -+
     -+	memset(&el, 0, sizeof(el));
      +
      +	sparse_filename = get_sparse_checkout_filename();
     -+	add_excludes_from_file_to_list(sparse_filename, "", 0, &el, NULL);
     -+
      +	fp = fopen(sparse_filename, "w");
     -+	write_excludes_to_file(fp, &el);
     -+
     -+	while (!strbuf_getline(&line, stdin)) {
     -+		strbuf_trim(&line);
     -+		fprintf(fp, "%s\n", line.buf);
     -+	}
     -+
     ++	write_patterns_to_file(fp, pl);
      +	fclose(fp);
      +	free(sparse_filename);
      +
     -+	clear_exclude_list(&el);
     ++	clear_pattern_list(pl);
     ++	return update_working_directory();
     ++}
      +
     -+	return sc_read_tree();
     ++static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
     ++{
     ++	int i;
     ++	struct pattern_list pl;
     ++	memset(&pl, 0, sizeof(pl));
     ++
     ++	for (i = 1; i < argc; i++)
     ++		add_pattern(argv[i], NULL, 0, &pl, 0);
     ++
     ++	return write_patterns_and_update(&pl);
      +}
      +
       int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
     @@ -78,8 +79,8 @@
       			return sparse_checkout_list(argc, argv);
       		if (!strcmp(argv[0], "init"))
       			return sparse_checkout_init(argc, argv);
     -+		if (!strcmp(argv[0], "add"))
     -+			return sparse_checkout_add(argc, argv);
     ++		if (!strcmp(argv[0], "set"))
     ++			return sparse_checkout_set(argc, argv, prefix);
       	}
       
       	usage_with_options(builtin_sparse_checkout_usage,
     @@ -91,13 +92,12 @@
       	test_cmp expect dir
       '
       
     -+test_expect_success 'add to existing sparse-checkout' '
     -+	echo "/folder2/*" | git -C repo sparse-checkout add &&
     ++test_expect_success 'set sparse-checkout using builtin' '
     ++	git -C repo sparse-checkout set "/*" "!/*/" "*folder*" &&
      +	cat >expect <<-EOF &&
      +		/*
     -+		!/*/*
     -+		/folder1/*
     -+		/folder2/*
     ++		!/*/
     ++		*folder*
      +	EOF
      +	git -C repo sparse-checkout list >actual &&
      +	test_cmp expect actual &&
     @@ -112,4 +112,4 @@
      +'
      +
       test_done
     - \ No newline at end of file
     + 
  -:  ---------- >  5:  21a0165be7 sparse-checkout: add '--stdin' option to set subcommand
  5:  5f332b799f !  6:  b62b76013f sparse-checkout: create 'disable' subcommand
     @@ -13,8 +13,8 @@
       --- a/Documentation/git-sparse-checkout.txt
       +++ b/Documentation/git-sparse-checkout.txt
      @@
     - 	Add a set of patterns to the sparse-checkout file, as given over
     - 	stdin. Updates the working directory to match the new patterns.
     + 	a list of arguments following the 'set' subcommand. Update the
     + 	working directory to match the new patterns.
       
      +'disable'::
      +	Remove the sparse-checkout file, set `core.sparseCheckout` to
     @@ -30,7 +30,7 @@
      +To repopulate the working directory with all files, use the
      +`git sparse-checkout disable` command.
      +
     -+Sparse checkout support in 'git read-tree' and similar commands is
     ++Sparse checkout support in 'git checkout' and similar commands is
      +disabled by default. You need to set `core.sparseCheckout` to `true`
      +in order to have sparse checkout support.
      +
     @@ -67,8 +67,8 @@
       #include "strbuf.h"
       
       static char const * const builtin_sparse_checkout_usage[] = {
     --	N_("git sparse-checkout [init|add|list]"),
     -+	N_("git sparse-checkout [init|add|list|disable]"),
     +-	N_("git sparse-checkout [init|list|set] <options>"),
     ++	N_("git sparse-checkout [init|list|set|disable] <options>"),
       	NULL
       };
       
     @@ -80,36 +80,32 @@
      +static int sc_set_config(int mode)
       {
       	struct argv_array argv = ARGV_ARRAY_INIT;
     - 	int result = 0;
     --	argv_array_pushl(&argv, "config", "--add", "core.sparseCheckout", "true", NULL);
     -+	argv_array_pushl(&argv, "config", "--add", "core.sparseCheckout", NULL);
     + 
     +@@
     + 		return 1;
     + 	}
     + 
     +-	argv_array_pushl(&argv, "config", "--worktree", "core.sparseCheckout", "true", NULL);
     ++	argv_array_pushl(&argv, "config", "--worktree", "core.sparseCheckout", NULL);
      +
     -+	switch (mode) {
     -+	case 1:
     ++	if (mode)
      +		argv_array_pushl(&argv, "true", NULL);
     -+		break;
     -+
     -+	case 0:
     ++	else
      +		argv_array_pushl(&argv, "false", NULL);
     -+		break;
     -+
     -+	default:
     -+		die(_("invalid config mode"));
     -+	}
       
       	if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
       		error(_("failed to enable core.sparseCheckout"));
      @@
     - 	FILE *fp;
       	int res;
     + 	struct object_id oid;
       
      -	if (sc_enable_config())
      +	if (sc_set_config(1))
       		return 1;
       
     - 	memset(&el, 0, sizeof(el));
     + 	memset(&pl, 0, sizeof(pl));
      @@
     - 	return sc_read_tree();
     + 	return write_patterns_and_update(&pl);
       }
       
      +static int sparse_checkout_disable(int argc, const char **argv)
     @@ -125,7 +121,7 @@
      +	fprintf(fp, "/*\n");
      +	fclose(fp);
      +
     -+	if (sc_read_tree())
     ++	if (update_working_directory())
      +		die(_("error while refreshing working directory"));
      +
      +	unlink(sparse_filename);
     @@ -139,8 +135,8 @@
       	static struct option builtin_sparse_checkout_options[] = {
      @@
       			return sparse_checkout_init(argc, argv);
     - 		if (!strcmp(argv[0], "add"))
     - 			return sparse_checkout_add(argc, argv);
     + 		if (!strcmp(argv[0], "set"))
     + 			return sparse_checkout_set(argc, argv, prefix);
      +		if (!strcmp(argv[0], "disable"))
      +			return sparse_checkout_disable(argc, argv);
       	}
     @@ -170,4 +166,4 @@
      +'
      +
       test_done
     - \ No newline at end of file
     + 
  6:  86f12dc77d !  7:  25642f8df2 trace2:experiment: clear_ce_flags_1
     @@ -1,11 +1,16 @@
      Author: Jeff Hostetler <jeffhost@microsoft.com>
      
     -    trace2:experiment: clear_ce_flags_1
     +    trace2: add region in clear_ce_flags
      
     -    The clear_ce_flags_1 method is used by many types of calls to
     -    unpack_trees(). Add trace2 regions around the method, including
     -    some flag information, so we can get granular performance data
     -    during experiments.
     +    When Git updates the working directory with the sparse-checkout
     +    feature enabled, the unpack_trees() method calls clear_ce_flags()
     +    to update the skip-wortree bits on the cache entries. This
     +    check can be expensive, depending on the patterns used.
     +
     +    Add trace2 regions around the method, including some flag
     +    information, so we can get granular performance data during
     +    experiments. This data will be used to measure improvements
     +    to the pattern-matching algorithms for sparse-checkout.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
     @@ -14,7 +19,7 @@
       --- a/unpack-trees.c
       +++ b/unpack-trees.c
      @@
     - 			  struct exclude_list *el)
     + 			  struct pattern_list *pl)
       {
       	static struct strbuf prefix = STRBUF_INIT;
      +	char label[100];
     @@ -25,14 +30,14 @@
      -	return clear_ce_flags_1(istate,
      +	xsnprintf(label, sizeof(label), "clear_ce_flags(0x%08lx,0x%08lx)",
      +		  (unsigned long)select_mask, (unsigned long)clear_mask);
     -+	trace2_region_enter("exp", label, the_repository);
     ++	trace2_region_enter("unpack_trees", label, the_repository);
      +	rval = clear_ce_flags_1(istate,
       				istate->cache,
       				istate->cache_nr,
       				&prefix,
       				select_mask, clear_mask,
     - 				el, 0);
     -+	trace2_region_leave("exp", label, the_repository);
     + 				pl, 0);
     ++	trace2_region_leave("unpack_trees", label, the_repository);
      +
      +	return rval;
       }
  7:  19d664a5da !  8:  84511255d1 sparse-checkout: add 'cone' mode
     @@ -7,14 +7,14 @@
          If there are 1,000 patterns and 1,000,000 entries, this time can
          be very significant.
      
     -    Create a new 'cone' mode for the core.sparseCheckout config
     -    option, and adjust the parser to set an appropriate enum value.
     +    Create a new Boolean config option, core.sparseCheckoutCone, to
     +    indicate that we expect the sparse-checkout file to contain a
     +    more limited set of patterns. This is a separate config setting
     +    from core.sparseCheckout to avoid breaking older clients by
     +    introcuding a tri-state option.
      
     -    While adjusting the type of this variable, rename it from
     -    core_apply_sparse_checkout to core_sparse_checkout. This will
     -    help avoid parallel changes from hitting type issues, and we
     -    can guarantee that all uses now consider the enum values instead
     -    of the int value.
     +    The config option does nothing right now, but will be expanded
     +    upon in a later commit.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ -49,7 +49,7 @@
      +inclusion/exclusion rules. These can result in O(N*M) pattern matches when
      +updating the index, where N is the number of patterns and M is the number
      +of paths in the index. To combat this performance issue, a more restricted
     -+pattern set is allowed when `core.spareCheckout` is set to `cone`.
     ++pattern set is allowed when `core.spareCheckoutCone` is enabled.
      +
      +The accepted patterns in the cone pattern set are:
      +
     @@ -67,7 +67,7 @@
      +
      +```
      +/*
     -+!/*/*
     ++!/*/
      +```
      +
      +This says "include everything in root, but nothing two levels below root."
     @@ -77,18 +77,18 @@
      +
      +```
      +/*
     -+!/*/*
     -+/A/*
     -+!/A/*/*
     -+/A/B/*
     -+!/A/B/*/*
     -+/A/B/C/*
     ++!/*/
     ++/A/
     ++!/A/*/
     ++/A/B/
     ++!/A/B/*/
     ++/A/B/C/
      +```
      +
      +Here, order matters, so the negative patterns are overridden by the positive
      +patterns that appear lower in the file.
      +
     -+If `core.sparseCheckout=cone`, then Git will parse the sparse-checkout file
     ++If `core.sparseCheckoutCone=true`, then Git will parse the sparse-checkout file
      +expecting patterns of these types. Git will warn if the patterns do not match.
      +If the patterns do match the expected format, then Git will use faster hash-
      +based algorithms to compute inclusion in the sparse-checkout.
     @@ -97,76 +97,6 @@
       --------
       
      
     - diff --git a/builtin/clone.c b/builtin/clone.c
     - --- a/builtin/clone.c
     - +++ b/builtin/clone.c
     -@@
     - 	 * We must apply the setting in the current process
     - 	 * for the later checkout to use the sparse-checkout file.
     - 	 */
     --	core_apply_sparse_checkout = 1;
     -+	core_sparse_checkout = SPARSE_CHECKOUT_FULL;
     - 
     - 	if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
     - 		error(_("failed to initialize sparse-checkout"));
     -
     - diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
     - --- a/builtin/sparse-checkout.c
     - +++ b/builtin/sparse-checkout.c
     -@@
     - 	return result;
     - }
     - 
     --static int sc_set_config(int mode)
     -+static int sc_set_config(enum sparse_checkout_mode mode)
     - {
     - 	struct argv_array argv = ARGV_ARRAY_INIT;
     - 	int result = 0;
     - 	argv_array_pushl(&argv, "config", "--add", "core.sparseCheckout", NULL);
     - 
     - 	switch (mode) {
     --	case 1:
     -+	case SPARSE_CHECKOUT_FULL:
     - 		argv_array_pushl(&argv, "true", NULL);
     - 		break;
     - 
     --	case 0:
     -+	case SPARSE_CHECKOUT_CONE:
     -+		argv_array_pushl(&argv, "cone", NULL);
     -+		break;
     -+
     -+	case SPARSE_CHECKOUT_NONE:
     - 		argv_array_pushl(&argv, "false", NULL);
     - 		break;
     - 
     -@@
     - 	FILE *fp;
     - 	int res;
     - 
     --	if (sc_set_config(1))
     -+	if (sc_set_config(SPARSE_CHECKOUT_FULL))
     - 		return 1;
     - 
     - 	memset(&el, 0, sizeof(el));
     -@@
     - 	char *sparse_filename;
     - 	FILE *fp;
     - 
     --	if (sc_set_config(1))
     -+	if (sc_set_config(SPARSE_CHECKOUT_FULL))
     - 		die(_("failed to change config"));
     - 
     - 	sparse_filename = get_sparse_checkout_filename();
     -@@
     - 	unlink(sparse_filename);
     - 	free(sparse_filename);
     - 
     --	return sc_set_config(0);
     -+	return sc_set_config(SPARSE_CHECKOUT_NONE);
     - }
     - 
     - int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
     -
       diff --git a/cache.h b/cache.h
       --- a/cache.h
       +++ b/cache.h
     @@ -180,12 +110,8 @@
       extern int protect_ntfs;
       extern const char *core_fsmonitor;
       
     -+enum sparse_checkout_mode {
     -+	SPARSE_CHECKOUT_NONE = 0,
     -+	SPARSE_CHECKOUT_FULL = 1,
     -+	SPARSE_CHECKOUT_CONE = 2,
     -+};
     -+enum sparse_checkout_mode core_sparse_checkout;
     ++int core_apply_sparse_checkout;
     ++int core_sparse_checkout_cone;
      +
       /*
        * Include broken refs in all ref iterations, which will
     @@ -195,32 +121,26 @@
       --- a/config.c
       +++ b/config.c
      @@
     + 		return 0;
       	}
       
     - 	if (!strcmp(var, "core.sparsecheckout")) {
     --		core_apply_sparse_checkout = git_config_bool(var, value);
     -+		int result = git_parse_maybe_bool(value);
     ++	if (!strcmp(var, "core.sparsecheckoutcone")) {
     ++		core_sparse_checkout_cone = git_config_bool(var, value);
     ++		return 0;
     ++	}
      +
     -+		if (result < 0) {
     -+			core_sparse_checkout = SPARSE_CHECKOUT_NONE;
     -+
     -+			if (!strcasecmp(value, "cone"))
     -+				core_sparse_checkout = SPARSE_CHECKOUT_CONE;
     -+		} else
     -+			core_sparse_checkout = result;
     + 	if (!strcmp(var, "core.precomposeunicode")) {
     + 		precomposed_unicode = git_config_bool(var, value);
       		return 0;
     - 	}
     - 
      
       diff --git a/environment.c b/environment.c
       --- a/environment.c
       +++ b/environment.c
      @@
     - enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
       char *notes_ref_name;
       int grafts_replace_parents = 1;
     --int core_apply_sparse_checkout;
     -+enum sparse_checkout_mode core_sparse_checkout;
     + int core_apply_sparse_checkout;
     ++int core_sparse_checkout_cone;
       int merge_log_config = -1;
       int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
       unsigned long pack_size_limit_cfg;
     @@ -233,7 +153,7 @@
       '
       
      +test_expect_success 'cone mode: match patterns' '
     -+	git -C repo config --replace-all core.sparseCheckout cone &&
     ++	git -C repo config --worktree core.sparseCheckoutCone true &&
      +	rm -rf repo/a repo/folder1 repo/folder2 &&
      +	git -C repo read-tree -mu HEAD &&
      +	git -C repo reset --hard &&
     @@ -249,16 +169,3 @@
       test_expect_success 'sparse-checkout disable' '
       	git -C repo sparse-checkout disable &&
       	test_path_is_missing repo/.git/info/sparse-checkout &&
     -
     - diff --git a/unpack-trees.c b/unpack-trees.c
     - --- a/unpack-trees.c
     - +++ b/unpack-trees.c
     -@@
     - 
     - 	trace_performance_enter();
     - 	memset(&el, 0, sizeof(el));
     --	if (!core_apply_sparse_checkout || !o->update)
     -+	if (!core_sparse_checkout || !o->update)
     - 		o->skip_sparse_checkout = 1;
     - 	if (!o->skip_sparse_checkout) {
     - 		char *sparse = git_pathdup("info/sparse-checkout");
  8:  b99acea4a0 <  -:  ---------- sparse-checkout: use hashmaps for cone patterns
  9:  568fda2d03 <  -:  ---------- sparse-checkout: init and add in cone mode
  -:  ---------- >  9:  95a3285bc6 sparse-checkout: use hashmaps for cone patterns
  -:  ---------- > 10:  995c5b8e2b sparse-checkout: init and set in cone mode
  -:  ---------- > 11:  1d4321488e unpack-trees: hash less in cone mode

-- 
gitgitgadget
