Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58CB31F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752138AbeA2WkZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:40:25 -0500
Received: from mout.gmx.net ([212.227.15.19]:63091 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752111AbeA2WiF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:38:05 -0500
Received: from MININT-KR8J64V.europe.corp.microsoft.com ([37.201.193.1]) by
 mail.gmx.com (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0Lug8u-1eozG33HmK-00zrrY; Mon, 29 Jan 2018 23:37:59 +0100
Date:   Mon, 29 Jan 2018 23:37:58 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 4/8] rebase-helper --make-script: introduce a flag to
 recreate merges
In-Reply-To: <xmqqh8rcgx65.fsf@gitster.mtv.corp.google.com>
Message-ID: <nycvar.QRO.7.76.6.1801292323260.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <b9cb2d915aa4ff564b1960ce0352664b1d26eecb.1516225925.git.johannes.schindelin@gmx.de> <xmqqh8rcgx65.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:PR79Xn5Xx4cHwHSidJMHbQCwoon+HKJ6jEOGzLZ8fDNuj/F684M
 DzPA0pE0hvZ+8VlDMGKHo/kPTnSLN3tLCU5fdXNyz4AKaK5DvXhXZhpRbgBGn3S4SS+szdb
 6SdJ9N6IcVD/FPMsB7LYBFjZBuB886ixoDLwtB9cPIP0/PO/Mh9rqcB/RF/Lm37zGE1R5Xw
 kTNYWat3NcslrxfQbwNcA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iSmbQNngOYo=:vag0hHpinpLf6JhvT0MA7o
 o2fl1W4ME7H+lwTeQ+ClwOkqzpxRqrJ6w4dzpfAxpuojGTBb/PmBE7Gl1UDQMJ12egWwF4nRY
 PAMmAtfN2VijU8cQnc4xMfQXXrHP4i8pvwyIXV903ghFftKHnBsbRBiBIjgH+jjFxl6kBrZKx
 U2vLrEgAzkC0cI04XRO3BHRwZG4sdrMbzIuJvHbrbU300/Y7h7pGVy4Yijr73sInRcM6EUtx+
 hVpD+cfgKR1ZfSIK1PS8aoFpyR3+f3443Q3Wm75Z26LSu97RYwvQEkdoO8fnYD27N6cA0tqRd
 UAgtu2YP6hEzp61yC0yzlE4gHis9drlhx8bAlG+HeE91BT3E1tvkMFOt2kc+knyN51kmNQ3M9
 lOUGRefgkF/5PdVOMoGacmfgmi3cnTMm6TWSJTyq9eEsYNgO5tTOz3NxLZHx5cFk3hOdrnKqm
 xoXedpfAPArALLHYHPsEDs4pOKbLMMq4mQBUStGGKjE5TkxtBaC6Kcb6zNINu1yf0h4FqGc5F
 wXAIu/Xg9Hrj3d6i1cUPwVq1h66+R+G4LUt7EaKoyTfcNidR4qjTDi7F74dQtQjXpUabw4cWx
 DU2Y4wVYAI2diS5HVHvCRwZG0uHqXG9FiPrOYRi79gA6ZPzQxkKK19qrsqqJ3GibEicP+Yl7h
 VtNc7eE1ITiTwbWwZT+wH9JO91FCehyv3x022c2t+n7cZrJzNcFGkC4ugCrIivDHKJJGKowZA
 Ao+fihE2wDvZXn0uLAv2rRWcRSEBVqVDfWs4Vz+40jiXzwEBB9Q0Aq0sv8z7FR7cmonljXmEd
 aJX1JZTEnWCRkYB6yefRd7yyRpzZTgJObqm7RMk7QaOh2YtidXyOjFgg2Ms421mBWKBpek6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 23 Jan 2018, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > structure (similar in spirit to --preserve-merges, but with a
> > substantially less-broken design).
> > ...
> > @@ -2785,6 +2787,335 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
> >  	strbuf_release(&sob);
> >  }
> >  
> > +struct labels_entry {
> > +	struct hashmap_entry entry;
> > +	char label[FLEX_ARRAY];
> > +};
> > +
> > +static int labels_cmp(const void *fndata, const struct labels_entry *a,
> > +		      const struct labels_entry *b, const void *key)
> > +{
> > +	return key ? strcmp(a->label, key) : strcmp(a->label, b->label);
> > +}
> 
> label_oid() accesses state->labels hash using strihash() as the hash
> function, but the final comparison between the entries in the same
> hash buckets are done with case sensitivity.  It is unclear to me if
> that is what was intended, and why.

Heh... you were almost there with your analysis. strihash() is needed for
case-insensitive comparisons, and labels are... ref names.

So the idea (which I implemented only partially) was to make the labels
case-insensitive based on `ignore_case`.

I think the best way forward will be to copy
merge-recursive.c:path_hash().

