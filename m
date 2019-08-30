Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91F511F461
	for <e@80x24.org>; Fri, 30 Aug 2019 15:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfH3PQT (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 11:16:19 -0400
Received: from smtp01.domein-it.com ([92.48.232.141]:36009 "EHLO
        smtp01.domein-it.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfH3PQT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 11:16:19 -0400
Received: by smtp01.domein-it.com (Postfix, from userid 1000)
        id 3755D806F8A5; Fri, 30 Aug 2019 17:16:17 +0200 (CEST)
Received: from ferret.domein-it.nl (unknown [92.48.232.148])
        by smtp01.domein-it.com (Postfix) with ESMTP id 19A85807B72F;
        Fri, 30 Aug 2019 17:16:13 +0200 (CEST)
Received: from 80-112-22-40.cable.dynamic.v4.ziggo.nl ([80.112.22.40]:54406 helo=ben.local)
        by ferret.domein-it.nl with esmtpa (Exim 4.92)
        (envelope-from <ben@wijen.net>)
        id 1i3idF-0004lz-Fn; Fri, 30 Aug 2019 17:16:09 +0200
From:   Ben Wijen <ben@wijen.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Szeder=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Ben Wijen <ben@wijen.net>
Subject: [PATCH v6 0/2] rebase.c: make sure current branch isn't moved when autostashing
Date:   Fri, 30 Aug 2019 17:16:04 +0200
Message-Id: <20190830151607.4208-1-ben@wijen.net>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829164757.7301-1-ben@wijen.net>
References: <20190829164757.7301-1-ben@wijen.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Domein-IT-MailScanner-Information: Please contact the ISP for more information
X-Domein-IT-MailScanner-ID: 1i3idF-0004lz-Fn
X-Domein-IT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-Domein-IT-MailScanner-SpamCheck: 
X-Domein-IT-MailScanner-From: ben@wijen.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are my "fix things without making unnecessary changes"
Fixing a copy-paste fault which I missed in v5...


Ben Wijen (2):
  builtin/rebase.c: make sure the active branch isn't moved when
    autostashing
  builtin/rebase.c: Remove obsolete message

 builtin/rebase.c            | 13 +------------
 t/t3420-rebase-autostash.sh | 12 ++++++++----
 2 files changed, 9 insertions(+), 16 deletions(-)

-- 
2.22.0

