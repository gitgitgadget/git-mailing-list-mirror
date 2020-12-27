Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC9AC433E9
	for <git@archiver.kernel.org>; Sun, 27 Dec 2020 21:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3930D22581
	for <git@archiver.kernel.org>; Sun, 27 Dec 2020 21:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgL0U71 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Dec 2020 15:59:27 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:46484 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgL0U70 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Dec 2020 15:59:26 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1ktd7k-004xay-00; Sun, 27 Dec 2020 13:58:44 -0700
Received: from mta5.zcs.xmission.com ([166.70.13.69])
        by in02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1ktd7j-00FgVI-0n; Sun, 27 Dec 2020 13:58:43 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta5.zcs.xmission.com (Postfix) with ESMTP id 8A89C1280796;
        Sun, 27 Dec 2020 13:58:42 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta5.zcs.xmission.com
Received: from mta5.zcs.xmission.com ([127.0.0.1])
        by localhost (mta5.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5nyf3PZgxodF; Sun, 27 Dec 2020 13:58:42 -0700 (MST)
Received: from localhost.localdomain (unknown [139.60.10.209])
        by mta5.zcs.xmission.com (Postfix) with ESMTPSA id D70C8128062A;
        Sun, 27 Dec 2020 13:58:41 -0700 (MST)
From:   Seth House <seth@eseth.com>
To:     git@vger.kernel.org
Cc:     Seth House <seth@eseth.com>, Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sun, 27 Dec 2020 13:58:33 -0700
Message-Id: <20201227205835.502556-1-seth@eseth.com>
X-Mailer: git-send-email 2.30.0.rc0.dirty
In-Reply-To: <20201223045358.100754-1-felipe.contreras@gmail.com>
References: <20201223045358.100754-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1ktd7j-00FgVI-0n;;;mid=<20201227205835.502556-1-seth@eseth.com>;;;hst=in02.mta.xmission.com;;;ip=166.70.13.69;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.69
X-SA-Exim-Mail-From: seth@eseth.com
Subject: [PATCH v6 0/1] mergetool: add automerge configuration
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for the slow turnaround on this. I haven't used Git via email
patches before now so it took me quite a few hours to read through
tutorials, configure git-send-email and fight missing Perl libs. Please
let me know if I did anything incorrectly! I should be able to
contribute more quickly from now on.

Changes since v5:

 * Add per-tool configuration that Felipe has a "deep philosophical"
   opposition to adding.

Felipe Contreras (1):
  mergetool: add automerge configuration

Seth House (1):
  mergetool: Add per-tool support for the autoMerge flag

 Documentation/config/mergetool.txt |  6 ++++++
 git-mergetool.sh                   | 13 +++++++++++++
 t/t7610-mergetool.sh               | 18 ++++++++++++++++++
 3 files changed, 37 insertions(+)

-- 
2.29.2

