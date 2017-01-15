Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA2722079E
	for <e@80x24.org>; Sun, 15 Jan 2017 12:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750946AbdAOMmF (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 07:42:05 -0500
Received: from forward13m.cmail.yandex.net ([5.255.216.144]:32810 "EHLO
        forward13m.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750859AbdAOMmE (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Jan 2017 07:42:04 -0500
Received: from mxback4g.mail.yandex.net (mxback4g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:165])
        by forward13m.cmail.yandex.net (Yandex) with ESMTP id 3000821C98
        for <git@vger.kernel.org>; Sun, 15 Jan 2017 15:42:02 +0300 (MSK)
Received: from web16g.yandex.ru (web16g.yandex.ru [95.108.252.116])
        by mxback4g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id gsHLKXF1Cu-g1fuKJ5a;
        Sun, 15 Jan 2017 15:42:01 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1484484121;
        bh=haQHkNOha6Mv//NyKOmQUcxVI9XqR2l+RpjAPTHSWr4=;
        h=From:To:Subject:Message-Id:Date;
        b=liENVFpWohwJiKK8GEm1wvQoEOCJkIrx0p0IgNzG+Oz+//tsy1j22EYc/PRu/rWDa
         /AbKLmcgkJozkoomQ+Itq43EaiQm8OJvX/cXuDOhbqc3M63psX8T4Yi6YE0t5RkrqT
         t7PurBiNSfiML4VefUQIyGXu4wwV9C1Sj4TJG0bA=
Authentication-Results: mxback4g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by web16g.yandex.ru with HTTP;
        Sun, 15 Jan 2017 15:42:01 +0300
From:   KES <kes-kes@yandex.ru>
Envelope-From: kes-kes@yandex.ua
To:     git <git@vger.kernel.org>
Subject: feature request: allow to stash changed files
MIME-Version: 1.0
Message-Id: <2141311484484121@web16g.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Sun, 15 Jan 2017 14:42:01 +0200
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

http://stackoverflow.com/questions/3040833/stash-only-one-file-out-of-multiple-files-that-have-changed-with-git#comment32451416_3040833

Sometimes poople are forced to save stash for changed files. But there is no such option (
