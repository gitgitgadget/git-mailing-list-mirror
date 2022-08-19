Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DAFC32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 10:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347328AbiHSKT2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 06:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348205AbiHSKT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 06:19:27 -0400
Received: from mailproxy07.manitu.net (mailproxy07.manitu.net [217.11.48.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2F0E3971
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 03:19:26 -0700 (PDT)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: michael@grubix.eu)
        by mailproxy07.manitu.net (Postfix) with ESMTPSA id 1C4AAC826A
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 12:19:23 +0200 (CEST)
Received: by mail-io1-f50.google.com with SMTP id d68so2951598iof.11
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 03:19:22 -0700 (PDT)
X-Gm-Message-State: ACgBeo3wkwg/JSSae08ujMuzWIAduHU0J7S2XXeyxvHyvfuqoEiPsXyo
        Qo3660RjUBGLypk5coq4ayKtZqwgCe05UYlQoXM=
X-Google-Smtp-Source: AA6agR7DgsUfSRYo6rol0GZLdTcevX/JDUduG7o5hfcKs9hDaBEA69+k6GqzdRhXJV9Y3atI+19Xbu3M8SOsyTs3edY=
X-Received: by 2002:a6b:771a:0:b0:67b:d23e:277b with SMTP id
 n26-20020a6b771a000000b0067bd23e277bmr3078967iom.203.1660904361604; Fri, 19
 Aug 2022 03:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <09rn6r61-38qo-4s1q-q7qq-p5onp6p87o44@tzk.qr> <cover.1660828108.git.git@grubix.eu>
 <2p150404-o6r0-4p10-o0s4-orso00o6n369@tzk.qr>
In-Reply-To: <2p150404-o6r0-4p10-o0s4-orso00o6n369@tzk.qr>
From:   Michael J Gruber <git@grubix.eu>
Date:   Fri, 19 Aug 2022 12:19:10 +0200
X-Gmail-Original-Message-ID: <CAA19uiQhgxKDM8LJq-os=KuxmwVOt2eJ_pkpj0eLBU=E0MYLRQ@mail.gmail.com>
Message-ID: <CAA19uiQhgxKDM8LJq-os=KuxmwVOt2eJ_pkpj0eLBU=E0MYLRQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] sequencer: clarify translations
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Fr., 19. Aug. 2022 um 11:32 Uhr schrieb Johannes Schindelin
<Johannes.Schindelin@gmx.de>:
>
> Hi Michael,
>
> On Thu, 18 Aug 2022, Michael J Gruber wrote:
>
> > thanks for all your input to my RFC patch. I tried to summarize and pack
> > everything up into this little series.
> >
> > A follow-up could (but does not have to) turn translated action names
> > into untranslated git command names in some places.
>
> Thank you for persisting on this, and on behalf of the core Git reviewers
> I would like to apologize for the hornets' nest.

No need to. After all, this thoroughness is a huge part of what makes
git into what it is.

It's also why I'ven been participating much less: simply for lack of
time. That thoroughness takes time, sometimes much more than expected
(and can be frustrating, even in the very technical-physical meaning).
But discussions here are always about the best solution (not "whose"
solution "wins"), and that is why I'm always happy to be back for a
bit.

> I offer my ACK to this iteration of the patch series, with or without the
> v2 of patch 4/4.

Thanks!

Personally, I care only about the consistent reflog, which currently
means untranslated. Not that I look at the reflog all the time, but
...

Michael
