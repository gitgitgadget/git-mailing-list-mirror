Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E280C433DB
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 02:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C6CC64E4E
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 02:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhBNC3f (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Feb 2021 21:29:35 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:42704 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhBNC3d (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Feb 2021 21:29:33 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1lB79X-00ACrz-5b; Sat, 13 Feb 2021 19:28:51 -0700
Received: from mta5.zcs.xmission.com ([166.70.13.69])
        by in01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <seth@eseth.com>)
        id 1lB79V-00047y-LF; Sat, 13 Feb 2021 19:28:50 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta5.zcs.xmission.com (Postfix) with ESMTP id 43A471280E5B;
        Sat, 13 Feb 2021 19:28:49 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta5.zcs.xmission.com
Received: from mta5.zcs.xmission.com ([127.0.0.1])
        by localhost (mta5.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lAfY9CX_oQFh; Sat, 13 Feb 2021 19:28:49 -0700 (MST)
Received: from ellen.lan (unknown [139.60.10.209])
        by mta5.zcs.xmission.com (Postfix) with ESMTPSA id DCA741280AD3;
        Sat, 13 Feb 2021 19:28:48 -0700 (MST)
From:   Seth House <seth@eseth.com>
To:     git@vger.kernel.org
Cc:     Seth House <seth@eseth.com>, pudinha <rogi@skylittlesystem.org>,
        David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Date:   Sat, 13 Feb 2021 19:28:39 -0700
Message-Id: <20210214022840.849312-1-seth@eseth.com>
X-Mailer: git-send-email 2.30.1.617.g3a1ad5624f
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1lB79V-00047y-LF;;;mid=<20210214022840.849312-1-seth@eseth.com>;;;hst=in01.mta.xmission.com;;;ip=166.70.13.69;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.69
X-SA-Exim-Mail-From: seth@eseth.com
Subject: [PATCH 0/1] mergetools/vimdiff: add vimdiff1 merge tool variant
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add yet another vimdiff layout variant to present the simplest possible
two-way diff when resolving conflicts.

The name is an attempt at UNIX-style humor -- vimdiff3 opens four
buffers and vimdiff2 opens three buffers so vimdiff1 should therefore
open two buffers. It also communicates that vimdiff will be used and
fits cleanly into the existing layout variant naming. That said,
suggestions welcome if that isn't as great a fit as I think it is. :)

Seth House (1):
  mergetools/vimdiff: add vimdiff1 merge tool variant

 mergetools/vimdiff | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

-- 
2.29.2


