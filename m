Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 879BF20970
	for <e@80x24.org>; Sat,  8 Apr 2017 20:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752577AbdDHUbI (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 16:31:08 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:32810 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752489AbdDHUbD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 16:31:03 -0400
Received: by mail-lf0-f48.google.com with SMTP id h125so55442070lfe.0
        for <git@vger.kernel.org>; Sat, 08 Apr 2017 13:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9GqrcrFKYtENSiyRAI9h34f2P6qd2f5yt6rQZXpORa8=;
        b=Yq445pIP61fjL5yGx6sO6kkkkxqtGHEotdmX6XVVC1fZNtB0wTz9/cFBVCr6QGJvvg
         ueUkTvl2ovv7nKp1uaf+E12xkcapgiZnatmHD0uBQtdoVhKx5QRxzeApBnxYrGW6bjnV
         ZCP/ZST1zDm/M7NtR4jR8hmzNtvWhCluppq1fmiNBW384UA9w+8wshrtUYJcFtTVtT51
         ajPh4Xx9YTsKNz8LJG/LFq1cApFVGASVD1g0zgQkUB8jDpqpgx1HmG8br2ofRNHF38Qj
         5vN0Q4MpENvgJN4Nkhggr/jC4Xf/XzEQs0u+VyF31yCAxFpF4q5M7NjJYO3DvOLBamEE
         +X7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9GqrcrFKYtENSiyRAI9h34f2P6qd2f5yt6rQZXpORa8=;
        b=QVoYqBbLSEUr6ArvJihr3ZfxwU4Itz11O7AuNB6LgHzq/qRu5n6sA3Mi1ez7M6uL5I
         91kIYuErp2akVgLireP/lt7FyPKx3lK8ObMkE1dIqPh4VU3mvBYcLIHTYwHYpSIGIde/
         x23F/X4YihYiumx7BSqFF7xMhmOddRvVOs74GPuPfju5HmYNSwEJZWStYks44Gc0PtjS
         zQjkaqmNSOs4F6Ntps8iYlzxle3PtNL1M6eOsIFokBJM7skZKTg0lWZL0tPiI/cZh1mo
         gG/9q0SYE8cTduSE2HkQiNbplqDWasisGFo19vXrlKUhKTi/kjSEk908EzPHt74blAm7
         bA4A==
X-Gm-Message-State: AFeK/H3rhVnxyPIwOQxK2uBI3bqXf9NHfBwMaBnRVJNrwIlyFuJpzNfsTQTUYZMv1wzCBg==
X-Received: by 10.46.5.148 with SMTP id 142mr14726351ljf.46.1491683461236;
        Sat, 08 Apr 2017 13:31:01 -0700 (PDT)
Received: from kicer.localnet (095160130254.rudaslaska.vectranet.pl. [95.160.130.254])
        by smtp.googlemail.com with ESMTPSA id f72sm1819626lfk.2.2017.04.08.13.31.00
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Apr 2017 13:31:00 -0700 (PDT)
From:   "=?utf-8?B?TWljaGHFgg==?= Walenciak" <kicer86@gmail.com>
X-Google-Original-From: =?utf-8?B?TWljaGHFgg==?= Walenciak <Kicer86@gmail.com>
To:     git@vger.kernel.org
Subject: broken text encoding in commit author name
Date:   Sat, 08 Apr 2017 22:30:55 +0200
Message-ID: <12228342.8FuY78Fyzc@kicer>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

since git 2.12 I'm having random problems with broken text enciding in auth=
or=20
name.

As an example broken commit:
Author: Micha=C3=85=C2=82 Walenciak <Kicer86@gmail.com>  2017-04-07 21:38:23
Committer: Micha=C5=82 Walenciak <Kicer86@gmail.com>  2017-04-07 21:38:33

good commit:=20
Author: Micha=C5=82 Walenciak <Kicer86@gmail.com>  2017-04-08 21:21:15
Committer: Micha=C5=82 Walenciak <Kicer86@gmail.com>  2017-04-08 21:21:15

Broken commits are quite rare and I cannot find any rule when they happen.
Git 2.12.2 here, Arch linux.

regards

=2D-=20
Micha=C5=82 Walenciak
gmail.com kicer86
http://kicer.sileman.net.pl
gg: 3729519
