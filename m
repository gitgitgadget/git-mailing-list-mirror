Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E661FC00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 18:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbiHASTl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 14:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbiHASTk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 14:19:40 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5FF286D7
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 11:19:38 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id rq15so15839605ejc.10
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 11:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=/+UvemFblC4xCxRYy7w8G0LM1S5bfzZ5sPhXbjt8vN0=;
        b=HB+wFiMiqodiM/5CG6FJg2xvDNeMuEYke2516h4X/GFzQq71VtwRCiMp428nwJmyL2
         bns4HS+YAMVk0gJ5hFcLcyyoxLWDI57nJS40Zfdgmxe5herI96PmtvwRqLaATglNZgmb
         kd1/PmJd19qqUFHMAUZ3TJlC/NgvwWa5K6UPxhiKtRUn7xI5I5zvRbMA5f6YZgJs/Nro
         l/9cCy6fdHK/hCYHMlZZPmpwgSti/PPDT+tl3g/vIOVsn47i+Vitu8RFkI+63tPjSGZE
         SkagPnCGMp1jRHzWyogl0chcLgq5QqQ4W6PGk8b38341S52Shl2lxx313oLCFx7Vu/uU
         0Rmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=/+UvemFblC4xCxRYy7w8G0LM1S5bfzZ5sPhXbjt8vN0=;
        b=JAIbyNXR+K1ISpKLm0rzOXM5mDkmnwkbk7NApvv+IvW6jOoA5sgWzq3GaNPmPtt2Ez
         TXtuCLHxEEWgk9xb5S8Au8mimt3rbd0ilV415T/qjwiQLslx18NF8o3+Pwde3ddANO+9
         Ax9yokXH2llf78ilmEMbVCDTIjJCFwBmkAepYUxN9VfRtKLFLIAslaHVdhPgJvz5OujI
         cXr3z8eko2hHkwxvAgEdF0FpAJ3agfkaDIVYxYsJv2NT3ERxACIGJlPk9ZFBYH5jLFpR
         ngckNFEDb+oeVN7j/TJjXatsX7aq+nl8CJUTT3Mp6oNLSHk1re8e89U9XrwVX34k/9qq
         ADBg==
X-Gm-Message-State: AJIora926feH+TY1JOKRSl//UDhASlXFUhPx6cc6Tf8SOi/COY5FdcgQ
        kpPpZbfvlb3I5f/UO8EJLgChBjIfF+6VGsyu5TzqhYiJ
X-Google-Smtp-Source: AGRyM1sC97n6fv5e2RqTbUFd688zJf0aGp88FDukEoAs+AcLQ0uMoECpRJY7CJ1SJDoYY8Hnr/+wqaOLChcbsyfCEj0=
X-Received: by 2002:a17:907:9809:b0:72f:817:d433 with SMTP id
 ji9-20020a170907980900b0072f0817d433mr13604191ejc.483.1659377977414; Mon, 01
 Aug 2022 11:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAMxJVdH6=dP7vwruSnKFVTT4ZgygLK_2fu5TKoRia+WyMzATXA@mail.gmail.com>
 <840r6312-3r19-n087-68s1-rpo1n9869osn@tzk.qr>
