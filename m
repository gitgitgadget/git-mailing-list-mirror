Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F20CB1F461
	for <e@80x24.org>; Fri, 12 Jul 2019 08:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbfGLIkZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 04:40:25 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38305 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfGLIkY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 04:40:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id y15so4008742pfn.5
        for <git@vger.kernel.org>; Fri, 12 Jul 2019 01:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pVUYbqUrWBGJ9gOxBtxnfjPhibGE9pRHDY2iWuXGWI8=;
        b=ksbjok2D008KemZhic+XsoAn48gQbmR2BcoCCwpd1s/VNKQYN5NUSEhx5MqPQATPie
         Fz/mbCI3tvKrHpiJ96TGYx1eDyYXIRAprGejF4L9QKfhsg2NPgDhgAl87gocWJh6pPji
         UySYnyiT3ANNVOxTuHV3iiOV7x35gBVW++yYe1GzgndisBgfAsaGwbYWG1N0/1sB1VaW
         gv5jaxeBCEOMZB4a/74I1lhpQGw5nQBvYcsHBxM8xbpWaKGBkPZEryPdErnSeAMnuh+I
         XCR4299MSgaHhHnH6t8ckhOzdsFUNbiBonjCRFLfWfDkJMUTsLAvIUba4fTrGeQxn3CC
         i72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pVUYbqUrWBGJ9gOxBtxnfjPhibGE9pRHDY2iWuXGWI8=;
        b=Yca7TolEBgvoElsOQsgydGqoteaHltKRw/gIEF/VoBawxH2FKB2I9zCP+/rjFuHOhb
         sVpXD/x1zHOWgELu3GSODF6J7bm9s7RH9ynAlSnDRv4TvWEsr0iivAFtIWiFojGLaM1p
         avF/RglxN7FRtglEZczUZ8KYyKWkWstg6muBQDI0PRrLcL7/1CqnJ+WkrfEkwW7ok4M4
         04PQEVbzVfrehzY3I1Ct8JskD2ieNE9fLUwzi6wVgE5b7HqVIlsrI9Lsdr0u4U4/51YW
         tAqTe7ZOj83buMLi6dKx6lwRGApoCmIyk5PLXTrzfAI0h0dWh6oNK8slEn1lQcmgAi7W
         Thyg==
X-Gm-Message-State: APjAAAUNs89lMgGjVUibA7Z8mL2SglHKBk4tEes7pdL0ESpM+nfPWvaA
        EDJGVNg/n80/4a3Sm2/ZnXqcHi6jfBRz9CqgaaK3OA==
X-Google-Smtp-Source: APXvYqzl6Qt3lsSbiwDrfgQIavzUNv1pKqQrCVG1qWT97M2iOUOSipESe4kZcv24Yj//fgDfobxGT+JtP04d5PMFN7Y=
X-Received: by 2002:a17:90a:8b98:: with SMTP id z24mr10357839pjn.77.1562920824015;
 Fri, 12 Jul 2019 01:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190711183727.8058-1-ariadne@dereferenced.org>
 <xmqqy314qsgp.fsf@gitster-ct.c.googlers.com> <xmqqtvbsqs9x.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqtvbsqs9x.fsf@gitster-ct.c.googlers.com>
From:   Ariadne Conill <ariadne@dereferenced.org>
Date:   Fri, 12 Jul 2019 03:40:13 -0500
Message-ID: <CAAOiGNwGqtSoG8vsy+3gb0=tDVvA1YcA3FcDP0KQMa0=xp5j9w@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] use mailmap by default in git log
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Thu, Jul 11, 2019 at 2:34 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Even though I personally think it is an OK longer-term end goal, the
> > execution looks too hasty.  The normal way we handle a big behaviour
> > change like this is to do the following in steps, in different
> > releases:
> >
> >  - In the first release, introduce an early adoptor option (say
> >    log.usemailmap) that can be turned on by the user, but is off by
> >    default.  IOW, the initial step is "no change in behaviour,
> >    unless you ask for it".  This step also makes sure that the way
> >    to disable it for those who opt into the option from the command
> >    line (i.e.  the --no-use-mailmap option) works well.
> >
> >  - In the second release, when "git log" is run without command line
> >    "--[no-]use-mailmap" and "log.usemailmap" is not set by the user,
> >    give warning about an upcoming flipping of the default, with an
> >    advice message that the user can squelch the warning by setting
> >    the option.
> >
> >  - In the final release, flip the default and remove the warning.
> >
> > Usually there needs sufficient time between the second step and the
> > third step, so that people will not miss the warning.
>
> IIUC, we are between step 1 and step 2.  The configuration already
> exists and uses the safe (i.e. the same as before) default.  Your
> change combines the step 2 and step 3 into one, which will not work.

Makes sense.

> What we need at this point is the "second release" phase, i.e.
> additional warnings without yet changing the default behaviour.
> After it is given to the end users and sufficient time passes, we
> can flip the default.

Do you have a proposed timetable for this?  I can add a warning
message and we can proceed with the warning message for now and then
flip the defaults later.  I just need to know what version you would
like to do the flip in (3.0?) so that I can write the warning message.

Assuming the release you would like to flip the setting in is 3.0, I
would propose something like this:

Warning: The `git log` command will default to using the mailmap file
if present to map contributor names as of Git 3.0.  If you want to
enable this behaviour now, use `git config --global log.mailmap true`
to enable it.  If you want to explicitly disable this behaviour in the
future, use `git config --global log.mailmap false` to disable it.

Your thoughts on this message?

Ariadne
