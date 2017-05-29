Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B27D2027C
	for <e@80x24.org>; Mon, 29 May 2017 10:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750871AbdE2KXl (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 06:23:41 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:35100 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750787AbdE2KXl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 06:23:41 -0400
Received: by mail-oi0-f46.google.com with SMTP id l18so74104296oig.2
        for <git@vger.kernel.org>; Mon, 29 May 2017 03:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZY6PDtKkP0Eew3mhfR0yA3py5Hwn1DCrEHvLbCkjMoc=;
        b=USew5amPOGvtqyggt32f2TSJZMZwCtGgmjHUbegoS/Rd41bvMcvbGiuAN6ueQ8yYjp
         RJI9JYpHlmMA1C1BaGKcN4SrvPucj7xYmsyJFO+ry5Nt6PjrH/AJjt9ouUJ7AJ8QWMHI
         berPDAhIxOzmGNwmiFT18tXcLbbk6bnj8OQgQ8fl32O1fx7IlvuYHWuwy9BXdw6LeFMP
         IA91pc+vMnlveROmpiykpcUpcfo6GfYzj5apfxaTA2/or9jussfBa5YHEvq4xGCTyZRR
         62yjr2HjQT/lRluE0xCvrC2kBcKcJ+cWgD7PNROTlPTq8RR9FjzHAfmExW9GDP+zVU2g
         om/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZY6PDtKkP0Eew3mhfR0yA3py5Hwn1DCrEHvLbCkjMoc=;
        b=qzDgoxS9mi2ccs+HOy8YIjbu2ILL14ohGM4b9tyIpk24HVn8mosAQz9g0wqkAQW2Bg
         GzQO29XQw0xYjbVKM3gbFFRtG+/oa5PSq21Yy7WCptYaF/UXLnynVXBaCa3jWl3md4ik
         MgLhAtR7LNfxAsq2L1WYvNqFvPZ1yFhoBeDXDM/V+ay8OzHvqosjutOC7WvMiMR5lUXy
         bQa6VRSiXZGRsDiuZh/Fx6QuElPbvy+/4uxh2264OG5xfomPVwyFMf4B2eAiriX3NXiw
         CgQs3SEZr6nfaElVn556lTZneIsrxBgmrxyqVO/PFSOoYAubYqHNNBIbLMz8najVnQIR
         gAAw==
X-Gm-Message-State: AODbwcA4ssO81LdLSjCvTt0T4bS1aU6jwu9jTSH0fnKMW81fUXGE6pea
        awfjAUNb2LCWTbs3fCTjldtDVkz9Ww==
X-Received: by 10.202.84.205 with SMTP id i196mr6842474oib.145.1496053420290;
 Mon, 29 May 2017 03:23:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.145.17 with HTTP; Mon, 29 May 2017 03:23:09 -0700 (PDT)
In-Reply-To: <20170527111032.30897-1-avarab@gmail.com>
References: <20170527111032.30897-1-avarab@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 29 May 2017 17:23:09 +0700
Message-ID: <CACsJy8CUpHNDfvN+P7=Jub4+Z281rzExFV9x3_hdVKw6ORUSqQ@mail.gmail.com>
Subject: Re: [RFC/PATCH] WIP: add deprecation & experimental process/interface
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 27, 2017 at 6:10 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> This is the WIP start of a deprecation & experimental interface to
> git. The goal is to formalize the workflow around deprecating
> features, or around introducing new experimental features.
>
> This is much more idea than code at the moment, but included is an
> example showing how :/ might be deprecated[1] (let's not discuss /if/
> we should do that here, this is just an example).
>
> The plan, subject to RFC feedback is to:
>
>  * Add a new config variable `core.version`. E.g. `core.version =3D
>    2.14.0` With this the user can specify that they'd like
>    new/experimental features introduced in that version (and below),
>    as well as immediately getting new deprecations added in that
>    version as errors.

We have extensions.* for this purpose (or close to this purpose). I
think it's more flexible to go with extensions.* instead of a single
"core.version". extensions.* are non-optional though (if a git binary
does not understand it, the repo can't be accessed). So it's more
about fundamental experiments (like sha256 transition). I'm guessing
we can have a "soft" extensions (warn if not understand, instead of
die), like what we have in $GIT_DIR/index.

Deprecation via extension.* though may be unintuitive. But I think
something along that line (e.g. deprecation.*) might work.
--=20
Duy
