Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 198D0211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 19:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbeLDTBY (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 14:01:24 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40001 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbeLDTBY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 14:01:24 -0500
Received: by mail-ed1-f65.google.com with SMTP id d3so14862811edx.7
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 11:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=loskot-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=KgqmfVS8s/wQzHKyzIk0frTxhIOJTDMrKlTAkn9iNbc=;
        b=vdZgcH3fStP9W6rpTuwi+l0Cw4QMjtfb/dqsSNbcE9W+H71vG5vffWjEcEPzKVI7g1
         8Wjp99qtVujM3Fv4tMetkIE21mbuKAPi2ohFhmhxOgecxIm/FoHXi5HfEUOZuroDhWyA
         Y2IDgHSiwIexAuMIXEZX8uh/w4+t1K0ijpXoJGf6eFwtCOLkJoYCxN358m17WIt8R7kK
         /GOF+qZXtFNSbFq7fuAE/UCkAg5Z6lGwY06vLVD8jzjcG6grTfRsd7WUcU+5kjE3gK32
         wIv6ksilMUsCAUWwTbJ2Wv1EHnH7H2JM6u6C6MZj0jxke+A5DwCLUfYwx1owtWHa4fFn
         mFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=KgqmfVS8s/wQzHKyzIk0frTxhIOJTDMrKlTAkn9iNbc=;
        b=rXfV/i9y0ajWNnahtqodzJHktRSEeYxrX6y68sy9IoQFE2iX0cf0s9/veDF9Awpt/k
         gIKgHycCO1pbLzGONa/HSrV/x+It+k+1cYcUby8Ae3DKDbmOKyxj5AN7YYCfHhWOdOOq
         O6PAWJxu1cyqL1KsCNBcLbwOtQ7qkPIaRq1vu+eIDJwZ5Pqqm/Kp+oQJwE8WofjO+Sdr
         j1uTnTL9NTECukyVqU48RG7Eai5JyCO7l5/ynhl5lDRchTx9VDrlP7R5H4ReLLXDJ/HD
         COW9kGCfVyDwnumHOngeQUvNtDQACQse4Aca27xjBBzRvdHIvgKTtNxvSa1qgj/rT5Xq
         Jh6Q==
X-Gm-Message-State: AA+aEWbp5ZcsKb9f/sq5WVeXQE8ywZPIwYnwObaOvZ5Ya3vF7IfjLNky
        DETDlqfzJtqQIGQRAwsmeKwjphqO2zpERd9mh1BZia/k4fc=
X-Google-Smtp-Source: AFSGD/WVW+4kXWM8sHwg+4+2qa9+Y2wUtFpgLG7rDb+pqs2pxpljCh3p5uARlXt1aKyrPy7aO5j+HaifqSFnsprCt18=
X-Received: by 2002:a50:ef18:: with SMTP id m24mr18690567eds.136.1543950082018;
 Tue, 04 Dec 2018 11:01:22 -0800 (PST)
MIME-Version: 1.0
References: <CABUeae-e33Jc4s4MezjhpVsEJ_0sO8QZ1mpa1z_79ZGuQWM-Xw@mail.gmail.com>
 <87y39cx6wt.fsf@evledraar.gmail.com> <CABUeae_VVtbj0JCRyUuqf=uaPFXkmHwHpYyapH4H5A_cQSQsdA@mail.gmail.com>
 <87va4fyjtv.fsf@evledraar.gmail.com>
In-Reply-To: <87va4fyjtv.fsf@evledraar.gmail.com>
From:   Mateusz Loskot <mateusz@loskot.net>
Date:   Tue, 4 Dec 2018 20:00:55 +0100
Message-ID: <CABUeae9w4kfrPp3ZkdYpBb3o5cRqdxhvMixUAjVLQzS+2LYF=w@mail.gmail.com>
Subject: Re: Simple git push --tags deleted all branches
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 29 Nov 2018 at 16:39, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avara=
b@gmail.com> wrote:
> On Thu, Nov 29 2018, Mateusz Loskot wrote:
> > On Thu, 29 Nov 2018 at 16:03, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
> >> On Wed, Nov 28 2018, Mateusz Loskot wrote:
> >> >
> >> > (using git version 2.19.2.windows.1)
> >> >
> >> > I've just encountered one of those WTH moments.
> >> >
> >> > I have a bare repository
> >> >
> >> > core.git (BARE:master) $ git branch
> >> >   1.0
> >> >   2.0
> >> > * master
> >> >
> >> > core.git (BARE:master) $ git tag
> >> > 1.0.1651
> >> > 1.0.766
> >> > 2.0.1103
> >> > 2.0.1200
> >> >
> >> > I published the repo using: git push --all --follow-tags
> >> >
> >> > This succeeded, but there seem to be no tags pushed, just branches.
> >> > So, I followed with
> >> >
> >> > core.git (BARE:master) $ git push --tags
> >> > To XXX
> >> >  - [deleted]               1.0
> >> >  - [deleted]               2.0
> >> >  ! [remote rejected]       master (refusing to delete the current
> >> > branch: refs/heads/master)
> >> > error: failed to push some refs to 'XXX'
> >> >
> >> > And, I've found out that all branches and tags have been
> >> > wiped in both, local repo and remote :)
> >> >
> >> > I restored the repo and tried out
> >> >
> >> > git push origin 1.0
> >> > git push origin --tags
> >> >
> >> > and this time both succeeded, without wiping out any refs.
> >> >
> >> > Could anyone help me to understand why remote-less
> >> >
> >> > git push --tags
> >> >
> >> > is/was so dangerous and unforgiving?!
> >>
> >> Since nobody's replied yet, I can't see what's going on here from the
> >> info you've provided. My guess is that you have something "mirror" set
> >> on the remote.
> >
> > Thank you for responding.
> >
> > The git push --tags hugely surprised me, and here is genuine screenshot
> > https://twitter.com/mloskot/status/1068072285846859776
> >
> >> It seems you can't share the repo or its URL, but could you share the
> >> scrubbed output of 'git config -l --show-origin' when run inside this
> >> repository?
> >
> > Here is complete output. I have not stripped the basics like aliases,
> > just in case.
>
> Right, it's because you used --mirror, the important bit:
>
> > file:config     remote.origin.url=3Dhttps://xxx.com/core-external-metad=
ata.git
> > file:config     remote.origin.fetch=3D+refs/*:refs/*
> > file:config     remote.origin.mirror=3Dtrue
> > file:config
>
> I.e. you have cloned with the --mirror flag, this is what it's supposed
> to do: https://git-scm.com/docs/git-clone#git-clone---mirror
> https://git-scm.com/docs/git-fetch#git-fetch---prune
>
> I.e. you push and git tries to mirror the refs you have locally to the
> remote, including pruning stuff in the remote.

Thank you very much for diagnosing my issue.
I was not aware about how --mirror affects the workflow.
It all makes perfect sense now.

Best regards,
--=20
Mateusz Loskot, http://mateusz.loskot.net
