Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D090209AB
	for <e@80x24.org>; Wed,  6 Sep 2017 06:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750880AbdIFGq7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 02:46:59 -0400
Received: from 9.mo176.mail-out.ovh.net ([46.105.78.81]:39693 "EHLO
        9.mo176.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbdIFGq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 02:46:59 -0400
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo176.mail-out.ovh.net (Postfix) with ESMTPS id 328BE8A043
        for <git@vger.kernel.org>; Wed,  6 Sep 2017 08:46:57 +0200 (CEST)
Received: from [10.0.2.127] (86.200.152.136) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 6 Sep
 2017 08:46:56 +0200
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Subject: [PATCHv3 0/2] fix recurse.submodule config for git pull
To:     <git@vger.kernel.org>
Openpgp: preference=signencrypt
Message-ID: <884cd3b0-7eeb-b711-2c7f-f93a57a009ee@morey-chaisemartin.com>
Date:   Wed, 6 Sep 2017 08:46:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Language: fr-xx-classique+reforme1990
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.200.152.136]
X-ClientProxiedBy: CAS1.indiv2.local (172.16.1.1) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 11088143758281795549
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelledrvdelgdduudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenuc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v2:
- Add a patch that fixes the option parsing order (parse config before cli, not the other way around)
- Enhance the tests to check --recurse-submodule and submodule.recurse combinations

Nicolas Morey-Chaisemartin (2):
  pull: fix cli and config option parsing order
  pull: honor submodule.recurse config option

 builtin/pull.c            |  8 ++++++--
 t/t5572-pull-submodule.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 2 deletions(-)

-- 
2.14.1.461.g503560879

