Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3745EC47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 07:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A1FB6127A
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 07:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhFHH2F (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 03:28:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:48728 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhFHH2E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 03:28:04 -0400
Received: (qmail 28599 invoked by uid 109); 8 Jun 2021 07:26:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Jun 2021 07:26:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7404 invoked by uid 111); 8 Jun 2021 07:26:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Jun 2021 03:26:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Jun 2021 03:26:11 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <ttaylorr@github.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] t: use user-specified utf-8 locale for testing svn
Message-ID: <YL8bk5f4Xu91xwIL@coredump.intra.peff.net>
References: <20210602114646.17463-1-congdanhqx@gmail.com>
 <20210608065628.23767-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210608065628.23767-1-congdanhqx@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 08, 2021 at 01:56:28PM +0700, Đoàn Trần Công Danh wrote:

>  New in v5: fix a regression when LC_ALL or LANG set to something that not
>  ends with utf-8, e.g. "C", "locale -a" will be ignored completely.
> 
>  Thanks to Peff's comment, I didn't notice this regression earlier.

Doh, I totally missed that, too. I'm glad my comment was helpful in that
respect, at least. :)

Your fix here looks good.

-Peff
