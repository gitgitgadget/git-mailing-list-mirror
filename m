Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB6741F404
	for <e@80x24.org>; Mon, 17 Sep 2018 13:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbeIQTBH (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 15:01:07 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33042 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728431AbeIQTBH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 15:01:07 -0400
Received: by mail-ot1-f66.google.com with SMTP id i10-v6so11263955oth.0
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 06:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7kmpBBO0WCs7+GWLtB4lv3nYv2jlHTVwYS3d0uRYT0I=;
        b=nVh1O0cva1kQLAGy4luuFugpSqU/xKV54T0j4RdTBPcOq3jshwvAFx+RNswDPoeJpv
         GNlAQWgNLbElXsD9yjCIsDrhK0AxEPPThNtqWoPFFOhDG4DN6nZjviIg1yO3y313WrLh
         CJGGouHTWRbINXg4rLfULat3pKFKYT/GmgN49CrYOc7YJO/llaNIb7yDQxdqVTsdKD+9
         e2/XvZPd18o6AHPfcfUV4LvDchWXYF7hEjpWQppjywOndmvykLQhUj93QNRl11ZAnbzR
         5zpLnsHhc9mgkIiMhzbAIj6Qi6sW1CgHi02bwpRNnTiu4Bx20XjOZd+XYNXG5EeYFK/S
         OyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7kmpBBO0WCs7+GWLtB4lv3nYv2jlHTVwYS3d0uRYT0I=;
        b=kgkz86KT76GRmwMt5ihelOspYqQiVc8cLHAf92sD543EfAg5MnOqvfqir/zk1UwyYC
         eFokOD60QOuoHVArcl9zOUm993yLGIG7BVQk9wcmk3Ldimp8h4daPdaFRMkIAkGagQHP
         Go5acIryl5bPQjzXTd6aPqJLWC8O5vzlKBxIx7aHUaqzYNbiXGvEkKBf7ZuR6gPpueeF
         12XiC6m+0dYrL3JpvE01gXU/aq1XqgfA5KsVkQc6VfjwSp7sRxV8m/YCAvrg9Sk9HUAy
         aAtmXe7EUW46uoA9ayG+JUpRgaZXfQr6NNsN2LiHVWP1VM263n4GF+ystTVrp21rhj6U
         rALg==
X-Gm-Message-State: APzg51ALOdTSdP3URsJxi2cixHdiScuTvcfL/GreTbgnx9AlHZjpzXbZ
        ihCK5oi37OqW5gxbZzlU/7E9satfRwlfvfTjZdP26QTe
X-Google-Smtp-Source: ANB0VdYdb7apbFDq2PNajQ+K+1mFK8LNnijbx3vb78NxGMrlcl9aT4Q6+E5KGctohtYCvvMJIWgTnZvPUfsOF0lMt2w=
X-Received: by 2002:a9d:3d22:: with SMTP id a31-v6mr11788127otc.326.1537191225162;
 Mon, 17 Sep 2018 06:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <CACU07Yt5vh36tHcHxV-b_5MNLc-RzqGQ7=nkJq-DTqNgmYP+wA@mail.gmail.com>
 <875zz4l0kv.fsf@evledraar.gmail.com>
In-Reply-To: <875zz4l0kv.fsf@evledraar.gmail.com>
From:   Nikola Milekic <nikolamilekic@gmail.com>
Date:   Mon, 17 Sep 2018 15:33:47 +0200
Message-ID: <CACU07Yug+oiiKXa53W6f+mugLPdrXOHRRDbWVOpbwwKov4MiFA@mail.gmail.com>
Subject: Re: Differences between git show HEAD and git show head
To:     avarab@gmail.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ups, my bad, didn't realize that. Apologies for spamming. Would love
to help but unfortunately I have no C background.
On Mon, Sep 17, 2018 at 3:23 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, Sep 17 2018, Nikola Milekic wrote:
>
> > Hi,
> >
> > On Windows, when using multiple workspaces and git 2.19.0.windows.1,
> > 'git show HEAD' and 'git show head' return different results when
> > executed from a secondary workspace (the one without the .git
> > directory).
> >
> > 'git show HEAD' shows the HEAD of the current workspace, while git
> > show head shows the HEAD of the main workspace (the one with the .git
> > directory). I find this to be highly misleading, especially for users
> > like myself who are not used to typing HEAD in all caps. Is this
> > indented behavior or a bug?
>
> This is an outstanding bug in git that's tricky to solve (maybe you're
> interested!), here's a recent discussion about it:
> https://public-inbox.org/git/87ziclb2pa.fsf@gmail.com/
