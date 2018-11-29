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
	by dcvr.yhbt.net (Postfix) with ESMTP id BB2F1211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 15:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbeK3CJN (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 21:09:13 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:38275 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbeK3CJN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 21:09:13 -0500
Received: by mail-ed1-f47.google.com with SMTP id h50so2167016ede.5
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 07:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=LKLIsfzElEH0Ome9VzkOVf8tUfTHoGmSPc/J768u/zE=;
        b=itvYmMyn+gCmgRK4hVOU5ek3RJwERTnMf3casTk9tTFNP7XMQ1Qn8AT6nUMoQRdwsu
         rE3CmKTKgMkJEBVLYYyjXXYmcjMLPFqjJbZNl3yvkuzIadQ/57tncVfMyfP7CQBG4nla
         1+19PMDFjBfmMMkL613eLhIh4hf3ihCvYuB0i0LUfNxzzs3PTJJD73f4/znheQBkyT4m
         84t9NScWZnhbf8Z6R/pyBN8mbkKT0wW6vDftwDtZVwFULGhNsx6eYIlrle8PNYZc3OkR
         buIC2t2y3dQ0fxYrzR8wx1EWydEXGBaBKIVO/e0oq3kFEro2vcAqP7Fk5aeKKdvHv4nO
         ZOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=LKLIsfzElEH0Ome9VzkOVf8tUfTHoGmSPc/J768u/zE=;
        b=Vwzaoq/nNrRrHgGdfOy0I6tYkSsZ80/8VaKXPtDtOJ2ncXWb6K2xT8m8qtGjHiXB8Y
         iOvlU2kjcmpR8VpAHiXBkQlZMzFNhlwYr1zBmOxveCLNqKfWw/sJwJWLRBw7lzdCLDVb
         uBW7Eu1/RJj64NIfaisG31aM+RnTd6URoa0HCDpiGtH5ier+DOaugFxpgVhRgabAVF/H
         dHdrt1C46DVhnjxVA2DP6tJgZig7arWT+MJHsytGeLJIGZc+MldnUw9CNRa2/WwPqeUn
         +0jNUhFdaIsRPMSszw7SDRhBy2wjHXG3S6bPudBzIHz9D0y7XHVMuU2vuMgRq/y2tpaB
         rQPQ==
X-Gm-Message-State: AA+aEWZyfN1SO+XX+W+GDj7HjUWRnxJiyJJBR7wbUaNXTgZmkb0Gc7r4
        pbptRGFrknIadKEiGACA8AwJ9j7z
X-Google-Smtp-Source: AFSGD/VjBbQ+Iau1D8y/7Znpa+jVVlt7kIQDqSELaKEMCknuF92L1IR0+NgvYUalOhyDL0a2Vz2bDQ==
X-Received: by 2002:a50:b103:: with SMTP id k3mr1907442edd.247.1543503812794;
        Thu, 29 Nov 2018 07:03:32 -0800 (PST)
Received: from evledraar ([5.57.21.10])
        by smtp.gmail.com with ESMTPSA id i46sm651292ede.62.2018.11.29.07.03.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 07:03:32 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Mateusz Loskot <mateusz@loskot.net>
Cc:     git@vger.kernel.org
Subject: Re: Simple git push --tags deleted all branches
References: <CABUeae-e33Jc4s4MezjhpVsEJ_0sO8QZ1mpa1z_79ZGuQWM-Xw@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CABUeae-e33Jc4s4MezjhpVsEJ_0sO8QZ1mpa1z_79ZGuQWM-Xw@mail.gmail.com>
Date:   Thu, 29 Nov 2018 16:03:30 +0100
Message-ID: <87y39cx6wt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 28 2018, Mateusz Loskot wrote:

> Hi,
>
> (using git version 2.19.2.windows.1)
>
> I've just encountered one of those WTH moments.
>
> I have a bare repository
>
> core.git (BARE:master) $ git branch
>   1.0
>   2.0
> * master
>
> core.git (BARE:master) $ git tag
> 1.0.1651
> 1.0.766
> 2.0.1103
> 2.0.1200
>
> I published the repo using: git push --all --follow-tags
>
> This succeeded, but there seem to be no tags pushed, just branches.
> So, I followed with
>
> core.git (BARE:master) $ git push --tags
> To XXX
>  - [deleted]               1.0
>  - [deleted]               2.0
>  ! [remote rejected]       master (refusing to delete the current
> branch: refs/heads/master)
> error: failed to push some refs to 'XXX'
>
> And, I've found out that all branches and tags have been
> wiped in both, local repo and remote :)
>
> I restored the repo and tried out
>
> git push origin 1.0
> git push origin --tags
>
> and this time both succeeded, without wiping out any refs.
>
> Could anyone help me to understand why remote-less
>
> git push --tags
>
> is/was so dangerous and unforgiving?!

Since nobody's replied yet, I can't see what's going on here from the
info you've provided. My guess is that you have something "mirror" set
on the remote.

It seems you can't share the repo or its URL, but could you share the
scrubbed output of 'git config -l --show-origin' when run inside this
repository?
