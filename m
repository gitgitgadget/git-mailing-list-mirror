Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F86C1F6DC
	for <e@80x24.org>; Wed,  1 Feb 2017 19:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752752AbdBATwC (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 14:52:02 -0500
Received: from mail-lf0-f51.google.com ([209.85.215.51]:35806 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752568AbdBATwB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 14:52:01 -0500
Received: by mail-lf0-f51.google.com with SMTP id n124so233860257lfd.2
        for <git@vger.kernel.org>; Wed, 01 Feb 2017 11:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LHaSS6FK7ox4F2ZIJt1JEWOljHiifer6bBK5CoR+LD0=;
        b=MqLO9S15FareuCCfBQoOp60QMJzI1UfYc79cTEq2GBfegK5vZ2TQKWVE55+ryPw8ET
         sfqta7WIh69UNq5UPSZnWEaWQj0rMlonevycTTrO/1EGgehIX+N60y0TJ8p1lAbod4+x
         fxKnaiAYGPMj8tKir0ge2jmyGYcBgREJas3DWdDVGl2AHaM9DuFBhu1FQZQ8KRM6VDkh
         eJvCH8w1cNY7G4yHybjl09PygV+76nayVG588/DMyAl1jjqAFEXAPs12CcFjX8X2URxd
         cj3nu+dIrtHwXauuFafewKCYTjRXs8cUTDmblXzgw5xZ1PcvRm+Uv63TG9hdxwHMV7yN
         Gpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LHaSS6FK7ox4F2ZIJt1JEWOljHiifer6bBK5CoR+LD0=;
        b=lQ1vXvdRdnOIChH2cvvDsgzv7bNXAVen2uGtTmvXIvEoWAdBRHqmTesAPcbRLUhQmh
         98c4FREGLZVrkOsj8BLaNypG/H9lhtUZYIy1sI2z2QZKklmabr5aC0pgASt0Bsh3LFEp
         O0l0+SfZZTvzQ7TnvZ2Kq4Fq7GalGLXRHdGVGdy912Vp9z71tbuG2/KAgrOL0FBjr5lU
         1CYT9oyKKjf1vmneAxLsFoxNIWg2exCFD/bIYe683KEWQzRLVtyYls6mKYYftRs4vhB7
         163Hni1eSOec1crAmAZFE8WyGYJdcWl3kZSMoqemFVY00G24qi9AZRMnCBwTncrgUi70
         4QuA==
X-Gm-Message-State: AIkVDXL5nXOODKCmPhwVB21tNK0k++sC0N2USOgHoNaNdzNYtLO/SDqs2uQcTrNyTJfz9k9uUcxqzcGL829jXA==
X-Received: by 10.25.16.77 with SMTP id f74mr1519880lfi.81.1485978719934; Wed,
 01 Feb 2017 11:51:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.199.13 with HTTP; Wed, 1 Feb 2017 11:51:59 -0800 (PST)
In-Reply-To: <20170131005900.fo5qnbsb67rzgnjt@sigill.intra.peff.net>
References: <20170131004804.p5sule4rh2xrgtwe@sigill.intra.peff.net> <20170131005900.fo5qnbsb67rzgnjt@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 1 Feb 2017 20:51:59 +0100
Message-ID: <CAP8UFD3NE65Uy1kWMCNrpC05Fs_WY=g7K2NmMcab6CGUy4c8LA@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git Merge Contributor Summit topic planning
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 31, 2017 at 1:59 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Jan 31, 2017 at 01:48:05AM +0100, Jeff King wrote:
>
>> The list of topics is totally open. If you're coming and have something
>> you'd like to present or discuss, then propose it here. If you're _not_
>> coming, you may still chime in with input on topics, but please don't
>> suggest a topic unless somebody who is there will agree to lead the
>> discussion.
>
> Here are the two topics I plan on bringing:
>
>   - Git / Software Freedom Conservancy yearly report. I'll plan to give
>     a rundown of the past year's activities and financials, along with
>     some open questions that could benefit from community input.
>
>   - The git-scm.com website: who runs that thing, anyway? An overview
>     of the site, how it's managed, and what it needs.
>
> I plan to send out detailed emails on both topics to the list on
> Wednesday, and then follow-up with a summary of any useful in-person
> discussion (since obviously not everybody will be at the summit).
>
> I'd encourage anybody with a topic to present to consider doing
> something similar.

GitLab people at the Summit (this includes me) would like to spend a
few minutes to introduce https://gitlab.com/gitlab-org/gitaly/ and
answer any questions.
