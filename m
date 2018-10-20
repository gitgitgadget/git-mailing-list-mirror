Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE98E1F453
	for <e@80x24.org>; Sat, 20 Oct 2018 06:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbeJTO5K (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 10:57:10 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:42300 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbeJTO5J (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 10:57:09 -0400
Received: by mail-qt1-f180.google.com with SMTP id j46-v6so40857004qtc.9
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 23:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4xWjnfbDJQx1VNMTXOtnijRaNW/XJYc9Wm+5G3ShFOs=;
        b=iWN6usggLmQCKxQGBCQZk+Tlznt1S0xKQSIJ55x0+FqjR9DkPfnsuLfZ1FwN96SMNx
         aSBjGQkT/ptjgtpxy6JbDcE8H4IZZsfigyJWJFiSi4XYuuQvsNEEXeQePWAz+2+QZQKC
         DmuiM320eeXGM3rACmivO9lGttmONJH6BtLKqgexulwUoH1RVXfRMPGxmH6iO4u6kxy+
         Qzcal6J95bTSJVhAzfm3inshNJh2Un4HqLfwTyZDjsD6b0S8HAuVjJBsXNJZeaPgTbpN
         OZl5pZCdvOXY+ZIN4GChxPhym+fuCHeYccM6zZ+QW6+S5H9LytcQ6e3W0sOdjp/Ptr2x
         FYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4xWjnfbDJQx1VNMTXOtnijRaNW/XJYc9Wm+5G3ShFOs=;
        b=QRClX0gMmzEvW2+KQhe+LLU1geTXloBiksoDCBCq3SNDQIiHlqYbe/LXhuMlgT59sc
         g+WFQRt57EjzjkczTH3/mcV7Vr9xl+mQNuJs+XXGHi3v85n1YZrZCeyS8+aX1M61rHxg
         B0QRbQzvF5ZrwzevVk8ljvRF8FV5VihgL0XKr+C3cbwXOrcN4fdNczq/PWTnUanPsujH
         BUUsGjRTtBOK1VSeDOQTV6bFw3mon+6V12+569hQfYs1otnFF1/I+VMm2XfMB4bUfYK1
         5UXh51+yp+z5XLe3C4MaZW2iEP6Z+x6s0P+0E7RoogLluwsUvS+3OAhH+7lt3NjNbfAt
         5vZg==
X-Gm-Message-State: ABuFfoj40Wa2J0D7RrAX9aeMTySNMPTvUYFH6zuBa4tZgA5sKLbzZOaC
        oPCYkWBuyMCq7Y+WzTrnv/Q8NB4jO/DHKkEH+Ss=
X-Google-Smtp-Source: ACcGV639MvZ02QjwWoctI/CozTtUUDx31U9u9AdKTByy60daPIIn9GaDiZ8+7EpUFyzrD6jAtauL/r7gecIlfHNC9wY=
X-Received: by 2002:ac8:6754:: with SMTP id n20-v6mr36292248qtp.70.1540018066665;
 Fri, 19 Oct 2018 23:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAJKt3eP+BZkfK_yn3KYWMgmJB8_18UFr5eizmdGOY_4vM5=AYA@mail.gmail.com>
In-Reply-To: <CAJKt3eP+BZkfK_yn3KYWMgmJB8_18UFr5eizmdGOY_4vM5=AYA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 20 Oct 2018 08:47:35 +0200
Message-ID: <CAP8UFD3CDwu7OVgVmEgP2Se_bxYszcze68_bXT7=wgZaxncpzg@mail.gmail.com>
Subject: Re: How to start contributing
To:     trickygitninja@gmail.com
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Oct 18, 2018 at 2:51 PM =CE=A0=CE=BB=CE=AC=CF=84=CF=89=CE=BD =CE=9A=
=CE=B9=CE=BF=CF=81=CF=80=CE=B5=CE=BB=CE=AF=CE=B4=CE=B7=CF=82
<trickygitninja@gmail.com> wrote:
>
> Hello,
>
> I=E2=80=99m a computer science student and I=E2=80=99m interested in cont=
ributing to git.
> I=E2=80=99ve read the GSoC git page with the ideas and micro-projects as =
I=E2=80=99m
> interested in participating next summer.
> I=E2=80=99ve also read the Documentation at the GitHub mirror.
> I=E2=80=99ve never worked on such large project and I don=E2=80=99t know =
where to start from.
> I=E2=80=99ve picked this microproject from the GSoC page:
>
> Make =E2=80=9Cgit tag =E2=80=93contains <id>=E2=80=9D less chatty if <id>=
 is invalid
> =E2=80=9Cgit tag =E2=80=93 contains <id>=E2=80=9D prints the whole help t=
ext if <id> is
> invalid. It should only show the error message instead.
> Thread: https://public-inbox.org/git/20160118215433.GB24136@sigill.intra.=
peff.net/
>
> This bug is solved using the 3rd option, but I suspect that it=E2=80=99s =
still
> here because the 2nd option is preferred.

I think it should probably have been removed from the micro-project
list. I am CC'ing Peff as he wrote the email listing the different
options to solve the original issue and may think otherwise.

> How should I tackle this?

It's a good first step to ask first on the list as you did if it is a
good micro-project or not. Unfortunately in this case I think you
might want to try to find another micro-project.

Thanks,
Christian.
