Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C527121847
	for <e@80x24.org>; Wed,  2 May 2018 18:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751121AbeEBSxn (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 14:53:43 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:36709 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750948AbeEBSxm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 14:53:42 -0400
Received: by mail-oi0-f50.google.com with SMTP id v2-v6so13909550oif.3
        for <git@vger.kernel.org>; Wed, 02 May 2018 11:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=clRVFZVUpEwBMH+gmBDhUyU6E4jiC9oH/TTlK415nYk=;
        b=Xzfs8VRqZ/cvd+5dVPSzaWuzwJ5mPXfVF5mH5BLaCElsUGKKuGqdAiEUYZiBmmf2Dr
         p3+7veVRs2dMipjcdqAWR5olhug4mYhZYJK4eIkdE/aBMkqYP/0xmGPkY+pCgQE1tQdJ
         gk6QJRqOv7hk1HGwW/i7JM7x8QadsxFpJJdH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=clRVFZVUpEwBMH+gmBDhUyU6E4jiC9oH/TTlK415nYk=;
        b=c63O3m1/WQiRz7crrTeT7nS3CXEvkg12AXKncz5y1JhEFX6d0OeplKUKtRvYIQNXMh
         +IM2sBBogJ3ma+A4ZFyrRaRIaHmwzpwOjQach5p5s+GdcpBp5FUjEKn1UKJD2Xy2Uzny
         Ip1Y5WzfkKMDdz9ejmfGx/GbluUTweEsGBjBeKGWjlq1jgSvdv4PLT5Z3toSWaOyDhF6
         AlYX4VwyL46DuWbGeObRepnXSVQgmO2jJqq0HZ/p24WG8p3wqzrm4gQisFTNSr+C7Bhl
         JpZUazvtrb3HlSrcH3FhUFljabd+1gqhJikGrVcxbeg22auFwSokBgWgmC+3ejGgZbES
         T+GA==
X-Gm-Message-State: ALQs6tDRKP9/3wpL5g8r7abl35PIRKP54twXLyxvyManF193+DDL4r4v
        c2CdtzqItVS4D22UVjSZa128BoaBQsPbufwolybQ4A==
X-Google-Smtp-Source: AB8JxZrNhtQeoakRBvyCRYrBiqEDeTCk5z/KqpfyQRZXhurYHb62VbbGmLy3krKYI624eMC/Si90xb/UROFW4d18DRU=
X-Received: by 2002:a54:4406:: with SMTP id k6-v6mr11903726oiw.162.1525287222299;
 Wed, 02 May 2018 11:53:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3c57:0:0:0:0:0 with HTTP; Wed, 2 May 2018 11:53:41 -0700 (PDT)
In-Reply-To: <1093388937.5389750.1525276285911@mail.yahoo.com>
References: <1943804476.5328267.1525271559834.ref@mail.yahoo.com>
 <1943804476.5328267.1525271559834@mail.yahoo.com> <CAE5ih7-71WakVOYLhREchcnOP7HtYfMqPMKvp9r+TMdsTJJmPQ@mail.gmail.com>
 <1093388937.5389750.1525276285911@mail.yahoo.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Wed, 2 May 2018 19:53:41 +0100
Message-ID: <CAE5ih7-=SUaL+VUTNJ0W5x44U7UeRqLhWSCtP5X4mwCF-qSdBw@mail.gmail.com>
Subject: Re: [PATCH] git-p4 - Add option --sha1 to submit in p4
To:     Merland Romain <merlorom@yahoo.fr>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Vinicius Kursancew <viniciusalexandre@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2 May 2018 at 16:51, Merland Romain <merlorom@yahoo.fr> wrote:
> Thanks Luke,
>
> Following your comments, I will:
> - change the option name to --commit if it suits you

Seems like a good name.

> - add an option --force-rebase which defaults to false. Setting it to true
> will rebase even with --commit option used.

Or "--disable-rebase" ?  I think there's no reason you couldn't rebase
after doing a commit like this is there?

And "--disable-rebase" would be useful generally, not just with the
--commit option, but also with the regular options.

"--force-rebase" is a bit confusing since for the normal flow, it
always rebases anyway, and there's no need to force!

But you're the one who is using this in anger, so your opinion likely
counts for more than mine!

> it can be useful too if some commits have been skipped and user wants to
> rebase anyway
> - add an entry in the documentation
> - (learn how to create a test and) add tests for these specific cases

To create a test just look in t/ for the t98*.sh files. Cut-n-paste
one or add to an existing one. Send an email here if you get stuck
(but it's pretty straightforward).

You can run only the git-p4 tests with:

$ (cd t && make T=t98* -j)

>
> What is the best practice ? to send a new email with the new diff ? to
> continue this discussion ?

I think either, probably a new email is easiest. See
Documentation/SubmittingPatches for the general process.


Regards!
Luke
