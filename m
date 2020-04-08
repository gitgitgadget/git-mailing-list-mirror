Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77331C2BA16
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 03:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562F72076D
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 03:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgDHD5r (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 23:57:47 -0400
Received: from aibo.runbox.com ([91.220.196.211]:38088 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbgDHD5q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 23:57:46 -0400
Received: from [10.9.9.203] (helo=mailfront21.runbox)
        by mailtransmit03.runbox with esmtp (Exim 4.86_2)
        (envelope-from <me@pluvano.com>)
        id 1jM1qR-0002H7-Jm; Wed, 08 Apr 2020 05:57:43 +0200
Received: by mailfront21.runbox with esmtpsa  [Authenticated alias (964124)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1jM1qL-0001Hh-TE; Wed, 08 Apr 2020 05:57:38 +0200
Date:   Wed, 8 Apr 2020 03:57:20 +0000
From:   Emma Brooks <me@pluvano.com>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] format-patch: teach --no-q-encode-headers
Message-ID: <20200408035720.GA25740@pluvano.com>
References: <20200405231109.8249-1-me@pluvano.com>
 <20200407051745.44390-1-me@pluvano.com>
 <20200407074031.GA20612@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407074031.GA20612@danh.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-07 14:40:31+0700, Danh Doan wrote:
> > +format.qEncodeHeaders::
> > +	Encode email headers that have non-ASCII characters with
> > +	"Q-encoding" for email transmission. Defaults to true.
> 
> I think have (described in RFC 2047) as same as
> --[no]-q-encode-headers belows would be better.

Agreed. I will reference it there as well.

> > +--q-encode-headers::
> > +--no-q-encode-headers::
> > +	Encode email headers that have non-ASCII characters with
> > +	"Q-encoding" (described in RFC 2047), instead of outputting the
> > +	headers verbatim. The default is set to the value of the
> > +	`format.qEncodeHeaders` configuration variable.
> 
> I find this paragraph hard to understand.
> I think:
> 
> 	If this option is omited, set to value of of ...
> 
> is easier to understand (to me, at least).

OK, I will simplify the language in v3.
