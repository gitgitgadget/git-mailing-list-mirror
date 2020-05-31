Return-Path: <SRS0=yrqn=7N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F45C433E0
	for <git@archiver.kernel.org>; Sun, 31 May 2020 21:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABA3C20776
	for <git@archiver.kernel.org>; Sun, 31 May 2020 21:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgEaVr3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 May 2020 17:47:29 -0400
Received: from smtp-1a.his.com ([216.194.196.25]:55892 "EHLO smtp-1a.his.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728402AbgEaVr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 May 2020 17:47:28 -0400
Received: from cuda201.his.com (cuda201.his.com [216.194.196.22])
        by smtp-1a.his.com (Postfix) with ESMTPS id A33621FA1
        for <git@vger.kernel.org>; Sun, 31 May 2020 17:38:07 -0400 (EDT)
X-ASG-Debug-ID: 1590961087-061c412f3814bc40001-QuoKaX
Received: from smtp-nf-202.his.com (smtp-nf-202.his.com [216.194.196.20]) by cuda201.his.com with ESMTP id khnOBOOUQ85LOhzC for <git@vger.kernel.org>; Sun, 31 May 2020 17:38:07 -0400 (EDT)
X-Barracuda-Envelope-From: keni@his.com
X-Barracuda-RBL-Trusted-Forwarder: 216.194.196.20
Received: from zproxy101.his.com (zproxy101.his.com [18.218.2.49])
        by smtp-nf-202.his.com (Postfix) with ESMTPS id 419F6600C0
        for <git@vger.kernel.org>; Sun, 31 May 2020 17:38:07 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy101.his.com (Postfix) with ESMTP id 039D4177EC9;
        Sun, 31 May 2020 17:38:07 -0400 (EDT)
X-Barracuda-RBL-IP: 18.218.2.49
X-Barracuda-Effective-Source-IP: zproxy101.his.com[18.218.2.49]
X-Barracuda-Apparent-Source-IP: 18.218.2.49
Received: from zproxy101.his.com ([127.0.0.1])
        by localhost (zproxy101.his.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wcJ1MWDFuVT7; Sun, 31 May 2020 17:38:06 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy101.his.com (Postfix) with ESMTP id E0E36178042;
        Sun, 31 May 2020 17:38:06 -0400 (EDT)
X-Virus-Scanned: amavisd-new at zproxy101.his.com
Received: from zproxy101.his.com ([127.0.0.1])
        by localhost (zproxy101.his.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3T6zMgay8DBd; Sun, 31 May 2020 17:38:06 -0400 (EDT)
Received: from wings.local (pool-74-96-209-77.washdc.fios.verizon.net [74.96.209.77])
        by zproxy101.his.com (Postfix) with ESMTPSA id BBA63177EC9;
        Sun, 31 May 2020 17:38:06 -0400 (EDT)
Received: from wings.fios-router.home (localhost [127.0.0.1])
        by wings.local (8.15.2/8.15.2/Debian-10) with ESMTP id 04VLc6ZB010800;
        Sun, 31 May 2020 17:38:06 -0400
Received: (from keni@localhost)
        by wings.fios-router.home (8.15.2/8.15.2/Submit) id 04VLc59X010799;
        Sun, 31 May 2020 17:38:05 -0400
From:   Kenneth Lorber <keni@his.com>
To:     git@vger.kernel.org
Cc:     keni@his.com
Subject: [RFC PATCH 0/2] update glossary hooks entry
Date:   Sun, 31 May 2020 17:37:55 -0400
X-ASG-Orig-Subj: [RFC PATCH 0/2] update glossary hooks entry
Message-Id: <20200531213757.10752-1-keni@his.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525232727.21096-1-keni@his.com>
References: <20200525232727.21096-1-keni@his.com>
X-Barracuda-Connect: smtp-nf-202.his.com[216.194.196.20]
X-Barracuda-Start-Time: 1590961087
X-Barracuda-URL: https://spam.his.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at his.com
X-Barracuda-Scan-Msg-Size: 415
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=6.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.82237
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Per Junio C Hamano, extract and split
v2-0001-doc-Tell-the-glossary-about-core.hooksPath.patch
from the series starting with [RFC PATCH v2 0/6] various documentation bits.

Kenneth Lorber (2):
  doc: Tell the glossary about core.hooksPath
  doc: remove dated info and refs to sample hooks

 Documentation/glossary-content.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.17.1

