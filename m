Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D3461F453
	for <e@80x24.org>; Wed, 13 Feb 2019 10:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389440AbfBMKYI (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 05:24:08 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38971 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732488AbfBMKYH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 05:24:07 -0500
Received: by mail-wm1-f68.google.com with SMTP id f16so1785823wmh.4
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 02:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=w8s4xqarD+TOJ2sn3fzzu9Bu2i3uGYmAngLGkJRW3Hc=;
        b=BH4akuYirJZlCZo/bNZRW2ECh210CjE/Q6zmF46f/43xckdzemHGAFRBgbMBi/wbvX
         BMz5RH4sBflQcZiyxwYm79U2g3/VVpwiFfQCpLIhEWkpXbU1rtKwhgmv+5EWcGxLMH7K
         jZ0ruUY4srRsCCeIgY0rReFGOlaOJB9WSUkCcEi3bCPVJZCgXBv5z+I//x1XUdkomAMW
         Kc/0qKX/KdNGXBUVCDC6SA2bhQYJNRqv+2n12Wz0SMebLFS5yZSH2aTQ82Yl0cYKkB2e
         xhOfPZVfGGLUdZI/VomiOtab68YuA9gWuoZUMt1hmlAXLHUxGaoKWO211KCmAWSblwjH
         ZRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=w8s4xqarD+TOJ2sn3fzzu9Bu2i3uGYmAngLGkJRW3Hc=;
        b=USZR1XifPF3wiGD3Ix07nu+bQ4Ud5vkALONuTgBMCmyQVAYtORVsLZCadSDpSCzxZt
         IN2o+L8AtE9Qx4l4r3U7/gm/bQJJhUXLkIkqw0IcegQ1/NMVZd9xTihY4E1x0Jvm8JVl
         Hfoq3Z4WiRTEuOgkxH1ZKYgb3bgvWD9+ZYQCYE9ILGGL8l6DqG5Os78rWeCt2ugV9y3n
         E1/of3IHDOR9vd1s91C6hG8oK+au9L4zquSxHJ9pBbLySmyBYvU8KJIbMjQr3g3l1TaT
         qPpCm7OUPTUNZU8SDJZaAigH4k+IJ1CXwOf8iU2+qFEPhTxBYAekgir3p6DbduxZb/PH
         H0ZQ==
X-Gm-Message-State: AHQUAuap2Fc+0K6zJP0SP+9siBED1PFANlSSXoq8VSZmpJ53jTnOdYi9
        gi/+NwmF21JGx0uyMFivxmT4BdGC
X-Google-Smtp-Source: AHgI3IYSBhaov8CFa3YdbElChHAc9QariGBglZVRx7+1XNSSpQCB+yXY71NnPjUkL7UKhmyit61MqQ==
X-Received: by 2002:a05:600c:2255:: with SMTP id a21mr2830919wmm.31.1550053445921;
        Wed, 13 Feb 2019 02:24:05 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id d4sm4260121wmb.25.2019.02.13.02.24.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 02:24:05 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Petri Gynther <pgynther@google.com>
Cc:     git@vger.kernel.org
Subject: Re: Feature request on git log --oneline <revision range> -- <path>...
References: <CAGXr9JHb1hjtMamdWt=oDg_eeBEuiDcbzAx+1XpV+HvvX1xsaA@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CAGXr9JHb1hjtMamdWt=oDg_eeBEuiDcbzAx+1XpV+HvvX1xsaA@mail.gmail.com>
Date:   Wed, 13 Feb 2019 11:24:04 +0100
Message-ID: <87k1i4j8aj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 13 2019, Petri Gynther wrote:

> git developers:
>
> Small feature request on:
> git log --oneline <revision range> -- <path>...
>
> Could we add an option to:
> 1) display all commits in <revision range> unconditionally
> 2) use a special marker (e.g. star) for commits that touch <path>...
> and list the files from <path>... that this commit modified
>
> Sample output:
> git log --oneline (--annotated?) HEAD~5..HEAD -- Makefile kernel/printk/printk.c
>
>   aaaabbbbccc1 uninteresting commit 1
> * aaaabbbbccc2 fix Makefile
>     Makefile
>   aaaabbbbccc3 uninteresting commit 2
> * aaaabbbbccc4 fix Makefile and printk()
>     Makefile
>     kernel/printk/printk.c
>   aaaabbbbccc5 uninteresting commit 3
>
> In other words:
> - commits that don't touch <path>... are still listed (without special markers)
> - commits that touch <path>... are listed with * prefix, and the files
> from <path>... that the commit modified are listed below the commit
>
> This is very useful for kernel LTS merges, when we want to know which
> LTS patches in the merge chain actually touched the files that matter
> for a specific build target.

What do you think such an option should do when it finds negative path
specs, e.g. this on git.git:

    git log --oneline --stat -- ':!/Makefile' '*Makefile*'

Should it only render positive matches, or distinguish between
matched/blacklisted/not-matched, your example (with no negative
patspecs) just shows matched/not-matched.

> Is this an easy add-on to git log?

It's been a while since I looked at this code, but (depending on the
answer to the above) I don't think it would be that hard. We already
pass up what we matched for the --stat machinery. E.g. try on git.git:

    git log --oneline -1 --stat 32ceace39f --
    git log --oneline -1 --stat 32ceace39f -- '*fetch.c'

The former shows a few modified *.c files in the --stat, the latter just
builtin/fetch.c since it matched.
