Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7D7C433E6
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 00:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D29EC22AAA
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 00:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgL1Am4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Dec 2020 19:42:56 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:38396 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbgL1Am4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Dec 2020 19:42:56 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1ktgbz-005A3K-30; Sun, 27 Dec 2020 17:42:13 -0700
Received: from mta4.zcs.xmission.com ([166.70.13.68])
        by in02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1ktgbx-00GDzp-Ca; Sun, 27 Dec 2020 17:42:10 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta4.zcs.xmission.com (Postfix) with ESMTP id 954D350055C;
        Sun, 27 Dec 2020 17:42:08 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta4.zcs.xmission.com
Received: from mta4.zcs.xmission.com ([127.0.0.1])
        by localhost (mta4.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8rjOdy4A-ZOW; Sun, 27 Dec 2020 17:42:08 -0700 (MST)
Received: from localhost.localdomain (unknown [139.60.10.209])
        by mta4.zcs.xmission.com (Postfix) with ESMTPSA id C9F6650055F;
        Sun, 27 Dec 2020 17:42:07 -0700 (MST)
From:   Seth House <seth@eseth.com>
To:     git@vger.kernel.org
Cc:     Seth House <seth@eseth.com>, Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sun, 27 Dec 2020 17:41:50 -0700
Message-Id: <20201228004152.522421-1-seth@eseth.com>
X-Mailer: git-send-email 2.30.0.rc0.dirty
In-Reply-To: <20201227205835.502556-1-seth@eseth.com>
References: <20201227205835.502556-1-seth@eseth.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1ktgbx-00GDzp-Ca;;;mid=<20201228004152.522421-1-seth@eseth.com>;;;hst=in02.mta.xmission.com;;;ip=166.70.13.68;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.68
X-SA-Exim-Mail-From: seth@eseth.com
Subject: [PATCH v7 0/2] mergetool: add automerge configuration
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v6:

 * Incorporated Junio's help and advice:

   * Rebased v7 off of the correct v5 version.
   * Signed off on Felipe's commit. (Although I have minor qualms with
     Felipe's various wording and even the name of the flag it is
     decidedly not worth burdening the list with bike-shedding.)

Changes since v5:

 * Add per-tool configuration that Felipe has a "deep philosophical"
   opposition to adding.

Felipe Contreras (1):
  mergetool: add automerge configuration

Seth House (1):
  mergetool: Add per-tool support for the autoMerge flag

 Documentation/config/mergetool.txt |  6 ++++++
 git-mergetool.sh                   | 20 ++++++++++++++++++++
 t/t7610-mergetool.sh               | 18 ++++++++++++++++++
 3 files changed, 44 insertions(+)

-- 
2.29.2

