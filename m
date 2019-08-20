Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFE3E1F461
	for <e@80x24.org>; Tue, 20 Aug 2019 20:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbfHTUNC (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 16:13:02 -0400
Received: from smtp01.domein-it.com ([92.48.232.141]:58242 "EHLO
        smtp01.domein-it.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfHTUNC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 16:13:02 -0400
Received: by smtp01.domein-it.com (Postfix, from userid 1000)
        id 244C080A51B0; Tue, 20 Aug 2019 22:13:01 +0200 (CEST)
Received: from ferret.domein-it.nl (unknown [92.48.232.148])
        by smtp01.domein-it.com (Postfix) with ESMTP id 2D37F80A51A7;
        Tue, 20 Aug 2019 22:12:44 +0200 (CEST)
Received: from 80-112-22-40.cable.dynamic.v4.ziggo.nl ([80.112.22.40]:33342 helo=ben.local)
        by ferret.domein-it.nl with esmtpa (Exim 4.92)
        (envelope-from <ben@wijen.net>)
        id 1i0AUi-0005DL-Es; Tue, 20 Aug 2019 22:12:40 +0200
From:   Ben Wijen <ben@wijen.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Ben Wijen <ben@wijen.net>
Subject: [PATCH v2 0/1] git rebase: Make sure upstream branch is left alone.
Date:   Tue, 20 Aug 2019 22:12:36 +0200
Message-Id: <20190820201237.10205-1-ben@wijen.net>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190818095349.3218-3-ben@wijen.net>
References: <20190818095349.3218-3-ben@wijen.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Domein-IT-MailScanner-Information: Please contact the ISP for more information
X-Domein-IT-MailScanner-ID: 1i0AUi-0005DL-Es
X-Domein-IT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-Domein-IT-MailScanner-SpamCheck: 
X-Domein-IT-MailScanner-From: ben@wijen.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip, Junio,

Thank you for taking the time to look into this.
With this new patch I think I've addressed all your concerns.


Ben Wijen (1):
  rebase.c: make sure current branch isn't moved when autostashing

 builtin/rebase.c            | 18 ++++++------------
 t/t3420-rebase-autostash.sh | 13 +++++++++----
 2 files changed, 15 insertions(+), 16 deletions(-)

-- 
2.22.0

