Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC52C1FBEC
	for <e@80x24.org>; Wed,  8 Mar 2017 02:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756689AbdCHCJ3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 21:09:29 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33611 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756434AbdCHCJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 21:09:26 -0500
Received: by mail-pf0-f171.google.com with SMTP id w189so8019316pfb.0
        for <git@vger.kernel.org>; Tue, 07 Mar 2017 18:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WuKY18CS0g5uCOkW9B4crU7mhv67byRIT3ncWfl1vgI=;
        b=iJSjJeRiiBdW0A/YqDuW6eHbesVkrzgDVV80fIMf4GQzLg2GqPVM59MaTsmZ9P5Bjd
         1g+r77+NAQVe9tqi7mj1/x/NP9agJTg4bFkO+Y0Jzo2w0gr58l+jecwppbsZsgL/A8ZI
         seoFhzQ32lI8rbH2sz2NWlFqRj0MY3O+omfwDsLOJ0BlGFyh/e+DjioVlkGw/4VVTeKL
         LkrF/qtKqV86TX+AVVqaiMBXxKu6xJ8Llaye1nk/3hul3CFdh3aNWiZZKxRvYMJHQ/pR
         ybmd7ZkJhY3B2/gXWpj98FHb9lf1WVvCbAuICNd91W/clhhmdRpfZLNNnlu5EXALVZl+
         3Ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WuKY18CS0g5uCOkW9B4crU7mhv67byRIT3ncWfl1vgI=;
        b=tvHU9PXotzxm6+ld/zCRugIPvnJqRCJoZAtS2waXfJLSCHzt+uJqsmpTliq9S9BrlY
         7QlmCvMPC2/IH0RXqrE/6wL/BeheCPjpOeHnqDwNLmEIzqLuJf/2LdoOdLm1remP8lWG
         yK6KDVYrMvDbM82QNC7zsJ4aBf2+JvhZR3zIgNFOe5XpfPp6y8MUjUPKDC5YsVBFVsMR
         ra2cIJqBEJWdMoCLXqF6+TheiCzo5/U+4K66+1c495gqdvsBDmv7VkkHBBV6rZAmLPgd
         rTdcgrcXmAdzlXqPv10umxBTtEPKNln+BoBNZnMhU1Ct4djwChzzu5sZgOAriNBowD3G
         McAQ==
X-Gm-Message-State: AMke39mrVyM9iIAlG9qsIbynoxlaJUVwSSF+OjQ2+QE2mKgPloEAT7cmwA1d8Qq82Pmxibay
X-Received: by 10.84.233.134 with SMTP id l6mr4893252plk.49.1488938960202;
        Tue, 07 Mar 2017 18:09:20 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:2547:c8c9:5d3e:d641])
        by smtp.gmail.com with ESMTPSA id c195sm2121193pfb.60.2017.03.07.18.09.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 07 Mar 2017 18:09:19 -0800 (PST)
Date:   Tue, 7 Mar 2017 18:09:18 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     valtron <valtron2000@gmail.com>, git@vger.kernel.org
Subject: Re: Crash on MSYS2 with GIT_WORK_TREE
Message-ID: <20170308020918.GA1650@google.com>
References: <CAFKRc7y_kpCGNORENUZ2qw_4qBwjjyaaDFxAEQa52fTryj+w7A@mail.gmail.com>
 <alpine.DEB.2.20.1703072345530.3767@virtualbox>
 <alpine.DEB.2.20.1703080104580.3767@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1703080104580.3767@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/08, Johannes Schindelin wrote:
> Hi valtron,
> 
> On Wed, 8 Mar 2017, Johannes Schindelin wrote:
> 
> > On Tue, 7 Mar 2017, valtron wrote:
> > 
> > > When GIT_WORK_TREE contains a drive-letter and forward-slashes, some git
> > > commands crash:
> > > 
> > > C:\repo>set GIT_WORK_TREE=C:/repo
> > > C:\repo>git rev-parse HEAD
> > >      1 [main] git 2332 cygwin_exception::open_stackdumpfile: Dumping
> > > stack trace to git.exe.stackdump
> > 
> > [...]
> >
> > In any case, this problem is squarely within the MSYS2 runtime. It has
> > nothing to do with Git except for the motivation to set an environment
> > variable to an absolute path as you outlined.
> 
> Oh boy was I *wrong*! I take that back and apologize for my premature
> verdict.
> 
> It is true that you should not set GIT_WORKTREE=c:/repo if you want to
> work with MSYS2 Git because MSYS2 expects pseudo Unix paths, i.e. /c/repo,
> and it will simply try to guess correctly and convert Windows paths with
> drive letters and backslashes to that form.
> 
> But that does not excuse a crash.
> 
> The problem is actually even worse: On *Linux*, this happens:
> 
> 	$ GIT_WORK_TREE=c:/invalid git rev-parse HEAD
> 	Segmentation fault (core dumped)
> 
> The reason is this: when set_git_work_tree() was converted from using
> xstrdup(real_path()) to real_pathdup(), we completely missed the fact that
> the former passed die_on_error = 1 to strbuf_realpath(), while the latter
> passed die_on_error = 0. As a consequence, work_tree can be NULL now, and
> the current code does not expect set_git_work_tree() to return
> successfully after setting work_tree to NULL.
> 
> I Cc:ed Brandon, the author of 4ac9006f832 (real_path: have callers use
> real_pathdup and strbuf_realpath, 2016-12-12).
> 
> Brandon, I have a hunch that pretty much all of the xstrdup(real_path())
> -> real_pathdup() sites have a problem now. The previous contract was that
> real_path() would die() if the passed path is invalid. The new contract is
> that real_pathdup() returns NULL in such a case. I believe that the
> following call sites are problematic in particular:

