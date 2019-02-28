Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE31120248
	for <e@80x24.org>; Thu, 28 Feb 2019 21:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbfB1Vqs (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 16:46:48 -0500
Received: from mail-io1-f53.google.com ([209.85.166.53]:38392 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfB1Vqs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 16:46:48 -0500
Received: by mail-io1-f53.google.com with SMTP id p18so17915230ioh.5
        for <git@vger.kernel.org>; Thu, 28 Feb 2019 13:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=JvI/52z0JFZXw4SBXRDz9kB1CWgs3BkHjIMojZNock4=;
        b=dmOop0+Y4jioSRK3oDuTnvSyGxcr9R6iP0tP7/ZovF0pDUfeYaHTP96HCrVAu2awyY
         9/BOY15oKYF4vng7+dyFHNfRWFXB8+taHDzAF/Llziur+sHZQjpUnzR9PMmYhhe+TnJ6
         xG0BvZthwsvYw80sbnCX92xm8ZbEUVRGFL1p4d4SboMjSA1bj5v6CrpxTt00rMzmIIGu
         a8hGaU5lHSsTwwPZ5Ph8Z+9fi2QwZhqfmFoCkVBiE3RWX5T8fRmfibQz8r/kzXCQ0H9L
         yNYmsuj5y0VTJSPbortFHdBo6cR5jpq0G+QhiL80dvJOSW8jrHJibW1WlDr96dsGWKkb
         Laxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=JvI/52z0JFZXw4SBXRDz9kB1CWgs3BkHjIMojZNock4=;
        b=iaJeX80PIca3EGhAzvccmDmIbdyJw/qZAlT3PJTtTcF1bAoS4R58oPlWkvSAWxp9ta
         a4CA1XLiTOSsYxb/0R1SOmagjQaJs4kV35h1ek+QUpHKDFLJViF1cquPPnG1Izl3mUNb
         VHV69qGIa9ByrFC00N1XhHPZ1xU7gcvL+zG6SfZV+Eh6S7KsRpd+EpMtq/Q2EX0GLp6F
         n6YGv5K8K4QYiuS2Ouo1xN+CXqqnVwlulIpXDfJkyDD/wVwfRErl4oLy42CKsbFT3ck1
         RvBZD/ZtltPiyj3BNp3kUFDyWuM/eYUErqJS3JI9SoSRUabtcwtTYIOCoNU0/G6qfWvl
         5c/g==
X-Gm-Message-State: APjAAAU3+X+Luxp07ndQusAzZePDf3HXQV56omwL7wa2/DvNDDdk2LrJ
        bpyf7w91babUgcvYlWaNF7Y6ucMJJxcKM0lt8DmeyxiPEpc=
X-Google-Smtp-Source: APXvYqzhlEV33Dy+MtPHHZDCpbqQhnyX/qyqabc2B+QhKE2vJMqs5OgyU7hYdWcEXgjlbV19/WHZaZrYivMfHPkzyb4=
X-Received: by 2002:a6b:1447:: with SMTP id 68mr905087iou.293.1551390407027;
 Thu, 28 Feb 2019 13:46:47 -0800 (PST)
MIME-Version: 1.0
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 28 Feb 2019 18:46:36 -0300
Message-ID: <CAHd-oW7onvn4ugEjXzAX_OSVEfCboH3-FnGR00dU8iaoc+b8=Q@mail.gmail.com>
Subject: Questions on GSoC 2019 Ideas
To:     git <git@vger.kernel.org>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Elijah Newren <newren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, everyone

I've been in the mailing list for a couple weeks now, mainly working
on my gsoc micro-project[1] and in other patches that derived from it.
I also have been contributing to the Linux Kernel for half an year,
but am now mainly just supporting other students here at USP.

I have read the ideas page for the GSoC 2019 and many of them interest
me. Also, looking around git-dev materials on the web, I got to the
GSoC 2012 ideas page. And this one got my attention:
https://github.com/peff/git/wiki/SoC-2012-Ideas#improving-parallelism-in-various-commands

I'm interested in parallel computing and that has been my research
topic for about an year now. So I would like to ask what's the status
of this GSoC idea. I've read git-grep and saw that it is already
parallel, but I was wondering if there is any other section in git in
which it was already considered to bring parallelism, seeking to
achieve greater performance. And also, if this could, perhaps, be a
GSoC project.

I'm also interested in the 'convert script to builtin' task, and I was
wondering if 'git-bisect' would be a good candidate for that.

Thanks,
Matheus Tavares

[1]: https://public-inbox.org/git/20190226051804.10631-1-matheus.bernardino@usp.br/
