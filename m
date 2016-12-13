Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9107520451
	for <e@80x24.org>; Tue, 13 Dec 2016 23:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752831AbcLMXeM (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 18:34:12 -0500
Received: from mx1.2b3w.ch ([92.42.186.250]:56368 "EHLO mx1.2b3w.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751014AbcLMXdr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 18:33:47 -0500
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
        by mx1.2b3w.ch (Postfix) with ESMTP id 496D3C3444
        for <git@vger.kernel.org>; Wed, 14 Dec 2016 00:31:54 +0100 (CET)
Received: from drbeat.li (21-244-153-5.dyn.cable.fcom.ch [5.153.244.21])
        by mx1.2b3w.ch (Postfix) with ESMTPSA id 48E6BC3442
        for <git@vger.kernel.org>; Wed, 14 Dec 2016 00:31:52 +0100 (CET)
Received: by drbeat.li (Postfix, from userid 1000)
        id 02B8521687; Wed, 14 Dec 2016 00:31:51 +0100 (CET)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Subject: [PATCH v2 0/6] unicode_width.h: update the width tables to Unicode 9.0
Date:   Wed, 14 Dec 2016 00:31:38 +0100
Message-Id: <1481671904-1143-1-git-send-email-dev+git@drbeat.li>
X-Mailer: git-send-email 2.7.2
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is v2 of my Unicode 9.0 series. After a short discussion [1], we
decided to move the generator script into contrib. This is what this
series now does first. The script is then updated in contrib.

Diff to v1:
- complete commit reordering
- fix nits in the commit messages

.gitignore                               |   1 -
contrib/update-unicode/.gitignore        |   3 ++
contrib/update-unicode/README            |  20 +++++++++++
contrib/update-unicode/update_unicode.sh |  33 ++++++++++++++++++
unicode_width.h                          | 131 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------
update_unicode.sh                        |  40 ----------------------
6 files changed, 163 insertions(+), 65 deletions(-)

[1] http://public-inbox.org/git/xmqqr35dm203.fsf@gitster.mtv.corp.google.com/
