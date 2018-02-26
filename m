Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	PI_EMPTY_SUBJ,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 206851F404
	for <e@80x24.org>; Mon, 26 Feb 2018 17:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751732AbeBZR1V (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 12:27:21 -0500
Received: from mout.web.de ([212.227.17.12]:57705 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751061AbeBZR1T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 12:27:19 -0500
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lz376-1edHg21I2q-01498p; Mon, 26
 Feb 2018 18:27:06 +0100
From:   tboegi@web.de
To:     peff@peff.net, j6t@kdbg.org, lars.schneider@autodesk.com,
        git@vger.kernel.org, gitster@pobox.com, patrick@luehne.de,
        larsxschneider@gmail.com
Subject: 
Date:   Mon, 26 Feb 2018 18:27:04 +0100
Message-Id: <20180226172704.7779-1-tboegi@web.de>
X-Mailer: git-send-email 2.16.1.194.gb2e45c695d
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:SRgOhVCSqw2JKmn8D9B5gBbXONcsO6Zrkc1KeLVgIhCjjiq/qlC
 TLEqZOduqP6nbTCaNlL1geyiJrr/V5JZbcDlbz/AIYvrKArKDvDEisBwAQp35/wMQ3TNkTU
 bXgIj8mryFUOk293DEp8G9f89QV+RC0gWqaHOexrCuLgwLilQGu0uPIoE3PjBsEWkSleme3
 nvd/r5Bn+MVZBQ/rF8qBQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J/iAN1GdglA=:vAhXRUtDyNntIIuBhKMuZx
 vjjXf76vYQ2Xv3tT9OcL9+XVpHrvfTl+8nHD7uaboV728XtRwdmTOmFfe+6zor5doOozBMRE/
 cetxlXkdijjlFsVq/hMU+jxW0PN9t3SPGy1SWaMtKDKTB5y3WmHzOpNgrn3G88e8RIsiqsLiU
 Cu/X4kmOoZp2TbIRO18ttGKMOciUweh/EGk/RPvhJZaA9vXgjPaHfQTOA9dcnmXYJwZkN2D7S
 27JdR6cGLz2g5Oi+E4yfJDW/USY8na0Cc0pJFPfErxxRySAdqW7sM05jZDlDIW3POFuPa1dTn
 QjLH4RbbcpkEkJy1tIC5UavB955pfyWIAC5i/HXK8zmLYGPLYaiij/4/LRYJmv6ZDyzow85ZR
 YXIaz9HzN/AuTJYHhpF4M4wdlG7awZZX04dsGDzuHmRrwmiy7XPKKxfJkGBafmTFG13w4jvUF
 qq3sRx45tp1fIuXID0HMYSYbyzGS/jpiDptFEpI/g8F/b7VEOZ1q5zvtr5sELfj5LVz0iFei+
 NxxKoIjbTcqNGpslEakkVYxa8gXnSTvRKUOnZamVQA/E7ZBF5sd+HibhpRtxX4enEHd/PvHHL
 bVVbMuo/rHnUc9Ex1+fuhpB71O+c5Hr1oPu5kSYOuDuaM7SGhtytib/bpxKTVit7FPj144XpB
 FgcYaAa9ajQ0YJPNu1tnF7vP/AUyCFk92JguNAHFHUK8L0Xdjq4i2D2eocZHTLQHpz7O5B+6A
 HMChYFxwYgOiWKMyd9a+rQDWAvGbUQZ0yvyy/ETyiiFa5N01gNl+GHoG3LNbzJCWXMJH6oRwh
 VJK5IPaUz5JDFOygBKBn8586aKl4zsExUsd1XVFnkWZfPsbg14=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From 9f7d43f29eaf6017b7b16261ce91d8ef182cf415 Mon Sep 17 00:00:00 2001
In-Reply-To: <20171218131249.GB4665@sigill.intra.peff.net>
References: <20171218131249.GB4665@sigill.intra.peff.net>
From: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Date: Fri, 23 Feb 2018 20:53:34 +0100
Subject: [PATCH 0/1] Auto diff of UTF-16 files in UTF-8
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Make it possible to show a user-readable diff for UTF-16 encoded files.
This would replace the "binary files differ" with something useful,
without breaking anything for existing users (?).
For future repos the w-t-e encoding can be used, which allows e.g. easier
merging.
People which stick to native UTF-16 because they need the compatiblity
with e.g. libgit2 can still get a readable diff.
Opinions ?

Torsten Bögershausen (1):
  Auto diff of UTF-16 files in UTF-8

 diff.c                   | 43 ++++++++++++++++++++-
 diffcore.h               |  3 ++
 t/t4066-diff-encoding.sh | 98 ++++++++++++++++++++++++++++++++++++++++++++++++
 utf8.h                   | 11 ++++++
 4 files changed, 153 insertions(+), 2 deletions(-)
 create mode 100755 t/t4066-diff-encoding.sh

-- 
2.16.1.194.gb2e45c695d

