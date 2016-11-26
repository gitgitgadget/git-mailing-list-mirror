Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C3FE1FF76
	for <e@80x24.org>; Sat, 26 Nov 2016 09:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751064AbcKZJn0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Nov 2016 04:43:26 -0500
Received: from mail-yw0-f176.google.com ([209.85.161.176]:33525 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750920AbcKZJnX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2016 04:43:23 -0500
Received: by mail-yw0-f176.google.com with SMTP id r204so79557129ywb.0
        for <git@vger.kernel.org>; Sat, 26 Nov 2016 01:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NYJl2Km1EY4fS+J4kt8XyfiuZO49z4TYmIu8UK9WULg=;
        b=CM3IRT4QlTwM8Oy4AXOUbMp3I1dcZ60mEve9wOq7+/WkMpiBvGHOfDMYtlvnYyVOHX
         lMSyFyONe7LZtRiZaeluwwNLuYz4GVJ/OB2kUvgkzi1ifaXBavwwuvX7w/8soAU5BfZh
         k6BdysDdRLd00uCdiWB77keqyuKeDZa6GO49LxIx/tD7/KnBs7uRwejkGz19ayASCPou
         qT61pBWEQx4O8AKxbqlctAvApFV3ObXVphEjFGxDCYOAzW5wdNlTIF9Bmiq61ccyykQt
         FfGMpFz+IZuqbgGXgxfmiPWk4/4oc22umseH1iIhtcRECDMrnz2ROCyrGCAtBkWPW1KP
         T19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NYJl2Km1EY4fS+J4kt8XyfiuZO49z4TYmIu8UK9WULg=;
        b=CdPshn7ygHvu22cBLCvowUWoT70oyR4RcZRTAvI527quxfGzvfd/56SSgj5pRCHG5n
         YutzSUkbw3nRlIdohz+LDXiXIurzsRexwFrVTu4pYDqvOqSpLBC7QlfJ2J09VKFCe9Z0
         OtWGD99ypTElFEochaw/qIEXTiTT7GtAKYEYrrmLg7Of3ryi1TR2F0CoAyapGa6PH/se
         UCfKhQz4WKrj2XjW6a/uYp73ZiIjBrFQJlDDUSPbOfmgWBg4rIJ5wMxYQArx1x/TgOS/
         nDkkwzVoSZFNY5ntUkgR3wGLwm6hxnEMaIu64qpjq0lll4XrMzKRliliElLHElIznRCN
         ifFQ==
X-Gm-Message-State: AKaTC00GI5uu2dBFNX0SpX7ZJkzZEBnGjGaLtWrSFPZrgE4Gb5hXsPFXTYBPLKFYnnVO6mXUFiKaam0M2Q3EMQ==
X-Received: by 10.129.56.10 with SMTP id f10mr15013619ywa.45.1480153396795;
 Sat, 26 Nov 2016 01:43:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.211.7 with HTTP; Sat, 26 Nov 2016 01:42:45 -0800 (PST)
In-Reply-To: <xmqqk2btlr3x.fsf@gitster.mtv.corp.google.com>
References: <xmqqk2btlr3x.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 26 Nov 2016 16:42:45 +0700
Message-ID: <CACsJy8DaOB=ybWFbcqFgZ_U_JYWFUXNDJRmG6_-S3raWh6AWaQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2016, #05; Wed, 23)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 24, 2016 at 6:21 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * nd/rebase-forget (2016-10-28) 1 commit
>  - rebase: add --forget to cleanup rebase, leave HEAD untouched
>
>  "git rebase" learned "--forget" option, which allows a user to
>  remove the metadata left by an earlier "git rebase" that was
>  manually aborted without using "git rebase --abort".
>
>  Waiting for a reroll.

The reroll was http://public-inbox.org/git/%3C20161112020041.2335-1-pclouds@gmail.com%3E/
-- 
Duy
