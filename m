Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 395FC2021E
	for <e@80x24.org>; Tue, 15 Nov 2016 15:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755529AbcKOPna (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 10:43:30 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:34226 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753270AbcKOPn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 10:43:29 -0500
Received: by mail-it0-f66.google.com with SMTP id o1so738044ito.1
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 07:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=igs8o35CTd+ysSMIRUnm6ZF1pKmPDsW+OowckUx5GDk=;
        b=YF3lqLLpWY0lOK3T69ats6z5v9H1zOUEwjG9phW+yKKninUpR3S27b/H5CZmujfu8E
         XzXk5eA886Ntd2AQeIJ4s6vZpu0mjHk0xFCUZoTgbA5NBKr/d6VjFVg58aiHXrMdzZfW
         62WPyPNjChCd8X5ec4YQ4mYEJRZ3ei5OTF28dg+V6RUCKY8uitjaQprdUgTjIYAAgyyc
         bBawQql77pw9mPWay+PlF9ucs0H8CYxsHHGSk6T3DRXUZotlkWcxMTveh7PAf2Age0Kc
         GjdoDogZ8iw67uspJoo+4EFbfetcCq5TC7+aM5uOcHqVw2AlEWvFKpel7YhpPuD0P4Tv
         N7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=igs8o35CTd+ysSMIRUnm6ZF1pKmPDsW+OowckUx5GDk=;
        b=lyDzbVmqxjNItgLhUESQCYJcuQj8l8gBQFI2kNxlcMoMZoJyNULL2dr5GSvXVU+tpC
         c10urkmkTHyLvLTmGDVUwP8zvRhHCFlvwxf50M7tD/bTBRs9XsZKk6qiYSnrPfPr/mA0
         c0OAKLPW9jjmqPl+9s7MAvX9HKIE0oiu4ova5V9rV/4od7hDmIGdbFJrpARVRxRBvJ32
         yjxMSyXdQCgAoZIMffkuG5vSEedtsHOI2GS3cnVxKEl2LbghkrJIjhKjleyqjMCqc1fN
         MGaUPTpq/HRPDRz9Qkmc9dkkCTQv8Ct/TfA7jqTdEKoWcH793wQBLCnz/r2w5nNj+/ci
         jBvQ==
X-Gm-Message-State: ABUngvfJeBnyIPuFEl2KickMGX1KuzzpyT12GO1ulnHI89RbjEWGdUfixhCwfxF55Dr7DWFqVneJbDS2hIw2lg==
X-Received: by 10.36.41.81 with SMTP id p78mr3565298itp.60.1479224608517; Tue,
 15 Nov 2016 07:43:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.27.209 with HTTP; Tue, 15 Nov 2016 07:43:28 -0800 (PST)
In-Reply-To: <CAJNRPQRhyrALj0zdaTxKgwo8j8r8_7ixgX21+C=ue+CGKYgaCg@mail.gmail.com>
References: <CAJNRPQRhyrALj0zdaTxKgwo8j8r8_7ixgX21+C=ue+CGKYgaCg@mail.gmail.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Tue, 15 Nov 2016 21:13:28 +0530
Message-ID: <CAFZEwPPiQpP+Nr1x2852DBZu71gwHNpKf0WS8htunHpBkBqMCw@mail.gmail.com>
Subject: Re: New to git, need help!
To:     Mayank Gupta <mayankgupta18198@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Mayank,

On Tue, Nov 15, 2016 at 6:00 PM, Mayank Gupta
<mayankgupta18198@gmail.com> wrote:
> Hi All,
>
> I'm new to open source and have recently joined this mailing list.
> Since I'm new at this, I think I can initially contribute to the
> community by fixing some small bugs or errors but as the documentation
> is too large, I don't know where to start.
> So if anybody could guide me on how to go about it, it would be really
> appreciated.

It is really nice that you want to start contributing. We have a user
documentation[1] and a developer documentation[2]. To contribute to a
feature, firstly you need to learn about that feature. So go through
the man pages of the tool which you would want to work on. The things
that you would be using are documented in the technical documentation.
Apart from this, you can start hunting small errors but I think it
would be difficult in the initial stages. So read this[3] even though
it is specific for GSoC, it is helpful for any new developer. Also you
can search the mailing list archives for "low hanging fruit" to get
things which were thought of but not done or something like that.

[1]: https://github.com/git/git/tree/master/Documentation
[2]: https://github.com/git/git/tree/master/Documentation/technical
[3]: https://git.github.io/SoC-2016-Microprojects/

Hope to see a patch from your side soon! :)

Regards,
Pranit Bauva
