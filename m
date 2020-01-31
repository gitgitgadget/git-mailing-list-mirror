Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE36C2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 00:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FBC22067C
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 00:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbgAaAPh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 19:15:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:49204 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727640AbgAaAPg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 19:15:36 -0500
Received: (qmail 9898 invoked by uid 109); 31 Jan 2020 00:15:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 31 Jan 2020 00:15:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28521 invoked by uid 111); 31 Jan 2020 00:23:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Jan 2020 19:23:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 30 Jan 2020 19:15:35 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David =?utf-8?B?QnVyc3Ryw7Zt?= <davidburstrom@spotify.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] sha1-name: mark get_oid() error messages for
 translation
Message-ID: <20200131001535.GC2394563@coredump.intra.peff.net>
References: <20200125000542.GA566779@coredump.intra.peff.net>
 <20200125001301.GC567109@coredump.intra.peff.net>
 <xmqqpnf2dk6m.fsf@gitster-ct.c.googlers.com>
 <xmqqimkudjmt.fsf@gitster-ct.c.googlers.com>
 <20200130071700.GB2189233@coredump.intra.peff.net>
 <xmqqeevgdabm.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeevgdabm.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 30, 2020 at 11:16:13AM -0800, Junio C Hamano wrote:

> Yes.  The final amend to 3/3 has become like this.
> [...]

Perfect, thanks for fixing my mistake.

-Peff
