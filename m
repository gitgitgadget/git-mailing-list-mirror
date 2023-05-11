Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F29C77B7D
	for <git@archiver.kernel.org>; Thu, 11 May 2023 01:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjEKB0G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 21:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236375AbjEKB0C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 21:26:02 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6498759F2
        for <git@vger.kernel.org>; Wed, 10 May 2023 18:26:00 -0700 (PDT)
Received: (qmail 19483 invoked by uid 109); 11 May 2023 01:25:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 May 2023 01:25:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3251 invoked by uid 111); 11 May 2023 01:25:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 May 2023 21:25:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 10 May 2023 21:25:58 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] diff: fix interaction between the "-s" option and
 other options
Message-ID: <20230511012558.GA1464167@coredump.intra.peff.net>
References: <xmqqfs8bith1.fsf_-_@gitster.g>
 <20230505165952.335256-1-gitster@pobox.com>
 <645995f53dd75_7c6829483@chronos.notmuch>
 <xmqqsfc62t8y.fsf@gitster.g>
 <6459c31038e81_7c68294ee@chronos.notmuch>
 <xmqqjzxgzua0.fsf@gitster.g>
 <645c25dcb590b_7b63e294ea@chronos.notmuch>
 <645c2bc57fdd0_7c6152945e@chronos.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <645c2bc57fdd0_7c6152945e@chronos.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 10, 2023 at 05:41:57PM -0600, Felipe Contreras wrote:

> Felipe Contreras wrote:
> > Junio C Hamano wrote:
> 
> > > And it led to unproductive and irritating waste of time number of times, and
> > > eventually you were asked to leave the development community for at least a
> > > few times.
> > 
> > That is blatantly false. As a member of Git's Project Leadership Committee, you
> > should know precisely how many times the committee has excercised this power,
> > and it hasn't been "a few times", it has been one time.
> 
> And for the record: that one time I was asked by the committee to not interact
> with certain members of the community for a few months.
> 
> The amount of times I was asked to "leave the development community" is *zero*.

You're right, in the sense that the first time you were asked to leave
we did not have a CoC, and nor was the PLC expected to be part of such
conversations at that time. Likewise, many times during which your
behavior has been a problem on the list, people did not ask you to
leave, but simply said "I am not going to read your messages anymore".

For example, here's Junio asking you to leave in 2013:

  https://lore.kernel.org/git/7vsj0lvs8f.fsf@alter.siamese.dyndns.org/

Here's him explaining a few months later why your patches aren't getting
reviewed:

  https://lore.kernel.org/git/xmqqtxgjg35a.fsf@gitster.dls.corp.google.com/

Here's me addressing complaints about your behavior half a year after
that:

 https://lore.kernel.org/git/20140514202646.GE2715@sigill.intra.peff.net/

    That last one has some gmane links; if anyone truly wants to follow
    them (and I don't recommend that as being worth your time), the lore
    equivalents are:

      https://lore.kernel.org/git/20140425191236.GA31637@sigill.intra.peff.net/

      https://lore.kernel.org/git/480ACEB0-7629-44DF-805F-E9543E66241B@quendi.de/

      https://lore.kernel.org/git/7vfvl0htys.fsf@alter.siamese.dyndns.org/

      https://lore.kernel.org/git/20140502223612.GA11374@sigill.intra.peff.net/

I'm sure you will find reason to argue with all of that. But I think the
spirit of "it led to an unproductive and irritating waste of time a
number of times" is accurate. And this thread is one more example.

You can feel free to respond if you want to; I'm not planning to
participate further in this thread (and in case you were not aware, I'm
not on the PLC any more). I just didn't want Junio to think he was alone
in his view of the situation.

-Peff
