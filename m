Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA09C3DA66
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 19:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238271AbjHWTDj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 15:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236070AbjHWTDS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 15:03:18 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB09E6A
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 12:03:16 -0700 (PDT)
Received: (qmail 2993 invoked by uid 109); 23 Aug 2023 19:03:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 23 Aug 2023 19:03:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10946 invoked by uid 111); 23 Aug 2023 19:03:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 23 Aug 2023 15:03:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 23 Aug 2023 15:03:15 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Santiago <taylorsantiago@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] Fix the order of consuming unpackLimit config
 settings.
Message-ID: <20230823190315.GB2355007@coredump.intra.peff.net>
References: <20230817215325.2550998-1-taylorsantiago@google.com>
 <20230817215325.2550998-2-taylorsantiago@google.com>
 <20230821203051.GA1800481@coredump.intra.peff.net>
 <xmqqttsrn9l2.fsf@gitster.g>
 <xmqqpm3eh7f6.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpm3eh7f6.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 22, 2023 at 06:30:21PM -0700, Junio C Hamano wrote:

> This time, what I am sending is not a squashable patch, but the
> whole thing as a single patch.
> 
> ------- >8 ------------- >8 ------------- >8 -------
> Subject: transfer.unpackLimit: fetch/receive.unpackLimit takes precedence

Thanks, this looks fine to me.

-Peff
