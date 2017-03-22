Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D35D520323
	for <e@80x24.org>; Wed, 22 Mar 2017 21:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751153AbdCVVKK (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 17:10:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:49651 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750867AbdCVVKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 17:10:09 -0400
Received: (qmail 25560 invoked by uid 109); 22 Mar 2017 21:10:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Mar 2017 21:10:07 +0000
Received: (qmail 31165 invoked by uid 111); 22 Mar 2017 21:10:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Mar 2017 17:10:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Mar 2017 17:10:03 -0400
Date:   Wed, 22 Mar 2017 17:10:03 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org,
        Jan Palus <jan.palus@gmail.com>
Subject: Re: [PATCH 3/3] t7004, t7030: fix here-doc syntax errors
Message-ID: <20170322211003.b52cql3iwig2xqcd@sigill.intra.peff.net>
References: <20170322173528.ho43ulndlozq35tu@kalarepa>
 <20170322200805.23837-1-gitster@pobox.com>
 <20170322200805.23837-4-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170322200805.23837-4-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2017 at 01:08:05PM -0700, Junio C Hamano wrote:

> From: Jan Palus <jan.palus@gmail.com>
> 
> These all came as part of an earlier st/verify-tag topic that was
> merged to 2.12.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * This should be applied on top of 4fea72f4 ("t/t7004-tag: Add
>    --format specifier tests", 2017-01-17)
> 
>  t/t7004-tag.sh        | 8 ++++----
>  t/t7030-verify-tag.sh | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)

Like 2/3, this one also produces test failures for me. It looks like
"verify-tag" does not show a tag which has been forged. I'm not sure if
that's intentional (and the test is wrong) or a bug.  +cc Santiago

-Peff
