Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BF951F453
	for <e@80x24.org>; Wed,  7 Nov 2018 15:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbeKHAkv (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 19:40:51 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:53735 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeKHAkv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 19:40:51 -0500
Received: by mail-it1-f194.google.com with SMTP id r12-v6so20491115ita.3
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 07:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GLW7+sSIdF+QpulTwoByafM/v7kEiATEBmfoKCyUCdg=;
        b=hftN4aW+mT9jlOQmCHH/KUvSpaYVZq7U9d+yd9fwG+ev24U7EH/gQeo8Rov2EKfRE5
         lCZjmktHZfD126VjvDLTchz6+p5ApM5a7ddtI2FO2LqVM639XPYThdaLv2y9Vvx4zgB5
         bI2bUMoMm/5GmhhFFhuSEjY39qzzhi1umvB6/rvNZHc4QLg3CxgvYatBYrW9Nz7M8Inf
         AcCfFcQ++NdV7nANhsVNgWx7b+ku64HPeQN8tKiA5Rh8ssLV5X9ag51N5hldXogj77dg
         pGxtDaDWCMgHXvZV6zIranwIlpkWUNi8psXn0CMgusex7bHhT+kI+WgazgCmuz9AI71f
         vZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GLW7+sSIdF+QpulTwoByafM/v7kEiATEBmfoKCyUCdg=;
        b=ZWTp4YP13DEeg7OWW2Z/ZG1mG/k/0KTtYaefJHgRaNm62cKDeCYaBTjgC576xEgOgn
         a5UJt5kJ9sDN56X7zpxNHmENPKJ6cRh+DZFDFkwDpDwRqZECB2Sowrw7gegxJ8ATAlSB
         pOxI4cNRen76YFsy8QlrZgOOOXgHES+3ZAYmuRbmrxkm8k8k+X4f6k9xj1vMHA8RR2Wl
         iLQcmTFMlANbhseB1r1wIU36NLkJN4AN+/xfQPLn6h+W6B76hpLFoiE8EN2QwCk9ge8F
         Jk/AVk5A8iZ+DrkizVBxFtmiNK+oDANLM2k9qUYaGtwuQMT7WsTkm9vYGhDmVGYauE3H
         Wg/g==
X-Gm-Message-State: AGRZ1gKVdB3oNUi43aKE8eiMx5tRS9R52REdmujJUtUmErsNswVoBrgG
        92Ixv3dZ1S/dpuMC+jzxqzld29w4U7EEYHyI5dl7Sg==
X-Google-Smtp-Source: AJdET5eaUDKrfdr+w4BsnAYR7/Oegwio0aR4MflPyWnoVuNboMmzyloh1IxrH/5RAGOAfqyrHy4178nZJ4ttRa6G+tM=
X-Received: by 2002:a02:5748:: with SMTP id u69-v6mr577126jaa.30.1541603404899;
 Wed, 07 Nov 2018 07:10:04 -0800 (PST)
MIME-Version: 1.0
References: <xmqqy3a5b4x2.fsf@gitster-ct.c.googlers.com> <20181107130950.GA30222@szeder.dev>
In-Reply-To: <20181107130950.GA30222@szeder.dev>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 7 Nov 2018 16:09:36 +0100
Message-ID: <CACsJy8CuYgX9yFisJerf9C_6-hyyZD8DjzTsQ7v-uKpbm5LvQQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2018, #03; Wed, 7)
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 7, 2018 at 2:09 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wro=
te:
>
> On Wed, Nov 07, 2018 at 06:41:45PM +0900, Junio C Hamano wrote:
> > * nd/i18n (2018-11-06) 16 commits
> >  - fsck: mark strings for translation
> >  - fsck: reduce word legos to help i18n
> >  - parse-options.c: mark more strings for translation
> >  - parse-options.c: turn some die() to BUG()
> >  - parse-options: replace opterror() with optname()
> >  - repack: mark more strings for translation
> >  - remote.c: mark messages for translation
> >  - remote.c: turn some error() or die() to BUG()
> >  - reflog: mark strings for translation
> >  - read-cache.c: add missing colon separators
> >  - read-cache.c: mark more strings for translation
> >  - read-cache.c: turn die("internal error") to BUG()
> >  - attr.c: mark more string for translation
> >  - archive.c: mark more strings for translation
> >  - alias.c: mark split_cmdline_strerror() strings for translation
> >  - git.c: mark more strings for translation
> >
> >  More _("i18n") markings.
>
> When this patch is merged into 'pu' all four tests added to
> 't1450-fsck.sh' in b29759d89a (fsck: check HEAD and reflog from other
> worktrees, 2018-10-21) as part of 'nd/per-worktree-ref-iteration'
> below fail when run with GETTEXT_POISON=3Dy.  The test suite passes in
> both of these topics on their own, even with GETTEXT_POISON, it's
> their merge that is somehow problematic.

Not surprising. The i18n series makes fsck output localized strings
and without updating grep to test_i18ngrep, new tests will fail. If
'pu' was passing before, I'm ok with just ejecting this series for
now. Then I wait for the other to land, rebase, fixup and resubmit.
--=20
Duy
