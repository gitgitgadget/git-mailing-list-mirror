Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBCD21F424
	for <e@80x24.org>; Thu, 12 Apr 2018 11:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752234AbeDLLdT (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 07:33:19 -0400
Received: from mout.gmx.net ([212.227.17.22]:38665 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751818AbeDLLdS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 07:33:18 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mhhr5-1esVZ91Dk3-00MvU7; Thu, 12
 Apr 2018 13:33:16 +0200
Date:   Thu, 12 Apr 2018 13:33:00 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Harald Nordgren <haraldnordgren@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] Create '--merges-only' option for 'git bisect'
In-Reply-To: <20180411225534.48658-1-haraldnordgren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804121143120.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180411225534.48658-1-haraldnordgren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:LKgGXsf/lejRYn7E7lHFXx3ginoHyPGntLEv6Mceylo6cQRIUy0
 XXh75s+gsb64bvMv74ePIAR8BF+xvoSP7c5p6YVjNyMGKToJ5j+CkzAT4pX8mAUhINz1/aA
 5wfbPCkJ/vzkj8QWNZi+W+GgpFu4h6evJ984Vn0sBJnY/vZxdu0IytfecILhxbHDpG3oUT0
 3Dh4ZUbs4R2khdm3O8bLA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:j3xynucFoCg=:LWbyWkxjMZ/4k/0mf18IGS
 QgQJ8VX+9xcMlr3ry3tOty/elq/2rxqelzEie74mt++BwG0cpuTuk5xVx9+B0dtq9UyFNnReH
 wKmU+0hFB+M9Pyen9veodiB/WEykQFLjE68wb+xLa0MS9xKIXnCnpi51f778mNy2OlPLer6R7
 3FfQtR5yA7rgnWdOW1rvfmNWiGFltmr6ZRwBWxrtcJe2HmKYVbIYxn43bQ1geJ6GPSNVi98vc
 DLfbh7586cP6QkOhkmVbUbpuxO0al7RekzHjivFqN3q8muiX/E60iXXoRKOUVAUcQPN8mEStR
 BTIildh93Asuu2kA48zH4idxVxjAKC0Ql3ONdw6xD/vw9ADFbytcLkFzgx5TXC0qHTjvXgqqF
 7o0w6jYQV1emWxWygYSN4qHNqE+YOP+jaeEX0J+0EaJjRDL2rxsS2rInvKyD+iEVb4tObNSwx
 xeZyb9we4UPBAEN+5VO/0Zib4n9c3/dUfOH+4HRHXev1y0NqU/286AyGtH6Mj64hOi5U7gI3Y
 oLI5G27IBUYGOEiPMZXSvtLqPbxeN7Ozu1eRW7v4I2LwaZ/UtE6bfRRrAh3oZR8rNPY51srgn
 FBvRDaT8r71j+1EduYnAs7sxY9CgXpHWWf4r+Yh4alOYbVRFJdrBhGxEkDdvayOUBP/C3haFk
 I93/REjyEDuYuGeV1T+Pqtqmbg43c0j0oBtbK/gDg3DfaSlfau4Cr8Pdg4em9SV1BRJrg9dxk
 THZ//+t3+g+fhIBzWBA96CsUSlvXIkksSuHIBqLZ/VtuF+l1mGDmaCPnqjN3GtOhs0++NSbGv
 k52wawBtQ+VLL2p/9mALffJR4M5VSx0eB6NWIzYW2OCovTaNWQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Harald,

Thank you for working on this.

On Thu, 12 Apr 2018, Harald Nordgren wrote:

> When ran with '--merges-only', git bisect will only look at merge
> commits -- commits with 2 or more parents or the initial commit.

This is an excellent idea!

>     Proof of concept of a feature that I have wanted in Git for a while.
>     In my daily work my company uses GitHub, which creates lots of merge
>     commits. In general, tests are only ran on the tip of a branch
>     before merging, so the different commits within a merge commit are
>     allowed not to be buildable. Therefore 'git bisect' often doesn't
>     work since it will give lots of false positives for anything that is
>     not a merge commit. If we could have a feature to only bisect merge
>     commits then it would be easier to pinpoint which merge causes any
>     particular issue. After that, a bisect could be done within the
>     merge to pinpoint futher. As a follow-up to this patch -- we could
>     potentially create a feature that automatically continues into
>     regular bisect within the bad merge commit after completed
>     '--merges-only' bisection.

It also helps when bisecting breakages in `pu` (mainly because the
branches in `pu` use branch points that are often insanely far in the
past).

> diff --git a/bisect.c b/bisect.c
> index a579b5088..e8a2f77c7 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -254,7 +254,7 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
>   */
>  static struct commit_list *do_find_bisection(struct commit_list *list,
>  					     int nr, int *weights,
> -					     int find_all)
> +					     int find_all, int only_merge_commits)

