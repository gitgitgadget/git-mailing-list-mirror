Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95ECA2027C
	for <e@80x24.org>; Tue, 30 May 2017 16:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750984AbdE3QCU (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 12:02:20 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:36137 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbdE3QCT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 12:02:19 -0400
Received: by mail-qt0-f173.google.com with SMTP id f55so73704783qta.3
        for <git@vger.kernel.org>; Tue, 30 May 2017 09:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+fEK1GB0ihtk5+nObPyIzIuUyc6j8rm4w1BiX2QNVEo=;
        b=mXdTK5jJR6yfOK65q5f8FVsicCqXc13F330+BqzcHpdznjZ4s3oq8kO2WS+ZPu+IbK
         cAG/lxDeWCTefRz+Imim0tsy1j370YjVHvoByJkFwrLta/InKzd1/fRz5IBuKSmObczE
         tiR3kKkyykCgUQMN/IT9FGXgU3TFN9msnXPtzO9n8CTwb+wZ9DJxlddcdiWc0P3lOkgb
         vFr6Vg+hsOuzD2ko96DgFaQ1qlf2wm9zEoXl3gh088gpnVF2wXskui7DVCAXJw1YoxJB
         +U9y82f2LvGK/msqnZf5vnCFF1rgbqQ5v1sAobENlg0jZwhsjDLVCMN26z2ljn1GGCru
         MLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+fEK1GB0ihtk5+nObPyIzIuUyc6j8rm4w1BiX2QNVEo=;
        b=k829exXCzjagnAqk0e1xJP1uxYEkZ9vtSifmeq1b7J9diHnKmK+K+hNlsTTPWJlnoA
         b/zXWciVXHhPQrxXIUzdAL1eWqDM18GbmrOb2wL3tpLLjcEGMy3YC9DMnKVQQwForLBA
         GvtdWZhQTYL2EblTtfNriAJvWFP6wA5aPHcJzZhihCcT+g4RgvpIEQALUufffd3EC9vY
         hWJ4/ZR2mK9vvB2xv5zO/rT8VWrE4TMPUYyZG84TNeBwJhBpi/KnayReSEBbPDv9WzoX
         Ckz1sNSEJftZxAhFKZNM3GF/+XaAwiLgx8t0+bhQGQbcAp+HRtqMipyi888aEvoWn/82
         qG0w==
X-Gm-Message-State: AODbwcCe2QcXUh1pvuQsGSRf1qO1KaKH4mfbJSRYZLK6q0ngvDpfdUll
        EEj224hPrAqhn9ZOwBN4KTPUmbOqMg==
X-Received: by 10.237.60.150 with SMTP id d22mr26118092qtf.126.1496160138735;
 Tue, 30 May 2017 09:02:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.149.236 with HTTP; Tue, 30 May 2017 09:02:18 -0700 (PDT)
In-Reply-To: <20170511212012.6782-1-avarab@gmail.com>
References: <20170511204334.GM83655@google.com> <20170511212012.6782-1-avarab@gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Wed, 31 May 2017 00:02:18 +0800
Message-ID: <CANYiYbH=EJy51yAdiMg6R_yDzZ3PLUuLMsLxdkf9zXJPhLcwKA@mail.gmail.com>
Subject: Re: [PATCH] C style: use standard style for "TRANSLATORS" comments
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-05-12 5:20 GMT+08:00 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gm=
ail.com>:
> Change all the "TRANSLATORS: [...]" comments in the C code to use the
> regular Git coding style, and amend the style guide so that the
> example there uses that style.
>
> This custom style was necessary back in 2010 when the gettext support
> was initially added, and was subsequently documented in commit
> cbcfd4e3ea ("i18n: mention "TRANSLATORS:" marker in
> Documentation/CodingGuidelines", 2014-04-18).
>
> GNU xgettext hasn't had the parsing limitation that necessitated this
> exception for almost 3 years. Since its 0.19 release on 2014-06-02
> it's been able to recognize TRANSLATOR comments in the standard Git
> comment syntax[1].

My gettext version is 0.19.8.1.  I applied this patch and checked the
new generated `git.pot` file, all "TRANSLATORS:" directions are well
kept as usual.

This patch is nice.

--=20
Jiang Xin