Welp, looks like I missed that when I made the conversion.  You're
right, the semantics of getting the real_path were changed which would
cause a NULL to be returned instead of the program exiting with a call
to die().  

After a cursory look at your patch, I think all of your changes look
sane.  I would have to take a closer look at the call sites to see if
each caller would need to die or not.  I'm assuming you took a quick
glace to make your decision about each call site?

> 
> builtin/init-db.c: init_db():
> 	char *original_git_dir = real_pathdup(git_dir);
> 
> builtin/init-db.c: cmd_init_db():
> 	real_git_dir = real_pathdup(real_git_dir);
> 	...
> 	git_work_tree_cfg = real_pathdup(rel);
> 
> environment.c: set_git_work_tree():
> 	work_tree = real_pathdup(new_work_tree);
> 
> setup.c: setup_discovered_git_dir():
> 	gitdir = real_pathdup(gitdir);
> 
> submodule.c: connect_work_tree_and_git_dir():
> 	const char *real_work_tree = real_pathdup(work_tree);
> 
> transport.c: refs_from_alternate_cb():
> 	other = real_pathdup(e->path);
> 
> worktree.c: find_worktree():
> 	path = real_pathdup(arg);
> 
> I verified that all calls are still there, except for the submodule.c one
> which simply moved to dir.c and the transport.c one which apparently now
> no longer die()s but simply ignores non-existing paths now.
> 
> That leaves six places to patch, methinks... This diff may serve as an
> initial version, but I have not really had a deep look at all call sites
> (and it is an unwise idea to trust me at this hour anyway, look at the
> time when I sent this mail):
> 
> -- snipsnap --
> diff --git a/abspath.c b/abspath.c
> index 2f0c26e0e2c..b02e068aa34 100644
> --- a/abspath.c
> +++ b/abspath.c
> @@ -214,12 +214,12 @@ const char *real_path_if_valid(const char *path)
>  	return strbuf_realpath(&realpath, path, 0);
>  }
>  
> -char *real_pathdup(const char *path)
> +char *real_pathdup(const char *path, int die_on_error)
>  {
>  	struct strbuf realpath = STRBUF_INIT;
>  	char *retval = NULL;
>  
> -	if (strbuf_realpath(&realpath, path, 0))
> +	if (strbuf_realpath(&realpath, path, die_on_error))
>  		retval = strbuf_detach(&realpath, NULL);
>  
>  	strbuf_release(&realpath);
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 1d4d6a00789..8a6acb0ec69 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -338,7 +338,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
>  {
>  	int reinit;
>  	int exist_ok = flags & INIT_DB_EXIST_OK;
> -	char *original_git_dir = real_pathdup(git_dir);
> +	char *original_git_dir = real_pathdup(git_dir, 1);
>  
>  	if (real_git_dir) {
>  		struct stat st;
> @@ -489,7 +489,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
>  	argc = parse_options(argc, argv, prefix, init_db_options, init_db_usage, 0);
>  
>  	if (real_git_dir && !is_absolute_path(real_git_dir))
> -		real_git_dir = real_pathdup(real_git_dir);
> +		real_git_dir = real_pathdup(real_git_dir, 1);
>  
>  	if (argc == 1) {
>  		int mkdir_tried = 0;
> @@ -560,7 +560,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
>  		const char *git_dir_parent = strrchr(git_dir, '/');
>  		if (git_dir_parent) {
>  			char *rel = xstrndup(git_dir, git_dir_parent - git_dir);
> -			git_work_tree_cfg = real_pathdup(rel);
> +			git_work_tree_cfg = real_pathdup(rel, 1);
>  			free(rel);
>  		}
>  		if (!git_work_tree_cfg)
> diff --git a/cache.h b/cache.h
> index e7b57457e73..7168c1e5ff0 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1160,7 +1160,7 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
>  		      int die_on_error);
>  const char *real_path(const char *path);
>  const char *real_path_if_valid(const char *path);
> -char *real_pathdup(const char *path);
> +char *real_pathdup(const char *path, int die_on_error);
>  const char *absolute_path(const char *path);
>  char *absolute_pathdup(const char *path);
>  const char *remove_leading_path(const char *in, const char *prefix);
> diff --git a/dir.c b/dir.c
> index 4541f9e1460..aeeb5ce1049 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2730,8 +2730,8 @@ void connect_work_tree_and_git_dir(const char *work_tree_, const char *git_dir_)
>  {
>  	struct strbuf file_name = STRBUF_INIT;
>  	struct strbuf rel_path = STRBUF_INIT;
> -	char *git_dir = real_pathdup(git_dir_);
> -	char *work_tree = real_pathdup(work_tree_);
> +	char *git_dir = real_pathdup(git_dir_, 1);
> +	char *work_tree = real_pathdup(work_tree_, 1);
>  
>  	/* Update gitfile */
>  	strbuf_addf(&file_name, "%s/.git", work_tree);
> diff --git a/environment.c b/environment.c
> index c07fb17fb70..42dc3106d2f 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -259,7 +259,7 @@ void set_git_work_tree(const char *new_work_tree)
>  		return;
>  	}
>  	git_work_tree_initialized = 1;
> -	work_tree = real_pathdup(new_work_tree);
> +	work_tree = real_pathdup(new_work_tree, 1);
>  }
>  
>  const char *get_git_work_tree(void)
> diff --git a/setup.c b/setup.c
> index 9118b48590a..d51549a6de3 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -698,7 +698,7 @@ static const char *setup_discovered_git_dir(const char *gitdir,
>  	/* --work-tree is set without --git-dir; use discovered one */
>  	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
>  		if (offset != cwd->len && !is_absolute_path(gitdir))
> -			gitdir = real_pathdup(gitdir);
> +			gitdir = real_pathdup(gitdir, 1);
>  		if (chdir(cwd->buf))
>  			die_errno("Could not come back to cwd");
>  		return setup_explicit_git_dir(gitdir, cwd, nongit_ok);
> @@ -808,7 +808,7 @@ static int canonicalize_ceiling_entry(struct string_list_item *item,
>  		/* Keep entry but do not canonicalize it */
>  		return 1;
>  	} else {
> -		char *real_path = real_pathdup(ceil);
> +		char *real_path = real_pathdup(ceil, 0);
>  		if (!real_path) {
>  			return 0;
>  		}
> diff --git a/submodule.c b/submodule.c
> index 3b98766a6bc..1d4c0ce86ee 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1403,7 +1403,7 @@ static void relocate_single_git_dir_into_superproject(const char *prefix,
>  		/* If it is an actual gitfile, it doesn't need migration. */
>  		return;
>  
> -	real_old_git_dir = real_pathdup(old_git_dir);
> +	real_old_git_dir = real_pathdup(old_git_dir, 0);
>  
>  	sub = submodule_from_path(null_sha1, path);
>  	if (!sub)
> @@ -1412,7 +1412,7 @@ static void relocate_single_git_dir_into_superproject(const char *prefix,
>  	new_git_dir = git_path("modules/%s", sub->name);
>  	if (safe_create_leading_directories_const(new_git_dir) < 0)
>  		die(_("could not create directory '%s'"), new_git_dir);
> -	real_new_git_dir = real_pathdup(new_git_dir);
> +	real_new_git_dir = real_pathdup(new_git_dir, 0);
>  
>  	if (!prefix)
>  		prefix = get_super_prefix();
> @@ -1472,14 +1472,14 @@ void absorb_git_dir_into_superproject(const char *prefix,
>  		new_git_dir = git_path("modules/%s", sub->name);
>  		if (safe_create_leading_directories_const(new_git_dir) < 0)
>  			die(_("could not create directory '%s'"), new_git_dir);
> -		real_new_git_dir = real_pathdup(new_git_dir);
> +		real_new_git_dir = real_pathdup(new_git_dir, 0);
>  		connect_work_tree_and_git_dir(path, real_new_git_dir);
>  
>  		free(real_new_git_dir);
>  	} else {
>  		/* Is it already absorbed into the superprojects git dir? */
> -		char *real_sub_git_dir = real_pathdup(sub_git_dir);
> -		char *real_common_git_dir = real_pathdup(get_git_common_dir());
> +		char *real_sub_git_dir = real_pathdup(sub_git_dir, 0);
> +		char *real_common_git_dir = real_pathdup(get_git_common_dir(), 0);
>  
>  		if (!starts_with(real_sub_git_dir, real_common_git_dir))
>  			relocate_single_git_dir_into_superproject(prefix, path);
> diff --git a/worktree.c b/worktree.c
> index d633761575b..0486e31ad4a 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -255,7 +255,7 @@ struct worktree *find_worktree(struct worktree **list,
>  		return wt;
>  
>  	arg = prefix_filename(prefix, strlen(prefix), arg);
> -	path = real_pathdup(arg);
> +	path = real_pathdup(arg, 1);
>  	for (; *list; list++)
>  		if (!fspathcmp(path, real_path((*list)->path)))
>  			break;

-- 
Brandon Williams
