Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 307861F404
	for <e@80x24.org>; Mon,  9 Apr 2018 18:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752078AbeDISFt (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 14:05:49 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:43402 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751507AbeDISFt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 14:05:49 -0400
Received: by mail-qk0-f172.google.com with SMTP id v2so10351634qkh.10
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 11:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=AyW/jQEvsInnSYqNaQ+S+yHVM76m9TFC7H9I3IuJXIE=;
        b=nVbeJWXCCJiYd8Ys4FXjj8/utOHJvDzkgzFOkUElBY5dTXHjLF5jrFMXZLWFVqbpWR
         qaTVd9zRc5nFmDogKrkFEH5QV1l/F2e7vAokCM1QJ5gwjGizxQK9mFaF1ahjFFpDMkNW
         FJzwsXF+hu7IG6MeaqU1x2+KnjZEi04QUJagx0QO3Hn4cP5OtA9R7lj26UQX1GZtvdbD
         kfbBKrTPOgmzjTgkEHhMCh/380VPLpyF4QMDtlFyDuTgohNNwMEHe1dx9AQ+qUu4zMx6
         9x4C5q0q/RwLmBqtdnuC0bjdsYYLfHDS6HqF7InK7tZgQXpYVPDB7pagbkjepojZitdH
         gVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=AyW/jQEvsInnSYqNaQ+S+yHVM76m9TFC7H9I3IuJXIE=;
        b=o620EwJO6ZjYhBbkNoRS+F0ByzdXaTz7ggMDV1eEj9OX0cAoPtt0+BEZAnYDsnPMle
         H3bxwebKOXh4Q6eDlnFgjox4XrURhtx/z6PLLsCntgDiiUZ2Ry4S5lcRRrSkEgsapLJY
         73qMQXj5g1yYVDKBpGDq7nioFLsQujguzOxOcugGUPIqK01r43PyylUDJ5hjldFVQbSt
         M6xbBIQy84JDLttum392VrIZU1xrXn2LftC4DBS7wJLjNoNO7wk0yKvxrakN0/aF1sRy
         cKKRx4Kmrf2pXq7UBOkurVTt2GByEUdUP1/1NFysZ/NcadqmocC186WVPF2HWE9ghH2K
         aKMw==
X-Gm-Message-State: ALQs6tB0nMmxtyTnbzT9J62Nubojd/sboRi5o6BuCjd+7tNAQIFtkyS1
        X5SXTvxlabnxpC1Ue1ghYiYoRTT06sKNAWJnlvM=
X-Google-Smtp-Source: AIpwx48pz1xe3FVjn9X/Cf4PF9/VXHEUNc1en0CXm0vmkn5plB8UsTA5lTO/JQr8OaT5OHXuqkK8dx217ubixIZlDS0=
X-Received: by 10.55.108.69 with SMTP id h66mr50314017qkc.42.1523297148208;
 Mon, 09 Apr 2018 11:05:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Mon, 9 Apr 2018 11:05:47 -0700 (PDT)
In-Reply-To: <CAHKv1qs-cnmcd2pR9iv=Xx1aKnb=SEsCQ7OAjy-4yHhCE_e_dw@mail.gmail.com>
References: <CAHKv1qs-cnmcd2pR9iv=Xx1aKnb=SEsCQ7OAjy-4yHhCE_e_dw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 9 Apr 2018 14:05:47 -0400
X-Google-Sender-Auth: ndYIXysJdRWJyfDAljhzLlIbw0U
Message-ID: <CAPig+cRNbDBpDn_ku0cXJhzvnrSOkBTztp8tWomePxfXaviotw@mail.gmail.com>
Subject: Re: Want to start contributing to git through this task: "Use
 dir-iterator to avoid explicit recursiv
To:     vaibhav kurhe <vaibhav.kurhe@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 9, 2018 at 9:51 AM, vaibhav kurhe <vaibhav.kurhe@gmail.com> wrote:
> https://git.github.io/SoC-2018-Microprojects/.
> Out of the tasks listed down in above URL, I found this one interesting:-
> "Use dir-iterator to avoid explicit recursive directory traversal"
> I cloned the git repo and browsed through it. I found that in git
> clone (buildtin/clone.c), raw directory API readdir() is used
> recursively.
> So there is a place to change it to use the already available
> "dir_iterator" structure.
> I just want to know, if anybody is working on this task already.
> If not, then I can proceed to work.

There has been no recent discussion on the mailing list regarding
this, so it is unlikely that anyone else is working on it.
