Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC2981FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 14:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752400AbdCXOBl (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 10:01:41 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42156 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751616AbdCXOBj (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Mar 2017 10:01:39 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 88853207D8;
        Fri, 24 Mar 2017 10:01:37 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 24 Mar 2017 10:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=bn+CZb
        VJMu66ChtO6NVrzwMwnC7+ggRO5yZ9lWiCNQE=; b=kDZ/finIINEG81JH9yGsza
        yH75c0gc7H690zi+oGe1QERU/i5fJ+CB6LzRLfjGIQvRWCvkbLG2RYmpwNE4zDFk
        yXqJfk0nPodEIvB8fVNKybo5dM1bgmN0/xYhqh5ECg4rF0sWpsVztYcwhoZeXawQ
        +M0DPU4lnsRV5XixDNbZODUP/vCH7ky/NrLlG+XGit7hX52bNOPQp4Mu/ZYfTaln
        XoR6SnwC1dB0EKKycpTcgUn/QWfQ7tzCZ3YOvjytoBK8Ou96ZmOm3hzddV/HHxGA
        NviRLwZF0iJU4QYpKne9OLlPdvcVk/vfTvYxd88Cu0olZmb+CYOs3rjhU+pmoEZg
        ==
X-ME-Sender: <xms:wSbVWNDALH-n16Hmb3y6IYlCIY-QLq9MJnKeIhwD_r1cG57fDyjLDA>
X-Sasl-enc: iWjF/bmD2leUHpUr20A7YXZYwHya8L6wSTfY7mq/OUa9 1490364097
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2C86C244DA;
        Fri, 24 Mar 2017 10:01:37 -0400 (EDT)
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] mailmap: use Michael J Gruber's new address
Date:   Fri, 24 Mar 2017 15:01:36 +0100
Message-Id: <0f89a236d8e31aaa55cc45eaa6294855fc6c90fe.1490364024.git.git@grubix.eu>
X-Mailer: git-send-email 2.12.1.598.g142b194aba
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Map both old addresses to the new, hopefully more permanent one.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 .mailmap | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index e06526a493..ab85e0d16d 100644
--- a/.mailmap
+++ b/.mailmap
@@ -151,7 +151,8 @@ Matthias Kestenholz <matthias@spinlock.ch> <mk@spinlock.ch>
 Matthias Urlichs <matthias@urlichs.de> <smurf@kiste.(none)>
 Matthias Urlichs <matthias@urlichs.de> <smurf@smurf.noris.de>
 Michael Coleman <tutufan@gmail.com>
-Michael J Gruber <git@drmicha.warpmail.net> <michaeljgruber+gmane@fastmail.fm>
+Michael J Gruber <git@grubix.eu> <michaeljgruber+gmane@fastmail.fm>
+Michael J Gruber <git@grubix.eu> <git@drmicha.warpmail.net>
 Michael S. Tsirkin <mst@kernel.org> <mst@redhat.com>
 Michael S. Tsirkin <mst@kernel.org> <mst@mellanox.co.il>
 Michael S. Tsirkin <mst@kernel.org> <mst@dev.mellanox.co.il>
-- 
2.12.1.598.g142b194aba

