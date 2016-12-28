Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E1F320441
	for <e@80x24.org>; Wed, 28 Dec 2016 22:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbcL1Wpu (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 17:45:50 -0500
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:40655 "EHLO
        homiemail-a18.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751890AbcL1Wpt (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 28 Dec 2016 17:45:49 -0500
Received: from homiemail-a18.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a18.g.dreamhost.com (Postfix) with ESMTP id 9D798258065;
        Wed, 28 Dec 2016 14:45:48 -0800 (PST)
Received: from localhost.localdomain (gzac10-107-1.nje.twosigma.com [208.77.214.155])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a18.g.dreamhost.com (Postfix) with ESMTPSA id 18C72258062;
        Wed, 28 Dec 2016 14:45:48 -0800 (PST)
From:   David Turner <dturner@twosigma.com>
To:     git@vger.kernel.org, peff@peff.net, j6t@kgdb.org
Cc:     David Turner <dturner@twosigma.com>
Subject: [PATCH v5 0/2] repack (oops)
Date:   Wed, 28 Dec 2016 17:45:40 -0500
Message-Id: <1482965142-6778-1-git-send-email-dturner@twosigma.com>
X-Mailer: git-send-email 2.8.0.rc4.22.g8ae061a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This version addresses Johannes Sixt's comments on v4.  Also, I
messed up the rebase on v4.

David Turner (2):
  auto gc: don't write bitmaps for incremental repacks
  repack: die on incremental + write-bitmap-index

 builtin/gc.c            |  9 ++++++++-
 builtin/repack.c        |  9 +++++++++
 t/t5310-pack-bitmaps.sh |  8 +++-----
 t/t6500-gc.sh           | 25 +++++++++++++++++++++++++
 4 files changed, 45 insertions(+), 6 deletions(-)

-- 
2.8.0.rc4.22.g8ae061a

