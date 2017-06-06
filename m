Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75A1120D09
	for <e@80x24.org>; Tue,  6 Jun 2017 17:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751416AbdFFRmX (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 13:42:23 -0400
Received: from forward10h.cmail.yandex.net ([87.250.230.221]:47202 "EHLO
        forward10h.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751291AbdFFRmW (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 6 Jun 2017 13:42:22 -0400
X-Greylist: delayed 473 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Jun 2017 13:42:22 EDT
Received: from mxback2h.mail.yandex.net (mxback2h.mail.yandex.net [IPv6:2a02:6b8:0:f05::10b])
        by forward10h.cmail.yandex.net (Yandex) with ESMTP id B07C8215FE
        for <git@vger.kernel.org>; Tue,  6 Jun 2017 20:34:25 +0300 (MSK)
Received: from web10m.yandex.ru (web10m.yandex.ru [37.140.138.101])
        by mxback2h.mail.yandex.net (nwsmtp/Yandex) with ESMTP id W0rciGMAbJ-YJaWLBsL;
        Tue, 06 Jun 2017 20:34:19 +0300
Received: by web10m.yandex.ru with HTTP;
        Tue, 06 Jun 2017 20:34:19 +0300
From:   Konstantin Podsvirov <konstantin@podsvirov.pro>
To:     git@vger.kernel.org
Subject: [BUG] Help > About Git Gui = crash
MIME-Version: 1.0
Message-Id: <227151496770459@web10m.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Tue, 06 Jun 2017 20:34:19 +0300
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reproduction:
- Start git gui
- Go to menu panel: Help > About Git Gui

Output:
error: git-gui died of signal 11

Environment:
Debian 8 jessie amd64 KDE

--
Regards,
Konstantin Podsvirov
