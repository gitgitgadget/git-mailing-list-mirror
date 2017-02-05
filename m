Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA1511FAF4
	for <e@80x24.org>; Sun,  5 Feb 2017 20:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753705AbdBEULM (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Feb 2017 15:11:12 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:35095 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752820AbdBEULK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2017 15:11:10 -0500
Received: by mail-it0-f43.google.com with SMTP id 203so43283100ith.0
        for <git@vger.kernel.org>; Sun, 05 Feb 2017 12:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6r9GiJWO0M9bBeesOycC16VjcKNdHLn4qDVSkF0ZGXU=;
        b=EiI+7AhSzEzWIkuB6sDJ20/b9pZi9Etkpg2g5eOy8JM5Qu2MEFKJERyNtq5y2XxmUB
         yllbzqVt+Uk9UFtCOTHDEZWXUxEcuHebkuyVpvgBbwIF1+itOBnvEAv2OFk/Y3HkoCu3
         aIn05UBiGnPtBlHlo59sidoYUrXDTOtTpDenKkbiKMSonjsT3etZdye47ZEZyTm6aRLb
         c+H0PWNXlr69FvU4kuIA817f8sqLS41zonbLmP3GvnXcpE/CvVOz4rdYHnwacnDdPDKJ
         j3IhGn1MV+VE5DO6mRIYd/qxWfFSwAuXy0Qcakydns5QTm547LsGk28tqRb7cfec9etb
         +auQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6r9GiJWO0M9bBeesOycC16VjcKNdHLn4qDVSkF0ZGXU=;
        b=dzBGQ/fJssgkcw1HKuSFBpV3JfKTXLWz3zYcFiGRqKm/Mde5vAqoskdb9ZaPyEbmKb
         YbFVRlBIjZ63FIJu2km3vO1Dr4cFzWd7s7T4wRIxG3lGUFJC76rS3MhdkCVAgQF8rI8L
         0zPXYK83lSS1Ff8KDImm6Ajxg/5IbVL6ufNYFm5C3zuI3HvjpW/kMF5UCVGw2w0d9I+e
         +LMhUoZ3b8YtZ3lGgEfuIuK9DXeyfxlroopDMSyI6gc//SIuciCWEBBhNtM0w3J3GLoA
         qd57x/L30Uh4M51BzvD1HEzcgXGZu3oeywFrAJGR2mXeA3Yb6UYdB2hkiu3RtjM81k6P
         hk3A==
X-Gm-Message-State: AIkVDXJvi+YItpoikmAO6/dcg/223qKXCXQI6ndB/ZWsselmmNHpItr2rME3s2ay1ZiY6DXWQmno0dJ3L1cCPA==
X-Received: by 10.36.250.65 with SMTP id v62mr5133699ith.100.1486325465151;
 Sun, 05 Feb 2017 12:11:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.147 with HTTP; Sun, 5 Feb 2017 12:11:04 -0800 (PST)
In-Reply-To: <20170202023349.7fopb3a6pc6dkcmd@sigill.intra.peff.net>
References: <20170202023349.7fopb3a6pc6dkcmd@sigill.intra.peff.net>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Mon, 6 Feb 2017 01:41:04 +0530
Message-ID: <CAFZEwPPX4LngKrOHxgEp4aMGKOs0w4LHUBKumtmeRJSZ2_iV_Q@mail.gmail.com>
Subject: Re: git-scm.com status report
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Peff,

On Thu, Feb 2, 2017 at 8:03 AM, Jeff King <peff@peff.net> wrote:
> ## What's on the site
>
> We have the domains git-scm.com and git-scm.org (the latter we've had
> for a while). They both point to the same website, which has general
> information about Git, including:

Since we have an "official" control over the website, shouldn't we be
using the .org domain more because we are more of an organization?
What I mean is that in many places, we have referred to git-scm.com,
which was perfectly fine because it was done by github which is a
company but now I think it would be more appropriate to use
git-scm.org domain. We can forward all .com requests to .org and try
to move all reference we know about, to .org. What do you all think?

Regards,
Pranit Bauva
