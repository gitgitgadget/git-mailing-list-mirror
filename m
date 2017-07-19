Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCAC61F600
	for <e@80x24.org>; Wed, 19 Jul 2017 11:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932183AbdGSLbh (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jul 2017 07:31:37 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37080 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754074AbdGSLbe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2017 07:31:34 -0400
Received: by mail-qt0-f195.google.com with SMTP id n43so328302qtc.4
        for <git@vger.kernel.org>; Wed, 19 Jul 2017 04:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=mblETWBZ0UVnELf6QvEdZtYpmkgHG2V2dxnk339B0pw=;
        b=mY2zOemGOm+QVfXnFX6XBM2jVYTUIGgNRGf7RB9L/+ufZ395+Cmeeski1+qYI2qY3b
         QNoDL+fp5/P6/FbD7ZZJPjotPt/mUXFsppkxM5ikXxPumF6YbJ6EK2LmgAdE6Tk/9fNB
         hOMu8g1B+5jgjxB3ws7sZbP4hSj/5Ihs+xoBNJqQwnhPpLHamPXBLBJr/I9hPzCxF8Ta
         +veBfCK/ybmZ0FkUJpiazJjsN0LPWytyTM6yiUoy+8PUCNyiXWVV//HvzpjysdHkZ7bh
         0nHbKaEsUwGcG0/Y9od9aPXXK2uHH91p4z+CN35sIa/Jw7k9zdZ0wjqhAnOhwj5eC0PF
         XJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=mblETWBZ0UVnELf6QvEdZtYpmkgHG2V2dxnk339B0pw=;
        b=pn5zX0jpaej9QEYbFiGLi8TU12r5eqOzX/TZiDpwJFXJu7cLCFMaEZQZxnyZTLTcrq
         pbaTny/rdcizqQ2X3/IsTqHbb7W5Lh2jiekJZjRm/FkfTyl/sR/UVrLRnABcTPD/hRaS
         jng+SOJyojOwDb1Rq2o3/FqfL+AKEH5v/EGp8oejZLqGm8kai+Cio8VIuzuQ9KOrDN/8
         Luqt2ghIdPAh+YiXyiJfvR19cEk7OAXF9ZzYzgM4cfsp8AsB0q+f+9ZtmHnXFp+/Y7Wq
         bBeZ2ymYt4SeYO/shEdFdzqaMXYvoyY34ZocCXTBtlVLh2s4w6amWXcb6W/ERKtt+OJ1
         ayQg==
X-Gm-Message-State: AIVw110WnxVA/779i/C9ZDwzCYnHP4CGmz9l9vjyiu6d2QOC5oZy+PeR
        YEg0Hv7FLhxtJG8s2XX/1Uwr5+iGAW3+
X-Received: by 10.237.49.194 with SMTP id 60mr2571286qth.73.1500463893015;
 Wed, 19 Jul 2017 04:31:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.31.13 with HTTP; Wed, 19 Jul 2017 04:31:32 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 19 Jul 2017 13:31:32 +0200
Message-ID: <CAP8UFD1LBuZHrTXYTr+bqc+44kwwfns6uc=rzzPGAx=vRoQzow@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 29
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 29th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2017/07/19/edition-29/

Thanks a lot to all the contributors and helpers!

Enjoy,
Christian, Thomas, Jakub and Markus.
