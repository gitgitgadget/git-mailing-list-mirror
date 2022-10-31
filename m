Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DA4ECAAA1
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 17:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiJaRAj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 13:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiJaRAh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 13:00:37 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C89011C3A
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 10:00:37 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 17so6942597pfv.4
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 10:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=woRk90ggCn3WpZAvhqRIHAVisoiOdyg/V6mm0BHPDoY=;
        b=atsc46VUv4wYzUq1VmKyUFnwUog8IcvQ8ck9fcKSqLR6q6dp3qhLnW6OlUOKh7Qd7k
         9MfpFHZvnmd5xPNsMGwvYjJGCWsqVTMcseiR6nIROgDveWBKW3yOVlKd6CJvyF52P7H0
         vwfzaKDXqBQSZCJedr+rcqrpXhy2xGSTeQcqvstEwXFMAYyqaaB8jZtJuvCJvtn4dPF+
         RZLQM5syk2cYUfZD98ccGMmVyVZiJoGYdDoKAVeEQULIA1Opkr/K0ubLinEAsIidpVYi
         7ScLgQxJYCAQO2ytVn6k/GQpnn5JPdwiXdMDXd5xqYWECDxaCL7z0hrsFj3vpXbbYOmy
         F6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=woRk90ggCn3WpZAvhqRIHAVisoiOdyg/V6mm0BHPDoY=;
        b=nBDc9jS968dmObKON5d68nwRCDuCy/oneymFRbbNP7E0G+LsJxQQw18X2S8ZHdyuqz
         Ah6XmL7LNrnNJ6KqocyiVS+9Z8TfU5BOGzpFRpMsK3Ob/6UJnOXX/nWyeLEnMNzrrQAW
         okVhrIAsy3+vKpEUcCSjJ+1Fi0p2mOcoTPabHqxw+OmvE3gE36jYUOmLdWMBP9vuO+lQ
         FyZ1SMfj3DPY0ZpTMc8DDfBxrPbe5wTCqlyjygJgSzi+1Wwsau9wVywtYgE5hsSlAANc
         QNRxW+QO8r9/pcj1cdsLjMOcDbN/t7HIQn1kqEcPjf+T/mk+s3AdXHPZPhqLdnna+hnf
         vHQQ==
X-Gm-Message-State: ACrzQf3chv5oEPHtwJnVbgKkgN451fNIJKGFj1vT7Qt1nmv46/yOHFEu
        oFNQwqctaEqbNk64y7Xwl/mbOJJOqUIv5WSyZL5EYfXaPLM=
X-Google-Smtp-Source: AMsMyM6nFPREUuNuUp8Wb29gDC3K2N2CB6qTbUO0bCUADKflSjBiU2m/gs5jhEke9fuaCVTZfK6OTg/O6Vsfcnsvwj8=
X-Received: by 2002:a05:6a00:150e:b0:56c:83b3:d148 with SMTP id
 q14-20020a056a00150e00b0056c83b3d148mr15537149pfu.48.1667235636880; Mon, 31
 Oct 2022 10:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <4D2B0F7C-3ABD-44B0-BDFC-D5960BE261DD@gmail.com> <Y1/7+S78dbtyTZWU@nand.local>
In-Reply-To: <Y1/7+S78dbtyTZWU@nand.local>
From:   Luna Jernberg <droidbittin@gmail.com>
Date:   Mon, 31 Oct 2022 18:00:23 +0100
Message-ID: <CADo9pHisMqe_2hvJkyLVKfGyKAaV14woOQgvE=Yd7i8vaGGkEQ@mail.gmail.com>
Subject: Re: Large repos mini virtual meetup
To:     Taylor Blau <me@ttaylorr.com>,
        Luna Jernberg <droidbittin@gmail.com>
Cc:     John Cai <johncai86@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Don't have time to attend as its on my birthday

On Mon, Oct 31, 2022 at 5:53 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Mon, Oct 31, 2022 at 11:18:37AM -0400, John Cai wrote:
> > Hi everyone,
> >
> > From our contributor's summit back in September, one theme that
> > emerged was the work around scaling Git for large repositories. In an
> > effort to gain shared consciousness around the problem space, surface
> > opportunities for cross collaboration, and deduplicating current
> > efforts, I am organizing a mini virtual meetup where we can share
> > about common problems we're trying to solve in scaling Git for large
> > repositories.
>
> Thanks for organizing. This sounds like it will be pretty interesting,
> and I'm looking forward to it.
>
> > Anyone is welcome to join! Here are the details:
> >
> > Google Meet Link: https://meet.google.com/zid-azpu-apa?hs=122&authuser=0
> > Google Doc for notes: https://docs.google.com/document/d/18Mh6WokkSb3t7xeLsTdAUrSd8xfxZ4Myc-X25sG8b1Y/edit?usp=meetingnotes
> > Time: Thursday 2022/11/17 11am-12pm PST / 2-3PM EST / 8-9pm CET
>
> Added to the Git calendar.
>
> Thanks,
> Taylor
