Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 610CC1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 21:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbeHJXch (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 19:32:37 -0400
Received: from mout.gmx.net ([212.227.15.19]:60605 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbeHJXch (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 19:32:37 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M0gcI-1g2rlT0oX8-00usmE; Fri, 10
 Aug 2018 23:01:01 +0200
Date:   Fri, 10 Aug 2018 23:01:03 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 09/21] range-diff: adjust the output of the commit
 pairs
In-Reply-To: <20180729193818.GE2734@hank.intra.tgummerer.com>
Message-ID: <nycvar.QRO.7.76.6.1808081507040.71@tvgsbejvaqbjf.bet>
References: <pull.1.v3.git.gitgitgadget@gmail.com> <pull.1.v4.git.gitgitgadget@gmail.com> <9641ab5c0df984f5e7ea9c49debffffe2a929095.1532210683.git.gitgitgadget@gmail.com> <20180729193818.GE2734@hank.intra.tgummerer.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4tPW7qIH3igfF9tYOgjv96i1HFPp1GettoTOX2AJ2nmqKsEsdC9
 MvnnOdixY+qJTvjkftcDakItaZ2vtaGacQ48ad0/Z7Nn0HskbJXjCNhxTMJcK8/cB1RbQ05
 B8vW69np0rSDRhaGWu88CHm6GePpj79HOyaAQVcJg+lBSJIFOk7/gN10vKQqKupwwJ6A7KS
 Hf8EPVHsxPr31vIIErn9w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:P2BYnUINM7c=:7+uOk6lEAlSprX+Nl+w2ro
 t+OU6Zixb18SGXTJ/FAiB2xY111Fe7x5FL2rBJ0s0pPi4mPI0qwVv8YAbZutIN18Dv99nz9Pc
 PtavpYzKoifwyewpR1BDn6VIlB6cFvUUpU2z0jFiumFlWW0r1jHeErZPQG+KEj7KDIIfwVcJY
 M4g7ks0nCZl2NAJ4EQj9FD38rIzEC8r83gLNLCH3phMBh299xYZXd6DBoB+SJ3c/egZVOlBfP
 oZlnVE0+jSuNs7eYdxgEGwLVBgizISA0bjoObsZ5ZfYmLrYp6vn9TAuuSibaNW2a4E3TwYHF4
 Moatd5E4HJCm1Yx/HtrkjQFKUhMeXUYdbjFkIjRPE8AYScZd8ksFwhZ0bw4iDIbogrS9w2jHv
 IZbnbT/UTxbruk9gWf31n0EEvzLThc0FH8HeA2PNTyWBSpswPBlvtbytygsJTzMS9PPx+O8Tu
 K+A2ZRUc8W+VJaAUOuaJF8kChddUMKC4c6KSiBZzFnoRUESLxdyGYymFfbv/TO+XyHE+aVMRD
 i0fiFqlVfJZ3B3eZcDw/G+bGXRPgas/wH3RN31uML9UJbrHrqznX87CmiZyTJ+ZTRjuRwwQcd
 PNRgDpoN/ONjy+CaizluW5wDgKd7J95PIlM422lSSVnSzcpHcCkZlt4EEIIxfhcDV8lCf2cn/
 IqKMUtzG3rD/908vGg2Oev9912lSPqOWyHfFOR6gFL2c+UdCg/UnxRZW1tEvPIVu3OkrhGIxf
 I0bufA0GckAIce/mBkhdZGcqG0jjSQ7utSw4YQ+m0IvJnvWIB+yFRSyEfrH/oo1a+depJLF0t
 2sH5Ghr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Sun, 29 Jul 2018, Thomas Gummerer wrote:

> On 07/21, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > 
> > This change brings `git range-diff` yet another step closer to
> > feature parity with tbdiff: it now shows the oneline, too, and indicates
> > with `=` when the commits have identical diffs.
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  range-diff.c | 64 ++++++++++++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 55 insertions(+), 9 deletions(-)
> > 
> > diff --git a/range-diff.c b/range-diff.c
> > index 1ecee2c09..8329f52e7 100644
> > --- a/range-diff.c
> > +++ b/range-diff.c
> > @@ -7,6 +7,8 @@
> >  #include "xdiff-interface.h"
> >  #include "linear-assignment.h"
> >  #include "diffcore.h"
> > +#include "commit.h"
> > +#include "pretty.h"
> >  
> >  struct patch_util {
> >  	/* For the search for an exact match */
> > @@ -255,9 +257,54 @@ static void get_correspondences(struct string_list *a, struct string_list *b,
> >  	free(b2a);
> >  }
> >  
> > -static const char *short_oid(struct patch_util *util)
> > +static void output_pair_header(struct strbuf *buf,
> > +			       struct strbuf *dashes,
> > +			       struct patch_util *a_util,
> > +			       struct patch_util *b_util)
> >  {
> > -	return find_unique_abbrev(&util->oid, DEFAULT_ABBREV);
> > +	struct object_id *oid = a_util ? &a_util->oid : &b_util->oid;
> > +	struct commit *commit;
> > +
> > +	if (!dashes->len)
> > +		strbuf_addchars(dashes, '-',
> > +				strlen(find_unique_abbrev(oid,
> > +							  DEFAULT_ABBREV)));
> 
> We're doing this only once, which makes sense.  What's a bit
> unfortunate here I guess is that if the first commit we're dealing
> with in the range-diff has a longer unique abbreviation, the dashes
> will be longer for all commits, even if all the others have a shorter
> abbreviation.
> 
> Tbh I don't really know what the right thing to do here is, so this is
> probably as good a heuristic as any.  It would probably be worse to
> have different length dashes lines, than guessing based on the first
> commit.

Yes, I had the same reaction as you did. But still, I think it is the best
we can do, and I don't think it is worth spending a lot of thought about
ways to fix this, up and until the day when somebody experiences a real
problem there (and that it will be *their* responsibility to fix it).

> > +
> > +	strbuf_reset(buf);
> > +	if (!a_util)
> > +		strbuf_addf(buf, "-:  %s ", dashes->buf);
> > +	else
> > +		strbuf_addf(buf, "%d:  %s ", a_util->i + 1,
> > +			    find_unique_abbrev(&a_util->oid, DEFAULT_ABBREV));
> > +
> > +	if (!a_util)
> > +		strbuf_addch(buf, '>');
> > +	else if (!b_util)
> > +		strbuf_addch(buf, '<');
> > +	else if (strcmp(a_util->patch, b_util->patch))
> > +		strbuf_addch(buf, '!');
> > +	else
> > +		strbuf_addch(buf, '=');
> > +
> > +	if (!b_util)
> > +		strbuf_addf(buf, " -:  %s", dashes->buf);
> > +	else
> > +		strbuf_addf(buf, " %d:  %s", b_util->i + 1,
> > +			    find_unique_abbrev(&b_util->oid, DEFAULT_ABBREV));
> > +
> > +	commit = lookup_commit_reference(oid);
> 
> This bit surprised me slightly.  May be worth mentioning that we now
> also show the first line of the commit message here.

Right...

> 
> > +	if (commit) {
> > +		const char *commit_buffer = get_commit_buffer(commit, NULL);
> > +		const char *subject;
> > +
> > +		find_commit_subject(commit_buffer, &subject);
> > +		strbuf_addch(buf, ' ');
> > +		format_subject(buf, subject, " ");
> > +		unuse_commit_buffer(commit, commit_buffer);
> 
> I think the above could be written slightly shorter as
> 
>     strbuf_addch(buf, ' ');
>     pp_commit_easy(CMIT_FMT_ONELINE, commit, &buf);

I guess so. I shied away from the pretty-printing machinery because last
time I tried to use it in a libified manner I had to put in a major fight
to get the code into git.git. But I guess that was because of a user
format (which uses global state, something I still would like to fix, but
that fight just cost me too much time), which is not the case here.

> Not sure if it's worth changing this at this stage of the series
> though, or if there is something in the above that I'm missing, that
> would make the shorter version not workable.

I think your version is not only shorter, but also possibly safer.

Ciao,
Dscho
