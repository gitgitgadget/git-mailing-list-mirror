Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFE4F2027C
	for <e@80x24.org>; Mon, 29 May 2017 10:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750909AbdE2K75 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 06:59:57 -0400
Received: from mout.gmx.net ([212.227.17.22]:54637 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750885AbdE2K74 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 06:59:56 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MBZ9u-1d70PP1FCA-00AVOF; Mon, 29
 May 2017 12:59:37 +0200
Date:   Mon, 29 May 2017 12:59:34 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Liam Beguin <liambeguin@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 02/10] rebase -i: generate the script via
 rebase--helper
In-Reply-To: <20170526031516.26287-1-liambeguin@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1705291256430.3610@virtualbox>
References: <e173445d9a6321f80053967e50375400c0a61764.1493414945.git.johannes.schindelin@gmx.de> <20170526031516.26287-1-liambeguin@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ImVnn8wye8BZB1G7DT1eXBE5RagGzIPGqEW9fNtOKUAdVIEyM/l
 FZ8D1SHmCyJ/Tq1Uj3fsrmjdlq7SueoGNYYavoAvd4PrWEHNjY0q+iYkbXQW18Lv4TVLDhw
 TW+NVNDkpFbxFbPOp/KGrHXwc8K1ES8UhdUGJtd8YMsgaw7nTQuA1c+CFhJlUHG8mhvtUYX
 RfuwhYfKLli7lmR4huJ7w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BDR7YAwskBE=:YDtwXnHpN00NaHXSGFdr19
 VE6zkPbj1ngFns6mTrKht8V1p+0FlXqFS/3Up3LS66Z1/ddX/UbgRapmilnaZL4mjnBEr8lJe
 IWm3uOViYaFD17HjSFrfTYr5HJkOmyh5T1B6qykMKFFEjSIAQx8UlHF9pIsHnyNXu6iSVypQo
 CDx4DlKqNep2rIAEOgZOqoWjZryy8YtgjxIX9/4IJf5x6yiutanUTmiFbLnZ4X8TYsCAUdSxP
 SNepUFp4ftsHGp1Y3iIB2BHPYQyuBf/e6Pl63fGYwKCYzxMNhsMxqzBEi6xrEklIhbKTfAFjD
 zQN8y23ihld35jfU5fx4l8dvUJs5HrtguDeQTXaa7ngc8K8xUB1EKBUfFg/7wKklXRdITs9T7
 2U97JgeDSJNNTtf3vMONzibi9i0X1b3uNvWn3VOk7ieXDLhalXEaPVJ37Sz/s7OfSGhuqXPgY
 U5Nn1UPckVhCo+skKFn6M+U/cZF1r838Tz7FcHQYgjjUyHs5l0auuWFyx3neRdugfsNnyXC5l
 mydj9m/KxmjZpbs0DF+fNIIuV147hS7FNIElK5lZ6yNhI/DWQr6eT98CzM3FPDbbVqGn+XsgU
 gGvAvFO+9wAfQ1dsnLAP+dup07S4h6Wqwgy+zpB7NPwKDhRG5kdpFNARzIjq1qrb+65eDnGlT
 Ypth2Vd6Xvz7CbY0CP4ktm95u7pWFblvenv85z1Qxq39YYX7ZpQDmbbwpb07kRHInaYzDHjhx
 1aI0RKaMUqUATyNI/wTRpuBi0/WItCS55TzMuLIN4Nclyz4/QrnwFgx+FwV1cFrqwuJagfM7q
 mybkicL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Liam,

On Thu, 25 May 2017, Liam Beguin wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>
> > diff --git a/sequencer.c b/sequencer.c
> > index 130cc868e51..88819a1a2a9 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -2388,3 +2388,52 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
> >  
> >  	strbuf_release(&sob);
> >  }
> > +
> > +int sequencer_make_script(int keep_empty, FILE *out,
> > +		int argc, const char **argv)
> > +{
> > +	char *format = NULL;
> > +	struct pretty_print_context pp = {0};
> > +	struct strbuf buf = STRBUF_INIT;
> > +	struct rev_info revs;
> > +	struct commit *commit;
> > +
> > +	init_revisions(&revs, NULL);
> > +	revs.verbose_header = 1;
> > +	revs.max_parents = 1;
> > +	revs.cherry_pick = 1;
> > +	revs.limited = 1;
> > +	revs.reverse = 1;
> > +	revs.right_only = 1;
> > +	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
> > +	revs.topo_order = 1;
> > +
> > +	revs.pretty_given = 1;
> > +	git_config_get_string("rebase.instructionFormat", &format);
> > +	if (!format || !*format) {
> > +		free(format);
> > +		format = xstrdup("%s");
> > +	}
> > +	get_commit_format(format, &revs);
> > +	free(format);
> > +	pp.fmt = revs.commit_format;
> > +	pp.output_encoding = get_log_output_encoding();
> > +
> > +	if (setup_revisions(argc, argv, &revs, NULL) > 1)
> > +		return error(_("make_script: unhandled options"));
> > +
> > +	if (prepare_revision_walk(&revs) < 0)
> > +		return error(_("make_script: error preparing revisions"));
> > +
> > +	while ((commit = get_revision(&revs))) {
> > +		strbuf_reset(&buf);
> > +		if (!keep_empty && is_original_commit_empty(commit))
> > +			strbuf_addf(&buf, "%c ", comment_line_char);
> 
> I've never had to use empty commits before, but while testing this, I
> noticed that `git rebase -i --keep-empty` behaves differently if using
> the --root option instead of a branch or something like 'HEAD~10'.
> I also tested this on v2.13.0 and the behavior is the same.

FWIW the terminology "empty commit" is a pretty poor naming choice. This
is totally not your fault at all. I just wish we had a much more intuitive
name to describe a commit that does not introduce any changes to the tree.

And yes, doing this with --root is a bit of a hack. That's because --root
is a bit of a hack.

I am curious, though, as to the exact differences you experienced. I mean,
it could be buggy behavior that needs to be fixed (independently of this
patch series, of course).

Ciao,
Johannes
