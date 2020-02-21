Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8EFC11D00
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 01:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075D724650
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 01:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbgBUBcn convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 20 Feb 2020 20:32:43 -0500
Received: from hub.hrl.com ([192.136.116.2]:9620 "EHLO mymail.hrl.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729554AbgBUBcn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 20:32:43 -0500
Received: from exch02.hrl.com (2002:c01b:5f3b::c01b:5f3b) by exch02.hrl.com
 (2002:c01b:5f3b::c01b:5f3b) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 20 Feb 2020 17:32:42 -0800
Received: from exch02.hrl.com ([fe80::dd6:55e:f5de:51e0]) by exch02.hrl.com
 ([fe80::dd6:55e:f5de:51e0%13]) with mapi id 15.00.1497.000; Thu, 20 Feb 2020
 17:32:42 -0800
From:   "Nogin, Aleksey" <anogin@hrl.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RFE: git stash --recurse-submodules
Thread-Topic: git stash --recurse-submodules
Thread-Index: AdXoVTGtseOIz1tqTYmYQo2gNEghagAAYFKA
Date:   Fri, 21 Feb 2020 01:32:42 +0000
Message-ID: <23ed84665dcb4058a8b6c19bfc1d1da5@exch02.hrl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.27.95.71]
x-etp-domain-auth-token: b38c41f7c92cc88e4332608a61a11755b41b18b5faf8f99c0c1892fe5a6a05b1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is there a good reason for git stash to not take the --recurse-submodules flag? Thank you.

Aleksey
CONFIDENTIALITY NOTICE: The information transmitted in this email, including attachments, is intended only for the person(s) or entity to which it is addressed and may contain confidential, proprietary and/or privileged material exempt from disclosure under applicable law. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons or entities other than the intended recipient is prohibited. If you received this message in error, please contact the sender immediately and destroy any copies of this information in their entirety.
