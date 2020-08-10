Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866F3C433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 10:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 716FF20734
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 10:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgHJKAk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 06:00:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:53896 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgHJKAk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 06:00:40 -0400
Received: (qmail 20287 invoked by uid 109); 10 Aug 2020 10:00:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 10 Aug 2020 10:00:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4220 invoked by uid 111); 10 Aug 2020 10:00:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Aug 2020 06:00:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 Aug 2020 06:00:38 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] extend --abbrev support to diff-patch format
Message-ID: <20200810100038.GB37030@coredump.intra.peff.net>
References: <cover.1596887883.git.congdanhqx@gmail.com>
 <xmqqd03zej8w.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqd03zej8w.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 09, 2020 at 12:01:35PM -0700, Junio C Hamano wrote:

> Đoàn Trần Công Danh  <congdanhqx@gmail.com> writes:
> 
> > Đoàn Trần Công Danh (2):
> >   revision: differentiate if --no-abbrev asked explicitly
> >   diff: extend --abbrev support to diff-patch format
> 
> It was not clear, at least to me at all, what these patches are
> trying to achieve (i.e. what end-users appreciate) until I saw the
> code change X-<.
> 
> The changes to fill_metainfo() make sense to me.  It just needs log
> messages that explain the intent better.  They do not even make it
> clear that they want to make the abbreviation length of the object
> names on the "index $from..$to $mode" lines configurable.

After reading the original including cover letter, I'm still confused
using why --full-index is not the solution for most cases. Perhaps that
would be worth touching on, as well.

-Peff
