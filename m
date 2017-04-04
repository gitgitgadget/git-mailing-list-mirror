Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 614E220966
	for <e@80x24.org>; Tue,  4 Apr 2017 08:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753016AbdDDI1u (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 04:27:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:56413 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752992AbdDDI1r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 04:27:47 -0400
Received: (qmail 15903 invoked by uid 109); 4 Apr 2017 08:27:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Apr 2017 08:27:44 +0000
Received: (qmail 4805 invoked by uid 111); 4 Apr 2017 08:28:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Apr 2017 04:28:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Apr 2017 04:27:43 -0400
Date:   Tue, 4 Apr 2017 04:27:43 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@jeffhostetler.com, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 2/4] fsck: force core.checksumindex=1
Message-ID: <20170404082743.jqdn27j6bbftvtvq@sigill.intra.peff.net>
References: <20170403185306.36164-1-git@jeffhostetler.com>
 <20170403185306.36164-3-git@jeffhostetler.com>
 <CACBZZX7DFuLia8RzB908EG7+oWQiFGkFEq14bzT77A75msM98Q@mail.gmail.com>
 <20170404022945.nmadthjzovmjplyb@sigill.intra.peff.net>
 <CACBZZX50+Mpj-GY11KNmh+BkNkWCX3OZjHFQ3iK8c8Hib90_Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX50+Mpj-GY11KNmh+BkNkWCX3OZjHFQ3iK8c8Hib90_Xg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 04, 2017 at 10:23:52AM +0200, Ævar Arnfjörð Bjarmason wrote:

> The part that confused my & I found unintuitive is that there's a new
> core.WHATEVER config that'll get silently overridden by a specific
> command, git-fsck.
> 
> Nothing else I can think of in core.* works like this, i.e. it's a
> namespace for "applies to all of git", core.editor, core.ignoreCase
> etc.
> 
> Having git-fsck have a command-line option that's on by default as I
> suggested is one way to get out of that confusion. It makes it a
> special case of a CLI option overriding some config.

Yeah, I do agree your suggestion makes it slightly less confusing.

I mostly just think we can avoid the situation altogether, which IMHO is
preferable.

-Peff
