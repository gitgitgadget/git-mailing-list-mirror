Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ECED1FAAD
	for <e@80x24.org>; Fri, 27 Jan 2017 21:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751382AbdA0VUS (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 16:20:18 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:4787 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbdA0VTO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 16:19:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 722D41E2E2F;
        Fri, 27 Jan 2017 22:19:11 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id b8mmGB26mRS5; Fri, 27 Jan 2017 22:19:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 13F561E2FBA;
        Fri, 27 Jan 2017 22:19:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FZrQB-zh80eb; Fri, 27 Jan 2017 22:19:11 +0100 (CET)
Received: from localhost.localdomain (aftr-185-17-206-252.dynamic.mnet-online.de [185.17.206.252])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id A01011E2E2F;
        Fri, 27 Jan 2017 22:19:10 +0100 (CET)
From:   cornelius.weig@tngtech.com
To:     j6t@kdbg.org
Cc:     szeder.dev@gmail.com, spearce@spearce.org, git@vger.kernel.org,
        Cornelius Weig <cornelius.weig@tngtech.com>
Subject: [PATCH v2 0/7] completion: recognize more long-options
Date:   Fri, 27 Jan 2017 22:17:02 +0100
Message-Id: <20170127211703.24910-1-cornelius.weig@tngtech.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <74ecd09c-55da-3858-5187-52c286a6bf62@kdbg.org>
References: <74ecd09c-55da-3858-5187-52c286a6bf62@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cornelius Weig <cornelius.weig@tngtech.com>

This revision addresses Johannes' concerns. Changes wrt v1:

 - fixed the commit message: two of the "dangerous" options erroneously ended
   up in the commit message. These options were already in the list of
   auto-completable options.
 - removed the possibly dangerous option '--unsafe-paths' from git-apply.
 - added my sign-off

Patches 1-6 are not resent, because they have not changed (other than my added sign-off).

Also, I added further people to CC, because nobody actually has looked at the code yet.


Cornelius Weig (7):
  completion: recognize more long-options

 contrib/completion/git-completion.bash | 132 +++++++++++++++++++++++++++------
 1 file changed, 110 insertions(+), 22 deletions(-)

-- 
2.10.2

