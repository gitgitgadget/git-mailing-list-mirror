Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BB4F1F405
	for <e@80x24.org>; Fri, 21 Dec 2018 11:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732380AbeLULwh (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Dec 2018 06:52:37 -0500
Received: from mout.gmx.net ([212.227.15.18]:42005 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731477AbeLULwg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Dec 2018 06:52:36 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LcBin-1hHNnF3Dld-00jXEw; Fri, 21
 Dec 2018 12:52:20 +0100
Date:   Fri, 21 Dec 2018 12:52:04 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] diff: add support for reading files literally with
 --no-index
In-Reply-To: <20181220002610.43832-1-sandals@crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.1812211246050.41@tvgsbejvaqbjf.bet>
References: <20181220002610.43832-1-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BSNQqq7hWtud86sYLCjlEJQt4MSMKP7h2vnnE4Y3s2UauDowl+2
 ItVP5co+briwptDDF9wjo7I/v1hIAVKdsqed3rylronBU9HWZORb2L+lVv8h4zabvYO5Pbp
 bMbPaODJLrW1JpHWgYa3NtgyhaksZDHrqot10+TDT67lgx3IL5jF9m1ZviPoxWDU+pW3Bhw
 Aa4RlbpLDLXuPlo55GcqQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LJjyCxxh+gk=:pcdyz0ghnS7DGqNWBDWq1g
 LKXmNlPN6Dse7FFmvYyseZSNOel7U5Ri0C6f8YCvFYzgKL40XOSz0dTBEwss2ItSvHAC3oSNk
 XyZbx6O7Jq11z3X+fJLuWYZdAUjvSMdyODLj3L2Apx3ohQYrHhl7rRU9PlVIBFrZGNowY2Mzz
 KznhRUIkKTP1Oj2gf4Lf+rZmXdNlXoTVBteK1A22vcadnXJ/sl5Gp0HCzro5zgoo0s0f+Velc
 2uUCTDXJAFyvBwLzppNzqqCTSdA8t9D5R7pVkiFDnZBnGkSZy/iJoVfWHGhy1JFKINDH+lJSZ
 isDtaJamdEXldRhRx0En+yuNo2Cn4wzH7gsQGU781uAZkruGhNCI+FTHWPaiQI5E33YiPbTW6
 7BRkj0ZUXuyavcGMQmOWAE14B6WtVA8hySD+YXPxRe/oa6W0C9kzQnbELin838Hm7BJR56I79
 hwDRTh+9wCegjt6Bv51PKbQTdiYaLk3EOpSwRLpZQCY8h4qS6BA1auXyfbA5Gt52avvUgKUX+
 x7wZoIdH1EW43EuQcb1sWhpt5ptkqweDvQL9kDcU69LCZd1urGU/jEyjEKdgoxkze3a3tUeMr
 8BTvCmOITYvLFXAdKRsujqQca6PU3yDrhNNC6KMBvPsML1UB/8or4zaR8GBRgQMtHCoDi5p01
 2Zl32PBjXfKhbH3V3Lf1yvz7gSKKrqPcNCKWU9WNZ9laeGipIkRDVBA0Bz2a8VTPb/gSgPOQm
 tzrQm827EP9BDUIOUxBzhMFvU2K7rMjqSCvBUjH1/eyG75/Q7SrA396uke8lQHEctarT03hG2
 Ne9eYmvCtNnwH0Qrezkd/Ogf//RBryIaDXTkWyXu8ShliqYHbQbVmTGjSN39XSUXkoe7skllH
 Is8Lk8lTIgQWPCGWnxtFudiNNqz8HHbcKvgg0z+1sTLloi0EUDrBcqK1yAbSopDqHKsr5T3Ee
 SkVjgxKB4MQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian,

On Thu, 20 Dec 2018, brian m. carlson wrote:

> In some shells, such as bash and zsh, it's possible to use a command
> substitution to provide the output of a command as a file argument to
> another process, like so:
> 
>   diff -u <(printf "a\nb\n") <(printf "a\nc\n")
> 
> However, this syntax does not produce useful results with git diff
> --no-index.
> 
> On macOS, the arguments to the command are named pipes under /dev/fd,
> and git diff doesn't know how to handle a named pipe. On Linux, the
> arguments are symlinks to pipes, so git diff "helpfully" diffs these
> symlinks, comparing their targets like "pipe:[1234]" and "pipe:[5678]".


... and in Git for Windows' Bash, it would result in something like:

	$ git -P diff --no-index <(printf "a\nb\n") <(printf "a\nc\n")
	error: Could not access '/proc/24012/fd/63'

... because the Bash is "MSYS2-aware" and knows about `/proc/` while
`git.exe` is a pure Win32 executable that has no idea what Bash is talking
about.

Sadly, your patch does not change the situation one bit (because it does
not change the fact that the MSYS2 Bash passes a path to `git.exe` that is
not a valid Windows path, and neither could it, but that's not the problem
of your patch).

I reviewed your patch and it looks good to me!

Thanks,
Dscho

> Because this behavior is not very helpful, and because git diff has many
> features that people would like to use even on non-Git files, add an
> option to git diff --no-index to read files literally, dereferencing
> symlinks and reading them as a normal file.
> 
> Note that this behavior requires that the files be read entirely into
> memory, just as we do when reading from standard input.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> This is a long-standing annoyance of mine, and it also makes some use
> cases possible (for example, diffing filtered and non-filtered objects).
> 
> We don't include a test for the pipe scenario because I couldn't get
> that case to work in portable shell (although of course it works in
> bash). I have, however, tested it on both macOS and Linux. No clue how
> this works on Windows.
> 
>  Documentation/git-diff.txt |  5 +++++
>  diff-no-index.c            | 34 +++++++++++++++++++++++++++-------
>  diff.c                     | 24 +++++++++++++-----------
>  diff.h                     |  1 +
>  diffcore.h                 |  1 +
>  t/t4053-diff-no-index.sh   | 28 ++++++++++++++++++++++++++++
>  6 files changed, 75 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
> index 030f162f30..4c4695c88d 100644
> --- a/Documentation/git-diff.txt
> +++ b/Documentation/git-diff.txt
> @@ -111,6 +111,11 @@ include::diff-options.txt[]
>  	"Unmerged".  Can be used only when comparing the working tree
>  	with the index.
>  
> +--literally::
> +  Read the specified files literally, as `diff` would,
> +  dereferencing any symlinks and reading data from pipes.
> +  This option only works with `--no-index`.
> +
>  <path>...::
>  	The <paths> parameters, when given, are used to limit
>  	the diff to the named paths (you can give directory
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 9414e922d1..2707206aee 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -75,7 +75,25 @@ static int populate_from_stdin(struct diff_filespec *s)
>  	return 0;
>  }
>  
> -static struct diff_filespec *noindex_filespec(const char *name, int mode)
> +static int populate_literally(struct diff_filespec *s)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	size_t size = 0;
> +	int fd = xopen(s->path, O_RDONLY);
> +
> +	if (strbuf_read(&buf, fd, 0) < 0)
> +		return error_errno("error while reading from '%s'", s->path);
> +
> +	s->should_munmap = 0;
> +	s->data = strbuf_detach(&buf, &size);
> +	s->size = size;
> +	s->should_free = 1;
> +	s->read_literally = 1;
> +	return 0;
> +}
> +
> +static struct diff_filespec *noindex_filespec(const char *name, int mode,
> +					      struct diff_options *o)
>  {
>  	struct diff_filespec *s;
>  
> @@ -85,6 +103,8 @@ static struct diff_filespec *noindex_filespec(const char *name, int mode)
>  	fill_filespec(s, &null_oid, 0, mode);
>  	if (name == file_from_standard_input)
>  		populate_from_stdin(s);
> +	else if (o->flags.read_literally)
> +		populate_literally(s);
>  	return s;
>  }
>  
> @@ -101,14 +121,14 @@ static int queue_diff(struct diff_options *o,
>  
>  		if (S_ISDIR(mode1)) {
>  			/* 2 is file that is created */
> -			d1 = noindex_filespec(NULL, 0);
> -			d2 = noindex_filespec(name2, mode2);
> +			d1 = noindex_filespec(NULL, 0, o);
> +			d2 = noindex_filespec(name2, mode2, o);
>  			name2 = NULL;
>  			mode2 = 0;
>  		} else {
>  			/* 1 is file that is deleted */
> -			d1 = noindex_filespec(name1, mode1);
> -			d2 = noindex_filespec(NULL, 0);
> +			d1 = noindex_filespec(name1, mode1, o);
> +			d2 = noindex_filespec(NULL, 0, o);
>  			name1 = NULL;
>  			mode1 = 0;
>  		}
> @@ -189,8 +209,8 @@ static int queue_diff(struct diff_options *o,
>  			SWAP(name1, name2);
>  		}
>  
> -		d1 = noindex_filespec(name1, mode1);
> -		d2 = noindex_filespec(name2, mode2);
> +		d1 = noindex_filespec(name1, mode1, o);
> +		d2 = noindex_filespec(name2, mode2, o);
>  		diff_queue(&diff_queued_diff, d1, d2);
>  		return 0;
>  	}
> diff --git a/diff.c b/diff.c
> index dc9965e836..740d0087b9 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4282,18 +4282,18 @@ static void run_diff_cmd(const char *pgm,
>  		fprintf(o->file, "* Unmerged path %s\n", name);
>  }
>  
> -static void diff_fill_oid_info(struct diff_filespec *one, struct index_state *istate)
> +static void diff_fill_oid_info(struct diff_filespec *one, struct diff_options *o)
>  {
>  	if (DIFF_FILE_VALID(one)) {
>  		if (!one->oid_valid) {
>  			struct stat st;
> -			if (one->is_stdin) {
> +			if (one->is_stdin || one->read_literally) {
>  				oidclr(&one->oid);
>  				return;
>  			}
>  			if (lstat(one->path, &st) < 0)
>  				die_errno("stat '%s'", one->path);
> -			if (index_path(istate, &one->oid, one->path, &st, 0))
> +			if (index_path(o->repo->index, &one->oid, one->path, &st, 0))
>  				die("cannot hash %s", one->path);
>  		}
>  	}
> @@ -4341,8 +4341,8 @@ static void run_diff(struct diff_filepair *p, struct diff_options *o)
>  		return;
>  	}
>  
> -	diff_fill_oid_info(one, o->repo->index);
> -	diff_fill_oid_info(two, o->repo->index);
> +	diff_fill_oid_info(one, o);
> +	diff_fill_oid_info(two, o);
>  
>  	if (!pgm &&
>  	    DIFF_FILE_VALID(one) && DIFF_FILE_VALID(two) &&
> @@ -4389,8 +4389,8 @@ static void run_diffstat(struct diff_filepair *p, struct diff_options *o,
>  	if (o->prefix_length)
>  		strip_prefix(o->prefix_length, &name, &other);
>  
> -	diff_fill_oid_info(p->one, o->repo->index);
> -	diff_fill_oid_info(p->two, o->repo->index);
> +	diff_fill_oid_info(p->one, o);
> +	diff_fill_oid_info(p->two, o);
>  
>  	builtin_diffstat(name, other, p->one, p->two,
>  			 diffstat, o, p);
> @@ -4414,8 +4414,8 @@ static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
>  	if (o->prefix_length)
>  		strip_prefix(o->prefix_length, &name, &other);
>  
> -	diff_fill_oid_info(p->one, o->repo->index);
> -	diff_fill_oid_info(p->two, o->repo->index);
> +	diff_fill_oid_info(p->one, o);
> +	diff_fill_oid_info(p->two, o);
>  
>  	builtin_checkdiff(name, other, attr_path, p->one, p->two, o);
>  }
> @@ -5159,6 +5159,8 @@ int diff_opt_parse(struct diff_options *options,
>  		options->flags.funccontext = 1;
>  	else if (!strcmp(arg, "--no-function-context"))
>  		options->flags.funccontext = 0;
> +	else if (!strcmp(arg, "--literally"))
> +		options->flags.read_literally = 1;
>  	else if ((argcount = parse_long_opt("output", av, &optarg))) {
>  		char *path = prefix_filename(prefix, optarg);
>  		options->file = xfopen(path, "w");
> @@ -5720,8 +5722,8 @@ static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
>  		if (DIFF_PAIR_UNMERGED(p))
>  			continue;
>  
> -		diff_fill_oid_info(p->one, options->repo->index);
> -		diff_fill_oid_info(p->two, options->repo->index);
> +		diff_fill_oid_info(p->one, options);
> +		diff_fill_oid_info(p->two, options);
>  
>  		len1 = remove_space(p->one->path, strlen(p->one->path));
>  		len2 = remove_space(p->two->path, strlen(p->two->path));
> diff --git a/diff.h b/diff.h
> index ce5e8a8183..7dedd3bcd1 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -97,6 +97,7 @@ struct diff_flags {
>  	unsigned stat_with_summary:1;
>  	unsigned suppress_diff_headers:1;
>  	unsigned dual_color_diffed_diffs:1;
> +	unsigned read_literally:1;
>  };
>  
>  static inline void diff_flags_or(struct diff_flags *a,
> diff --git a/diffcore.h b/diffcore.h
> index b651061c0e..363869447a 100644
> --- a/diffcore.h
> +++ b/diffcore.h
> @@ -48,6 +48,7 @@ struct diff_filespec {
>  #define DIRTY_SUBMODULE_UNTRACKED 1
>  #define DIRTY_SUBMODULE_MODIFIED  2
>  	unsigned is_stdin : 1;
> +	unsigned read_literally : 1;
>  	unsigned has_more_entries : 1; /* only appear in combined diff */
>  	/* data should be considered "binary"; -1 means "don't know yet" */
>  	signed int is_binary : 2;
> diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
> index 6e0dd6f9e5..53e6bcdc19 100755
> --- a/t/t4053-diff-no-index.sh
> +++ b/t/t4053-diff-no-index.sh
> @@ -137,4 +137,32 @@ test_expect_success 'diff --no-index from repo subdir with absolute paths' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'diff --no-index --literally' '
> +	echo "diff --git a/../../non/git/a b/../../non/git/b" >expect &&
> +	test_expect_code 1 \
> +		git -C repo/sub \
> +		diff --literally ../../non/git/a ../../non/git/b >actual &&
> +	head -n 1 <actual >actual.head &&
> +	test_cmp expect actual.head
> +'
> +
> +test_expect_success SYMLINKS 'diff --no-index --literally with symlinks' '
> +	test_write_lines a b c >f1 &&
> +	test_write_lines a d c >f2 &&
> +	ln -s f1 s1 &&
> +	ln -s f2 s2 &&
> +	cat >expect <<-\EOF &&
> +	diff --git a/s1 b/s2
> +	--- a/s1
> +	+++ b/s2
> +	@@ -1,3 +1,3 @@
> +	 a
> +	-b
> +	+d
> +	 c
> +	EOF
> +	test_expect_code 1 git diff --no-index --literally s1 s2 >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
> 
