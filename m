Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 292B520248
	for <e@80x24.org>; Thu, 28 Feb 2019 22:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730516AbfB1WHv (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 17:07:51 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44607 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbfB1WHv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 17:07:51 -0500
Received: by mail-ed1-f67.google.com with SMTP id b20so18304065edw.11
        for <git@vger.kernel.org>; Thu, 28 Feb 2019 14:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HjwB36213IT/AYydMq06cEXPabbQK09FrMpP6mIrkTM=;
        b=r+tx6kBHx1H0m5qPzu9I3hfAQwJU7BykjdcgG3KT3zrsGKigy7Xe1SAd/J5nWzeo1v
         c41/LhBMuunkFCScEjLS01HzJDHB4XVIVyWejisQOmltVzgm3InIWm4IL2HdU8sCNOpu
         GKS4NgN6k7QMnai05XD/8dbWEgKfk631jS+Zbh488uDk4TG4mKC7eV8HG2iQX5p3rPjL
         h4Z3Bghpu4o4UWpLzafgf2RGif2EEcUTrhxrgfU/KyamtFN+h1hDdVAyDGlmyFxBpAqw
         5Yi1Qd/kKeIKwxUKjIW/Oo9JyjJwAXYuhMhDmqxmeJlD8ZdYLR1lpz5hGEUB0SZe0ErC
         0NTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HjwB36213IT/AYydMq06cEXPabbQK09FrMpP6mIrkTM=;
        b=KzT+3l52U7XiqNZ+AteouZjNZDrvyz2M5cTEaYyNPFxCgaxBey22lvbuwvu8MDq62N
         HE4aWqnC5V+D3skl/IflubdOwW80h4DFUX/hfnaQNzehMQu93L2yJHQfmV+pZo5Vr7tx
         9AuJlRNaxob9657StjFUY9l7fgiQvrcNmuM1m4CfAjQMpsPRU1g3fGP6kOwI5wws6a7e
         r4nQFCVwFz9dnJjiukzvf2MdH7yLkDa2MuT6rT6x/JBHK742X0Es2llVFh97ymBFZfaY
         jnKFSKiWtsC84kZ10MftrzDx4rYUajeMT3CVENn2BA1NECT6wbfqVQyTkrxDe8GWX8XE
         8UUA==
X-Gm-Message-State: APjAAAXQJieAp7BwguV2uRQTLXHWfj19jhfr9iApNbaPHNFMQA6x/I/a
        9egTrqmBAfzRqFwaY8ayOCepoGxL5rdVx/GYbB/pOr1x4f0=
X-Google-Smtp-Source: APXvYqw0ccj18afICI4j6dVPo21gqeQgFogO/djxo5+pVzGrxZ/mxBCGq7sW3eFooYKPiFo4rFrEeVcCOrATP5ocXcg=
X-Received: by 2002:a50:b6db:: with SMTP id f27mr1381290ede.188.1551391669629;
 Thu, 28 Feb 2019 14:07:49 -0800 (PST)
MIME-Version: 1.0
References: <CAHd-oW7onvn4ugEjXzAX_OSVEfCboH3-FnGR00dU8iaoc+b8=Q@mail.gmail.com>
In-Reply-To: <CAHd-oW7onvn4ugEjXzAX_OSVEfCboH3-FnGR00dU8iaoc+b8=Q@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 28 Feb 2019 23:07:37 +0100
Message-ID: <CAP8UFD0jF5k31tBhj=bQMGOJKN8-F-Rx7RXF1SHZ22LEgSo9_Q@mail.gmail.com>
Subject: Re: Questions on GSoC 2019 Ideas
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Elijah Newren <newren@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

On Thu, Feb 28, 2019 at 10:46 PM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> I've been in the mailing list for a couple weeks now, mainly working
> on my gsoc micro-project[1] and in other patches that derived from it.
> I also have been contributing to the Linux Kernel for half an year,
> but am now mainly just supporting other students here at USP.
>
> I have read the ideas page for the GSoC 2019 and many of them interest
> me. Also, looking around git-dev materials on the web, I got to the
> GSoC 2012 ideas page. And this one got my attention:
> https://github.com/peff/git/wiki/SoC-2012-Ideas#improving-parallelism-in-various-commands
>
> I'm interested in parallel computing and that has been my research
> topic for about an year now. So I would like to ask what's the status
> of this GSoC idea. I've read git-grep and saw that it is already
> parallel, but I was wondering if there is any other section in git in
> which it was already considered to bring parallelism, seeking to
> achieve greater performance. And also, if this could, perhaps, be a
> GSoC project.

I vaguely remember that we thought at one point that all the low
hanging fruits had already been taken in this area but I might be
wrong.

> I'm also interested in the 'convert script to builtin' task, and I was
> wondering if 'git-bisect' would be a good candidate for that.

There is an ongoing work on that by Tanushree Tumane, an Outreachy
intern. The end of the internship is March 5, but it seems to me that
there is not a lot of work left on the project, and hopefully
Tanushree or her mentors will take care of that.

Best,
Christian.

> Thanks,
> Matheus Tavares
>
> [1]: https://public-inbox.org/git/20190226051804.10631-1-matheus.bernardino@usp.br/
