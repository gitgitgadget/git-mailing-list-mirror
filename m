Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BA0C1FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 14:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754650AbdBHOR5 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 8 Feb 2017 09:17:57 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:19357 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753915AbdBHOQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 09:16:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id DB8631E1872;
        Wed,  8 Feb 2017 14:23:05 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id rYR8R6pG_rFp; Wed,  8 Feb 2017 14:23:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 938DC1E1877;
        Wed,  8 Feb 2017 14:23:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id K-jXOBTEdFJG; Wed,  8 Feb 2017 14:23:05 +0100 (CET)
Received: from [192.168.178.77] (46.128.140.114.dynamic.cablesurf.de [46.128.140.114])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 526F21E1872;
        Wed,  8 Feb 2017 14:23:05 +0100 (CET)
Subject: Re: [PATCH 1/2] pathspec magic: add '^' as alias for '!'
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>
References: <alpine.LFD.2.20.1702072113040.25002@i7.lan>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   Cornelius Weig <cornelius.weig@tngtech.com>
Message-ID: <72ce071a-064d-5123-3248-d8486843c767@tngtech.com>
Date:   Wed, 8 Feb 2017 14:23:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.20.1702072113040.25002@i7.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As Duy pointed out, the glossary needs an update too.

For this one, the cange can be minimal I think:

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 8ad29e6..f127fe9 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -386,7 +386,7 @@ Glob magic is incompatible with literal magic.
 
 exclude;;
        After a path matches any non-exclude pathspec, it will be run
-       through all exclude pathspec (magic signature: `!`). If it
+       through all exclude pathspec (magic signature: `!` or `^`). If it
        matches, the path is ignored.
 --
 
