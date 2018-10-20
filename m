Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B95951F453
	for <e@80x24.org>; Sat, 20 Oct 2018 19:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbeJUDmK (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 23:42:10 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:32864 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeJUDmK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 23:42:10 -0400
Received: by mail-it1-f195.google.com with SMTP id h6-v6so6694617ith.0
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 12:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iQP/AVwr3C7wpulKz59oUHr2tvH79Y4hkI0JUIPeZ0o=;
        b=eMIIl7eEa8bLGW0Dwj//AHObh6D4C/k0yxfRuIP7FcW1Rh7YQo3AL34x3C50RxCVR0
         NPHLVsBYhYhJ/H3UE6hwI6UcpEMcW27B5BPPzYQGwslJzrPMSaUTmKcIn5f+OlJVH/ul
         M+BZabbb3lhssZCBezgu3aG0UXqE26FeFbaZcXxjmSI9plbPNnsBR2/Knv6YLl2qpsLQ
         B753+qAMvemZ4exoAoX5heMnxqvhhi5ChJ32xlSG5ZuYp8y3GgDywkMRLzcvp+GaNPif
         UigVkTWb5iswjQalSi1niUm03hkkQR0qAIEJdnrkHpFpb+M9yLVVnouJSjVJ+UuQiuhI
         gLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iQP/AVwr3C7wpulKz59oUHr2tvH79Y4hkI0JUIPeZ0o=;
        b=ltdysozoFx/D0X2vL2+cNXUCJbhQpP4CRSQy15+mA51s35Tw4KFdMd1TONRS4tVnIf
         yHZoBBUxhnhTkMEVGgkvoOwGjClO4HWFLQcPrTCuelRSxvraLa/Dfv6zv0fSzuZNDHq0
         rqF6fCiBik9S6GDGnQS/yiHKcYlobgER1ieD1pi4+OMZQKQUnkTu/IlRyK7E/4w5yCuQ
         lbqkQTrOi4wNDd9iw1t9vhatOCojGqfgkfjYRh42UhzTRd55kPP8Gf/7vHMKlkLgqP+0
         2uKkHxGepSaSge0nGLHAigROQWn0f9Egb/HEOGkPHEn1MkyrR1fUlMcO9gctO2aLTD+y
         3Q3g==
X-Gm-Message-State: ABuFfog/a7mFJvdCzF3e0Y96lRpUn4+IWxfTVyrdzi9gXzy4+Qc7mIkM
        zNdieuSLwWZHMQSsA/Js0xxkQYcfSy74HTdNHk0=
X-Google-Smtp-Source: ACcGV606TILLmh6OZ3va2yhVmNewU5DNY77N6WjqykQZKLDo3TGfpmyJ7Dr1+AR1x3ZkUgasTaTKiFbtEjalRIxiDN0=
X-Received: by 2002:a02:69cf:: with SMTP id e198-v6mr1269077jac.130.1540063841475;
 Sat, 20 Oct 2018 12:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20181020123848.2785-1-pclouds@gmail.com> <87d0s4ctds.fsf@evledraar.gmail.com>
In-Reply-To: <87d0s4ctds.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 20 Oct 2018 21:30:14 +0200
Message-ID: <CACsJy8ADfhRk9eUJG+FE4k_D5sZvBOu47Vm4Gkae1XiOVtZyjQ@mail.gmail.com>
Subject: Re: [PATCH 00/59] Split config.txt
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 20, 2018 at 9:25 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> And sometimes like in the case of git-gc(1) we have gc.* config
> documented in two places with different prose that needs to be updated
> in two places in a CONFIGURATION section. This series allows us to just
> unify the two and do an "include" in two places, and more generally have
> the convention that a given command that uses configuration could have
> that config both documented in git-config(1), and the same docs in its
> own manpage.
>
> Is doing some post-cleanup like that your eventual goal after this
> series?

I did see the possibility of including command-specific config in
individual command man page. But I'm not planning on doing it myself.
Some command man page is already pretty long, plus sometimes we rely
on the core.* part which should not be included in per-command man
page...
--=20
Duy
