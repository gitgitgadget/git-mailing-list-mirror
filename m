Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1739C636CC
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 02:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjBPCP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 21:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBPCP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 21:15:56 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5882007D
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 18:15:55 -0800 (PST)
Received: (qmail 19663 invoked by uid 109); 16 Feb 2023 02:15:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Feb 2023 02:15:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21440 invoked by uid 111); 16 Feb 2023 02:15:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Feb 2023 21:15:54 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Feb 2023 21:15:54 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Rafael Dulfer <rafael@dulfer.be>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Rafael Dulfer <rafael.dulfer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] rev-list: clarify git-log default date format
Message-ID: <Y+2R2qIVQG9hJpEA@coredump.intra.peff.net>
References: <20230201155712.86577-1-rafael@dulfer.be>
 <xmqq5ycl1c6h.fsf@gitster.g>
 <230201.864js5q9sv.gmgdl@evledraar.gmail.com>
 <xmqqy1phxabi.fsf@gitster.g>
 <d9fc8688-bbf1-96c2-07bf-a12fe38625a9@dulfer.be>
 <xmqqfsbovy7u.fsf@gitster.g>
 <xmqqsffouhys.fsf@gitster.g>
 <xmqqcz6av3ta.fsf_-_@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcz6av3ta.fsf_-_@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2023 at 04:42:25PM -0800, Junio C Hamano wrote:

> The documentation mistakenly said that the default format was
> similar to RFC 2822 format and tried to specify it by enumerating
> differences, which had two problems:
> 
>  * There are some more differences from the 2822 format that are not
>    mentioned; worse yet
> 
>  * The default format is not modeled after RFC 2822 format at all.
>    As can be seen in f80cd783 (date.c: add "show_date()" function.,
>    2005-05-06), it is a derivative of ctime(3) format.
> 
> Stop saying that it is similar to RFC 2822, and rewrite the
> description to explain the format without requiring the reader to
> know any other format.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  * The discussion stalled and the topic was left in limbo for a few
>    weeks.  Let's attempt to reboot it instead of silently waiting
>    for a rerolled version from the original author.

Thanks for keeping this moving. The proposed text looks great to me.

-Peff
