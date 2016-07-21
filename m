Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ADD6203C2
	for <e@80x24.org>; Thu, 21 Jul 2016 16:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179AbcGUQDP (ORCPT <rfc822;e@80x24.org>);
	Thu, 21 Jul 2016 12:03:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:55202 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753047AbcGUQDN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2016 12:03:13 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MKYsh-1bSByo0jx9-001wbE; Thu, 21 Jul 2016 18:02:57
 +0200
Date:	Thu, 21 Jul 2016 18:02:13 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	Jeff Hostetler <git@jeffhostetler.com>,
	Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org,
	gitster@pobox.com
Subject: Re: [PATCH v1 0/6] Porcelain Status V2
In-Reply-To: <20160720205753.GC578@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1607211800080.14111@virtualbox>
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com> <20160720161543.GD24902@sigill.intra.peff.net> <578FD0B1.9030709@jeffhostetler.com> <20160720205753.GC578@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:CN1rnG7td5mxzLbL+4MoWIHSi+Z6yjn0pWpzmsCnoqJeQGeRX2m
 bndBZrIp3zU5rF96k/9jaDMx13pgh+XrVoIis8dnuQTXrAvprUT8X2AD557lrFed/GCYfqb
 AGEsoLttkndlXT83UA359CEjT+fy817bvgGuJhx/ulu7UugdIRfwPZ7FcktsjK7VOP9SMFP
 3rb+CoN4WCPST4spZ35JA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:6WolXTU+hwA=:3tvYlK/aX8j+7xBvHZOfjl
 88PiX3eYZHqwqD77/p9dzkCmhlkq25yYZV9ulxBlQpVB1gm6rFbw3EJt2Ee7d09Qqtiwm6WAC
 000caavthqegGyhWn1QfG39ESZemaGmMkdEuNn+Fag9RMkH/SvlGnL+xjYUHHDFRKd8juV0op
 md0yVGu3VROSM1IO/pupUZEusucJPJI5oX5Y10Fw6igsYZEOtIMrQlMHItlR7S5H6wV1uf0RQ
 tL9x6ke6ZXKUgLdfx7/rPlwx20aGj7GUoQam2mBwn1NHJohevArNrAEMdO36iceZoOjvRscLb
 cs+4cakzcFGFmniBAsL53QiRcrK1GvLveCYW0323jmcOaVmno7Pyz4viVbJ5gfXYq5e71Vcp2
 XGMnvlbbIF8DqqpxEGKzpN5fCBHlHr9Jtt2100GJgq7lT06kzwXkjY9vWyrvYU6/2JTH7IHMu
 qMwBupGhSC20ZeHDfI4G/04MnDblI+uf9WLZiHEjtaTEspntbMwPMT/QUQOjBaEUZd3qeMWdA
 y5n6CEG+SLzMi+T5jdopU4OfAm6tyU1cSBgn6utnvFV4M2fc1RCNNLFU/4SP7W4R3fV6rkPzh
 EKoyAjzJy2n3M7R7cnvVjM3QP60PO95KeQaASTKyvVeaneB6WnMPf5C9RgTuvVPGHblStTKrC
 gFh6al0SCS/0Bh+T/Hecox3tyuFB/0jMCgb0+xeEiVrhVi7YnJMwl6LJrtwwdp7vc6Sj+4i8I
 0AVfjMsej8C9L7j/Cq4V4C4dS+jXEDM2nx74e68ufjBxanL6MZ6nwRJbqdAZJK0dW1xRtFXqp
 5DxGt98
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Peff & Jeff ;-)

On Wed, 20 Jul 2016, Jeff King wrote:

> On Wed, Jul 20, 2016 at 03:27:45PM -0400, Jeff Hostetler wrote:
> 
> > > A totally reasonable response is "haha no. Please stop moving the
> > > goalposts". I just wanted to throw it out there as an option (and in
> > > case you are interested, to let you think about it before any more work
> > > goes into this direction).
> > 
> > haha no.... :-)
> > 
> > Short term, I'd rather nail down what I have now (both content-wise
> > and format-wise) and see how we like it.  And have a follow-up task
> > to look at the --state header we spoke of earlier.  And save the JSON
> > version as an independent task for later.
> > 
> > I understand the motivation for a JSON option (and have thought
> > about it before) but I think it ought to be kept separate.
> > At a higher-level, it seems like a JSON option would be an
> > opportunity to start a project-wide conversation about formats,
> > consistency, plumbing, and etc.  A top-down conversation if you
> > will about which commands will/won't get enhanced, legacy cruft
> > that would not need to be converted, JSON style and naming and
> > consistency issues, current best practices in the node/whatever
> > community, and etc.  I could be wrong, but this feels like a
> > top-down feature conversation in a wider audience.
> 
> I agree with everything you've said here.
> 
> If we add JSON, we'd want to do it everywhere: lists of commits, lists
> of refs, status output, etc. I mentioned that somebody had asked me
> about it recently; they are working on a git client and finding that
> libgit2 is not serving their needs well, so they'd like to shell out to
> git more, and wanted to have a standard way to get the data back in.

Yeah, if we add JSON, we would want to add it everywhere. But we would
want to add that incrementally; otherwise it would be too humongous a
task.

And I think a good way forward was already suggested elsewhere in this
thread by Jeff: --porcelain=1j, or --porcelain=json (and maybe later
json-v2, json-v3, etc).

Ciao,
Dscho
