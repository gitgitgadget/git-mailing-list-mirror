Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FF4020802
	for <e@80x24.org>; Thu, 22 Jun 2017 23:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753957AbdFVXV7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 19:21:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:49638 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753649AbdFVXV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 19:21:58 -0400
Received: (qmail 31308 invoked by uid 109); 22 Jun 2017 23:21:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Jun 2017 23:21:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7128 invoked by uid 111); 22 Jun 2017 23:22:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Jun 2017 19:22:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Jun 2017 19:21:56 -0400
Date:   Thu, 22 Jun 2017 19:21:56 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Simon Ruderich <simon@ruderich.org>,
        Patrick Lehmann <Patrick.Lehmann@plc2.de>,
        Jessie Hernandez <git@jessiehernandez.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: your mail
Message-ID: <20170622232156.vptuoafdtglokujw@sigill.intra.peff.net>
References: <7c277ac1cfb40b9b362d468a94dfb4fe.squirrel@mail.jessiehernandez.com>
 <20170622124803.45sduodpfbwuuq52@ruderich.org>
 <0092CDD27C5F9D418B0F3E9B5D05BE080102A3D5@SBS2011.opfingen.plc2.de>
 <20170622134708.fcc4zxakga6p255x@ruderich.org>
 <0092CDD27C5F9D418B0F3E9B5D05BE080102A423@SBS2011.opfingen.plc2.de>
 <20170622204628.eintlap4uchlncub@ruderich.org>
 <xmqq8tkjiu3d.fsf@gitster.mtv.corp.google.com>
 <878tkjk7m7.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878tkjk7m7.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2017 at 11:58:08PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Which, in the context of what this follows (how to submit a bug,
> questions etc.) isn't a good use of time for the person reading the
> instructions.
> 
> Maybe something more like:
> 
> diff --git a/README.md b/README.md
> index f17af66a97..dc175757fa 100644
> --- a/README.md
> +++ b/README.md
> @@ -36,6 +36,12 @@ the body to majordomo@vger.kernel.org. The mailing list archives are
>  available at <https://public-inbox.org/git/>,
>  <http://marc.info/?l=git> and other archival sites.
> 
> +You don't need to be subscribed to the list to send mail to it, and
> +others on-list will generally CC you when replying (although some
> +forget this). It's adviced to subscribe to the list if you want to be
> +sure you're not missing follow-up discussion, or if your interest in
> +the project is wider than a one-off bug report, question or patch.
> +
>  The maintainer frequently sends the "What's cooking" reports that
>  list the current status of various development topics to the mailing
>  list.  The discussion following them give a good reference for

You perhaps already read it, but you may want to steal wording or
suggestions from the mailing list section at:

  https://git-scm.com/community

which is covering the same ideas (and vice versa, patches to that page
are welcome if the README says something better).

-Peff
