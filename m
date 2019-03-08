Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48A0720248
	for <e@80x24.org>; Fri,  8 Mar 2019 08:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfCHIu1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 03:50:27 -0500
Received: from mail-qt1-f170.google.com ([209.85.160.170]:46207 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfCHIu1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 03:50:27 -0500
Received: by mail-qt1-f170.google.com with SMTP id z25so20368036qti.13
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 00:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eBLnMXE9gmQHiuIqMz34ybwdWMopJD7fBub9NOLZnH0=;
        b=A6ytt1FLofhR+WenWngFbYDXpSiPQcMXK6xLpwml1i0sKupjk2vu/Gzt2FZTk6qfhy
         LzdXHM/GV+Y++xZZHQXGyyo8mEI71KaeMXWzFRxsEN2bOlIQXxHFoi6P53eqarjhqlEb
         p+YHiblsHkR5OwfPIEIOdrVY0tsKzjkBcqAeX0GX/NHDfKD8ms9tuffsT0T+h2F++ylJ
         HtIoQbNbj7Es9sWshEIN96zukO5n2Zro6lLIaRHj78DEIHbMFkwY4bLSDjDZxcEXnl4t
         YeLoV0tkodqi2F4pu5P7J1o4saC2Y1q3aKc+e/0zbaIIgtIKKfQyBEuo8Eb3YInVxANR
         +49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eBLnMXE9gmQHiuIqMz34ybwdWMopJD7fBub9NOLZnH0=;
        b=mE2z618lLz1l7KM2dNeZjQu5Cx9liPaGAsXygT5MU7EZVm1Zvtp0OmAG3QuQFoa0T0
         p1i/Z0RY4Y37lJbP7I1eacTciwF9fe2/NlbQN3iD763QtwB8CwmO3wr8g9M2mV5pTKR5
         rbilaKl1y7q6rAVZmhMtVOsMQR03K3LioCj1nE6hLEhd4tUSxuaeOp/jRyQrmE+sb2+/
         U9p5Oc02y+g0m2wx1wx1on5pOHLotZv7Ert8rAy1MW9fr/3+ZT38uTeYFESGBm7C34Bk
         rRtQsvMa06VDCYgfKyiOwNwV/jAVKwc1Qsy3+qoZqjX1fJ2g56b5opeJl+YjilCznu7+
         xvbQ==
X-Gm-Message-State: APjAAAUMFDbrdzLiD+BPjmuZkGivyqpYuqlWMKUd3IIF9S562hHpoWgQ
        F6EnAPeTAOs6Y6+B8mD78xLlFXfQykzNluXR+/NhwlqM
X-Google-Smtp-Source: APXvYqxknbmWhLJpiWyX3l+dQ+Lj2R1clLuJ9fWIWFZnW0rHVBmDhnPLfZulFqLBYg26shBcXEuAvESImGA/x6u0c/Q=
X-Received: by 2002:a0c:9387:: with SMTP id f7mr14443481qvf.118.1552035026302;
 Fri, 08 Mar 2019 00:50:26 -0800 (PST)
MIME-Version: 1.0
References: <CAL-rKu6AcyHdrCsVikwQxTgKHgtV86+BeHOv_sTSu-jvwME75Q@mail.gmail.com>
 <20190307180831.GA21404@sigill.intra.peff.net>
In-Reply-To: <20190307180831.GA21404@sigill.intra.peff.net>
From:   =?UTF-8?Q?Jesper_R=C3=B8nn=2DJensen?= <jesperrr@gmail.com>
Date:   Fri, 8 Mar 2019 09:50:15 +0100
Message-ID: <CAL-rKu6knyzyVE7VuTRZEKoS9MOU8ip+Nm+HH7dJAOffb46q2w@mail.gmail.com>
Subject: Re: Error fetching submodule from submodule
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Jeff

You are completely right! It works as I expect if I remember the extra
parameter `--recursive` when doing `git submodule update --init
--recursive`

Thanks a lot for your feedback! This is really useful! I learned a
useful thing today :)

/Jesper

On Thu, Mar 7, 2019 at 7:08 PM Jeff King <peff@peff.net> wrote:
>
> On Thu, Mar 07, 2019 at 12:07:21PM +0100, Jesper R=C3=B8nn-Jensen wrote:
>
> > Hi I think I may have found an error in the way git handles a
> > submodule's submodule. Read further for the example (extracted from a
> > real project).
>
> First off, thank you for the example script. It made understanding
> what's going on so much easier. :)
>
> > * I have a main repository which has some submodules defined.
> > * One of the submodules is a common submodule which is also included
> > in one of the other submodules
> > * When running `git fetch --recurse-submodules` I get an error.
>
> I think the presence of common_submodule in the main repo is actually a
> red herring. if you remove the last two lines of this stanza:
>
> > git setup main_repos
> > pushd main_repos
> > git submodule add ../common_submodule
> > git commit -m 'added submodule to main_repos'
>
> the outcome is the same.
>
> > # This line fails with error code 1 "Could not access submodule
> > 'common_submodule'"
> > git fetch --recurse-submodules
>
> It looks like "fetch" is smart enough to initialize a submodule when
> necessary, but not smart enough to do so recursively. If I replace that
> line with:
>
>   git submodule update --init --recursive
>
> then it works as I'd expect. Likewise, cloning the repository with:
>
>   git clone --recurse-submodules main_repos foo
>
> does what you'd want.
>
> After that, I think "git fetch --recurse-submodules" does what you want,
> because the submodule repository is already initialized.
>
> I'm not sure to what degree git-fetch intended to support initializing
> submodules. But it certainly seems like a bug that it handles the top
> layer but does not recurse (i.e., it should either handle all or none).
>
> Hopefully the commands above at least give you a workaround.
>
> -Peff



--=20

Jesper R=C3=B8nn-Jensen
Nine A/S
Mobile: +45 2989 1822
Blog http://justaddwater.dk/
jesperrr@gmail.com (Private e-mail and Google Talk IM)
