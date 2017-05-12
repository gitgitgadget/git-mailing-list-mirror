Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A02220188
	for <e@80x24.org>; Fri, 12 May 2017 08:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755284AbdELI6s (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 04:58:48 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:34152 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbdELI6q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 04:58:46 -0400
Received: by mail-io0-f169.google.com with SMTP id k91so36398084ioi.1
        for <git@vger.kernel.org>; Fri, 12 May 2017 01:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vp9r5Jspa5+OPG4gBxH+txVZcjYbF3uAptumduQARBI=;
        b=fZ3L6bELc7zXYzI2jjLLfLsAtEdpIAkKF59GA+No7jnwFh0Ne8JLMKGrAf2KyFp7XK
         PXNXOe/3L7OXkZCAUo/+yZWdi3slfqzJ1itZ/HtLj2mfCVQbIxKVbBpYKMwGr3PuFIYR
         FDmjDHPIBGYGdjDYXe/e3FxmD2AG1KFceCc4Ggr9ixQp0o+N8SivowFrP+Dk8NXANhpf
         jmhi/E1ph8/PX31wty4SEGNwf3rpPnWI7kRf8lj4WdNTSaiHC7VcbcoHdKwtEFOGMQUb
         SlsGDBcTBRlu7hNid0DjeIb6J3LvaO7+saEdPdoZYlGSOhbR09L7OANk0YUKEvPCpZsM
         IvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vp9r5Jspa5+OPG4gBxH+txVZcjYbF3uAptumduQARBI=;
        b=etQpa82iz/X4A792uyvup7kuL0r+0BijZ9GR41jvNmOqppskxLwuIx4Q3Csn8VMmUc
         zZBAFT3+JaoeT9+1B77fprBQ1Vwjba00w4lWrUe0Mc2rb8ig84RPfgEoWraGmwdjyTtF
         4dGGzOIvM9iKs3UZE57XoL4zppYArr5MgJCZVcCaqxwzvVYp3R7aWh13SXa2GG375uXM
         HrA130Ga2s2JzfsWhvjZF6JuR2V6PPxFbYltecq2KkVY5CsJdljOb5dzU71ZN94Ckiyd
         NDTBU1gUD5IrJGQOtv7uwQoIT+9B8UmhFQs9uNe8b4GIjJMoRatNyiS4Twm96lbbjE1g
         +TAA==
X-Gm-Message-State: AODbwcDvqEXvlie0hFT+Kw2Ho0R8q3wNH0XtcM/ILgohNjVQ0Nk2fkXr
        wDmqQCUnNFHZM6qq4gai0/ZeFAi5hg==
X-Received: by 10.107.178.12 with SMTP id b12mr2375392iof.50.1494579525402;
 Fri, 12 May 2017 01:58:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Fri, 12 May 2017 01:58:24 -0700 (PDT)
In-Reply-To: <F55DC360-9C1E-45B9-B8BA-39E1001BD620@gmail.com>
References: <F55DC360-9C1E-45B9-B8BA-39E1001BD620@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 12 May 2017 10:58:24 +0200
Message-ID: <CACBZZX7-Gw7G7yY=ah6AQCJKzWKB002iAo6RNJwZmvMRe4Pd+w@mail.gmail.com>
Subject: Re: Possible bug in includeIf / conditional includes on non git
 initialised directories
To:     Raphael Stolt <raphael.stolt@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 8:53 PM, Raphael Stolt <raphael.stolt@gmail.com> wr=
ote:
> Hi there,
>
> I might have stumbled this time over a real bug in includeIf / conditiona=
l includes or maybe it's just as intended.
> 1) Given I have a correct configured includeIf and I=E2=80=99m issuing `g=
it config --show-origin --get user.email` against an directory which hasn=
=E2=80=99t been `git init`ed I get the user.email configured globally.
> 2) Given I have a correct configured includeIf and I=E2=80=99m issuing `g=
it config --show-origin --get user.email` against an directory which has be=
en `git init`ed I get the user.email configured conditionally.
> For 1) I would probably expect to get the user.email configured condition=
ally even for a plain directory.
>
> More details see this (http://stackoverflow.com/questions/43919191/git-2-=
13-conditional-config-on-windows/) Stack Overflow question.
> Best regards,
> Raphael Stolt

The "this is how this works" has been covered already by others, but
can you elaborate on the use-case, why does it matter for you that
"git config" doesn't show your user.email when you have no git dir
there, I can't think of a reason for why this would matter since
there's no .git there, so there's no way anything can use the config
info at that location.
