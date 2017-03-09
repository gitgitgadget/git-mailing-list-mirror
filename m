Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E2D620135
	for <e@80x24.org>; Thu,  9 Mar 2017 01:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932174AbdCIBao (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 20:30:44 -0500
Received: from forward18m.cmail.yandex.net ([5.255.216.149]:48350 "EHLO
        forward18m.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750770AbdCIBao (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 Mar 2017 20:30:44 -0500
Received: from smtp1j.mail.yandex.net (smtp1j.mail.yandex.net [95.108.130.59])
        by forward18m.cmail.yandex.net (Yandex) with ESMTP id E896B214E6;
        Thu,  9 Mar 2017 04:27:43 +0300 (MSK)
Received: from smtp1j.mail.yandex.net (localhost.localdomain [127.0.0.1])
        by smtp1j.mail.yandex.net (Yandex) with ESMTP id 256913C80C6E;
        Thu,  9 Mar 2017 04:27:40 +0300 (MSK)
Received: by smtp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id OBpXAf9TTu-RdmqSFsI;
        Thu, 09 Mar 2017 04:27:39 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtolstov.org; s=mail; t=1489022859;
        bh=S9gs35opSGIGxEbSE6ZMQro2WpOEOx0cmJuzzIir6zQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=0//iGO1fFYqCRYWld4Xzd7kojrjEYcMAB1RCTkG7jaHFS6XiAwF1lBZsFBCTsYf6F
         nqC50PtVpo2tQDFqe5OKX1+AP/Q5DQPaLp1GsgDhQmUyafHk9Md861urufH1sCpdVH
         3wesRCBEM6jvT6rPvuMNw7r2IQIG8gd3Eq2v0ns8=
Authentication-Results: smtp1j.mail.yandex.net; dkim=pass header.i=@vtolstov.org
X-Yandex-ForeignMX:  US
X-Yandex-Suid-Status: 1 0,1 0,1 0,1 1130000030716801,1 0
From:   Valery Tolstov <me@vtolstov.org>
To:     git@vger.kernel.org
Cc:     bmwill@google.com, sbeller@google.com, me@vtolstov.org,
        gitster@pobox.com
Subject: [PATCH v3 0/2] Remove duplicate code from module_clone()
Date:   Thu,  9 Mar 2017 04:27:32 +0300
Message-Id: <20170309012734.21541-1-me@vtolstov.org>
X-Mailer: git-send-email 2.12.0.192.gbdb9d28a5
In-Reply-To: <20170309003858.GB153031@google.com>
References: <20170309003858.GB153031@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller (1):
  connect_work_tree_and_git_dir: safely create leading directories

Valery Tolstov (1):
  submodule--helper.c: remove duplicate code

 builtin/submodule--helper.c | 22 ++--------------------
 dir.c                       | 32 +++++++++++++++++++++-----------
 submodule.c                 | 11 ++---------
 3 files changed, 25 insertions(+), 40 deletions(-)

-- 
2.12.0.192.gbdb9d28a5

