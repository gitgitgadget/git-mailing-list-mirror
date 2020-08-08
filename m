Return-Path: <SRS0=OIeF=BS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC2FC433E0
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 00:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2B2E221E2
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 00:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgHHAfC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 20:35:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:52492 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgHHAfC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 20:35:02 -0400
Received: (qmail 3699 invoked by uid 109); 8 Aug 2020 00:35:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 08 Aug 2020 00:35:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19608 invoked by uid 111); 8 Aug 2020 00:35:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 07 Aug 2020 20:35:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 7 Aug 2020 20:35:00 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Raymond E. Pasco" <ray@ameretat.dev>,
        =?utf-8?B?16DXotedINeh15XXnNeV15HXmdemJ9eZ16c=?= 
        <inoamsol@gmail.com>, git@vger.kernel.org
Subject: Re: Why is AuthorDate displayed on git-blame?
Message-ID: <20200808003500.GA3751874@coredump.intra.peff.net>
References: <C4PPV24G8ZNK.3IYI2MQ3A262Y@ziyou>
 <xmqq1rkjljus.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1rkjljus.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 06, 2020 at 11:17:31AM -0700, Junio C Hamano wrote:

> "Raymond E. Pasco" <ray@ameretat.dev> writes:
> 
> > Perhaps the following
> > adaptation:
> >
> > --first-parent::
> > 	Follow only the first parent commit upon seeing a merge
> > 	commit. This option can be used to determine when a line
> > 	was introduced to a particular integration branch, rather
> > 	than when it was introduced to the history overall.
> 
> Yup.  We somehow forgot to document it when we did 95a4fb0e (blame:
> handle --first-parent, 2015-09-15).  The text reads well.

My fault. I think I imagined it would just be included along with other
rev-list options, but the text above makes it clear why we'd want to
talk specifically about how it applies to blame.

-Peff