> > +struct string_entry {
> > +	struct oidmap_entry entry;
> > +	char string[FLEX_ARRAY];
> > +};
> > +
> > +struct label_state {
> > +	struct oidmap commit2label;
> > +	struct hashmap labels;
> > +	struct strbuf buf;
> > +};
> > +
> > +static const char *label_oid(struct object_id *oid, const char *label,
> > +			     struct label_state *state)
> > +{
> > +	struct labels_entry *labels_entry;
> > +	struct string_entry *string_entry;
> > +	struct object_id dummy;
> > +	size_t len;
> > +	int i;
> > +
> > +	string_entry = oidmap_get(&state->commit2label, oid);
> > +	if (string_entry)
> > +		return string_entry->string;
> > +
> > +	/*
> > +	 * For "uninteresting" commits, i.e. commits that are not to be
> > +	 * rebased, and which can therefore not be labeled, we use a unique
> > +	 * abbreviation of the commit name. This is slightly more complicated
> > +	 * than calling find_unique_abbrev() because we also need to make
> > +	 * sure that the abbreviation does not conflict with any other
> > +	 * label.
> > +	 *
> > +	 * We disallow "interesting" commits to be labeled by a string that
> > +	 * is a valid full-length hash, to ensure that we always can find an
> > +	 * abbreviation for any uninteresting commit's names that does not
> > +	 * clash with any other label.
> > +	 */
> > +	if (!label) {
> > +		char *p;
> > +
> > +		strbuf_reset(&state->buf);
> > +		strbuf_grow(&state->buf, GIT_SHA1_HEXSZ);
> > +		label = p = state->buf.buf;
> > +
> > +		find_unique_abbrev_r(p, oid->hash, default_abbrev);
> > +
> > +		/*
> > +		 * We may need to extend the abbreviated hash so that there is
> > +		 * no conflicting label.
> > +		 */
> > +		if (hashmap_get_from_hash(&state->labels, strihash(p), p)) {
> > +			size_t i = strlen(p) + 1;
> > +
> > +			oid_to_hex_r(p, oid);
> > +			for (; i < GIT_SHA1_HEXSZ; i++) {
> > +				char save = p[i];
> > +				p[i] = '\0';
> > +				if (!hashmap_get_from_hash(&state->labels,
> > +							   strihash(p), p))
> > +					break;
> > +				p[i] = save;
> > +			}
> > +		}
> 
> If oid->hash required full 40-hex to disambiguate, then
> find-unique-abbrev would give 40-hex and we'd want the same "-<num>"
> suffix technique employed below to make it consistently unique.  I
> wonder if organizing the function this way ...
> 
> 	if (!label)
> 		label = oid-to-hex(oid);
> 
> 	if (label already exists or full oid) {
> 		make it unambiguous;
> 	}

It was hard to miss, I agree. The first arm of the if() is not trying to
make a label unambiguous by adding `-<num>`, but by extending the
abbreviated 40-hex until it is unique. (And we guarantee that there is a
solution, as we do not allow valid 40-hex strings to be used as label.)

The reason: if no `label` is provided, we want a valid raw (possibly
abbreviated) commit name. If `label` is provided, we want a valid ref name
(possibly made unique by appending `-<num>`).

Different beasts. Cannot be put into the same if() arm.

> A related tangent.  Does an auto-label given to "uninteresting"
> commit need to be visible to end users?

Yes. The reason for this is the `merge`/`reset` commands when *not*
rebasing cousins. Because in that case, we have to refer to commits that
we could not possibly have `label`ed, because they were never the current
revision. Therefore we cannot assign <name>-<num> labels, but have to use
the abbreviated commit hash.

> > +static int make_script_with_merges(struct pretty_print_context *pp,
> > +				   struct rev_info *revs, FILE *out,
> > +				   unsigned flags)
> > +{
> > + ...
> > +	int abbr = flags & TODO_LIST_ABBREVIATE_CMDS;
> > +	const char *p = abbr ? "p" : "pick", *l = abbr ? "l" : "label",
> > +		 *t = abbr ? "t" : "reset", *b = abbr ? "b" : "bud",
> > +		 *m = abbr ? "m" : "merge";
> 
> It would be easier to understand if these short named variables are
> reserved only for temporary use, not as constants.  It is not too
> much to spell 
> 
> 	fprintf(out, "%s onto\n", cmd_label);
> 
> than
> 
> 	fprintf(out, "%s onto\n", l);
> 
> and would save readers from head-scratching, wondering where the
> last assignment to variable "l" is.

Sure.

> > +	oidmap_init(&commit2todo, 0);
> > +	oidmap_init(&state.commit2label, 0);
> > +	hashmap_init(&state.labels, (hashmap_cmp_fn) labels_cmp, NULL, 0);
> > +	strbuf_init(&state.buf, 32);
> > +
> > +	if (revs->cmdline.nr && (revs->cmdline.rev[0].flags & BOTTOM)) {
> > +		struct object_id *oid = &revs->cmdline.rev[0].item->oid;
> > +		FLEX_ALLOC_STR(entry, string, "onto");
> > +		oidcpy(&entry->entry.oid, oid);
> > +		oidmap_put(&state.commit2label, entry);
> > +	}
> > +
> > +	/*
> > +	 * First phase:
> > +	 * - get onelines for all commits
> > +	 * - gather all branch tips (i.e. 2nd or later parents of merges)
> > +	 * - label all branch tips
> > +	 */
> 
> When an early part of a branch is merged and then the remaining part
> of the same branch is merged again, "branch tip" and "2nd or later
> parents of merges" would become different concepts.  The 2nd parent
> of an early merge is not among the branch tips.
> 
> For the purpose of the "recreate the topology" algorithm, I am
> imagining that you would need not just the tips but all the 2nd and
> subsequent parents of merges, and my quick skimming tells me that
> the following code grabs them correctly.

Yes. I have used an earlier iteration of this patch series to create the
merging-rebase of Git for Windows v2.16.0 and that has a couple of really
good corner cases to exercise this code.

Ciao,
Dscho
