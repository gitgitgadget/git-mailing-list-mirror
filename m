Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D634820899
	for <e@80x24.org>; Wed, 16 Aug 2017 10:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751666AbdHPKcQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 06:32:16 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:33905 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751628AbdHPKcP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 06:32:15 -0400
Received: by mail-it0-f66.google.com with SMTP id s132so2157512ita.1
        for <git@vger.kernel.org>; Wed, 16 Aug 2017 03:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=crH4Vg2+IWlhOv0jyni8bWI6w2XbCGRx7lM3VoQEWa0=;
        b=itgNJtbrOU116lcereyq6hdZ/z3mfWNdZo3M5SQss7PmS0JqUaKDq4cEZ8Rz7pP9Yf
         utILlaBVS2IcBzbIBY/OEjqMgN+zmVDz/TCiFZRRAvLfCBbSFQBdEpJafMatkLFEnPj0
         XPp+cABhVuNfAa/S4PGFIqS7wU37gYm6Yz+rJmQyKgRpn422noCeacfQxRPhgSb3bA37
         ptynNaP1klYV2QrIDno+cdsC80NW4yYX96iRLpqGUOmKjoDS1UmD/R/MThJK9sjZi3dq
         yUoWOwzEpshlmo9n1hs7jINEPn9mEVUINPYPBueqmtUZS0faLqlw+YJ+ZuyXkbcDlJTb
         zXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=crH4Vg2+IWlhOv0jyni8bWI6w2XbCGRx7lM3VoQEWa0=;
        b=qNvGiP5WpcqjT5pW0RgQbmkzV/ZrOIPRpOtgQWUxcaiRUKwOivubDd16QKvfM6Hk6t
         L8He1pQruXW7lMQoL0WuJ5/w8boGTekJtGVBaGwkdDHIbUF9mLLoCS6QV3EiecaSbApp
         3n1tTjfasZgoR0bz/Ct7o8hdgNwgQWj7+1EQ/9frDosx3zsZngsyHjpAYk+eJ6LrGpgK
         s0f6RvMX9klccTowGt2zBpP8x90vp4TSpchlup+UrA1BVdmhmypqSqAvefw+235jsk+B
         yH3X5eWCvL2UFdAk7QcgOAocNrXtiwpqOeluc0ldJVENSyufvi+7Z10xErE7Xpyjrqaj
         o+WQ==
X-Gm-Message-State: AHYfb5hqT72kDZ+jSuBF7LPn3ZiCd8rcWBpn+Hz6Dx0eIXXPXKFpgdJ+
        lKGEtmh8ogXWOPPs6pwinwJmOgN5nFvY
X-Received: by 10.36.141.199 with SMTP id w190mr1302596itd.143.1502879534557;
 Wed, 16 Aug 2017 03:32:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.127.85 with HTTP; Wed, 16 Aug 2017 03:32:14 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 16 Aug 2017 12:32:14 +0200
Message-ID: <CAP8UFD1Jc0YdeNOgWh8OYrc_xPHhc9yY9R0D0YkQ47A_6h7rhA@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 30
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "Shawn O. Pierce" <spearce@spearce.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Dave Borowitz <dborowitz@google.com>,
        Howard Chu <hyc@symas.com>,
        David Turner <David.Turner@twosigma.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Sixt <j6t@kdbg.org>, Eric Wong <e@80x24.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 30th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2017/08/16/edition-30/

Thanks a lot to all the contributors and helpers!

Enjoy,
Christian, Thomas, Jakub and Markus.
