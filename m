Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADFAC432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 17:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91876603E9
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 17:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344927AbhIARcX convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 1 Sep 2021 13:32:23 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:33545 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344985AbhIARcV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 13:32:21 -0400
Received: by mail-ed1-f49.google.com with SMTP id s25so94623edw.0
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 10:31:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9vCxH3W4HbJSTqF8Ahr2Qpp0YM2WcFWt/wfQMWuBPEs=;
        b=CA7yBbIgizN4K4x1CyWmBtkb/UjjViDvlNChXLWQ502u6p3ZDmOxQqqpfNYHf4SIUl
         UtgBe8kBrkwXWf5YO1PDrpugZ4YNDKKQIvsJKEwaiU6PF+FvrSdUz+1J73q9hvVKAnLZ
         VKUG96fnHarMKinYwep+CWEjtqrmAhU2We2l80lUR4gjZk9RMO++c6cakTwYWwurkG+W
         wP7CQDqWKheiGZkkj7bE+7KinQxpeTiqMuEGOKNZH7BC8Hkpd5dPgJ2LCaOKjSULTGII
         8dLPppD2h3CqC/xQnjTjTMoBFtUXXYzpESOj+znzgqtw1RuLvnJ/cze5jtdKhRAYhu3y
         MatA==
X-Gm-Message-State: AOAM533uvArSWdNFyGC6eNUVw4Gc1heAOWYwr68tAfWmg0jI0aowiX9k
        g1+5USSPX001FXugWSRIbOOm0K23Q9ilLFUa7hgs5iKw
X-Google-Smtp-Source: ABdhPJwADeEaO/b9b8rwT9GQkEoxi1W/y2L6opjpOjP+FWwig2luUZE8ePOo+ElGnjjTT+obCx4Hi2NkMFKx3JeD8Dw=
X-Received: by 2002:a05:6402:152:: with SMTP id s18mr697776edu.221.1630517483781;
 Wed, 01 Sep 2021 10:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <YS9RieTeJSFmd6M7@coredump.intra.peff.net> <patch-1.1-d24f1df5d49-20210901T112248Z-avarab@gmail.com>
In-Reply-To: <patch-1.1-d24f1df5d49-20210901T112248Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 1 Sep 2021 13:31:12 -0400
Message-ID: <CAPig+cRHwK=m0jpuTgsTG+cNVpGASHJP6v3kEQrJFS6Qt=biwQ@mail.gmail.com>
Subject: Re: [PATCH] gettext: remove optional non-standard parens in N_() definition
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Carlo Arenas <carenas@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        "Kyle J. McKay" <mackyle@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 1, 2021 at 7:26 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> [...]
> Then in e62cd35a3e8 (i18n: log: mark parseopt strings for translation,
> 2012-08-20) when "builtin_log_usage" was marked for translation the
> string concatenation the string concatenation for passing to usage()
> added in 1c370ea4e51 (Show usage string for 'git log -h', 'git show
> -h' and 'git diff -h', 2009-08-06) was faithfully preserved:

"...the string concatenation the string concatenation..."
