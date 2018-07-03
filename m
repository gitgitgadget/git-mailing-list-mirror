Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D657A1F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 21:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753164AbeGCV1v (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 17:27:51 -0400
Received: from mail-ua0-f182.google.com ([209.85.217.182]:37695 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752949AbeGCV1u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 17:27:50 -0400
Received: by mail-ua0-f182.google.com with SMTP id u8-v6so2162595uao.4
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 14:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4KYCfQFo9fpw8RQngLPKIp1AvOvW9pEWJMwMLrsdXQA=;
        b=WCbk37Tx+ZxhX1om0gz8BOd733dBdcFSsDimMZAfTzzE7Lo46YUo4OAGLmuRWyx1pF
         9qWlqj7RjbWU/W8MoU9XZglnWSgGgClS8kOaeLZNw+Kpz1/py0fyTTiD3Z7kj1eGCXsq
         XJkwd7gdp2vGn8Qk4Ey/uZLRxZTAJMpRLPF3HG4N5/15kjOqGpl3x1tSMt6akccvC0a/
         F59LXLho4Enzn7X5QnuzLR0I2j8gQKSFcoMyru/vlURKzoLQrAJ0W9IEZCtIc0H3zRop
         ptIBJVauFLjxrwhyjhORrkVX2EDHTnx5KHrSg5ge5NlQUGKQYtGhkMPV2ce60IRc1+JY
         sXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4KYCfQFo9fpw8RQngLPKIp1AvOvW9pEWJMwMLrsdXQA=;
        b=UsQvfkwqUUgW5EhJMYQ3l0eYqHe/08qEUTj+gRNd4LCal53ztxnizzLlAd5laZp0Ps
         UqATE0ZvKtlAVO6N9Pb2JRi2a3ni9krXJERYACzz2avNomFNxbzmPvguiB/zhCptwIaC
         poavhxSONrTk4mL1wWaCszd6rhpJyLOaO4guesgt3YxrFHIrHVvXQyWswwIExm1UPHBb
         R6ftL5T60I3uvtyyYXdyK8Y2HBnbdqAObhA+Ux0zZNFrXAvz/7aebIAYXcUK7kzCDis4
         A4x25MXcxyPND5FwdDwJL6LiBQqXH1U8OH6jS4Ax0p+opHXxyu9DhhkgXXL353aeNjT9
         nBHA==
X-Gm-Message-State: APt69E1UcXQysrW1HvSCceMZY3eu2514+/cPxdYez3RIUN331IrwZYNL
        aoMc/761JhyUFY0i8NCKPWt+GcGLGo9HO+wnyXRk3A==
X-Google-Smtp-Source: AAOMgpeOq/Bi/on83hS0caKBaVxCRARVuridDyHOudg8oC5qtVEkVVEC34BOCBKiZ/lEHuiQjUX+miRV14H5KSaYCQc=
X-Received: by 2002:a9f:3563:: with SMTP id o90-v6mr3467585uao.79.1530653269565;
 Tue, 03 Jul 2018 14:27:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 14:27:48 -0700 (PDT)
In-Reply-To: <E37C3A33-489B-4FEB-9170-097514B41317@redfish-solutions.com>
References: <E37C3A33-489B-4FEB-9170-097514B41317@redfish-solutions.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 3 Jul 2018 14:27:48 -0700
Message-ID: <CABPp-BFbDx4z2TiqiexyNJzA5UC5D7ZH6Uw-XLXeG3tDCHRKog@mail.gmail.com>
Subject: Re: Better interoperability with Bitkeeper for fast-import/-export
To:     Philip Prindeville <philipp_subx@redfish-solutions.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Tue, Jul 3, 2018 at 1:40 PM, Philip Prindeville
<philipp_subx@redfish-solutions.com> wrote:
> Hi.
>
> I tried to import into git a repo that I was working on (because it just =
seemed easier), but when I tried to export the repo back out after making m=
y changes I found it choking on a few things.
>
> It was explained to me (by the Bitkeeper folks) that git meta-data doesn=
=E2=80=99t accurately track file moves=E2=80=A6  If a file disappears from =
one place and reappears in another with the same contents, that=E2=80=99s a=
ssumed to be a move.
>
> Given that =E2=80=9Cgit mv=E2=80=9D is an explicit action, I=E2=80=99m no=
t sure why that wouldn=E2=80=99t be explicitly tracked.

Not a full explanation, but see
https://git-scm.com/book/en/v2/Git-Internals-Moving-Files

> But I=E2=80=99ve not looked too closely under the covers about how git re=
presents stuff, so maybe there=E2=80=99s more to it than I=E2=80=99m assumi=
ng.
>
> During an export using =E2=80=9C-M=E2=80=9D and =E2=80=9C-C=E2=80=9D, Bit=
keeper complained:

Why would you add -C?  Does bitkeeper also track copies?

> fast-import: line 'R ports/winnt/libntp/nt_clockstuff.c ports/winnt/ntpd/=
nt_clockstuff.c' not supported
>
> so I tried removing those two options, and it got further, this time stal=
ling on:
>
> fast-import: Unknown command: tag ntp-stable

If the fast-import command you are using can't read tags, then perhaps
you should report that to the authors of the fast-import tool you are
using and/or only feed branches to your fast-export command.

> I like git, mostly because I=E2=80=99ve used it a lot more=E2=80=A6 and I=
 like the GitHub service.  I use Bitkeeper because a few projects I work on=
 are already set up to use it and it=E2=80=99s not my call whether it=E2=80=
=99s worth the effort to make the conversion or live with it.
>
> So=E2=80=A6 this is an appeal for both to play better together.
>
> What=E2=80=99s involved in getting git to track file/directory moves/rena=
mes so that it=E2=80=99s palatable to Bitkeeper?

Not tracking file/directory moves/renames wasn't an oversight but a
fundamental design decision; see e.g.
https://public-inbox.org/git/Pine.LNX.4.64.0510211826350.10477@g5.osdl.org/=
.

However, supposing that we did track renames, how would we tell
bitkeeper?  Well, we'd print out a line that looks like this in the
fast-export:

'R ports/winnt/libntp/nt_clockstuff.c ports/winnt/ntpd/nt_clockstuff.c'

which is precisely the line that bitkeeper's fast-import was choking
on.  So, it sounds like they don't support importing rename
information (or at least the version of fast-import you're using
doesn't).  I think this is where the bug is; you'll probably want to
report it to whoever maintains the fast-import command that is choking
on this line.

Once that's fixed, you can export from git with the -M flag, and from
that output, there'll be no way to tell whether the original
repository tracked renames or detected them after the fact.


Hope that helps,
Elijah
