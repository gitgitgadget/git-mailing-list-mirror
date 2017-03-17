Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFB2B20951
	for <e@80x24.org>; Fri, 17 Mar 2017 15:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751345AbdCQPFF (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 11:05:05 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52526 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751143AbdCQPEX (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Mar 2017 11:04:23 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id D7ECC20503;
        Fri, 17 Mar 2017 11:04:20 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 17 Mar 2017 11:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
        :content-transfer-encoding:content-type:date:from:message-id
        :mime-version:subject:to:x-me-sender:x-me-sender:x-sasl-enc
        :x-sasl-enc; s=fm1; bh=Q42t6cQ0KuK3YJ3mNWwi15QsoY8=; b=iN0M6z9lW
        Cm7pKUVRDrOUI7DKgfBANHUuTyrcMBhAmePPD9uk9++vCD6kEZ1o/aE6OnpcjcSp
        OyN+vuknD0zo7aje3fuWoM7drUX2zckWuitGNMm2kb/cDvA8RMOhZtcDSJ5b/uF5
        ZSEEieCSODonZUZM09XKjip29SJocFY6awTIdql7jnLq8O0mNZ6uHd5tiJr8kv6T
        KLNLhVTBkULYuL5l6JIk4tZc0mYyEhY36xuKCq23dwBBpFKK3idvog2WvlwA5Uu6
        hEeuwyLlsL6ixmvsr4SsVHZKkoptfCX7xski14pik+2ghCNmLbMF1MFZPMfgFvN3
        wZqrumHkmcn2A==
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=Q42t6cQ0KuK3YJ3mNW
        wi15QsoY8=; b=mRI2FM0MR0h+pMzYJzbYkDFoq4PhSYxcOiJiXE01CpeORj8HEe
        FAd0Ji7y6N8XZIHpQLESRMcufuwvcIfPhHT//gGwsbuL33XMhQlRe39gsLL048ZC
        OZmIHkxPqj+TSlFoq825KQ5uzubEP+w84vxbV9j8mYqd62qarK0VRhJ4LlLqjOe3
        ItsitJB6mkIfooToLh7KJvCJ0kIjifMqzs7bCGZWrHQry1ZZinJEICcQ42LLKDuR
        GvEKLCfBlsfXqLdlHz/M+ZBkVO426L5aePgtiEv4pBkN2AS3kLDAZWsB4wh7QINp
        tE24hdtCxnUQmZzEAMrVZGYdcKyKYlv37nIQ==
X-ME-Sender: <xms:9PrLWHTpn7JLrOLFkPLLihFcN4wOwP32mtLAVOuEx8nc97FWm_P1uw>
X-Sasl-enc: TiXmX90HNDwBiX1UDE3utu1ApWkiBbc5TI/AAUHgU7B7 1489763060
Received: from localhost (dslb-178-011-152-175.178.011.pools.vodafone-ip.de [178.11.152.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id 646912436A;
        Fri, 17 Mar 2017 11:04:20 -0400 (EDT)
From:   Michael J Gruber <git@drmicha.warpmail.net>
To:     git@vger.kernel.org
Cc:     Ralf Thielow <ralf.thielow@googlemail.com>
Subject: [PATCH] l10n: de: lower case after semi-colon
Date:   Fri, 17 Mar 2017 16:04:19 +0100
Message-Id: <ae12d1eaac8cec63bbfe0eae3b428b781fd34d30.1489762895.git.git@drmicha.warpmail.net>
X-Mailer: git-send-email 2.12.0.484.g92f9ab2bc1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Just a minor thing. I'm wondering about lower/upper case
at the beginning of the line, though. Do we have a rule for de.po?

 po/de.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/de.po b/po/de.po
index e9c86f5488..f8215945e7 100644
--- a/po/de.po
+++ b/po/de.po
@@ -7599,7 +7599,7 @@ msgid ""
 "more than %i tags found; listed %i most recent\n"
 "gave up search at %s\n"
 msgstr ""
-"mehr als %i Tags gefunden; Führe die ersten %i auf\n"
+"mehr als %i Tags gefunden; führe die ersten %i auf\n"
 "Suche bei %s aufgegeben\n"
 
 #: builtin/describe.c:396
-- 
2.12.0.484.g92f9ab2bc1

