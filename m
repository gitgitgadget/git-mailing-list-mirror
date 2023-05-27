Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BE8C77B7C
	for <git@archiver.kernel.org>; Sat, 27 May 2023 13:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjE0NS3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 May 2023 09:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjE0NS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 May 2023 09:18:28 -0400
X-Greylist: delayed 2370 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 27 May 2023 06:18:26 PDT
Received: from smtpout2.mo529.mail-out.ovh.net (smtpout2.mo529.mail-out.ovh.net [79.137.123.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BE4A6
        for <git@vger.kernel.org>; Sat, 27 May 2023 06:18:26 -0700 (PDT)
Received: from mxplan6.mail.ovh.net (unknown [10.108.16.128])
        by mo529.mail-out.ovh.net (Postfix) with ESMTPS id D45BF20A54;
        Sat, 27 May 2023 12:38:54 +0000 (UTC)
Received: from jwilk.net (37.59.142.96) by DAG4EX1.mxp6.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 27 May
 2023 14:38:54 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-96R0015ed21d62-1c34-4f65-b10f-dc9f7deb8de5,
                    E2F3FEF457BEBCFF5195458F6703427CA1773367) smtp.auth=jwilk@jwilk.net
X-OVh-ClientIp: 5.172.255.83
From:   Jakub Wilk <jwilk@jwilk.net>
To:     <git@vger.kernel.org>
CC:     Eric Wong <normalperson@yhbt.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-clone.txt: document -4 and -6
Date:   Sat, 27 May 2023 14:38:49 +0200
Message-ID: <20230527123849.5990-1-jwilk@jwilk.net>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG6EX2.mxp6.local (172.16.2.52) To DAG4EX1.mxp6.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: b2e88486-c0f6-4e5e-ae9c-43ce0c358819
X-Ovh-Tracer-Id: 18004828361551763424
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekuddgheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvfevufffkffoggfgtghisehtkeertdertddtnecuhfhrohhmpeflrghkuhgsucghihhlkhcuoehjfihilhhksehjfihilhhkrdhnvghtqeenucggtffrrghtthgvrhhnpeefhfetfffhffehtedufedvfeehfffgudeljeehieetiefhfeffjeevleejveehieenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddrleeipdehrddujedvrddvheehrdekfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehjfihilhhksehjfihilhhkrdhnvghtqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhnohhrmhgrlhhpvghrshhonheshihhsghtrdhnvghtpdhgihhtshhtvghrsehpohgsohigrdgtohhmpdfovfetjfhoshhtpehmohehvdelpdhmohguvgepshhmthhpohhuth
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These options were added in c915f11eb4 ("connect & http: support -4 and
-6 switches for remote operations").

Signed-off-by: Jakub Wilk <jwilk@jwilk.net>
---
 Documentation/git-clone.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index c37c4a37f7..e6f0329510 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -316,6 +316,14 @@ or `--mirror` is given)
 	The number of submodules fetched at the same time.
 	Defaults to the `submodule.fetchJobs` option.
 
+-4::
+--ipv4::
+	Use IPv4 addresses only, ignoring IPv6 addresses.
+
+-6::
+--ipv6::
+	Use IPv6 addresses only, ignoring IPv4 addresses.
+
 <repository>::
 	The (possibly remote) repository to clone from.  See the
 	<<URLS,GIT URLS>> section below for more information on specifying
-- 
2.25.1

