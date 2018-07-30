Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C4341F597
	for <e@80x24.org>; Mon, 30 Jul 2018 16:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbeG3R5c (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 13:57:32 -0400
Received: from mout.gmx.net ([212.227.15.19]:56287 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbeG3R5b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 13:57:31 -0400
Received: from [192.168.0.129] ([37.201.193.26]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LcShi-1gQd1i0u3C-00jqDW; Mon, 30
 Jul 2018 18:21:36 +0200
Date:   Mon, 30 Jul 2018 18:21:29 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 03/21] range-diff: first rudimentary implementation
In-Reply-To: <20180729183629.GC2734@hank.intra.tgummerer.com>
Message-ID: <nycvar.QRO.7.76.6.1807301759340.10478@tvgsbejvaqbjf.bet>
References: <pull.1.v3.git.gitgitgadget@gmail.com> <pull.1.v4.git.gitgitgadget@gmail.com> <4e3fb47a1dcef96780bd536032b81dd99387f2db.1532210683.git.gitgitgadget@gmail.com> <20180729183629.GC2734@hank.intra.tgummerer.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DQNe/ZrU9OwNNe6XWmUOLxsg5bVn58ozDidmnBeDy+94uu8U4KI
 5lyDRhhkk6zyUDuR7JZJloa27bfsWVpXxuZkoZ/FyRrdrcwZtbXzzb1hC/EpRDPtUZYTbUe
 9lM2N8TWVlPbl32nxZamQvcrmRjh5C4BlAweVjEgUxDr4c2adjG17Y3DoFHV4WDpdRjX7ho
 9JdW9fk7bdGnL+nOJZ3ag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9JzlWOAnkiE=:M+0xiCTokYlGv+NfY/91FT
 m+DDBdferYHOqKdA5p0JM/jXMoqaMWcxqxRC6l8zXSrYVrJk+MfGpI1eLMGxC0wiLG4uROFfN
 BwRWoq1mwVbHQiaSI0h1uF58agCI5JiMu8kAj1hqzB7ugYlB/XsgIMceaN/I8zO8WZpwKzALB
 yAE82T8yuW2fCjGKefqG33PtoH/RmnDLQJMYJsOXvqSrMvT79OTlJgnZIVARJfT16DRe7ASUj
 bNhYDIlEW9c7ngwS9QQifkikVZipwRTBu2n36IMdnlR7xtrzTt8gvFEyDDeIuAT839Y8/e0jl
 ELL7DnuKJ0mWO857dQI//UdJ/2kaPZUv8ovGdt9jwEoN5Hj2EQsGTTEkiswlV7TK4f4nkyF5I
 G4mSZuxCwhDhMUW4pMhts23GRc+JntzM+shafd3kAcg8jbcYY3sy0LOjXB88gk0uAQJrJZKxX
 u9qEm2wTKK/Fc4TuRha484RT92i/I5OnHygxz+5j/hwZOH/JeL4iXdLWEbf4MN6Aljz9XT2me
 KHAmEHza5krU9rnuonWAjw6J6VWjaCWr1DMb6+d+vkUDsUV3wbGzNenMUOfr+onPI4EA4lHBI
 HSV/3OFTO65nYTuA1mBPu6lwzPvtaarDa5hP+q764r2Nd9K54jwz/JVkc0OJGwj0Y8/Qd/m9c
 uBrslaKHZ25G3GaOsEmS8A+hQZC1/KU9eCCv8JbiuPN0TFwnYexP1YhO5X07kohl1TlOzFnuA
 Q96BdLqKCb4xylXdCsHzDObjPQkx2DQWyM4Dz8fE5cT+uT54f0ANAwlqqgX4+m4gvAY3wvcdo
 Cm6gmzz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Sun, 29 Jul 2018, Thomas Gummerer wrote:

> On 07/21, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > 
> > At this stage, `git range-diff` can determine corresponding commits
> > of two related commit ranges. This makes use of the recently introduced
> > implementation of the linear assignment algorithm.
> > 
> > The core of this patch is a straight port of the ideas of tbdiff, the
> > apparently dormant project at https://github.com/trast/tbdiff.
> > 
> > The output does not at all match `tbdiff`'s output yet, as this patch
> > really concentrates on getting the patch matching part right.
> > 
> > Note: due to differences in the diff algorithm (`tbdiff` uses the Python
> > module `difflib`, Git uses its xdiff fork), the cost matrix calculated
> > by `range-diff` is different (but very similar) to the one calculated
> > by `tbdiff`. Therefore, it is possible that they find different matching
> > commits in corner cases (e.g. when a patch was split into two patches of
> > roughly equal length).
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  Makefile             |   1 +
> >  builtin/range-diff.c |  43 +++++-
> >  range-diff.c         | 311 +++++++++++++++++++++++++++++++++++++++++++
> >  range-diff.h         |   7 +
> >  4 files changed, 361 insertions(+), 1 deletion(-)
> >  create mode 100644 range-diff.c
> >  create mode 100644 range-diff.h
> >
> > [...]
> > 
> > diff --git a/range-diff.c b/range-diff.c
> > new file mode 100644
> > index 000000000..15d418afa
> > --- /dev/null
> > +++ b/range-diff.c
> > @@ -0,0 +1,311 @@
> > +#include "cache.h"
> > +#include "range-diff.h"
> > +#include "string-list.h"
> > +#include "run-command.h"
> > +#include "argv-array.h"
> > +#include "hashmap.h"
> > +#include "xdiff-interface.h"
> > +#include "linear-assignment.h"
> > +
> > +struct patch_util {
> > +	/* For the search for an exact match */
> > +	struct hashmap_entry e;
> > +	const char *diff, *patch;
> > +
> > +	int i;
> > +	int diffsize;
> > +	size_t diff_offset;
> > +	/* the index of the matching item in the other branch, or -1 */
> > +	int matching;
> > +	struct object_id oid;
> > +};
> > +
> > +/*
> > + * Reads the patches into a string list, with the `util` field being populated
> > + * as struct object_id (will need to be free()d).
> > + */
> > +static int read_patches(const char *range, struct string_list *list)
> > +{
> > +	struct child_process cp = CHILD_PROCESS_INIT;
> > +	FILE *in;
> > +	struct strbuf buf = STRBUF_INIT, line = STRBUF_INIT;
> > +	struct patch_util *util = NULL;
> > +	int in_header = 1;
> > +
> > +	argv_array_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
> > +			"--reverse", "--date-order", "--decorate=no",
> > +			"--no-abbrev-commit", range,
> > +			NULL);
> 
> Compared to tbdiff, add "--decorate=no", and "--no-abbrev-commit".  I
> see we're abbreviating the commit hashes later.  We don't want ref
> names here, so "--decorate=no" makes sense as well.

Indeed. Compare also to https://github.com/trast/tbdiff/pull/8

> > +	cp.out = -1;
> > +	cp.no_stdin = 1;
> > +	cp.git_cmd = 1;
> > +
> > +	if (start_command(&cp))
> > +		return error_errno(_("could not start `log`"));
> > +	in = fdopen(cp.out, "r");
> > +	if (!in) {
> > +		error_errno(_("could not read `log` output"));
> > +		finish_command(&cp);
> > +		return -1;
> > +	}
> > +
> > +	while (strbuf_getline(&line, in) != EOF) {
> > +		const char *p;
> > +
> > +		if (skip_prefix(line.buf, "commit ", &p)) {
> > +			if (util) {
> > +				string_list_append(list, buf.buf)->util = util;
> > +				strbuf_reset(&buf);
> > +			}
> > +			util = xcalloc(sizeof(*util), 1);
> > +			if (get_oid(p, &util->oid)) {
> > +				error(_("could not parse commit '%s'"), p);
> > +				free(util);
> > +				string_list_clear(list, 1);
> > +				strbuf_release(&buf);
> > +				strbuf_release(&line);
> > +				fclose(in);
> > +				finish_command(&cp);
> > +				return -1;
> > +			}
> > +			util->matching = -1;
> > +			in_header = 1;
> > +			continue;
> > +		}
> > +
> > +		if (starts_with(line.buf, "diff --git")) {
> > +			in_header = 0;
> > +			strbuf_addch(&buf, '\n');
> > +			if (!util->diff_offset)
> > +				util->diff_offset = buf.len;
> > +			strbuf_addbuf(&buf, &line);
> > +		} else if (in_header) {
> > +			if (starts_with(line.buf, "Author: ")) {
> > +				strbuf_addbuf(&buf, &line);
> > +				strbuf_addstr(&buf, "\n\n");
> > +			} else if (starts_with(line.buf, "    ")) {
> > +				strbuf_addbuf(&buf, &line);
> > +				strbuf_addch(&buf, '\n');
> > +			}
> > +			continue;
> > +		} else if (starts_with(line.buf, "@@ "))
> > +			strbuf_addstr(&buf, "@@");
> > +		else if (!line.buf[0] || starts_with(line.buf, "index "))
> > +			/*
> > +			 * A completely blank (not ' \n', which is context)
> > +			 * line is not valid in a diff.  We skip it
> > +			 * silently, because this neatly handles the blank
> > +			 * separator line between commits in git-log
> > +			 * output.
> > +			 *
> > +			 * We also want to ignore the diff's `index` lines
> > +			 * because they contain exact blob hashes in which
> > +			 * we are not interested.
> > +			 */
> > +			continue;
> > +		else
> > +			strbuf_addbuf(&buf, &line);
> > +
> > +		strbuf_addch(&buf, '\n');
> > +		util->diffsize++;
> > +	}
> 
> This seems to differ from tbdiff in the number of newlines we're
> adding in various places, however I think as long as it's consistent
> in itself, and with the way we're printing the output the differences
> shouldn't matter.

Right.

> > +	fclose(in);
> > +	strbuf_release(&line);
> > +
> > +	if (util)
> > +		string_list_append(list, buf.buf)->util = util;
> > +	strbuf_release(&buf);
> > +
> > +	if (finish_command(&cp))
> > +		return -1;
> > +
> > +	return 0;
> > +}
> > +
> > +static int patch_util_cmp(const void *dummy, const struct patch_util *a,
> > +		     const struct patch_util *b, const char *keydata)
> > +{
> > +	return strcmp(a->diff, keydata ? keydata : b->diff);
> > +}
> > +
> > +static void find_exact_matches(struct string_list *a, struct string_list *b)
> > +{
> > +	struct hashmap map;
> > +	int i;
> > +
> > +	hashmap_init(&map, (hashmap_cmp_fn)patch_util_cmp, NULL, 0);
> > +
> > +	/* First, add the patches of a to a hash map */
> > +	for (i = 0; i < a->nr; i++) {
> > +		struct patch_util *util = a->items[i].util;
> > +
> > +		util->i = i;
> > +		util->patch = a->items[i].string;
> > +		util->diff = util->patch + util->diff_offset;
> > +		hashmap_entry_init(util, strhash(util->diff));
> > +		hashmap_add(&map, util);
> > +	}
> > +
> > +	/* Now try to find exact matches in b */
> > +	for (i = 0; i < b->nr; i++) {
> > +		struct patch_util *util = b->items[i].util, *other;
> > +
> > +		util->i = i;
> > +		util->patch = b->items[i].string;
> > +		util->diff = util->patch + util->diff_offset;
> > +		hashmap_entry_init(util, strhash(util->diff));
> > +		other = hashmap_remove(&map, util, NULL);
> > +		if (other) {
> > +			if (other->matching >= 0)
> > +				BUG("already assigned!");
> > +
> > +			other->matching = i;
> > +			util->matching = other->i;
> > +		}
> > +	}
> 
> One possibly interesting corner case here is what happens when there
> are two patches that have the exact same diff, for example in the
> pathological case of commit A doing something, commit B reverting
> commit A, and then commit C reverting commit B, so it ends up with the
> same diff.
> 
> Having those same commits unchanged in both ranges (e.g. if a commit
> earlier in the range has been changed, and range B has been rebased on
> top of that), we'd get the following mapping from range A to range B
> for the commits in question:
> 
> A -> C
> B -> B
> C -> A
> 
> Which is not quite what I would expect as the user (even though it is
> a valid mapping, and it probably doesn't matter too much for the end
> result of the range diff, as nothing has changed between the commits
> anyway).  So I'm not sure it's worth fixing this, as it is a
> pathological case, and nothing really breaks.

Indeed. As far as I am concerned, this falls squarely into the "let's
cross that bridge when, or if, we reach it" category.

> > +
> > +	hashmap_free(&map, 0);
> > +}
> > +
> > +static void diffsize_consume(void *data, char *line, unsigned long len)
> > +{
> > +	(*(int *)data)++;
> > +}
> > +
> > +static int diffsize(const char *a, const char *b)
> > +{
> > +	xpparam_t pp = { 0 };
> > +	xdemitconf_t cfg = { 0 };
> > +	mmfile_t mf1, mf2;
> > +	int count = 0;
> > +
> > +	mf1.ptr = (char *)a;
> > +	mf1.size = strlen(a);
> > +	mf2.ptr = (char *)b;
> > +	mf2.size = strlen(b);
> > +
> > +	cfg.ctxlen = 3;
> > +	if (!xdi_diff_outf(&mf1, &mf2, diffsize_consume, &count, &pp, &cfg))
> > +		return count;
> > +
> > +	error(_("failed to generate diff"));
> > +	return COST_MAX;
> > +}
> > +
> > +static void get_correspondences(struct string_list *a, struct string_list *b,
> > +				int creation_factor)
> > +{
> > +	int n = a->nr + b->nr;
> > +	int *cost, c, *a2b, *b2a;
> > +	int i, j;
> > +
> > +	ALLOC_ARRAY(cost, st_mult(n, n));
> > +	ALLOC_ARRAY(a2b, n);
> > +	ALLOC_ARRAY(b2a, n);
> > +
> > +	for (i = 0; i < a->nr; i++) {
> > +		struct patch_util *a_util = a->items[i].util;
> > +
> > +		for (j = 0; j < b->nr; j++) {
> > +			struct patch_util *b_util = b->items[j].util;
> > +
> > +			if (a_util->matching == j)
> > +				c = 0;
> > +			else if (a_util->matching < 0 && b_util->matching < 0)
> > +				c = diffsize(a_util->diff, b_util->diff);
> > +			else
> > +				c = COST_MAX;
> > +			cost[i + n * j] = c;
> > +		}
> > +
> > +		c = a_util->matching < 0 ?
> > +			a_util->diffsize * creation_factor / 100 : COST_MAX;
> > +		for (j = b->nr; j < n; j++)
> > +			cost[i + n * j] = c;
> > +	}
> > +
> > +	for (j = 0; j < b->nr; j++) {
> > +		struct patch_util *util = b->items[j].util;
> > +
> > +		c = util->matching < 0 ?
> > +			util->diffsize * creation_factor / 100 : COST_MAX;
> > +		for (i = a->nr; i < n; i++)
> > +			cost[i + n * j] = c;
> > +	}
> > +
> > +	for (i = a->nr; i < n; i++)
> > +		for (j = b->nr; j < n; j++)
> > +			cost[i + n * j] = 0;
> > +
> > +	compute_assignment(n, n, cost, a2b, b2a);
> > +
> > +	for (i = 0; i < a->nr; i++)
> > +		if (a2b[i] >= 0 && a2b[i] < b->nr) {
> > +			struct patch_util *a_util = a->items[i].util;
> > +			struct patch_util *b_util = b->items[a2b[i]].util;
> > +
> > +			a_util->matching = a2b[i];
> > +			b_util->matching = i;
> 
> So here we re-assign 'matching' in the struct regardless of whether it
> was assigned before while searching for exact matches or not.

If `matching` were assigned here, it would indicate a bug in the code, I
think. Before this loop, all of the `matching` fields should be `NULL`,
and the `compute_assignment()` function is expected to populate `a2b` and
`b2a` appropriately, i.e. no "double booking".

> Shouldn't diffsize for matching patches also be 0?  So are we doing
> the 'find_exact_matches()' bit only as an optimization, or am I
> missing some other reason why that is beneficial?

An optimization.

Remember, the linear assignment algorithm runs in O(n^3). That's not a
laughing matter by any stretch of imagination. The more stuff we can get
out of the way, as quickly as possible, the less it hurts to have a cubic
runtime complexity.

> > +		}
> > +
> > +	free(cost);
> > +	free(a2b);
> > +	free(b2a);
> > +}
> > +
> > +static const char *short_oid(struct patch_util *util)
> > +{
> > +	return find_unique_abbrev(&util->oid, DEFAULT_ABBREV);
> > +}
> > +
> > +static void output(struct string_list *a, struct string_list *b)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < b->nr; i++) {
> > +		struct patch_util *util = b->items[i].util, *prev;
> > +
> > +		if (util->matching < 0)
> > +			printf("-: -------- > %d: %s\n",
> > +					i + 1, short_oid(util));
> > +		else {
> > +			prev = a->items[util->matching].util;
> > +			printf("%d: %s ! %d: %s\n",
> > +			       util->matching + 1, short_oid(prev),
> > +			       i + 1, short_oid(util));
> > +		}
> > +	}
> > +
> > +	for (i = 0; i < a->nr; i++) {
> > +		struct patch_util *util = a->items[i].util;
> > +
> > +		if (util->matching < 0)
> > +			printf("%d: %s < -: --------\n",
> > +			       i + 1, short_oid(util));
> > +	}
> > +}
> > +
> > +int show_range_diff(const char *range1, const char *range2,
> > +		    int creation_factor)
> > +{
> > +	int res = 0;
> > +
> > +	struct string_list branch1 = STRING_LIST_INIT_DUP;
> > +	struct string_list branch2 = STRING_LIST_INIT_DUP;
> > +
> > +	if (read_patches(range1, &branch1))
> > +		res = error(_("could not parse log for '%s'"), range1);
> > +	if (!res && read_patches(range2, &branch2))
> > +		res = error(_("could not parse log for '%s'"), range2);
> > +
> > +	if (!res) {
> > +		find_exact_matches(&branch1, &branch2);
> 
> Note to self: here we assign the matching member of struct patch_util
> for each patch in both ranges to a patch number in the other range if
> it is an exact match.
> 
> We also assign the patch and diff members, and number the patches
> using the 'i' member of struct patch_util.  Let's see if that
> numbering is still useful later.
> 
> > +		get_correspondences(&branch1, &branch2, creation_factor);
> 
> And here we use the linear assignment algorithm to match the rest of
> the commits.
> 
> > +		output(&branch1, &branch2);
> 
> And finally we print the output.  We don't seem to use the util->i
> that's assigned for range b (or range 2) anywhere at the moment, which
> I was wondering about earlier, so I assume it's there mainly for
> symmetry, but it doesn't really hurt other than me wondering what it
> was for.

It's there because it would require extra care to do it only for one side.

> > +	}
> > +
> > +	string_list_clear(&branch1, 1);
> > +	string_list_clear(&branch2, 1);
> > +
> > +	return res;
> > +}
> > diff --git a/range-diff.h b/range-diff.h
> > new file mode 100644
> > index 000000000..dd30449c4
> > --- /dev/null
> > +++ b/range-diff.h
> > @@ -0,0 +1,7 @@
> > +#ifndef BRANCH_DIFF_H
> > +#define BRANCH_DIFF_H
> 
> s/BRANCH/RANGE/ above?

Good eyes.

Thank you for your review. It is nice to see that you can follow the code
and come to the same conclusions as I. Can I always have you as reviewer?

Ciao,
Dscho

> > +int show_range_diff(const char *range1, const char *range2,
> > +		    int creation_factor);
> > +
> > +#endif
> > -- 
> > gitgitgadget
> > 
> 
