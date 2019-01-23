Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A1491F453
	for <e@80x24.org>; Wed, 23 Jan 2019 13:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfAWNpT (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 08:45:19 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41739 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfAWNpT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 08:45:19 -0500
Received: by mail-ed1-f65.google.com with SMTP id a20so1715832edc.8
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 05:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=+vgCqlgkpPbEHpL3GBdSAerx0dh6CW6N5Qcxle7q9ls=;
        b=VXRRYPf6yVpv1H8VThmmV+1eJ7a24qCphxreJ7bM6dSAsEzUGSHV7JHsk1M+c8+p+j
         Mjv9OxsSsCIFNQFE9I/HNT+6DQrZNUkyya51wd/2mPjFmhlnH0RoFmLvfhxA32ulZys7
         1IX6dYUw634cqboDEbXaA9zER8tX1Xjg2pnLeCFCYaMqTNmb/O3A8Zff8uy9URDDgCKx
         wXDkFH+CJG2KNuUIPAKkDuRqx6x1kxfLKpan6qrDfdnLyWSOvP0SoEWAIrnolxvaTb1u
         XQhHHaSM4I9TivT6DgB+UQcXtgO//Qhvn4LZwAz9BcDB7BnWBTi+aNvCXg0k4JLPzM/p
         Akrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=+vgCqlgkpPbEHpL3GBdSAerx0dh6CW6N5Qcxle7q9ls=;
        b=bbeu/afPEaHp8q0NAeS3dDJM8fnFrvlPi8bFBG2xleHx2x54wbN+0iTKUC8zaqCmhJ
         W0CE2+k+LKT2ZUZ+avXRaHlevw4yDfaby2SQ/Vq/NxryydrHFeZXrxGuOxezJs/4ZtSR
         MKaQl9j+ZZGHIzjWG4Ys1UCM1xZU6V/q5S7mPJyTV0339vLXyGP0HnULY4L8WN31W4pp
         qKUzwl0iQW4oe++dPGIfDpvhL5OpKm+SSQFUXrC+fG1ozBNuTl+0iFuc+E+uJwxX9EMA
         sbyouS9s42/hrYJ89M9AYqvTL2+A6HwqmtDVjZRGN/RC1EH3O6hGlrSR0xlhXbhU9KDq
         3oGw==
X-Gm-Message-State: AJcUukdDQovbblDsr0k65QTsMef9lNMzL2Fk4Bd8o66XAGvbo+zn2FC5
        NDcTiUI+k0N5gLRVKK3l30bKb4v2vojWK/y2LckIo6P1
X-Google-Smtp-Source: ALg8bN5AbDlihqfv8r326UNjkPvicG7yIPszlIln/g5HxyZWXVgP3QAo8z1SM7gpSnXGTBfq/WbVaS8bBjPAtmzmhGo=
X-Received: by 2002:a17:906:e298:: with SMTP id gg24mr2575878ejb.92.1548251116565;
 Wed, 23 Jan 2019 05:45:16 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 23 Jan 2019 14:45:05 +0100
Message-ID: <CAP8UFD1Ox+gEqP7oEbhC_ALeQn18apHiYjihVHd7n-5whiEZcw@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 47
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrn@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Luca Milanesio <luca.milanesio@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Robin Shen <robin@onedev.io>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Slavica Djukic <slawica92@hotmail.com>,
        David Pursehouse <dpursehouse@collab.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 47th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2019/01/23/edition-47/

Thanks a lot to the contributors: Johannes Schindelin, Robin Shen and
David Pursehouse!

Enjoy,
Christian, Jakub, Markus and Gabriel.
