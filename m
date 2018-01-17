Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E58331F406
	for <e@80x24.org>; Wed, 17 Jan 2018 13:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeAQNON (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 08:14:13 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:44981 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750816AbeAQNOM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 08:14:12 -0500
Received: by mail-it0-f67.google.com with SMTP id b5so9140802itc.3
        for <git@vger.kernel.org>; Wed, 17 Jan 2018 05:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=3KnMwZpDCg8AldvDZt9g9CjujrcdUfPCTRq/wUZwxTQ=;
        b=AylGJDpkKSsNX9afLgYbEfqUTRzO1aqXfF+EbqQ/sfQ23RTETMyAEPr2uaIJ5Gmn4h
         r7n5/KhP96EF5leKVFopE3JFczhleBJqA23p7JjGoQx2DyL49jLxRzgGHoB6cTlsjYlo
         ERNjn6OvJqzkwU9Q0ZdNFTwKoNRPzSGaZvwBFn/FPLW0j/LMApKSaZ/pV91VJcR1cbL2
         0daX57Q0AVtGP9yo/QwcESyYB4ZmLGawGgJK8aP1XvaLeV/aWFOZq8/oxnY2x8qPjCtJ
         VIvOjeuFHWCCejTJGKvuxcEBznmj+H1gwYe+hSiDxaYiB6ZdPKayqeqlrlyylJ2nTe5V
         gRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=3KnMwZpDCg8AldvDZt9g9CjujrcdUfPCTRq/wUZwxTQ=;
        b=uAGf311jvIolyH0DZxQ7xsItgvzMk7Yb9Zl8s1Y1I6lUPSearcDKS7Dq4aOjjRwtkx
         cetN49wCkQ+CN90hL2q26gNfjPhDGDdfehWiRdPAlgRs0/zn3B/3feDssMqEZAQa5ogj
         oLqtIDDCoEBUwNKaF2AtnOuMlbm4M9Nn4IYGRlb2glHhTT2ADxRmJRZnNZWYsd2h83Vr
         yvvCPwC7hedmtKr0xHVRgc0/groC1/QGADFpKkpflbkEwzoHHwO7CW7lHbgJ+B3lk6at
         4Hq8M/ve7bBz2K3mBqeHByeLEWCvK934XGjYS0ZiwTOWxrl3c3UQ2VugT6fEqEv2lIXM
         oAFw==
X-Gm-Message-State: AKwxyteZnaP/5Gg/hwChI/RyDTbWqlJ/9HT8nhwfz8CEx9j8O8E/Htgi
        DscOYYw7l6cmHXa5gFnTef4OpVnJHsJnK9YISROe0B4p
X-Google-Smtp-Source: ACJfBosavDjRYZs65+IlZ1OLgaY8gXqTpdW1gtY7YTYXYGejGacRV7dRWkpzxtfI2PgR3t4caPz9gqhyMagXvdtQjXI=
X-Received: by 10.36.84.205 with SMTP id t196mr12803471ita.128.1516194852129;
 Wed, 17 Jan 2018 05:14:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.113.199 with HTTP; Wed, 17 Jan 2018 05:14:11 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 17 Jan 2018 14:14:11 +0100
Message-ID: <CAP8UFD21GqJRUWr2hxKPCKFPWuPVFVXRaKCUcY-dbVxbEKwjYQ@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 35
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, lwn@lwn.net,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Josef Wolf <jw@raven.inka.de>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 35th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2018/01/17/edition-35/

Thanks a lot to all the contributors!

Enjoy,
Christian, Jakub, Markus and Gabriel.
