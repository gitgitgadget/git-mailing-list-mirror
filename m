Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 975771FF76
	for <e@80x24.org>; Sat, 24 Dec 2016 01:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752975AbcLXBJG (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Dec 2016 20:09:06 -0500
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:60952 "EHLO
        homiemail-a12.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751617AbcLXBJF (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Dec 2016 20:09:05 -0500
Received: from homiemail-a12.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a12.g.dreamhost.com (Postfix) with ESMTP id A7578262065;
        Fri, 23 Dec 2016 17:09:04 -0800 (PST)
Received: from frank.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a12.g.dreamhost.com (Postfix) with ESMTPSA id 14CE8262062;
        Fri, 23 Dec 2016 17:09:03 -0800 (PST)
From:   David Turner <dturner@twosigma.com>
To:     git@vger.kernel.org, peff@peff.net
Cc:     David Turner <dturner@twosigma.com>
Subject: [PATCH v3 0/2] pack bitmaps and incremental packing
Date:   Fri, 23 Dec 2016 20:08:53 -0500
Message-Id: <1482541735-21346-1-git-send-email-dturner@twosigma.com>
X-Mailer: git-send-email 2.8.0.rc4.22.g8ae061a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cleaned up the first patch's test code.
Decided to remove the unnecessary checks from the second patch.

David Turner (2):
  auto gc: don't write bitmaps for incremental repacks
  repack: die on incremental + write-bitmap-index

 builtin/gc.c            |  9 ++++++++-
 builtin/repack.c        |  9 +++++++++
 t/t5310-pack-bitmaps.sh |  5 +++--
 t/t6500-gc.sh           | 25 +++++++++++++++++++++++++
 4 files changed, 45 insertions(+), 3 deletions(-)

-- 
2.8.0.rc4.22.g8ae061a

