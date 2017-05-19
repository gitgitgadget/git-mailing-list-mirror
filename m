Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19043201CF
	for <e@80x24.org>; Fri, 19 May 2017 02:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755558AbdESCpF (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 22:45:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54650 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752301AbdESCpE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 22:45:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4AA1081B6D;
        Thu, 18 May 2017 22:45:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id; s=sasl; bh=oN0eDq/cP5uk3Y03qBHqnRjtC2o
        =; b=u+kux2U2pF3prMlx1HZe9k5g9S8vPwkBSZTfe8tMAQ/KHxcd+9qOr1yjE9S
        ueczQRCkkYz6eX3rxVA54kGSHAzkbMInSR4PjUu2HxqhecmoO7Ei2/GDsWYNK2VG
        wJkv+u1IGXxMLwi/eCEfZLckG0m6qXkTW4EBvVCqso1L0a8c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3B8AC81B6C;
        Thu, 18 May 2017 22:45:03 -0400 (EDT)
Received: from kmlap.hsd1.ct.comcast.net (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 439F481B69;
        Thu, 18 May 2017 22:45:01 -0400 (EDT)
From:   Kyle Meyer <kyle@kyleam.com>
To:     git@vger.kernel.org
Cc:     Kyle Meyer <kyle@kyleam.com>
Subject: [PATCH] config.txt: add an entry for log.showSignature
Date:   Thu, 18 May 2017 22:44:51 -0400
Message-Id: <20170519024451.11252-1-kyle@kyleam.com>
X-Mailer: git-send-email 2.13.0
X-Pobox-Relay-ID: 28380E66-3C3D-11E7-A6FD-61520C78B957-24757444!pb-smtp2.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id; s=mesmtp;
 bh=oN0eDq/cP5uk3Y03qBHqnRjtC2o=;
 b=KQcFoP2V+rKONYdk1ohxMn5R6bcjd85mI0j3kpye5GS4ffgey4fFWStlzgwH9MO49VSRlQQ5yx/UIjctITGJEvg8grep8XnNx4BPr7H5zp5b8yI1x0y9qwByKtrNeXpiBPcmzIE2c3qU7UG1mWJ4Jkcf4ZJTLo4BwIORMoxDkqM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The configuration variable log.showSignature is mentioned in git-log's
manpage.  Document it in git-config's manpage as well.

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 Documentation/config.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 96e9cf8b7..a7dce9a1e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2143,6 +2143,10 @@ log.showRoot::
 	Tools like linkgit:git-log[1] or linkgit:git-whatchanged[1], which
 	normally hide the root commit will now show it. True by default.
 
+log.showSignature::
+	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
+	linkgit:git-whatchanged[1] assume `--show-signature`.
+
 log.mailmap::
 	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
 	linkgit:git-whatchanged[1] assume `--use-mailmap`.
-- 
2.13.0

