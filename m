Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972ECC6FD1F
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 17:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjCVRpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 13:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjCVRpG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 13:45:06 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7450F67818
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 10:44:41 -0700 (PDT)
Received: (qmail 10617 invoked by uid 109); 22 Mar 2023 17:44:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Mar 2023 17:44:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15967 invoked by uid 111); 22 Mar 2023 17:44:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Mar 2023 13:44:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Mar 2023 13:44:33 -0400
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <nasamuffin@google.com>
Cc:     Sjur Moshagen <sjurnm@mac.com>, git@vger.kernel.org
Subject: Re: BUGREPORT: Modified files on a fresh clone on M2 MacBook Pro
Message-ID: <20230322174433.GA11532@coredump.intra.peff.net>
References: <593742E7-F0FC-471C-AFF5-1E855A3788B0@mac.com>
 <CAJoAoZkKTGzgVyL2wM9a4VcFObx4YpjMSatH9Bpqcgyi=zzBrQ@mail.gmail.com>
 <20230322173351.GC4296@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230322173351.GC4296@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2023 at 01:33:51PM -0400, Jeff King wrote:

> On Wed, Mar 22, 2023 at 09:46:11AM -0700, Emily Shaffer wrote:
> 
> > On Wed, Mar 22, 2023 at 9:38 AM Sjur Moshagen <sjurnm@mac.com> wrote:
> > >
> > > Thank you for filling out a Git bug report!
> > > Please answer the following questions to help us understand your issue.
> > >
> > > What did you do before the bug happened? (Steps to reproduce your issue)
> > > git clone https://github.com/giellalt/lang-sma
> > >
> > > What did you expect to happen? (Expected behavior)
> > > Clone to be clean, as reported by git status
> > >
> > > What happened instead? (Actual behavior)
> > > git status reported four changed files
> > 
> > It would help to know which files, or what the difference was, so we
> > have a chance to figure out what happens without having to go and buy
> > a Macbook :)
> 
> Just a guess, but it probably has to do with Unicode normalization.

Heh. After reading the other response in this thread, I could not have
been further from the truth. :) Sorry for the noise.

-Peff
