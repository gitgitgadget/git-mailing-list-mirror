Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1147211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 15:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbeK3Co6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 21:44:58 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:56317 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbeK3Co6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 21:44:58 -0500
Received: by mail-wm1-f49.google.com with SMTP id y139so2711054wmc.5
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 07:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=/3prHDuYnehrR9ce1T++0K550wX5ID9r/9fv+r910RU=;
        b=S9cBg7R2uCno1i7h7jfbcodfQEgs+EKLNDUtKXmMnnr9nwBVbKygi59uSbtg44Vy5b
         4qMERiv/m5h1ka/rH7gSgrrMTuQKDZKcBh7rPft/RVUbniYJrzsS5Qz1Tx/TGb938Cxo
         nBZXaABEOuxdFGpTcKN/O5CA/YUbZC2Ztyncneshm4WjQwu6F7j3IMC50FHkUSYqOfi+
         JBcRezf9FW7WyL8XscHbC8EUrs8vRB4knROEUe9PFlNtHvHkapyH8/U/xn9fmJeFUiyh
         FgijIwx3Dvwr4P7eX3ZFoKyigMRbKz5KYa+CjWcqqQv1h+uaFVwYKP2mfgHH8RRv+f8J
         WO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=/3prHDuYnehrR9ce1T++0K550wX5ID9r/9fv+r910RU=;
        b=IPCJ6yYk1opl5PD9bZlaJXuH5OiLcXBzT7BoAhlS6/cbpO1DT2VFOGUC4UphDTNRvf
         H++O6bHVXJBCIDI7n8iHj7h0kjFNJjFxlMvLYIFGnT+BPrsXMmXWlqcsCxNw8hryDHgm
         nuc3QCjrTnSP8ZCseNCvF0II9NSjfZbTiJiC+pH5+T0MPasvaxazmGnyV1Wlne25UVlK
         R5cQQG01ZhyyewqhFWFg1QxL1OtzifKhBz+Uxl05Yc34H+q1sHh0scWe7Z6NESxUAuxN
         Ix3rZSi4GSZplOw9hr5YizQVP+ZM7k6dNJXNxGBFAVce3ZHxYwCM7SxUD1N9cuZo3mP6
         mjPw==
X-Gm-Message-State: AA+aEWZp2hGgBfZqeN2Ki0YOCrqA3mjN9xF14pNpBAvBhFrMtDiViuKd
        hcFffo1GHhnGUFdZQ1fbtOxSLqLx
X-Google-Smtp-Source: AFSGD/Xyr64J75e47JBEAalOVGJbxAlFKC5YrXv9dv6jMpvvAr1SdVHbLhJVJk7vK9miYWJ6Zr7pjQ==
X-Received: by 2002:a1c:a6cd:: with SMTP id p196mr2200310wme.142.1543505950245;
        Thu, 29 Nov 2018 07:39:10 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id n5sm1428021wrr.94.2018.11.29.07.39.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 07:39:09 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Mateusz Loskot <mateusz@loskot.net>
Cc:     git@vger.kernel.org
Subject: Re: Simple git push --tags deleted all branches
References: <CABUeae-e33Jc4s4MezjhpVsEJ_0sO8QZ1mpa1z_79ZGuQWM-Xw@mail.gmail.com> <87y39cx6wt.fsf@evledraar.gmail.com> <CABUeae_VVtbj0JCRyUuqf=uaPFXkmHwHpYyapH4H5A_cQSQsdA@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CABUeae_VVtbj0JCRyUuqf=uaPFXkmHwHpYyapH4H5A_cQSQsdA@mail.gmail.com>
Date:   Thu, 29 Nov 2018 16:39:08 +0100
Message-ID: <87va4fyjtv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 29 2018, Mateusz Loskot wrote:

> On Thu, 29 Nov 2018 at 16:03, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>> On Wed, Nov 28 2018, Mateusz Loskot wrote:
>> >
>> > (using git version 2.19.2.windows.1)
>> >
>> > I've just encountered one of those WTH moments.
>> >
>> > I have a bare repository
>> >
>> > core.git (BARE:master) $ git branch
>> >   1.0
>> >   2.0
>> > * master
>> >
>> > core.git (BARE:master) $ git tag
>> > 1.0.1651
>> > 1.0.766
>> > 2.0.1103
>> > 2.0.1200
>> >
>> > I published the repo using: git push --all --follow-tags
>> >
>> > This succeeded, but there seem to be no tags pushed, just branches.
>> > So, I followed with
>> >
>> > core.git (BARE:master) $ git push --tags
>> > To XXX
>> >  - [deleted]               1.0
>> >  - [deleted]               2.0
>> >  ! [remote rejected]       master (refusing to delete the current
>> > branch: refs/heads/master)
>> > error: failed to push some refs to 'XXX'
>> >
>> > And, I've found out that all branches and tags have been
>> > wiped in both, local repo and remote :)
>> >
>> > I restored the repo and tried out
>> >
>> > git push origin 1.0
>> > git push origin --tags
>> >
>> > and this time both succeeded, without wiping out any refs.
>> >
>> > Could anyone help me to understand why remote-less
>> >
>> > git push --tags
>> >
>> > is/was so dangerous and unforgiving?!
>>
>> Since nobody's replied yet, I can't see what's going on here from the
>> info you've provided. My guess is that you have something "mirror" set
>> on the remote.
>
> Thank you for responding.
>
> The git push --tags hugely surprised me, and here is genuine screenshot
> https://twitter.com/mloskot/status/1068072285846859776
>
>> It seems you can't share the repo or its URL, but could you share the
>> scrubbed output of 'git config -l --show-origin' when run inside this
>> repository?
>
> Here is complete output. I have not stripped the basics like aliases,
> just in case.

Right, it's because you used --mirror, the important bit:

> file:config     remote.origin.url=https://xxx.com/core-external-metadata.git
> file:config     remote.origin.fetch=+refs/*:refs/*
> file:config     remote.origin.mirror=true
> file:config

I.e. you have cloned with the --mirror flag, this is what it's supposed
to do: https://git-scm.com/docs/git-clone#git-clone---mirror
https://git-scm.com/docs/git-fetch#git-fetch---prune

I.e. you push and git tries to mirror the refs you have locally to the
remote, including pruning stuff in the remote.

This is useful, but not what you wanted here. It's used for e.g. making
an up-to-date copy of a repo from server A to server B in HA setups
where you'd like to fail over to server B and get the same refs you had
on A.
