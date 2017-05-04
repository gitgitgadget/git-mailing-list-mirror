Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1C5D207B3
	for <e@80x24.org>; Thu,  4 May 2017 10:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751649AbdEDKSm (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 06:18:42 -0400
Received: from mail-yb0-f171.google.com ([209.85.213.171]:34598 "EHLO
        mail-yb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751347AbdEDKSk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 06:18:40 -0400
Received: by mail-yb0-f171.google.com with SMTP id 8so2141911ybw.1
        for <git@vger.kernel.org>; Thu, 04 May 2017 03:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+QVfpO7zOG/W0sUHrD2CSHLKmwTsZjzHDgB0MKs87A8=;
        b=ttnuidPHTjr98DnA67ovuUUOTnTHU7bZlFXaSslukw6WlydPenC7a9/kdUNut6JQ/A
         wNSzltUkmbKMgGX8ZZxIrv/YwVSvC2grXkE/A/FXfR/W7aJtijMOZ0WF2E1F0Qf0Yetc
         wGRqlw6N2olRLuAL6vxD+kXC1LkU6+JJBqjHlshplPM53pJCpDK3m9ajls0YHMCJFYgT
         wBl9xGnZ66g+9vJx+TbNNUfqQjg++2PZrDqzMKkzSPo4QyDQBVoBYu7tAzj93fdDKGQp
         TahcD7+S/ACmeI9MUoAJdItfbpQunnojgq/1Wau4SXPjaDAWi51rbqahnaGsyzXvaAEd
         H30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+QVfpO7zOG/W0sUHrD2CSHLKmwTsZjzHDgB0MKs87A8=;
        b=TmV4FTgFMIjIFV4HopG5aZXsZDn7w1HPw+dSubWr9e9gcZxmjlVyCofXc8usomEaFL
         OR31mghNsiidw6FI1x325SiQLrxGpJFU8wrjwX7aFd2pUb9oAVmqA8RO8exjG6taCCY6
         fSQUXlyBGXhoVajBeDOt/qk8S+mia3wp26TnS+BX2YqjyWcmL4HRkLyDtoBo6Sptnsex
         Vzv012Grea7t8+WpZZvuSjOss++unxPz6huBrx/Lc5mazH/vN+/LLJcGDotEcHuN+GVs
         2Ry68SbBRGLdK6+3NxMfTPvrujHThjNDz3tzfc6fjXht09XQwZNuJLhZZQ/RYa0YnTXI
         N2bg==
X-Gm-Message-State: AN3rC/50eJYT9n4HR2i3wu2S2tC3of9YplOJ99FQ5URnDR0GdJ1jHw14
        vjC6nq9BPYirvkp8LenZhg8wwNm8jA==
X-Received: by 10.37.117.134 with SMTP id q128mr32802707ybc.170.1493893119969;
 Thu, 04 May 2017 03:18:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.161.228 with HTTP; Thu, 4 May 2017 03:18:09 -0700 (PDT)
In-Reply-To: <20170504094719.GA3238@dinwoodie.org>
References: <CA+dhYEX+GgEHnVBnLQqnNW99xpf9kWcataTTt3Ya6ivGFgscMw@mail.gmail.com>
 <alpine.DEB.2.20.1705031147040.3480@virtualbox> <CA+dhYEUCJghqDQyBrL71Q=JKokcH-nhQ9WZzBb19-gonxi7o=Q@mail.gmail.com>
 <alpine.DEB.2.20.1705031630540.3480@virtualbox> <20170504094719.GA3238@dinwoodie.org>
From:   ankostis <ankostis@gmail.com>
Date:   Thu, 4 May 2017 12:18:09 +0200
Message-ID: <CA+dhYEX0f206pZ+7seOce7McnfZ9ZfXLvSn7YH3Ykgqk+gA8gg@mail.gmail.com>
Subject: Re: CYGWIN git cannot install python packages with pip
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4 May 2017 at 11:47, Adam Dinwoodie <adam@dinwoodie.org> wrote:
> Confirmed: the Cygwin project as a general rule doesn't support this
> sort of mixing of Windows and Cygwin tools.  Either use Python and Git
> packages both provided by Cygwin, or both provided by Windows.
>
> Mixing and matching does work sometimes -- as was apparently the case
> with Cygwin Git v2.8.3-1 -- but it requires care and you're generally on
> your own with it.

MSYS2's git-2.12.1 also works fine, so there must be something
different in this build of git that breaks this long-standing capability.

Judging from the error-message, it somehow concatenates input & output
paths.
Isn't this something to research about?

Regards, for your continuous effort,
  Kostis