In-Reply-To: <840r6312-3r19-n087-68s1-rpo1n9869osn@tzk.qr>
From:   Eric D <eric.decosta@gmail.com>
Date:   Mon, 1 Aug 2022 14:19:24 -0400
Message-ID: <CAMxJVdEPd3h3WyXC+MjN9dmKyQOTMb9+Nsp=Vm-bt7J+kL202g@mail.gmail.com>
Subject: Re: fsmonitor: perpetual trivial response
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 28, 2022 at 9:48 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Eric,
>
> On Wed, 27 Jul 2022, Eric D wrote:
>
> > fsmonitor daemon was started in the background (i.e. git
> > fsmonitor--daemon start) so I could enable trace2 logging.
> >
> > 15:36:37.860862 ...n/fsmonitor--daemon.c:969 | d1 | th01:ipc-server
> >       | region_enter | r1  | 124.965540 |           | fsmonitor    |
> > label:handle_client
> > 15:36:37.860862 ...n/fsmonitor--daemon.c:970 | d1 | th01:ipc-server
> >       | data         | r1  | 124.965809 |  0.000269 | fsmonitor    |
> > ..request:1658950597810367000
> > 15:36:37.860862 ...n/fsmonitor--daemon.c:786 | d1 | th01:ipc-server
> >       | data         | r1  | 124.965892 |  0.000352 | fsmonitor    |
> > ..response/token:builtin:0.12336.20220727T193432.938608Z:0
> > 15:36:37.860862 ...n/fsmonitor--daemon.c:822 | d1 | th01:ipc-server
> >       | data         | r1  | 124.965969 |  0.000429 | fsmonitor    |
> > ..response/trivial:1
> > 15:36:37.860862 ...n/fsmonitor--daemon.c:974 | d1 | th01:ipc-server
> >       | region_leave | r1  | 124.966000 |  0.000460 | fsmonitor    |
> > label:handle_client
> > 15:38:40.079662 ...n/fsmonitor--daemon.c:969 | d1 | th02:ipc-server
> >       | region_enter | r1  | 247.186960 |           | fsmonitor    |
> > label:handle_client
> > 15:38:40.079662 ...n/fsmonitor--daemon.c:970 | d1 | th02:ipc-server
> >       | data         | r1  | 247.187067 |  0.000107 | fsmonitor    |
> > ..request:1658950720017776200
> > 15:38:40.079662 ...n/fsmonitor--daemon.c:786 | d1 | th02:ipc-server
> >       | data         | r1  | 247.187328 |  0.000368 | fsmonitor    |
> > ..response/token:builtin:0.12336.20220727T193432.938608Z:0
> > 15:38:40.079662 ...n/fsmonitor--daemon.c:822 | d1 | th02:ipc-server
> >       | data         | r1  | 247.187448 |  0.000488 | fsmonitor    |
> > ..response/trivial:1
> > 15:38:40.079662 ...n/fsmonitor--daemon.c:974 | d1 | th02:ipc-server
> >       | region_leave | r1  | 247.187491 |  0.000531 | fsmonitor    |
> > label:handle_client
> > 15:42:14.719673 ...n/fsmonitor--daemon.c:969 | d1 | th03:ipc-server
> >       | region_enter | r1  | 461.821373 |           | fsmonitor    |
> > label:handle_client
> > 15:42:14.719673 ...n/fsmonitor--daemon.c:970 | d1 | th03:ipc-server
> >       | data         | r1  | 461.821429 |  0.000056 | fsmonitor    |
> > ..request:1658950934652816400
> > 15:42:14.719673 ...n/fsmonitor--daemon.c:786 | d1 | th03:ipc-server
> >       | data         | r1  | 461.821467 |  0.000094 | fsmonitor    |
> > ..response/token:builtin:0.12336.20220727T193432.938608Z:0
> > 15:42:14.719673 ...n/fsmonitor--daemon.c:822 | d1 | th03:ipc-server
> >       | data         | r1  | 461.821486 |  0.000113 | fsmonitor    |
> > ..response/trivial:1
> > 15:42:14.719673 ...n/fsmonitor--daemon.c:974 | d1 | th03:ipc-server
> >       | region_leave | r1  | 461.821497 |  0.000124 | fsmonitor    |
> > label:handle_client
> >
> > Note that this is a slightly hacked build of mine where I disabled the
> > check for network filesystems. I also added some additional logging
> > that tells me that the query is successful, it's just that the
> > response is trivial. The sandbox I am using is on the network and
> > being accessed from my Windows VM.
>
> Since you already "hacked" it, why not instrument it a bit more, e.g.
> offering some trace2 message for all the places where `do_trivial` is set
> to 1 in builtin/fsmonitor--daemon.c?
>
> Or maybe you need to use `GIT_TRACE2_EVENT` instead of `GIT_TRACE2_PERF`
> (I vaguely remember that `error()` messages are only logged in one of
> these two modes).
>
> Ciao,
> Johannes

My sandbox is sparse, but it is not "cone compliant"; temporarily
disabling sparse checkout seems to have (temporarily) resolved this
issue - at least for my purposes of testing fsmonitor out on network
filesystems.

-Eric
