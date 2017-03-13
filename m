Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A348620373
	for <e@80x24.org>; Mon, 13 Mar 2017 19:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754582AbdCMTt7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 15:49:59 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33998 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752493AbdCMTt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 15:49:58 -0400
Received: by mail-qk0-f182.google.com with SMTP id p64so231908987qke.1
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 12:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UZtQquupoFuFW8KhQtMTRtsdHNXoKkxY/B9tjMZU7eU=;
        b=uxJbuv+LBW7xGOw3euj5f9kuTZwp/urlXEUngHJ69bdJ+DjnM1AiekYnwcA4Pi8WHG
         irnqed2TVS9mu8xZeUZxn8f0IqTqMX/KL/kGcLPMhJYTgIGj0QSkVMAknacW2DUEsy1J
         SLV8YUuqwrpiFOJ7yodd0f6NoCsX0fS+Ro8XdEUdq9xV9UWfX/N1Tj3S3RGzEPZMEl5f
         TGWHlP94Bit1U91DKccbfx8m0UwsOiZBNjv70bO3eMgmsbZONu9w9IQdYJ3Taagc5Jet
         tLUHwuC5iwW+kI4x8DzNiskJVdvMcooVdycpuiE/IUpWuBCTiW+gG9BmdTVISXwBHGRx
         hXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UZtQquupoFuFW8KhQtMTRtsdHNXoKkxY/B9tjMZU7eU=;
        b=EFm7+btAnrX11kEbxwpNPvh7b0NJN4bdcn7Syeo7H4ZtuXm6jqSXaSaUCExYH12YHS
         F/D0JbJsUbw9m1CguhudnwSIlXAmyB7sYH3kLxSkSykxrUSi6wI674F77aX9ceECJI0z
         gi0I7XiGp+r7BWnXweIYvoVxmEhZDX5I2nDD/HKGLn/Z2SRnbxnI/O+11QaMbtStO9QF
         qYbnoWfsFQlmUjtVduvh6W//hHX2v2zjeBjN1ETY+8MXMpAMDJ+5eYqeylIXrJSo6UlO
         tT8PhYgkGBabl643LLHon3wo0xWlruEtegWTREHf1iunhSFyVRGUvTv7BOafZ9Na1Zhv
         Zv6Q==
X-Gm-Message-State: AFeK/H33aod/UUeNue74wtU0/KMI8tb3tAgiDL44TbelqNUpM+wWTKuTZXDfcVEPbDOqF9jp0gsR8VRmfY8ZYw==
X-Received: by 10.55.192.145 with SMTP id v17mr35585679qkv.3.1489434596541;
 Mon, 13 Mar 2017 12:49:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.177.137 with HTTP; Mon, 13 Mar 2017 12:49:36 -0700 (PDT)
In-Reply-To: <CA+P7+xp1T0-02=NznW0=Xd_K5_bdtg=nVgtTqT74+EJuncYxSw@mail.gmail.com>
References: <CABURp0pf=4BE=E7qeOmYAcqJb=qDeGJ1EFyfCf+hDtKjjMD=ng@mail.gmail.com>
 <xmqqzigswzk9.fsf@gitster.mtv.corp.google.com> <CA+P7+xp1T0-02=NznW0=Xd_K5_bdtg=nVgtTqT74+EJuncYxSw@mail.gmail.com>
From:   Phil Hord <phil.hord@gmail.com>
Date:   Mon, 13 Mar 2017 12:49:36 -0700
Message-ID: <CABURp0onBt8yo2nJhaxkZk+dujOYDD6dZDeo_a4=dMx867OPvg@mail.gmail.com>
Subject: Re: git-push branch confusion caused by user mistake
To:     Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 13, 2017 at 1:55 AM Jacob Keller <jacob.keller@gmail.com> wrote:
> On Fri, Mar 10, 2017 at 2:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Phil Hord <phil.hord@gmail.com> writes:
> >> I think git should be smarter about deducing the dest ref from the
> >> source ref if the source ref is in refs/remotes, but I'm not sure how
> >> far to take it.
> >
> > My knee-jerk reaction is "Don't take it anywhere".
> >
> > Giving a refspec from the command line is an established way to
> > defeat the default behaviour when you do not give any and only the
> > remote, and making it do things behind user's back, you would be
> > robbing the escape hatch from people.
>
> It might be worth having some warning or something happen here? I've
> had several  co-workers at $DAYJOB get confused by this sort of thing.

On one very active project at $work, we have 380,000 commits, 4600
branches in refs/heads and 96 branches in refs/remotes.  About half of
the refs/remotes (43) are obviously user errors.  The other half it's
not possible for me to know.

I suggested to our admins to block attempts to push to
'refs/remotes/*' so in the future users don't lose track of commits
they think they pushed.  But I don't know if that will really happen.

Thanks for the counterexample feedback.
