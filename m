Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152D7C2BA2B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 14:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F7420A8B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 14:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.mil header.i=@mail.mil header.b="rDLzcUTY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgDJOCQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 10:02:16 -0400
Received: from USAT19PA23.eemsg.mail.mil ([214.24.22.197]:62108 "EHLO
        USAT19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgDJOCQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 10:02:16 -0400
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Apr 2020 10:02:15 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=mail.mil; i=@mail.mil; q=dns/txt; s=EEMSG2018v1a;
  t=1586527336; x=1618063336;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=TjJL4ow6KF4yP/oZNyKNR0kM2QJWePsCFCbaqqPvs1g=;
  b=rDLzcUTY+59Xy5fcSScf+T96YINWyPMmQ77BqADOSKNUYrah+KMKsk4j
   XzoqlP9W38xu0DAn+kMqiw996zShFGdiN0DQaMq2grGsJWTwYa7yMkKbC
   fNvcP3wOOHAIuGujXXFDhRhXmPpdxBiGrC80GrcuJoGgelhqZMrsh2Jby
   oNLrIhEf49HC/r2QMA1YuniAy8OufC5uD2FI4wAsd/hYunAvF/hm9sThG
   ZajeDegR2ICU8MkNDgQtMkRHLoBUAZBT1cqEFtSj0RSLEF3+duIagVN9y
   OyM+37PjTclXKGwBylZq3lVAH8wmVj3jqEngxXxLVk7MzFJWmpAJt+kAg
   w==;
X-EEMSG-check-017: 100012024|USAT19PA23_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.72,366,1580774400"; 
   d="scan'208";a="100012024"
Received: from edge-mech01.mail.mil ([214.21.130.101])
  by USAT19PA23.eemsg.mail.mil with ESMTP; 10 Apr 2020 13:54:57 +0000
Received: from UMECHPAOF.easf.csd.disa.mil (214.21.130.33) by
 edge-mech01.mail.mil (214.21.130.101) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Fri, 10 Apr 2020 13:54:23 +0000
Received: from UMECHPA7A.easf.csd.disa.mil ([169.254.6.178]) by
 umechpaof.easf.csd.disa.mil ([214.21.130.33]) with mapi id 14.03.0487.000;
 Fri, 10 Apr 2020 13:54:21 +0000
From:   "Coghlan, Owen R CTR USARMY PEO EIS (USA)" 
        <owen.r.coghlan.ctr@mail.mil>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Pegram, George A JR CIV USARMY SEC (USA)" 
        <george.a.pegram.civ@mail.mil>
Subject: Possible impacts on Git due to COVID19
Thread-Topic: Possible impacts on Git due to COVID19
Thread-Index: AdYPP24MAa9RKajwSou86RWyfnR9zA==
Date:   Fri, 10 Apr 2020 13:54:21 +0000
Message-ID: <FA375405E0773E4095AD3784C67AE52214DA4BC3@UMECHPA7A.easf.csd.disa.mil>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [214.21.44.12]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Good Morning,

My name is Owen Coghlan and I'm the Cyber Security Analyst  for Defensive C=
yber Operations, Cyber Platforms and Systems, located at Fort Belvoir suppo=
rting the Army. Are there any  possible impacts or slowdowns due to COVID19=
? Impacts such as supply chain, coders, and shipping, where your software p=
roduct is concerned. This information would be greatly appreciated.

Owen Coghlan

Cyber Security SME
9351 Hall Road, Bldg 1456
Fort Belvoir, VA
703.806.3389
Owen.r.coghlan.ctr@mail.mil


