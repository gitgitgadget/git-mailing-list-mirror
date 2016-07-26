Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6541A203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 20:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758142AbcGZUpI (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 16:45:08 -0400
Received: from mta02.prd.rdg.aluminati.org ([94.76.243.215]:55280 "EHLO
	mta02.prd.rdg.aluminati.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754951AbcGZUpF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jul 2016 16:45:05 -0400
Received: from mta02.prd.rdg.aluminati.org (localhost [127.0.0.1])
	by mta.aluminati.local (Postfix) with ESMTP id D7C9A22FD9;
	Tue, 26 Jul 2016 21:45:03 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by mta02.prd.rdg.aluminati.org (Postfix) with ESMTP id D1DE636CE;
	Tue, 26 Jul 2016 21:45:03 +0100 (BST)
X-Quarantine-ID: <lXRN9WNUn-wv>
X-Virus-Scanned: Debian amavisd-new at mta02.prd.rdg.aluminati.org
Received: from mta.aluminati.local ([127.0.0.1])
	by localhost (mta02.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lXRN9WNUn-wv; Tue, 26 Jul 2016 21:45:02 +0100 (BST)
Received: from river.lan (unknown [10.2.0.9])
	by mta02.prd.rdg.aluminati.org (Postfix) with ESMTPSA id 9166933F0;
	Tue, 26 Jul 2016 21:44:58 +0100 (BST)
From:	John Keeping <john@keeping.me.uk>
To:	git@vger.kernel.org
Cc:	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v3 0/3] push: allow pushing new branches with --force-with-lease
Date:	Tue, 26 Jul 2016 21:44:42 +0100
Message-Id: <cover.1469565810.git.john@keeping.me.uk>
X-Mailer: git-send-email 2.9.2.639.g855ae9f
In-Reply-To: <cover.1469483499.git.john@keeping.me.uk>
References: <cover.1469483499.git.john@keeping.me.uk>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Changes in v3:
- Use hashclr() and oidclr() where appropriate instead of memset()
- Pull a test forward from patch 3 to patch 2 

John Keeping (3):
  Documentation/git-push: fix placeholder formatting
  push: add shorthand for --force-with-lease branch creation
  push: allow pushing new branches with --force-with-lease

 Documentation/git-push.txt |  5 +++--
 remote.c                   |  9 +++++----
 remote.h                   |  1 -
 t/t5533-push-cas.sh        | 38 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 46 insertions(+), 7 deletions(-)

-- 
2.9.2.639.g855ae9f
