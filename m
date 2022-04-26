Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004FFC433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 15:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349472AbiDZPY5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 11:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347899AbiDZPYz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 11:24:55 -0400
Received: from hosting01.xaranet.de (hosting01.xaranet.de [192.162.85.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AE49FE6
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 08:21:44 -0700 (PDT)
Received: from [192.168.178.20] (p54a37379.dip0.t-ipconnect.de [84.163.115.121])
        by hosting01.xaranet.de (Postfix) with ESMTPSA id 3E055A0799
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 17:21:41 +0200 (CEST)
Authentication-Results: hosting01.xaranet.de;
        spf=pass (sender IP is 84.163.115.121) smtp.mailfrom=guy.j@maurel.de smtp.helo=[192.168.178.20]
Received-SPF: pass (hosting01.xaranet.de: connection is authenticated)
Message-ID: <c14e6883-57f1-ab66-7453-830dad9f6eb7@maurel.de>
Date:   Tue, 26 Apr 2022 17:21:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: de-DE
To:     git@vger.kernel.org
From:   Guy Maurel <guy.j@maurel.de>
Subject: configure doesn't test all
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <165098650149.32108.3059381094883824744@hosting01.xaranet.de>
X-PPP-Vhost: maurel.de
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!

./configure
make
GIT_VERSION = 2.36.0
     * new build flags
     CC fuzz-commit-graph.o
In file included from commit-graph.h:4,
                  from fuzz-commit-graph.c:1:
git-compat-util.h:1427:10: fatal error: zlib.h

Is missing on my Mint-system, BUT configure doesn't complain about this.

-- 
Guy Maurel
Sebastian-Fischer-Weg 13
89077 Ulm/Germany
