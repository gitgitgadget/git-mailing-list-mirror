Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FD311F404
	for <e@80x24.org>; Fri, 10 Aug 2018 20:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbeHJXWE (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 19:22:04 -0400
Received: from mout.gmx.net ([212.227.15.19]:38967 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbeHJXWE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 19:22:04 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M4WRI-1g6hYH3PZM-00yjAd; Fri, 10
 Aug 2018 22:50:30 +0200
Date:   Fri, 10 Aug 2018 22:50:31 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 03/21] range-diff: first rudimentary implementation
In-Reply-To: <20180730211636.GK9955@hank.intra.tgummerer.com>
Message-ID: <nycvar.QRO.7.76.6.1808102237540.71@tvgsbejvaqbjf.bet>
References: <pull.1.v3.git.gitgitgadget@gmail.com> <pull.1.v4.git.gitgitgadget@gmail.com> <4e3fb47a1dcef96780bd536032b81dd99387f2db.1532210683.git.gitgitgadget@gmail.com> <20180729183629.GC2734@hank.intra.tgummerer.com> <nycvar.QRO.7.76.6.1807301759340.10478@tvgsbejvaqbjf.bet>
 <20180730211636.GK9955@hank.intra.tgummerer.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dM+VrqIm06LgIZNFY24Id0NdoNK7Yv/gHYS4zrXNb5RiXNK8hdB
 ydNbw1HmLm4zpNiM2kod6Bm4I2bjCvHmKnRPanCxjLInjT2pvDI/KEoi5R/SvZt/PDXfXSR
 Yp1EFXOls/h5hHwyFnzZgsz27HsjtReeKkpWu/ptv8yKvjteDZ8jHdIxkMerotxiFz1Vus0
 zoka+A0ldJmmdju//A7FA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4yFFMVr+64A=:MRvOcsxBW6Ks4SJWYvfN6k
 rcNjNQbhQUy1usRMjy42U1dNNkBAHZrnF/F9dGiRtmTZ/0g4TwxIQjQBQZw0U83QEWwkAezsH
 jIQ1cH+g+aM2G+s/kFuPScRP/Hpu6LkleZ9TizXxG4ty0GDBkRGDJHHdD6k8eCh0sd2v4noYF
 EUyLuMG9/Ejl4lZz8fgfVR3Nl31Cr6ay/kKAdvtJbVfLnIigtumpANZYufIF4cjrfyKbUscCm
 K+T2b9RspzygwO+rK92GDvV44mNldoac5ncMYK2ncc/8EFwcM0GuYS+Rc8YzXzeTQWwOI1CIG
 hfMQf15IG+0I4072F9ELAy6WdicUlcmaTcBdGiSnm/yBgq20kzdpRY67IwjvsCRha9le7hgD8
 82gm3MDCAXCGIC33QbKaxnnLkFlKgnFgumHGr5aJgvLfbReGnDWCdLaQL0S1EGkbn82VNKtKt
 Hn+J+1u8EwXN8QC9cZhzuip2m23xlkaDqNGSvfrOJWSjqF1AeojPl70nYgYOBMb/3KBDz9RN4
 mL4+3FlAeq5aHxzF14nqRnVuSwchViz/UXGvtznMgZ0w9oHt77JaS9qd3z0Jh+DzwiwkQAzzu
 XbAR0/oSTqxfo7jN0YVyVANdi7GGBoTrLV/tYwKNvgAm19p/YvsRqbeN0Y1N0NFfqX23TX5Ah
 DWDL2GlQxkIDaE4+rosqPNMjo0a2anmZGWHaq+FnBuhqSigwoFuFKD2EIxzKAgRH6UqUlfWxN
 SAV4zJiFwGkUqFPaCaAWhjS5B8Tr5cQ/Io6zm3gx2Lhwhhfxw2qMkn8pB2uJWv+hayogjlKfG
 2ZmbXAI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Mon, 30 Jul 2018, Thomas Gummerer wrote:

> On 07/30, Johannes Schindelin wrote:
> > 
> > On Sun, 29 Jul 2018, Thomas Gummerer wrote:
> > 
> > > On 07/21, Johannes Schindelin via GitGitGadget wrote:
> > > > 
> > > > [...]
> > > > 
> > > > +static void find_exact_matches(struct string_list *a, struct string_list *b)
> > > > +{
> > > > +	struct hashmap map;
> > > > +	int i;
> > > > +
> > > > +	hashmap_init(&map, (hashmap_cmp_fn)patch_util_cmp, NULL, 0);
> > > > +
> > > > +	/* First, add the patches of a to a hash map */
> > > > +	for (i = 0; i < a->nr; i++) {
> > > > +		struct patch_util *util = a->items[i].util;
> > > > +
> > > > +		util->i = i;
> > > > +		util->patch = a->items[i].string;
> > > > +		util->diff = util->patch + util->diff_offset;
> > > > +		hashmap_entry_init(util, strhash(util->diff));
> > > > +		hashmap_add(&map, util);
> > > > +	}
> > > > +
> > > > +	/* Now try to find exact matches in b */
> > > > +	for (i = 0; i < b->nr; i++) {
> > > > +		struct patch_util *util = b->items[i].util, *other;
> > > > +
> > > > +		util->i = i;
> > > > +		util->patch = b->items[i].string;
> > > > +		util->diff = util->patch + util->diff_offset;
> > > > +		hashmap_entry_init(util, strhash(util->diff));
> > > > +		other = hashmap_remove(&map, util, NULL);
> > > > +		if (other) {
> > > > +			if (other->matching >= 0)
> > > > +				BUG("already assigned!");
> > > > +
> > > > +			other->matching = i;
> > > > +			util->matching = other->i;
> > > > +		}
> > > > +	}
> > > 
> > > One possibly interesting corner case here is what happens when there
> > > are two patches that have the exact same diff, for example in the
> > > pathological case of commit A doing something, commit B reverting
> > > commit A, and then commit C reverting commit B, so it ends up with the
> > > same diff.
> > > 
> > > Having those same commits unchanged in both ranges (e.g. if a commit
> > > earlier in the range has been changed, and range B has been rebased on
> > > top of that), we'd get the following mapping from range A to range B
> > > for the commits in question:
> > > 
> > > A -> C
> > > B -> B
> > > C -> A
> > > 
> > > Which is not quite what I would expect as the user (even though it is
> > > a valid mapping, and it probably doesn't matter too much for the end
> > > result of the range diff, as nothing has changed between the commits
> > > anyway).  So I'm not sure it's worth fixing this, as it is a
> > > pathological case, and nothing really breaks.
> > 
> > Indeed. As far as I am concerned, this falls squarely into the "let's
> > cross that bridge when, or if, we reach it" category.
> 
> Makes sense, this can definitely be addressed later.
> 
> > > > +
> > > > +	hashmap_free(&map, 0);
> > > > +}
> > > > +
> > > > +static void diffsize_consume(void *data, char *line, unsigned long len)
> > > > +{
> > > > +	(*(int *)data)++;
> > > > +}
> > > > +
> > > > +static int diffsize(const char *a, const char *b)
> > > > +{
> > > > +	xpparam_t pp = { 0 };
> > > > +	xdemitconf_t cfg = { 0 };
> > > > +	mmfile_t mf1, mf2;
> > > > +	int count = 0;
> > > > +
> > > > +	mf1.ptr = (char *)a;
> > > > +	mf1.size = strlen(a);
> > > > +	mf2.ptr = (char *)b;
> > > > +	mf2.size = strlen(b);
> > > > +
> > > > +	cfg.ctxlen = 3;
> > > > +	if (!xdi_diff_outf(&mf1, &mf2, diffsize_consume, &count, &pp, &cfg))
> > > > +		return count;
> > > > +
> > > > +	error(_("failed to generate diff"));
> > > > +	return COST_MAX;
> > > > +}
> > > > +
> > > > +static void get_correspondences(struct string_list *a, struct string_list *b,
> > > > +				int creation_factor)
> > > > +{
> > > > +	int n = a->nr + b->nr;
> > > > +	int *cost, c, *a2b, *b2a;
> > > > +	int i, j;
> > > > +
> > > > +	ALLOC_ARRAY(cost, st_mult(n, n));
> > > > +	ALLOC_ARRAY(a2b, n);
> > > > +	ALLOC_ARRAY(b2a, n);
> > > > +
> > > > +	for (i = 0; i < a->nr; i++) {
> > > > +		struct patch_util *a_util = a->items[i].util;
> > > > +
> > > > +		for (j = 0; j < b->nr; j++) {
> > > > +			struct patch_util *b_util = b->items[j].util;
> > > > +
> > > > +			if (a_util->matching == j)
> > > > +				c = 0;
> > > > +			else if (a_util->matching < 0 && b_util->matching < 0)
> > > > +				c = diffsize(a_util->diff, b_util->diff);
> > > > +			else
> > > > +				c = COST_MAX;
> > > > +			cost[i + n * j] = c;
> > > > +		}
> > > > +
> > > > +		c = a_util->matching < 0 ?
> > > > +			a_util->diffsize * creation_factor / 100 : COST_MAX;
> > > > +		for (j = b->nr; j < n; j++)
> > > > +			cost[i + n * j] = c;
> > > > +	}
> > > > +
> > > > +	for (j = 0; j < b->nr; j++) {
> > > > +		struct patch_util *util = b->items[j].util;
> > > > +
> > > > +		c = util->matching < 0 ?
> > > > +			util->diffsize * creation_factor / 100 : COST_MAX;
> > > > +		for (i = a->nr; i < n; i++)
> > > > +			cost[i + n * j] = c;
> > > > +	}
> > > > +
> > > > +	for (i = a->nr; i < n; i++)
> > > > +		for (j = b->nr; j < n; j++)
> > > > +			cost[i + n * j] = 0;
> > > > +
> > > > +	compute_assignment(n, n, cost, a2b, b2a);
> > > > +
> > > > +	for (i = 0; i < a->nr; i++)
> > > > +		if (a2b[i] >= 0 && a2b[i] < b->nr) {
> > > > +			struct patch_util *a_util = a->items[i].util;
> > > > +			struct patch_util *b_util = b->items[a2b[i]].util;
> > > > +
> > > > +			a_util->matching = a2b[i];
> > > > +			b_util->matching = i;
> > > 
> > > So here we re-assign 'matching' in the struct regardless of whether it
> > > was assigned before while searching for exact matches or not.
> > 
> > If `matching` were assigned here, it would indicate a bug in the code, I
> > think. Before this loop, all of the `matching` fields should be `NULL`,
> > and the `compute_assignment()` function is expected to populate `a2b` and
> > `b2a` appropriately, i.e. no "double booking".
> 
> Hmm we are using the 'matching' fields in the loops above, e.g.:
> 
> 	if (a_util->matching == j)
> 		c = 0;
> 
> They're also ints, so they can't be `NULL`, right?

Right, I was confused, they are not pointers. They are initialized to
`-1`, though.

> So what I was thinking is that we could do
> 
> 	 if (a_util->matching < 0) {
> 		a_util->matching = a2b[i];
> 		b_util->matching = i;
> 	}

Yes, we could have that safeguard. But then, we should actually rather say

	if (a_util->matching >= 0)
		BUG("a[%d] already assigned to %d, cannot assign to %d",
		    i, a_util->matching, a2b[i]);

The reason this is a bug is that we really just calculated a linear
assignment, and a2b was initialized accordingly: it contains a 1:1 mapping
between a->items and b->items.

Side note: technically, the linear assignment is able to handle two
differently-sized sets. However, due to implementation details, we do not
use this, as a->nr and b->nr are both set to `n`. The reason is that we
want to avoid forcing matches where there are none, i.e. we add specific
entries to the cost matrix to allow for the "creation" or "destruction" if
that is cheaper than to match two completely unrelated commits. It just
so happens that these filler entries result in identical set sizes.

So practically, that `if()` guard is not necessary, and honestly, I would
stumble over it every time ("Why is this needed? Should `a2b` and `b2a`
not have a complete assignment already?")), so I'd rather not have it.

> Anyway, I don't think it really matters, as there is no "double
> booking", so we should essentially get the same results.

Exactly.

If you were worried about it, I would introduce that guarded BUG(), but it
is not an off-by-one error, so I probably did not introduce a bug here.

> Glad I could help.  Can I have more hours in a day? ;) I wish I had
> more time for reviewing code, but sadly the time I have is limited.
> Which is why I only got to review this now as well.  I did enjoy the
> read!

Thank you so much! I appreciate your help, and it was a very pleasant and
useful review that really made the patch series better. There were three
distinct issues that would have otherwise been missed before this hit
`next`.

Thanks!
Dscho