How about `int flags`, and defining FIND_ALL and ONLY_MERGE_COMMITS?

That way, it will be easy to add ONLY_FIRST_PARENTS without changing the
signature of do_find_bisection().

Ideally, a preparatory commit would change find_all -> flags (adding
FIND_ALL), and the second commit would then add support for
ONLY_MERGE_COMMITS.

> @@ -266,6 +266,13 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
>  		unsigned flags = commit->object.flags;
>  
>  		p->item->util = &weights[n++];
> +
> +		if (only_merge_commits) {
> +			weight_set(p, -2);
> +			counted++;
> +			continue;
> +		}
> +

This hunk is a little hard to understand when you come from elsewhere, as
I do. Could you maybe explain a little bit what the `weight_set(p, -2)`
does? This is probably good material for enhancing the commit message
(seeing as we understand the commit message to be kind of the "convince me
that this is a good change, and explain things that are not immediately
obvious from the diff" document).

Maybe it would be enough to describe the role of the weight, and what the
typical values look like.

> @@ -305,11 +312,17 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
>  	 * way, and then fill the blanks using cheaper algorithm.
>  	 */
>  	for (p = list; p; p = p->next) {
> +		int distance;
>  		if (p->item->object.flags & UNINTERESTING)
>  			continue;
>  		if (weight(p) != -2)
>  			continue;
> -		weight_set(p, count_distance(p));
> +
> +		if (only_merge_commits)
> +			distance = count_distance(p) - 1;
> +		else
> +			distance = count_distance(p);
> +		weight_set(p, distance);

A shorter way:

		weight_set(p, count_distance(p) - !!only_merge_commits);

Could you add a code comment above this line to explain why this is
needed? (I have to admit that I have no clue what the weights or the
distances are in this context, but I think that a 3-line explanation could
probably give me enough of an idea that I do not have to study an hour or
three to learn enough to understand this change.)

>  		clear_distance(list);
>  
>  		/* Does it happen to be at exactly half-way? */
> @@ -330,11 +343,17 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
>  			for (q = p->item->parents; q; q = q->next) {
>  				if (q->item->object.flags & UNINTERESTING)
>  					continue;
> +				if (!q->item->util)
> +					break;

So we use the `util` field now to do things, probably to flag some
property of the commit.

Maybe the commit message could prepare the reader for this, with a
paragraph starting with "We use the commits' `util` field to store the
information that [...]"?

Seeing as this loop iterates over the commit's parents, I guess we are
looking at merge commits, and drop out early if we find a parent that was
not marked as interesting earlier?

If this is the case, why do we not have to look further, at later parents,
whether they *do* have a non-NULL `util` attribute?

>  				if (0 <= weight(q))
>  					break;
>  			}
>  			if (!q)
>  				continue;
> +			if (!q->item->util) {
> +				counted++;
> +				continue;
> +			}

Okay, so here we skip the current commit if we found a parent commit that
has the `util` field set to NULL...

> @@ -364,8 +383,43 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
>  		return best_bisection_sorted(list, nr);
>  }
>  
> +int merge_commit_or_root(const struct commit c)

By value? Let's use `*c` instead of `c` here.

> +{
> +	if (!c.parents)
> +		return 1;
> +
> +	return !!c.parents->next;

Unless you need the return value to be 0 or 1 (instead of 0 or non-0),
this is conciser:

	return !c.parents || c.parents->next;

However, we should not detect root commits here. We are only interested in
merges, according to the new option! So we should filter out root commits,
too. So this is what you really want:

	int is_merge(const struct commit *c)
	{
		return c->parents && c->parents->next;
	}

> +void filter_non_merge_commits(struct commit_list **commit_list)

So does this keep non_merge_commits (similar to Makefile's $(filter ...)
function?) Or does it remove them?

Judging by the code, maybe "filter_out_non_merge_commits()" or
"drop_regular_commits()"? Or "keep_only_root_and_merge_commits()"?

> +{
> +	struct commit_list *list1 = *commit_list;
> +	struct commit_list *list2 = NULL;
> +	*commit_list = NULL;
> +
> +	for ( ; list1; list1 = list1->next) {
> +		if (merge_commit_or_root(*list1->item)) {
> +			list2 = list1;
> +			list1 = list1->next;
> +			list2->next = NULL;

Since commit_lists are malloc()ed, they also need to be free()d when
filtering something out.

> +			list2->item->parents = NULL;

Why do we touch the parents here? This is a bit dangerous, as the item
refers to the commit that `lookup_commit()` would produce again. And by
setting parents = NULL, we pretend that those commits are root commits
from now on.

> +			*commit_list = list2;
> +			break;

Also, using the non-descriptive names `list1` and `list2` makes code a bit
hard to understand. (And hence it makes it easy for bugs to creep in.)

> +		}
> +	}
> +
> +	for ( ; list1; list1 = list1->next) {

The previous for loop has the condition `list1` already. So at this point
we know that `list1 == NULL`, and therefore this for loop is dead code.

Did you mean `for (list1 = *commit_list; list1; list1 = list1->next)`?

> +		list2->next = NULL;

Where is list2 set? Only in the previous loop, if it found a merge or root
commit. Otherwise, list2 would still be NULL and dereferenced here!

> +		if (merge_commit_or_root(*list1->item)) {
> +			list2->next = list1;
> +			list2 = list2->next;
> +			list2->item->parents = list1;

And here, we set the parents to list1... Again, this is messing with the
commits that come back when `lookup_commit()` is called later.

Changing the parents of a commit is something I imagine breaks too many
assumption to be a safe thing.

I'll read on for a little bit, maybe I get a better understanding what we
need to do in this here function.

> +		}
> +	}
> +}
> +
>  void find_bisection(struct commit_list **commit_list, int *reaches,
> -		    int *all, int find_all)
> +		    int *all, int find_all, int only_merge_commits)

Let's use a flag here, just as above.

>  {
>  	int nr, on_list;
>  	struct commit_list *list, *p, *best, *next, *last;
> @@ -373,6 +427,10 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
>  
>  	show_list("bisection 2 entry", 0, 0, *commit_list);
>  
> +	if (only_merge_commits) {
> +		filter_non_merge_commits(commit_list);
> +	}
> +
>  	/*
>  	 * Count the number of total and tree-changing items on the
>  	 * list, while reversing the list.
> @@ -400,7 +458,7 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
>  	weights = xcalloc(on_list, sizeof(*weights));
>  
>  	/* Do the real work of finding bisection commit. */
> -	best = do_find_bisection(list, nr, weights, find_all);
> +	best = do_find_bisection(list, nr, weights, find_all, only_merge_commits);
>  	if (best) {
>  		if (!find_all) {
>  			list->item = best->item;
> @@ -878,7 +936,7 @@ static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
>  /*
>   * This does "git diff-tree --pretty COMMIT" without one fork+exec.
>   */
> -static void show_diff_tree(const char *prefix, struct commit *commit)
> +static void show_diff_tree(const char *prefix, struct commit *commit, int only_merge_commits)
>  {
>  	struct rev_info opt;
>  
> @@ -893,6 +951,11 @@ static void show_diff_tree(const char *prefix, struct commit *commit)
>  	opt.use_terminator = 0;
>  	opt.commit_format = CMIT_FMT_DEFAULT;
>  
> +	if (only_merge_commits) {
> +		opt.ignore_merges = 0;
> +		opt.combine_merges = 1;
> +	}

This is most likely what we want, whether --only-merge-commits was passed
or not. Let's make it the default (in a separate commit)?

> @@ -938,7 +1001,7 @@ void read_bisect_terms(const char **read_bad, const char **read_good)
>   * If no_checkout is non-zero, the bisection process does not
>   * checkout the trial commit but instead simply updates BISECT_HEAD.
>   */
> -int bisect_next_all(const char *prefix, int no_checkout)
> +int bisect_next_all(const char *prefix, int no_checkout, int only_merge_commits)

Let's use `flags` here, too.

>  {
>  	struct rev_info revs;
>  	struct commit_list *tried;
> @@ -957,7 +1020,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
>  
>  	bisect_common(&revs);
>  
> -	find_bisection(&revs.commits, &reaches, &all, !!skipped_revs.nr);
> +	find_bisection(&revs.commits, &reaches, &all, !!skipped_revs.nr, only_merge_commits);

With the `flags` change, we would probably just introduce a local variable
`int flags = 0;` and set `flags |= !!skipped_revs.nr;` here at first, and
only change the `flags` variable to a parameter when introducing the
--only-merge-commits flag.

> @@ -983,10 +1046,14 @@ int bisect_next_all(const char *prefix, int no_checkout)
>  	bisect_rev = &revs.commits->item->object.oid;
>  
>  	if (!oidcmp(bisect_rev, current_bad_oid)) {
> +		char *format_string = NULL;
>  		exit_if_skipped_commits(tried, current_bad_oid);
> -		printf("%s is the first %s commit\n", oid_to_hex(bisect_rev),
> -			term_bad);
> -		show_diff_tree(prefix, revs.commits->item);
> +		if (only_merge_commits)
> +			format_string = "%s is the first %s merge\n";
> +		else
> +			format_string = "%s is the first %s commit\n";

... why? We can reference merge commits as "commits", too... Why not leave
the message as-is?

> diff --git a/bisect.h b/bisect.h
> index a5d9248a4..664ada180 100644
> --- a/bisect.h
> +++ b/bisect.h
> @@ -9,7 +9,7 @@
>   * best commit, as chosen by `find_all`.
>   */
>  extern void find_bisection(struct commit_list **list, int *reaches, int *all,
> -			   int find_all);
> +			   int find_all, int only_merge_commits);

Oh, I missed that this is a global function. So the flags should not be
FIND_ALL and ONLY_MERGE_COMMITS but BISECT_FIND_ALL and
BISECT_ONLY_MERGE_COMMITS, and `#define`d above this function.

> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 4b5fadcbe..9d7a1dd23 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -106,6 +106,32 @@ static void check_expected_revs(const char **revs, int rev_nr)
>  	}
>  }
>  
> +static GIT_PATH_FUNC(git_path_bisect_merges_only, "MERGES_ONLY_BISECT")

The other bisect-specific files start with BISECT_, let's do that here,
too (i.e. "BISECT_ONLY_MERGES")?

> +static int merges_only(void)
> +{
> +	const char *filename = git_path_bisect_merges_only();
> +	struct stat st;
> +	struct strbuf str = STRBUF_INIT;
> +	FILE *fp;
> +	int res = 0;
> +
> +	if (stat(filename, &st) || !S_ISREG(st.st_mode))
> +		return 0;
> +
> +	fp = fopen_or_warn(filename, "r");
> +	if (!fp)
> +		return 0;
> +
> +	if (strbuf_getline_lf(&str, fp) != EOF)
> +		res = atoi(str.buf);

Why not use the presence of the file as flag, rather than its contents?
Then the test becomes as simple as

	int merges_only = file_exists(git_path_bisect_merges_only());

> +
> +	strbuf_release(&str);
> +	fclose(fp);
> +
> +	return res;
> +}
> +
>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
>  	enum {
> @@ -137,7 +163,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  
>  	switch (cmdmode) {
>  	case NEXT_ALL:
> -		return bisect_next_all(prefix, no_checkout);
> +		return bisect_next_all(prefix, no_checkout, merges_only());
>  	case WRITE_TERMS:
>  		if (argc != 2)
>  			return error(_("--write-terms requires two arguments"));
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index fadd3ec14..cacffe6c6 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -538,7 +538,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  	if (bisect_list) {
>  		int reaches, all;
>  
> -		find_bisection(&revs.commits, &reaches, &all, bisect_find_all);
> +		find_bisection(&revs.commits, &reaches, &all, bisect_find_all, 0);

This would become bisect_flags in the preparatory patch.

>  
>  		if (bisect_show_vars)
>  			return show_bisect_vars(&info, reaches, all);
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 54cbfecc5..730c983c5 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -82,6 +82,7 @@ bisect_start() {
>  	bad_seen=0
>  	eval=''
>  	must_write_terms=0
> +	merges_only=0
>  	revs=''
>  	if test "z$(git rev-parse --is-bare-repository)" != zfalse
>  	then
> @@ -96,6 +97,9 @@ bisect_start() {
>  			shift
>  			break
>  		;;
> +		--merges-only)
> +			merges_only=1
> +			shift ;;
>  		--no-checkout)
>  			mode=--no-checkout
>  			shift ;;
> @@ -212,6 +216,7 @@ bisect_start() {
>  		git bisect--helper --write-terms "$TERM_BAD" "$TERM_GOOD" || exit
>  	fi &&
>  	echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
> +	echo "$merges_only" >"$GIT_DIR/MERGES_ONLY_BISECT" || exit

The git-bisect.sh script deviates from our coding convention, it seems.
Typically, we would write

	merges_only=
	[...]
		--merges-only)
			merges_only=t
			;;
	[...]
	test -z "$merges_only" || : >"$GIT_DIR/BISECT_ONLY_MERGES" || exit

I would prefer that here, too.

> diff --git a/t/t6070-bisect-merge-commits.sh b/t/t6070-bisect-merge-commits.sh
> new file mode 100755
> index 000000000..edfae0cfd
> --- /dev/null
> +++ b/t/t6070-bisect-merge-commits.sh
> @@ -0,0 +1,116 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2018 Harald Nordgren
> +#
> +test_description='Tests git bisect merge commit functionality'
> +
> +exec </dev/null

This is unnecessary, as our test-lib.sh already executes `exec 6<&0`.
Further, it is not only unnecessary, but also breaks debugging with the
`debug` shell function defined in test-lib-function.sh. Let's just drop
this statement.

> +
> +. ./test-lib.sh
> +
> +add_line_into_file()
> +{
> +    _line=$1
> +    _file=$2
> +
> +    if [ -f "$_file" ]; then
> +        echo "$_line" >> $_file || return $?
> +        MSG="Add <$_line> into <$_file>."
> +    else
> +        echo "$_line" > $_file || return $?
> +        git add $_file || return $?
> +        MSG="Create file <$_file> with <$_line> inside."
> +    fi
> +
> +    test_tick
> +    git commit --quiet -m "$MSG" $_file
> +}

It would appear that the contents of the files written using this function
are never tested.

Let's just use `test_commit` instead.

> +
> +create_merge_commit()
> +{
> +    _branch=$1
> +    _file=$2
> +
> +     git checkout -b $_branch &&
> +     add_line_into_file "hello" $_file &&
> +     git checkout master &&
> +     git merge $_branch --no-edit --no-ff
> +}

This not only creates a merge commit but also sets up a branch and adds a
commit to it. I'd much rather have a function that performs the merge
after calling `test_tick`, and then tags the result just like
`test_commit` would do.

> +HASH1=
> +HASH2=
> +HASH3=
> +HASH4=
> +HASH5=
> +HASH6=

These are too non-descriptive names to be useful. Remember that the
purpose of a regression test is to help debugging regressions. If I
encounter a regression while developing a patch series that breaks this
test, I really need to understand the regression test as quickly as
possible.

So let's use HEAD~4 and/or the tags creates by `test_commit` instead.

> +test_expect_success 'set up basic repo with 3 files and 3 merge commits' '

If we say 'setup' here, it is not only conciser, but also less prone to
become incorrect in the future.

> +    add_line_into_file "hello" hello &&
> +    HASH1=$(git rev-parse --verify HEAD) &&
> +
> +    add_line_into_file "hello" hello &&
> +    git checkout -b branch1 &&
> +    add_line_into_file "hello" hello1 &&
> +    git checkout master &&
> +    git checkout -b branch2 &&
> +    add_line_into_file "hello" hello2 &&
> +    git checkout master &&
> +    git checkout -b branch3 &&
> +    add_line_into_file "hello" hello3 &&
> +    git checkout master &&
> +    git merge branch1 --no-edit --no-ff &&
> +    HASH2=$(git rev-parse --verify HEAD) &&
> +
> +    add_line_into_file "hello" hello &&
> +    add_line_into_file "hello" hello &&
> +    git merge branch2 --no-edit --no-ff &&
> +    git merge branch3 --no-edit --no-ff &&
> +    HASH3=$(git rev-parse --verify HEAD) &&
> +
> +    add_line_into_file "hello" hello &&
> +    HASH4=$(git rev-parse --verify HEAD) &&
> +
> +    create_merge_commit branch4 hello4 &&
> +    create_merge_commit branch5 hello5 &&
> +    create_merge_commit branch6 hello6 &&
> +    create_merge_commit branch7 hello7 &&
> +    create_merge_commit branch8 hello8 &&
> +    create_merge_commit branch9 hello9 &&
> +    create_merge_commit branch10 hello10 &&
> +    create_merge_commit branch11 hello11 &&
> +    create_merge_commit branch12 hello12 &&
> +    create_merge_commit branch13 hello13 &&
> +    create_merge_commit branch14 hello14 &&
> +    create_merge_commit branch15 hello15 &&
> +    create_merge_commit branch16 hello16 &&
> +    HASH5=$(git rev-parse --verify HEAD) &&
> +
> +    create_merge_commit branch17 hello17 &&
> +    create_merge_commit branch18 hello18 &&
> +    create_merge_commit branch19 hello19 &&
> +    create_merge_commit branch20 hello20 &&
> +    HASH6=$(git rev-parse --verify HEAD)
> +'

It is next to impossible to understand this function in an 80x25 terminal
(which many of us old-timers still use). And it is not even necessary in
order to test the functionality you introduced...

So how about this strategy: first, paint a nice little diagram of the
commit graph you want to achieve, and make it not as insanely complex.
Then, set that up using `test_commit`, `git checkout -b` and `test_tick &&
git merge`. Something like this:

# We generate the following commit graph:
#
# A - B - C - F
#   \   \   /   \
#     D - E - G - H

test_merge () {
	test_tick &&
	git merge "$@" &&
	git tag "$1"
}

test_expect_success 'setup' '
	test_commit A &&
	test_commit B &&
	test_commit C &&
	git reset --hard A &&
	test_commit D &&
	test_merge -m E B &&
	git reset --hard C &&
	git merge -m F E &&
	git reset --hard G &&
	git merge -m H F
'

> +test_expect_success 'bisect skip: successful result' '

I do not actually see that `bisect skip` is tested here.

> +	test_when_finished git bisect reset &&
> +	git bisect reset &&
> +	git bisect start $HASH4 $HASH1 --merges-only &&
> +	git bisect good &&
> +	git bisect good &&
> +	git bisect bad > my_bisect_log.txt &&
> +	grep "$HASH3 is the first bad merge" my_bisect_log.txt
> +'

What we want to verify here is that we only encounter merge commits,
right? So that is what we should test:

test_expect_success '--merges-only' '
	write_script find-c.sh <<-\EOF &&
	case "$(git show --format=%p -s)" in
	*\ *) ;; # merge commit: okay
	*) git rev-parse HEAD >non-merge-found;;
	esac
	# detect whether we are "before" or "after" C
	test ! -f C.t
	EOF

	git bisect start HEAD A &&
	git bisect run ./find-c.sh >actual &&
	test_path_is_missing non-merge-found &&
	grep "$(git rev-parse F) is the first bad commit" actual
'

> +
> +test_expect_success 'bisect skip: successful result' '
> +	test_when_finished git bisect reset &&
> +	git bisect reset &&
> +	git bisect start $HASH6 $HASH2 --merges-only &&
> +	git bisect good &&
> +	git bisect good &&
> +	git bisect bad &&
> +	git bisect bad > my_bisect_log.txt &&
> +	grep "$HASH5 is the first bad merge" my_bisect_log.txt
> +'
> +
> +test_done

So after reading this, I am quite a bit more puzzled about that
commit->util field we seem to use. Could you clarify that in the commit
message, to give readers a head start?

Okay, now let's come back to that function accepting a commit_list and
dropping all non-merge commits from it.

First of all, I do not think that we actually make use of the parents
information after calling this function, right? If we did, I think it
would be horribly broken because all non-merge commits would now be
looking like root commits, and all the merge commits would pretend to have
*all* of the previous merge commits as parents (the first merge commit
would therefore look like a root commit, the second merge commit would
look like a non-merge, and so on).

So let's just drop the parent rewriting? If we do need to collapse the
commit graph to the merge commit nodes, then a much better idea would be
to use an oidset with commit_lists representing the collapsed vertices in
that graph (i.e. for every commit, it would replace the non-merge parents
with the respective closest ancestor that *is* a merge, and this list
would be constructed in reverse topological order to give linear
complexity).

Under the assumption that we can leave the commits' parents alone, this is
my proposed function to keep only merge commits in a commit_list:

static void keep_only_merge_commits(struct commit_list **p)
{
	struct commit_list *parents, *next;

	while (*p) {
		parents = (*p)->item->parents;
		if (parents && parents->next) {
			/* merge commit: keep */
			p = &(*p)->next;
			continue;
		}

		/* non-merge commit: free() and skip */
		next = (*p)->next;
		free(*p);
		*p = next;
	}
}

This makes use of the fact that both the original list of commits, as well
as the `next` field in the commit_list items, is a pointer to a
commit_list. So once we processed the first item of the list, we either
free it and replace the list by the remainder of the list, or we advance
to the "sub list" starting with the second item of the list (if there is
any left).

Ciao,
Johannes
