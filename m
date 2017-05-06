Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F7A8207F8
	for <e@80x24.org>; Sat,  6 May 2017 21:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752144AbdEFVGS (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 17:06:18 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:32928 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbdEFVGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2017 17:06:16 -0400
Received: by mail-io0-f176.google.com with SMTP id p24so32768084ioi.0
        for <git@vger.kernel.org>; Sat, 06 May 2017 14:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JS7aCKFzsAnp27sm7+4Fu+9ESkq+OluuX6U3OyURmY8=;
        b=lOaYkxew1AZlihzSYtvcndlIVdEgtrgi2KB+8GDhLrzoWYRUCapZeqrG/pN5/cT7+N
         M9D6oqaT3FXgp2qUWVs42582CInfmgjraB+XXE/OiNBLkD4H4AFjQ9hTc7++F94Ogwti
         KgBOVEybmqN4RveHQLGwLBBmVz2wA7FwaOpKFP6/dQ9dezB1CQGNRaufQ0kfBmtMfsOa
         WKt3HOr+87x80TzU4njoFRPcfzHUl5C4wiT/3EwXS3KLYLcBuDs2hvYQq1jcPgX1FhrU
         VpFAnCdRj180QvhiwJ3r8Hc8Vp4JhivZGVTa8oCvWapuBsUnL8X/dwyYq73OW9bjxSJD
         NYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JS7aCKFzsAnp27sm7+4Fu+9ESkq+OluuX6U3OyURmY8=;
        b=l8ygf7f8Efd9VzoXhdjYZyY+OM/PsGDIDAqUVHAwwzblJt7DDKqjJcqt4hJskDSCS2
         4lGpw1LSaD/tSAyIUGVQFBFMOirorOEK1fBgCedt61EYZYaJcxs6ddZUvaM1e8uYVM30
         uP4c9XncprOLDWHbuAu+anxmsuFWiG1vVhFTWMmSNEpUmHcxJMD+yWRNTtbWrDORoEHw
         QF/7XJBQYm2ZL2YjauGjbEbv54vVfzAZ94kCfBD2QUwOuXXO8s72EXVWAjqzE1q2qGGI
         PCoiWr01z/W0YVgkdOLd97RNA856r2mfP9E4GPhSHzj2wWitndl8tt6b/4kiA4m/19zc
         kydA==
X-Gm-Message-State: AN3rC/7lr1harywPElsiSOdSdrHlcq03W4uIgF0Yjw3d3L92hF/rtH3g
        ms0pwhILQnuGXrq1/Lz/LdSGdIaxKA==
X-Received: by 10.107.138.9 with SMTP id m9mr50461750iod.80.1494104775309;
 Sat, 06 May 2017 14:06:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Sat, 6 May 2017 14:05:54 -0700 (PDT)
In-Reply-To: <20170506205041.GA26189@starla>
References: <v26esrmyqyqykypjs75fx2vy.1494092763967@email.android.com>
 <CAJZjrdWYDMFHRrbeFk89p+GebLpWJBUQfnpC6w87aVh8czL5_w@mail.gmail.com> <20170506205041.GA26189@starla>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 6 May 2017 23:05:54 +0200
Message-ID: <CACBZZX42rhmrq8z0u1aRXw87oT22YywwnaFHUMjDYgtE_i56nw@mail.gmail.com>
Subject: Re: vger not relaying some of Junio's messages today?
To:     Eric Wong <e@80x24.org>
Cc:     Samuel Lijin <sxlijin@gmail.com>,
        Jonathan Tirado <tiradojonathan32@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        meta@public-inbox.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 6, 2017 at 10:50 PM, Eric Wong <e@80x24.org> wrote:
> (I have no idea what Jonathan Tirado wrote; it was encrypted (but
>  sent to a public list).
>
> Samuel Lijin <sxlijin@gmail.com> wrote:
>> Yep, I see these on public-inbox.org/git/ but not in my gmail inbox:
>
> Hi Samuel, check your Spam box (and move it to a normal inbox so
> they can train it).  Gmail filters are known to trigger happy
> and incorrectly flag messages.  It's been a problem on LKML,
> too.
>
>> - Brandon [RFC 01/14] through [RFC 14/14] convert dir.c to take an
>> index parameter
>
> Ironically, Brandon is a Google employee and Gmail seems to not
> like his messages.  The only flag I see from SpamAssassin in
> public-inbox is HEADER_FROM_DIFFERENT_DOMAINS which happens to
> every message because it's relayed via kernel.org
>
> Maybe Brandon can escalate this internally in Google...
>
> (OTOH, I noticed a thread/mbox download bug in public-inbox,
> https://public-inbox.org/git/xmqqmvaq702u.fsf@gitster.mtv.corp.google.com/t.mbox.gz
> only shows two messages out of many.   Will need to fix that...)
>
>> - Johanne's Coverity patch series
>
> Likewise, but he also uses freemail domain (nothing wrong with
> that, but it raises one flag on SA).  I noticed at least one
> of his did trigger the RCVD_IN_SORBS_SPAM in SpamAssassin, but that's
> a common problem with all freemail providers (including Gmail).
>
>
> Anyways, I'm glad the SpamAssassin seems to be working well on
> public-inbox and would be grateful to know if there's false
> positives and missing messages.
>
> One of the major reasons I started public-inbox was because I
> lack faith in my ability to run my little list server (with
> mlmmj or mailman) and be able to successfully relay to the big
> providers.  Anyways, I'm glad it's helping readers of git@vger,
> too :)

Thanks a lot for public-inbox, my only problem with it is that it
doesn't cover every single mailing list I'm on, just git :)

Are you or someone else maintaining some ancillary scripts for it? I
probably need to fix my patch workflow but my usual mode is browsing
in GMail & then manually 'git am'-ing some file I find with git-log
commands.

I have one to git am a patch from a msgid, thought I should write
something to handle a series in some DWIM fashion (e.g. apply the
latest continuous sequence of patches matching --author) but figured
that someone's probably wrote this already & I don't need to hack it
up myself...
