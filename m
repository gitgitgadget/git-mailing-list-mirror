Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75F5320281
	for <e@80x24.org>; Thu, 14 Sep 2017 08:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751370AbdINIJM (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 04:09:12 -0400
Received: from 1.mo64.mail-out.ovh.net ([178.33.109.67]:46113 "EHLO
        1.mo64.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751265AbdINIJL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 04:09:11 -0400
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo64.mail-out.ovh.net (Postfix) with ESMTPS id 4912594A56
        for <git@vger.kernel.org>; Thu, 14 Sep 2017 09:51:01 +0200 (CEST)
Received: from [10.0.2.127] (86.200.198.152) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 14
 Sep 2017 09:50:54 +0200
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Subject: [PATCH v4 0/4] imap-send: Fix and enable curl by default
To:     <git@vger.kernel.org>
Openpgp: preference=signencrypt
Message-ID: <828c6333-0ba0-2a01-324e-f910a8042ca1@morey-chaisemartin.com>
Date:   Thu, 14 Sep 2017 09:50:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Language: fr-xx-classique+reforme1990
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.200.198.152]
X-ClientProxiedBy: CAS4.indiv2.local (172.16.1.4) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 3811452661655398365
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelledrgeehgdekfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v3:
- Fix return code in patch #1
- Reword patch#4

Nicolas Morey-Chaisemartin (4):
  imap-send: return with error if curl failed
  imap-send: add wrapper to get server credentials if needed
  imap_send: setup_curl: retreive credentials if not set in config file
  imap-send: use curl by default when possible

 imap-send.c | 60 ++++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 20 deletions(-)

-- 
2.14.1.461.g503560879

