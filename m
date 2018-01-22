Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D53B1F404
	for <e@80x24.org>; Mon, 22 Jan 2018 18:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751117AbeAVSD0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 13:03:26 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:40334 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbeAVSDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 13:03:25 -0500
Received: by mail-ua0-f196.google.com with SMTP id t6so6439315ual.7
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 10:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=abvHv1lQEStZxhRhsWYkx2pojihSpcgOm66ESjaK9xg=;
        b=k7meC7RetWjZ1WU1Gvs40ogeWptmWUFWavc6bEloXCWOS2PC4gBLDQ5W80zThGFCyU
         +ZtvgcNMIg+fN7vSuPjDjKrC3Wax16650Lsy2JO08ocMnWUI0Yrnawtqg8l11PN+j2h1
         Q8BzpWjWHyu+73qg9ZehCGlhtIAy0ugMFYliI/Hgs5NX63dtEdC12SNrAonVDVeqoq6Q
         M1b/RtgEXiEmuepTL/AoNUtVm2FIpe/t/BScC6VjTKlNfw+BpB7KXBPAxioe2sJjeJIQ
         S537DyJ7Ym0MopG1+zHiVqdanBgUJ6T/etUEWq949VtehERvHtSHWxv5MjzkRtMAG3dv
         ZUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=abvHv1lQEStZxhRhsWYkx2pojihSpcgOm66ESjaK9xg=;
        b=Utfd7lo+d2m56ZINGcibCd34t8GkA/r/qQjeURChDLpsLDRxUl5RPg7DFA3wwrV5Fz
         fsCrBeVoUaKsB2wYm4cimchX1BwbRqMpaFK2GvpecSmc6KtOmUZDqFY4o208fxV6J4XC
         V9gbVdZT4VvXOoa6AQpTns140ljdIgRHsMBl5cbJaSvj+odkK9XHimn2AhPQt2lWrYzr
         Qw1WW7eD9UMGBnboLHXHFnqqfUe+EHrJ8WNTRe3YZZx7IwDtu2+ejc0rgwZMZyk0RJ5J
         QQGSW3dVMRgSvPMmaoMwJGxzn5uSb16c0cwvelo/VUhHzx6PWVsM2YkI5Ehv1f062sLp
         xOZQ==
X-Gm-Message-State: AKwxytcL0CP4+m9nvTFnQNPvtFfq0taEnxbsGp+ZpiEogd/XKo7uwzYg
        g3GhsvX6jg2zDejPWD5/ehmgHXs08Mu1Y+dGilk=
X-Google-Smtp-Source: AH8x2241XMvXsyWBx18JewI7tXGmWyjkvYt/e4g8gZ8rtBcYPsE4/q7Ny3eaN9ymUHnD3T42m1GRcxjmAeF+nR/Mpls=
X-Received: by 10.176.96.4 with SMTP id j4mr5866229ual.180.1516644204898; Mon,
 22 Jan 2018 10:03:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.32.12 with HTTP; Mon, 22 Jan 2018 10:03:24 -0800 (PST)
In-Reply-To: <20180117093432.GA19189@ash>
References: <20180116103700.4505-1-pclouds@gmail.com> <CAM0VKjkz8-VsLJ8i64OHHUH4R4WY5fT6x3X+s=FKuZyfM9txkA@mail.gmail.com>
 <CACsJy8D3wRmP_o5iFJwWtODOJpj-r=JZsJ3P8XxWOCD8rJJrHA@mail.gmail.com> <20180117093432.GA19189@ash>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Mon, 22 Jan 2018 19:03:24 +0100
Message-ID: <CAM0VKj=NeQ_BthG087vswP=mCizXPBcfmCAa9haH4N5MRCNRWQ@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/2] Automate updating git-completion.bash a bit
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 17, 2018 at 10:34 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> Actually I forgot another option. What if we automate updating the
> script at "compile" time instead of calling git at run time? E.g. with
> something like below, a contributor could just run
>
>     make update-completion
>
> then add git-completion.bash changes to the same patch that introduces
> new options. If they forget

They inevitably will :)
If contributors have to remember something anyway, then they might
as well remember to update the completion script in the first place.

Another alternative would be to extend t9902 with (preferably
auto-generated) tests to compare the output of 'git $cmd
--git-completion-helper' with 'run_completion "git $cmd --"'.  Then
contributors wouldn't have to remember anything, because everyone runs
the full test suite every time anyway, right?

However, that would result in some code churn initially, because I
suspect the options are listed in different order in the command and
in the completion script.

All in all I don't think it would trump getting all --options straight
from the commands themselves.
