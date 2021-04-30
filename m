Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647C5C433ED
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 14:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3005E613F8
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 14:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhD3O6d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 10:58:33 -0400
Received: from elephants.elehost.com ([216.66.27.132]:40983 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbhD3O6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 10:58:25 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 13UEvYeM089510
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 10:57:35 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
References: <011e01d73dd0$ec141530$c43c3f90$@nexbridge.com>
In-Reply-To: <011e01d73dd0$ec141530$c43c3f90$@nexbridge.com>
Subject: RE: [Patch 0/3] Explicit support for NonStop SSH variant
Date:   Fri, 30 Apr 2021 10:57:28 -0400
Message-ID: <012201d73dd1$27024b80$7506e280$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQGrR5/5dV7WhbnFo2JmEduBSf6qEKslEtrw
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apologies for not using git send-email/imap-send. My ISP is blocking my access to that capability.

Randall S. Becker, Managing Director, Nexbridge Inc.
+1.416.984.9826

-----Original Message-----
From: Randall S. Becker <rsbecker@nexbridge.com> 
Sent: April 30, 2021 10:56 AM
To: git@vger.kernel.org
Subject: [Patch 0/3] Explicit support for NonStop SSH variant

>From 375278eb010a91f0ad3114ca2334cd85c4519208 Mon Sep 17 00:00:00 2001
From: "Randall S. Becker" <rsbecker@nexbridge.com>
Date: Fri, 30 Apr 2021 10:19:38 -0400
Subject: [Patch 0/3] Explicit support for NonStop SSH variant

The nonstopssh SSH variant constructs the platform-specific SSH
command using the /G/system/zssh/sshoss program and typical
program arguments needed by users to use this client on the NonStop
x86 and ia64 platforms.

Randall S. Becker (3):
  connect.c: add nonstopssh variant to the sshVariant set.
  ssh.txt: document nonstopssh variant
  t5601: add nonstopssh SSH variant sub-tests

 Documentation/config/ssh.txt | 18 +++++++++++++++++-
 connect.c                    | 17 +++++++++++++++++
 t/t5601-clone.sh             | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 1 deletion(-)

--
2.29.2

