Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7A1C201A7
	for <e@80x24.org>; Wed, 17 May 2017 14:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753874AbdEQOL1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 10:11:27 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:33630 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753341AbdEQOL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 10:11:26 -0400
Received: by mail-qk0-f171.google.com with SMTP id y201so10848609qka.0
        for <git@vger.kernel.org>; Wed, 17 May 2017 07:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=pjANilKCp+cvjvc5ujriXinEa7PGl8nqRSGzv0r1OzA=;
        b=T0ol723rR17P85FoV7hRIPEoyfRxrLKQgKdvRhwHSOPVztph/ZFbF2xyDWW032h6xp
         GnXINzpHsFlk6ycDwG/ONvGmlCREq9Zs38P5JRtqJYInluoLfhg5Zpncfb+K4EygRWcV
         oX0KWovlyf4La3BVjeDGEFVcPc3AA+7QPgwSvfkKygChXULUe8jVjPi3Qme1mM/vjZdf
         J5qDiR+aUMAPC5dkL4vEiEIwGhXI4F98v0Ns7gdHki3fqYuewkcoZyVm49E0qXIRzMJa
         Ga93DHuuQ5LRuLGhpIfyGtW6irIfRA8xuoEWBWUV7MPvr9ZACyhtBDUhAXGV99+C/Ovt
         qqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=pjANilKCp+cvjvc5ujriXinEa7PGl8nqRSGzv0r1OzA=;
        b=IFXIBCCuzfA9Hae7g8ATU4l8l8kCWijJpMfshsWt8NOyzcWZd/QZsZfPoBDH43NbEm
         HcCTJZ3vIb8sr5icexKHSBSclLsnWaAdRk3Asao3hwWF3Pg1YDKYucIQYDg8163VcvEv
         AMg/sFCY5vJxqTvHGPmSoFed4WgCJ5rvxu78bqw7DlM+34Yjv6L9T/TiQ7Asep42YlGO
         aLZ7wO5NXrSuVg6y7SGjuGx6HTtQF6suqDSx7jddOWyK65/mJWLvB1PlcTpRCJuyD9a8
         mzYWoBpeRrpW+Pi7YsHdShka+7A4qVXNMuzDOp5oMuBZkJp60B/j35H1Ybp3oPvOmGB6
         bAnQ==
X-Gm-Message-State: AODbwcAal1iW2ZZvEc3ttZav7y+i+CECr1KgLK9haQcipQTiz6Gq8OJv
        MgLLcJHD1fyxK0LjAg4O4GnH5HDSEQ==
X-Received: by 10.55.68.81 with SMTP id r78mr3727531qka.102.1495030286024;
 Wed, 17 May 2017 07:11:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.78.212 with HTTP; Wed, 17 May 2017 07:11:25 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 17 May 2017 16:11:25 +0200
Message-ID: <CAP8UFD16qZgSd2mAB4LcpaboCGXpWpVi32FfHCARC+g5mWvX_w@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 27
To:     git <git@vger.kernel.org>
Cc:     Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>, lwn@lwn.net,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Carlos Pita <carlosjosepita@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Raman Gupta <rocketraman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 27th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2017/05/17/edition-27/

Thanks a lot to all the contributors and helpers!

Enjoy,
Christian, Thomas, Jakub and Markus.
