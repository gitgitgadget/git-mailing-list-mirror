Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC2CC10DCE
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 22:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F967205ED
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 22:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="B9uvg/EF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbgCOWpE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Mar 2020 18:45:04 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54722 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729288AbgCOWpE (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Mar 2020 18:45:04 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 15B2060478;
        Sun, 15 Mar 2020 22:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1584312303;
        bh=Zcxt7K7vsY0RghHl/ljSrW+pwfgaxQ9R27djYvGSpvs=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=B9uvg/EFEJH5/W0EnVV77PmoPD2pe8kRa3P+AuQPogWqtKd8iTGZCZ8vNdRmMmFQ9
         bhnoiwVi4QvMGdu/ykBXlo6KHqcMewpGR7RMkOxY2A1YJwp8ek8EQiFEWuAqDYL9nO
         fPqbeNSBMA64ykqTmsuRL4YN877goyFXtP1MFwT0AcVeHmlGIE5n1QJB5YuekX3KA0
         9E3Iy5Luw6wg0lmsUaZOJdteUpo1wj4f4/s7cm+cwDJYxqmUjp94xOCK8BK1AGPzjd
         ZSkrwhrEIiOYv/2WVsJoUF1MmcP2MWG59VzM3MCOrnRUQC8cEzapQTwyQm8N560ZIK
         +Ii6eAv24c1CbsVcFXqTKIsoJ+UmoOnb1FtG/y8KZLgY5YvF24BKN4kmrzGPFaENri
         CnMnYSYC7ZimGlJiqV6j5csCBtKfsVyjImbhO0mQnimyVN2BTV+R42MGUuaHnGdCvG
         3WyqSUnTa/sSkaeQT9C07tPTut5qAnLNGw5bTOp6XbeEIql1bLA
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/1] FAQ for common user questions
Date:   Sun, 15 Mar 2020 22:39:22 +0000
Message-Id: <20200315223923.170371-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git is an enormously flexible and power piece of software, but many
people find it confusing and hard to use.  Over the time I've been
contributing, I've noticed a lot of the same questions keep coming up
over and over.  Some of these questions are well answered by existing
documentation, but people have trouble finding it.  Others are not
answered, and still others are questions about integrating with common
tools and hosting platforms.

To help people find and discover this documentation, let's provide a FAQ
that covers common issues.  A lot of these issues are things I've seen
asked on Stack Overflow or elsewhere and we'd be doing everyone a
service if we included some stock answers in one place in our
documentation.

The FAQ is designed to be conversational, approachable, and geared
towards a competent novice user.  However, it also addresses questions
that I've seen from technically advanced colleagues.  I've tried to make
it address common questions about integrations with other tools, such as
CI systems and hosting platforms, without mentioning any specific tool
by name.  This keeps us neutral on particular tools, but recognizes that
these tools are a common part of people's development experiences.

I definitely think we'll add more questions as we go along, but this
seems like a reasonable start for now.  I'd love feedback about the
phrasing of questions or answers, anything I've missed, and anything
that might be technically inaccurate, especially about Windows.

brian m. carlson (1):
  docs: add a FAQ

 Documentation/Makefile   |   1 +
 Documentation/gitfaq.txt | 330 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 331 insertions(+)
 create mode 100644 Documentation/gitfaq.txt

