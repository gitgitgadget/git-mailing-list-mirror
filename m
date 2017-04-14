Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28D8A20970
	for <e@80x24.org>; Fri, 14 Apr 2017 20:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754750AbdDNUcd (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 16:32:33 -0400
Received: from siwi.pair.com ([209.68.5.199]:24242 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751518AbdDNUcb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 16:32:31 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 3D77D84542;
        Fri, 14 Apr 2017 16:32:29 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v7] read-cache: call verify_hdr() in a background thread
Date:   Fri, 14 Apr 2017 20:32:20 +0000
Message-Id: <20170414203221.43015-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Version 7 of this patch cleans up the fsck test using
test_when_finished and eliminates unnecessary mv/rm's.

Jeff Hostetler (1):
  read-cache: force_verify_index_checksum

 builtin/fsck.c  |  1 +
 cache.h         |  2 ++
 read-cache.c    |  7 +++++++
 t/t1450-fsck.sh | 13 +++++++++++++
 4 files changed, 23 insertions(+)

-- 
2.9.3

