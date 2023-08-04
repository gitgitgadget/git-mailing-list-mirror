Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D96C001DE
	for <git@archiver.kernel.org>; Fri,  4 Aug 2023 16:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjHDQ6O convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 4 Aug 2023 12:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjHDQ6M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2023 12:58:12 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33384EF9
        for <git@vger.kernel.org>; Fri,  4 Aug 2023 09:57:58 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-63d0228d32bso13758446d6.2
        for <git@vger.kernel.org>; Fri, 04 Aug 2023 09:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691168277; x=1691773077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5f6tnzLYKTtB2Offjid9CtkioQgtF2CClYnaPWF4b4=;
        b=f2lksjWJ3rjjNBH5w9nb0JXz8t6XwwsPuFwat0APamrsTTo0gOG6AB6nBc95Opm4ld
         p3jags99IZI6kN0e8EbTTyEuFzD+SPWFJ2HH/a34QvlnJZH9P3UNxVoJsm1Sku2GbldS
         qF/ZDAFgWnmmhqhfR78leVwWl7KeFUP5oKEOI9CdPnE/rHCs/XuXsZEANzck/pMxsCYd
         KqEcZTlU/oHWzFjHYhMeDacSQZys60FXCco6WrzoHULvvsKp9fegMGf3fug570AEP+iK
         8VaB52ZXB20Pq7pxFxNa++dZlQVICVYql5C8xdZUMMhUMhXLJVRZu2VXwdbzUmgIaxJI
         6ptA==
X-Gm-Message-State: AOJu0Yz+xslPR8fffawdcD6uDcQsm/+smfQSQfGcEvIBhjT3MO1Eb3qJ
        wZU5czJSpO1CFaRXVNPmGvL4edK+nz3+vvHrHfrVJRXn
X-Google-Smtp-Source: AGHT+IHvwRmjgPHVq5Q0TwkbQrzsjuGHqw705YEy3fyO35OSf9T+6Z6eaF4voGcjSPsPlUnELARQVH+5Dx/iH1gL1xs=
X-Received: by 2002:a0c:f50d:0:b0:63d:5f5:a66b with SMTP id
 j13-20020a0cf50d000000b0063d05f5a66bmr2011795qvm.65.1691168277391; Fri, 04
 Aug 2023 09:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1560.git.1691058498.gitgitgadget@gmail.com>
 <pull.1560.v2.git.1691122124.gitgitgadget@gmail.com> <042271990895c4cfdedb20c3aed3d4141df610bd.1691122124.git.gitgitgadget@gmail.com>
 <CAPig+cTE__6B3RNbew8sHQQC3ELi9YAArYX5ofXRpMPBzZfmrw@mail.gmail.com>
 <DB9P250MB06922EB40B40F07DBAA1441EA509A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
 <xmqq1qgi3ge7.fsf@gitster.g>
In-Reply-To: <xmqq1qgi3ge7.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 4 Aug 2023 12:57:46 -0400
Message-ID: <CAPig+cQdJSo_VXE=fScv7CKM-8Au8gdx4PmZ=eBtCG+mEN8Rfg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] docs: update when `git bisect visualize` uses `gitk`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>,
        =?UTF-8?Q?Matthias_A=C3=9Fhauer_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Louis Strous <Louis.Strous@intellimagic.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Miriam Rubio <mirucam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 4, 2023 at 12:45 PM Junio C Hamano <gitster@pobox.com> wrote:
> Matthias Aßhauer <mha1993@live.de> writes:
> > On Fri, 4 Aug 2023, Eric Sunshine wrote:
> >> On Fri, Aug 4, 2023 at 1:22 AM Matthias Aßhauer via GitGitGadget
> >> <gitgitgadget@gmail.com> wrote:
> >>> +Git detects a graphical environment through various environment variables:
> >>> +`DISPLAY`, which is set in X Window System environments on Unix systems.
> >>> +`SESSIONNAME`, which is set under Cygwin in interactive desktop sessions.
> >>> +`MSYSTEM`, which is set under Msys2 and Git for Windows.
> >>> +`SECURITYSESSIONID`, which is set on macOS in interactive desktop sessions.
> >>
> >> Micronit: SECURITYSESSIONID is not universal on macOS[1]; some people
> >> report its presence in iTerm2 and HyperTerm, and perhaps even Apple's
> >> own Terminal (although it's not defined for me in Terminal on High
> >> Sierra). Perhaps just say "may be set on macOS".
> >
> > I've just checked in Terminal on Ventura and it isn't set for me either.
> > I'll reword it.
>
> I'll locally tweak "which may be set on macOS" for now.  It should
> be good enough for the upcoming release, right?

I would think so.
