Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 945611F406
	for <e@80x24.org>; Sat,  6 Jan 2018 23:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752802AbeAFX6L (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jan 2018 18:58:11 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:41624 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752249AbeAFX6K (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jan 2018 18:58:10 -0500
Received: by mail-qt0-f194.google.com with SMTP id i40so9873190qti.8
        for <git@vger.kernel.org>; Sat, 06 Jan 2018 15:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=5weaHKtL7adARH3L1dkqqCiWpenDe4BibjUJ+7Pehlo=;
        b=URowHLcYRiP7JnKahGjhaadV3hNt4nIw7DpvOaYUsE5xyaboIKXl5vJXzLRyYbp7gW
         S9cTtFaBxJ1l2CvlVy9Ldmzf4LC5q0UDtRJMc31owC39EWjA/ze7pOdSfxUzJgFvvVm5
         VHK9Lv9Ku/QQVAMvWa4i6lVyNJQZj1y1n3SiiPc/5koyO5P681yjgz2zO5MGqyLovCX8
         b3EvSto7ZDZHnA8RQpaoVX2kYw3weX/B0CXgXYuk2zndty+7MXG8Me1N25ZF9K2kMNaV
         veQQXaTI2rk4HdmyDQ/z0uMfko7NNFxSXkC3otnL4LihuTshD9sOb8mcE4vMRzPYEXzn
         AacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=5weaHKtL7adARH3L1dkqqCiWpenDe4BibjUJ+7Pehlo=;
        b=HJXI4F+47YFH1ftBY+agqtsFmPwbjgHYJfpuoFXQ1lHCXW6PZwTioUm7vMkQEdoxdo
         QoXTSJgFpCJy95nSIHDVmkQF6t9jA3k9qQ7nvdIY25zXVrSwZnD9dweK41S2h1i+KMjQ
         1fDk+DH6Hq0iriN6bnBYQ4GXo2p8zF9hLpZ59sGGDW1iUMOfwSUs2NQPVXdRPdwiJz13
         6YHUcfqtQF0BoXbQAZG7449lDf4Fjo/OMTl/AfqskcI6mrWjcL+7COaMpS1ziRf7qxD3
         FlA71J/+hVwVUrPK9AZ4+eRuL3yaf/dPbxiEZGa+suyxPess5IUs3a4eKqKOpmL7Tyqs
         BL4w==
X-Gm-Message-State: AKwxytd+0kd2lkNBwoBuz2fLKc/VSjb7fZTxhL5dHL/VRYkN0p3EDeuH
        3739Yf6HrcA3y+B56iuTeCQHv3RIkb/5F/OBqwXM5wMa
X-Google-Smtp-Source: ACJfBov+TI6fGSYG/dGWhhdc3Y9WsOeREnUchNodnVWjImZyanhGEQRbehRkuoGPyoCmZ9i/7vIDyoIv3tfS2xiubyU=
X-Received: by 10.237.60.20 with SMTP id t20mr11134400qte.229.1515283089382;
 Sat, 06 Jan 2018 15:58:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.208.108 with HTTP; Sat, 6 Jan 2018 15:58:08 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sun, 7 Jan 2018 07:58:08 +0800
Message-ID: <CANYiYbEc9dcB=A5cK6XLR7oqupbnohfNXsr6MLKKRE5OfOob3w@mail.gmail.com>
Subject: [L10N] Kickoff for Git 2.16.0 l10n round 2
To:     Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git 2.16.0-rc1 introduced 8 update messages, and let's
start the 2nd round of l10n for Git 2.16.0.

The new "git.pot" is generated from Git 2.16.0-rc1:

    l10n: git.pot: v2.16.0 round 2 (8 new, 4 removed)

    Generate po/git.pot from v2.16.0-rc1 for git v2.16.0 l10n round 2.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in "po/README" file.

--
Jiang Xin
