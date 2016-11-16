Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A85402042F
	for <e@80x24.org>; Wed, 16 Nov 2016 18:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753227AbcKPSf1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 13:35:27 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33317 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751584AbcKPSf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 13:35:26 -0500
Received: by mail-wm0-f66.google.com with SMTP id u144so13860496wmu.0
        for <git@vger.kernel.org>; Wed, 16 Nov 2016 10:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=DsrIH37Wvh22phFGG4LQ2tinD/KojMlJBm0tHEdw9Io=;
        b=Q/jODmRSxGS7jPgQdDwbCNY2/tsqwsWXuhAwwpCEh5tyFnbdBUArFdhbIPa4OegXQN
         YDBZhUj5HkYuI4vrIq+poVwny2WyyOooTiK537YNze9n1p503Sp6OKARj3lnSHfboHY5
         YPCQqOZy1V39uHX2uAX/kRRfL/Kqg2jTVQp24Wdi6wub0MyYpjKcMcdWfD5r7chbR4bK
         dGXZmJf7kJ11KPtbzy+OAE8j9AD4bEWEluv3cS/R+ECSkESB1YX4qKCxZQSDDdXiwkXw
         26YSL3PCmRRSpU7FWP0tkN8Ou9Eh3tb4DkoEoRsTX7U5OKVlK/U3Vmnm7m9oBZn4Nvc9
         aaxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=DsrIH37Wvh22phFGG4LQ2tinD/KojMlJBm0tHEdw9Io=;
        b=a5J9TczALeTVSQiOoPq6LBT3ZuGF1XTY/JaaypT93Q7Hw6grTph38U82uqbG+z4VzW
         mRwiOwuL1ldJHFQlMbTK+3irMelaQTQqNVgQIM+ki6nEXUFktic8TxP1oW2aSbqrClXl
         HzWK3+cejkcrQV+05/92ahzNDgktq1M+Dt6Gd0TrSSz/G9zvT9u0RUk0h38JE4/hPs9d
         7DpHsti/B5ZUbT5PgLZ1+Cwpr/Qug/ZR/W6NZo0ZHHl28QhK7566wSE5OiQ8LiTDKzHY
         kCCDntr6ZoJBhd867GnMVgTy8zzFgPBZ0GNIaNMSUZ4GsRlLAwUOjdxFMLyWLw1iInQm
         sDZw==
X-Gm-Message-State: ABUngvfTCthwrcZdXafl14jy4MNFRLGaYQu9Q99t8T5HhNdXQ4bCvm2MlD3HF6Ou/027lQv2pJQDUpZxmYoP6g==
X-Received: by 10.25.170.198 with SMTP id t189mr1610474lfe.129.1479321324544;
 Wed, 16 Nov 2016 10:35:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.25.142 with HTTP; Wed, 16 Nov 2016 10:35:24 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 16 Nov 2016 19:35:24 +0100
Message-ID: <CAP8UFD1j0tFOY5CvAV-Xbf0vR+ejogyVJoS+xfyT0+MnJd_nRw@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 20
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Aaron Pelly <aaron@pelly.co>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Alexei Lozovsky <a.lozovsky@gmail.com>,
        Martin Braun <martin@gnuradio.org>,
        Brendan Forster <brendan@github.com>,
        Parker Moore <email@byparker.com>,
        Shawn Pearce <shawn.pearce@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

I'm happy announce that the 21th edition of Git Rev News is now published:

https://git.github.io/rev_news/2016/11/16/edition-21/

Thanks a lot to all the contributors and helpers, especially Jacob,
Dscho, Markus, G=C3=A1bor and Peff!

Enjoy,
Christian, Thomas and Jakub.
