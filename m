Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 230001F453
	for <e@80x24.org>; Tue, 12 Feb 2019 00:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfBLA1d (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 19:27:33 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:53285 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbfBLA1d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 19:27:33 -0500
Received: by mail-it1-f194.google.com with SMTP id g85so2989421ita.3
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 16:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WPtx90B985F2P8CvgcEzOeP2eAiTmOhub+gswBm+/8U=;
        b=Xu4c50DtPy3TnUMqQUtjA5nuXH6OaMfbF3nfd0F0GxYGAeh2A0aS5bBQnpjvAlScHj
         GJYVPVXtkf5mg5zbbsbmP8ZfnVwCUJcqB/CWSAdOkxIFDOz72KvNWlOagNrOqdKkUoAk
         isQa1tm3Y425PABboz4ovjOAeHD+8xXPs8v8dSCIR98iyrIjrhBxBOecdaGF9aM+qQzp
         cairjFnUAS+J7An46K8aWZY0j92k0+O+UHcX2quDIyFqQyILYozqcalL0zjEfnBzaktj
         suj6YKmIe719RkDQ7jIItmPm2qJxKBqjhsYFRO8fxrfbkZhjfENyzoe1UkYV10iexH9w
         V5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WPtx90B985F2P8CvgcEzOeP2eAiTmOhub+gswBm+/8U=;
        b=Q8Grtr6Xch+k4m1nBCy7fnKZ3Qf4YfOyUK2tx5c6V5LYNYkfsIF9hEUVssiZE9FdDu
         fQx7981pl1sT2c4JaCumuNJsdeAHHml2Yjs5AJVjuxsjDGfh1sOW1sRkiTwE62NsJtLH
         PZJT1Hx5AdSD/RNWQAowB8V+LolarFpKmlvqoUMnw9QpGWLqbay0f6m0/xhDkzD6D24B
         L129+gzhnbrhObGEkOew/VF4tng8ZcOt7efR9Ou/Z/yYK/QBn/T1FW2uOum/jgeW/DxJ
         UnOGshiiQ9o24jydJjiAVtjpCEFBQTlG/5LW+MVuEbP0pkiFC/lQ0U/BNRHBfsMkEKVi
         tTtg==
X-Gm-Message-State: AHQUAubiHgJ8qr8Ts+iflbS2RlufjmGyius0GSmCit6QyioD51LZMely
        l+3rlH62XB93zVL/aF8bbknjsW+sIifIbV+iBAWFJg==
X-Google-Smtp-Source: AHgI3IZEtaYpMLfdpHFyMKnADKOwXgKG3aRq4G77wL0K5DIickDOvT/6iY7OC0seBQi0dEq2p08TQoA9okOKw5C4cDU=
X-Received: by 2002:a24:9102:: with SMTP id i2mr486624ite.4.1549931251772;
 Mon, 11 Feb 2019 16:27:31 -0800 (PST)
MIME-Version: 1.0
References: <CAHd-oW4p6XUjF_j+XXwYWGt__L_5bTJGwxmgWhxJfpuAFac=dQ@mail.gmail.com>
 <CAP8UFD1_7kBcp1W1kg-C2DObMmYf=rb79MbXvzWhxH7fWf5GTQ@mail.gmail.com>
In-Reply-To: <CAP8UFD1_7kBcp1W1kg-C2DObMmYf=rb79MbXvzWhxH7fWf5GTQ@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 11 Feb 2019 22:27:20 -0200
Message-ID: <CAHd-oW4ZV5+u7MsZ7MDXF=KTHd_Gu51Qjh=E2PvOUD0LJwS8OA@mail.gmail.com>
Subject: Re: [GSoC] Microproject on git-credential-cache
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 11, 2019 at 10:09 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi,
>
> On Tue, Feb 12, 2019 at 12:48 AM Matheus Tavares Bernardino
> <matheus.bernardino@usp.br> wrote:
> >
> > Hi, everyone
> >
> > I've been contributing to the Linux Kernel for the past semester and
> > I'm now looking to take my first steps in the git community. I'm also
> > interested in GSoC 2019.
>
> Thanks for your interest in Git!
>

Thank you!

> > I started looking at https://git.github.io/SoC-2019-Microprojects/ and
> > one that got my attention was "Move ~/.git-credential-cache to
> > ~/.cache/git". But looking around at the code and the mailing list,
> > this microproject seems to have been already solved at 60759ba
> > ("credential-cache: use XDG_CACHE_HOME for socket", 2017-03-17),
> > right?
>
> Yeah, I think you are right. Sorry for not having the time to check by myself.
>

No problem! I submitted a PR to remove it, as suggested by Jeff King.

Matheus Tavares

> > For the microproject "Add configuration options for some commonly used
> > command-line options", are there some options already known to be good
> > for adding to configuration file?
>
> Sorry, but I don't remember very well the previous discussions about
> this, so I don't know if some presumably good have been mentioned yet.
>
> > Finally, a non GSoC-related question. Just to confirm my understanding
> > of Documentation/SubmittingPatches: I must send patches to the mailing
> > list first and after some feedback from community, send to the
> > maintainer with CC to the list, is that correct?
>
> Yes, that's correct.
>
> Best,
> Christian.
