Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C63E41F406
	for <e@80x24.org>; Mon, 18 Dec 2017 08:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758137AbdLRIqw (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 03:46:52 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:35502 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757927AbdLRIqv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 03:46:51 -0500
Received: by mail-it0-f54.google.com with SMTP id f143so26776008itb.0
        for <git@vger.kernel.org>; Mon, 18 Dec 2017 00:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=wHgDu3bBb9e3TuYVDhTBYBg1v+ngKXiu6BXRvAku/zg=;
        b=qjzXVrqsKqao6XeFQ+QUXn0afsfjd7aCWAzAFACPKhiTRJw/0x9hIXyVfc26+HuJ84
         eX/BhGTehCX0IJxgpuE/8WPr0dPIYaLRn4LZmKi53Mbt5clE+kjcztoZwOdNSlJ34DRM
         7qAl60FIIYkD8kTDSl2NdJmSkW//HY5ciQ59i8ovC52x2NIe0RO125SuP7ToeYgcSxPO
         uBzjkPFIQGGtO9te1VXllrfy3HSqBqcgJZ/997RvQMq2uXcOGvxyOTR8IuZEn16oGGC+
         NND9AFcu//IHlfoTvxYB4pIdWB9Qhqc/j6BpFBMY6H2KZPbDMxUhy2jyW0GSCRLQ8Klk
         zv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=wHgDu3bBb9e3TuYVDhTBYBg1v+ngKXiu6BXRvAku/zg=;
        b=YSGI5SJqUO8Szic1T8QxsazYUtgzuATCqTDYdgxcEEQW09LLWQCcKN9Zs5PI+Ss4R9
         pXLEoNaEZ+qBAFsFh70LJ88IW3EGTt4FsbWzY0kIiau1ntqneXMV5oaMWiYYCBG4SKOI
         PFuPZGWmRmSNIknzEn+FDgfg7Pea553az/nm3vLHijtpsG/UuX2h7qDqKVKSbYq8xJHM
         heqY+nGPQ/MAF0cLMheqxCOGlJ8GubLRa18q8cK93FQ+8B+TXGHp5eSwmWAV7L2G3F9c
         Uwsz2mDDGWRkN/FQKOpWrNjk46bEvaOd0gXJRF60nQSxVaZT78GxuVCHNPtCCLFEpTm2
         Ea1w==
X-Gm-Message-State: AKGB3mIxjyDmEF1qAi4cdJw8DdMKm7m7DfckR8Zgr77eKwILcobKgTS0
        DMdba+uuWfgUnv0IkuxmF5lMhtG8TFm5zHjduH0XFpbt
X-Google-Smtp-Source: ACJfBovruu63aSWZlt8MGtpATwglK2CsO0WjJ8Yz4Lzn6J/EwG2Fx7AhAAci0t80ZvVs4WwWHEN8jeHklJtRrg4yyiM=
X-Received: by 10.36.124.197 with SMTP id a188mr357398itd.63.1513586810386;
 Mon, 18 Dec 2017 00:46:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Mon, 18 Dec 2017 00:46:49 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 18 Dec 2017 09:46:49 +0100
Message-ID: <CAP8UFD2Wjf_8jjc2Hhi4nKCscEix-Swn66JTXBWSOD+5PGrArQ@mail.gmail.com>
Subject: Draft of Git Rev News edition 34
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Charles Bailey <charles@hashpling.org>,
        Henry Kleynhans <hkleynhans@bloomberg.net>,
        Haaris <hsed@unimetic.com>, Kevin Daudt <me@ikke.info>,
        Marc Branchaud <marcnarc@xiplink.com>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>,
        Daniel Stenberg <daniel@haxx.se>,
        Doron Behar <doron.behar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-34.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/267

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated. This is even more relevant than
usual  as Thomas is stepping down from editing the "Releases" and
"Other News" sections (see the draft for more information).

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus and myself plan to publish this edition on
Wednesday December 20th.

Thanks,
Christian.
