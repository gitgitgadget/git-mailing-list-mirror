Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B507F203EB
	for <e@80x24.org>; Wed, 27 Jul 2016 17:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757789AbcG0RuP (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 13:50:15 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:36971 "EHLO
	mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757560AbcG0RuO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 13:50:14 -0400
Received: by mail-it0-f41.google.com with SMTP id f6so56108166ith.0
        for <git@vger.kernel.org>; Wed, 27 Jul 2016 10:50:13 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KWB8wXIoFURKFJ3m1EiA8OBXHY7OO8EkajTlAO7xIFM=;
        b=aAotjm2omI/Ly3RhS1qZtNvcqz2l3X/TnTXQHP9mCBLXq9IBXdsLRO51+bWWkYKbpf
         6d8y2ywOrh9tP0ogWygOYVgmpVrcdd6S17OhD+M+Bsj5DLlxW+7MFmQuVNoHmOUee+Vz
         jQGiseVOSzhi8raaZ/5j4yznUmcFIxCFhyc7BsdVF3szCbyZpbj7mq5/f8RgdBt4GveB
         hU7q1dHqJqCojwsIOHBsiXpJHhZ+j2kw+OHgaX/FYlVcNxt7G7OnEPeXc4ZKSCHMlpsa
         tt4rolgWfEAXAqWbqSgRpNW7QXHRiWxiWJNi8rs4Vw+nzUjw/+BS30OUw2CovKErg4vi
         GhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KWB8wXIoFURKFJ3m1EiA8OBXHY7OO8EkajTlAO7xIFM=;
        b=CqB+1pLC75fLeLA7SUqdq7RSJA/GLs7M1cgkuadrDwE5TdKQCxdjnCAfTNNt5gfmi1
         R430E1Qpc6o4pVU6GuD/TwKX9TLCAkc2zV4NEk7u8rbHnkMmZTOns4g7DJxcJdlAQmof
         iyIajZok1A6wpPPojDhEbvLebZp6rQUCbY/ihDWiwDK6YpzlwrNCFtCu0pojNyPS8nJi
         0qq5vTLAlXdjh11Ge68ffSZ9IcAoQRgMeluPiGb+UwKaPvRBz2conPtlp6BEPfFlbsw1
         Kg89h1OrVb/gk1djyU+6NGcOuj3jWeJdnx7Uhu3cnPOJU59+j13Ok3/SKG5uHNKI/NuD
         L3Jw==
X-Gm-Message-State: AEkoouv5oOYhe1I+unHELz5De5cxddvcUA57NAEYwKNZwKoB4PWK9QuUDGWQvwTt3XSWVIOUvkmU9CrUNzJhXVuy
X-Received: by 10.36.217.12 with SMTP id p12mr36126284itg.46.1469641813203;
 Wed, 27 Jul 2016 10:50:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 27 Jul 2016 10:50:12 -0700 (PDT)
In-Reply-To: <CACsJy8CMnywB8AdmLxB8LnsznHrMTieoezhaQS=2r1pnM8ONZA@mail.gmail.com>
References: <CACsJy8CMnywB8AdmLxB8LnsznHrMTieoezhaQS=2r1pnM8ONZA@mail.gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Wed, 27 Jul 2016 10:50:12 -0700
Message-ID: <CAGZ79kY5UrjSj8xbjB+MvTE2xUyt+te1RKN6Bf0WiEA23iZ7wg@mail.gmail.com>
Subject: Re: Find a topic branch containing a commit
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 27, 2016 at 10:42 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> Before I start doing anything silly because I don't know it can
> already be done without waving my C wand like a mad man...
>
> I often do this: find a commit of interest, the commit itself is not
> enough so I need a full patch series to figure out what's going, so I
> fire up "git log --graph --oneline" and manually search that commit
> and trace back to the merge point, then I can "git log --patch". Is
> there an automatic way to accomplish that? Something like "git branch
> --contains" (or "git merge --contains")?

https://github.com/mhagger/git-when-merged ?

>
> PS. Sometimes I wish we could optionally save cover letter in the
> merge commit. Sometimes the "big plan" is hard to see by reading
> individual commit messages.
> --
> Duy
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
