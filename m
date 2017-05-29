Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9CC92027C
	for <e@80x24.org>; Mon, 29 May 2017 10:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751107AbdE2KyN (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 06:54:13 -0400
Received: from mout.gmx.net ([212.227.17.22]:57652 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750885AbdE2KyM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 06:54:12 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M2WgT-1e6hg72e97-00sOwW; Mon, 29
 May 2017 12:54:02 +0200
Date:   Mon, 29 May 2017 12:54:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 02/10] rebase -i: generate the script via
 rebase--helper
In-Reply-To: <xmqq60gk8ad5.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1705291252080.3610@virtualbox>
References: <cover.1493207864.git.johannes.schindelin@gmx.de> <cover.1493414945.git.johannes.schindelin@gmx.de> <e173445d9a6321f80053967e50375400c0a61764.1493414945.git.johannes.schindelin@gmx.de> <xmqq60gk8ad5.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+ZXYPTas96vn1Tdnm9z6Wb+goTlA+HZJBmdiHziw6ylQZqUQljb
 nt0Le71do/iwt6tSJBycV+YrplvmJqa+OV63YR6YA8IXCskKtmN/OX6E4OQJHVCnXbMusVV
 3LDGnhfTc3DRzrCDk1g7VJaXGmIg7Q6yF//E9roQbe1nryE3jU2Ldmq8R5+DVjjncoAaww9
 q6SFG8TAGZuQ4X/GGTXVg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sRaZ4CT8nSU=:kvNzh6AI43ndv94y0uYhCy
 ZsX8WahkRly+Yd68rOVg4DoymaY/fJ/k5KRoVbK0i0mFoWOvW+YopA/FtOEfmhvGQUbN2Vjeh
 kZfSAOesLpO6muQPEqgLRvKdunYRs/aABXTGKKisxHl+EilnhVbpILXxB+SA2+npb2B/Y63q4
 WIDdtK6Zt/LTx+3rny1F8gdcXH2HtHbaGr0JwGwIMLUrDrTfNMOZKKtCBfMCbUtW+do3zfP1L
 edOv/Gn0vUkmv1ARZi2GyYPapuzCeE1kqp1PCHY/TjIOO2uQuWbJkRjYS/excYza1JHC6TQ82
 57Nqtrw5GjzsZ5t5m5IuJhzvxBAX67AJ32neZu/S70CCzPRBnkBH8ekW+FD2r99FyjdBqnPd3
 Onu9nDoIUzWCc1o0jp3KBjAecE5kVIgVIxGhtOOQpC2iCamxzklNoZ3nBf5rs7pO3EdhaAfFt
 z+MHQan+JwOxlOvjYPMIyu1vBSVFm27GGhgw099iPyyjFeDCBAzGhuSuSNmlSYtObKtPf57Nh
 nv+H2zH1pe1vMmR37WQEaMlnLip2gB3Z32bGgwf+R8eXGsKpw3DJMwgIp/qGyndDx6Yb/9BkE
 luBN++l5d7NGCk5oSu1ik6sLBTj3JA+TH3IFqy5zFmuOMA/+dU5I4dnlNb0d9cJHDpe7weCRx
 EvmQjdgT0EOTMTnsp7MfnZgE8wrtqF0EbDTJPparWwunVoNZ/oAFKmjRpAdUzmwZT6RyHQG9A
 gkVPGxoO0c9kn5MzKDdDzswqgE94ry0x+bt8zS93nuMjMXj0dDEe7iUuCmVRQyJzshVX2xiPp
 Ovk/Ey+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 29 May 2017, Junio C Hamano wrote:

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
> 
> cf. <xmqq4lx5i83q.fsf@gitster.mtv.corp.google.com>
> 
> This is still futzing below the API implementation detail
> unnecessarily.

You still ask me to pass options in plain text that has to be parsed at
run-time, rather than compile-time-verifiable flags.

I am quite puzzled that you keep asking me to make my code sloppy.

Ciao,
Dscho
