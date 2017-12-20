Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D8551F404
	for <e@80x24.org>; Wed, 20 Dec 2017 17:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755869AbdLTRnf (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 12:43:35 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:42676 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755856AbdLTRnd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 12:43:33 -0500
Received: by mail-it0-f67.google.com with SMTP id p139so7656875itb.1
        for <git@vger.kernel.org>; Wed, 20 Dec 2017 09:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=4map2rkfZ7DrviqHX0woGZX2lDbsZ6qJjRBSN/T84QE=;
        b=M1VAzpNi4Mqoc4e1uhMUFpzneNWyQgMkJxXT1teH7NJIQny7EQKXmbkPJMH+1fReoT
         FEjv9jRJxwgIoEt/1EsKg74stL1GTVkpcSecjVyUSZB1SiG7UqAMtXClgWFcXKKug8Uc
         XXPar6MAdN2nYvD3lQQdib/bxH5ClW6HKnQkMRyUvcrAOSIcml4RwjG/okMXMSYUcO2M
         AuQEhoMF6rUfrl3PcKO8G8bxfrgyB5SRk798zEtCdlzcFg6s8/6nDNues26sc5za1eB2
         03MT7z4GnYN/NQGCYJRo7W2iyDpCQee20VVm92TGllyz7hNLOYJDgAL5rwr7V5VhThG3
         S3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=4map2rkfZ7DrviqHX0woGZX2lDbsZ6qJjRBSN/T84QE=;
        b=KhwNmg/ZwmWNwHlcXzNs8bc3mRQ/sAze3QyJwd+1GqFZEnuS1Hl1p2ike381SG8wec
         YAZ6RBAix0EG+CpOoCdQCDsmcZ4KNX1ZgI9k1/vmLsh1m8uyk+qGITF6m+MObLMI97fu
         nZjHhw4KjsCWsnK3cJVdxhQV2X4rocZJF8yfAWc39SpGrzuqEfd9rCgNDQCCUfy/Ux7u
         Dcz4TCC1Cb5E2SRtM7gNsY0MipqDc5drWW+Jfci1Di+zCaXVDEa6yOzi4WTHGOUiWy00
         HqQYSfFWC3tihqCZ7C73zMn0M2k/c4ByVA+knbqshWf/ZCQ9d6HpQ6LK9zQxGrRHAKEb
         jU8g==
X-Gm-Message-State: AKGB3mIdj51PpYIRkQEvBzhPCNcuebZN+daUVgmKempBNaUMq2F1pAmV
        I4ITr1MiEiCEt/r+5laDOuMxfsKh+Ly6dLgCEvQ39mA3
X-Google-Smtp-Source: ACJfBou8GgZP4bFtNEXWw/KoNZhaAzkUTRI9bOX9zeZyKn4WGvw1udmM9Lc/U4fe2VXwXQwOtyybVnFU+RX8ktYT/Iw=
X-Received: by 10.36.192.2 with SMTP id u2mr8979907itf.119.1513791812229; Wed,
 20 Dec 2017 09:43:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Wed, 20 Dec 2017 09:43:31 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 20 Dec 2017 18:43:31 +0100
Message-ID: <CAP8UFD1ctYSMkxKk1gHG83Y6RUVz5TyrYegXm2q6LR8RrMgA7Q@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 34
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, lwn@lwn.net,
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
        Doron Behar <doron.behar@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 34th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2017/12/20/edition-34/

Thanks a lot to all the contributors and helpers!

Enjoy,
Christian, Jakub and Markus.
