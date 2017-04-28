Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E668207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 22:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1035993AbdD1WdR (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 18:33:17 -0400
Received: from [192.252.130.194] ([192.252.130.194]:27490 "EHLO
        cubert.xiplink.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1035235AbdD1WdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 18:33:16 -0400
Received: from xiplink.com (rincewind.xiplink.com [10.10.1.32])
        by cubert.xiplink.com (Postfix) with ESMTP id C61D16035F;
        Fri, 28 Apr 2017 18:33:13 -0400 (EDT)
From:   Marc Branchaud <marcnarc@xiplink.com>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 0/3] Make diff plumbing commands respect the indentHeuristic.
Date:   Fri, 28 Apr 2017 18:33:12 -0400
Message-Id: <20170428223315.17140-1-marcnarc@xiplink.com>
X-Mailer: git-send-email 2.13.0.rc1.15.gf67d331ad
In-Reply-To: <20170427205037.1787-1-marcnarc@xiplink.com>
References: <20170427205037.1787-1-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2: Fixed up the commit messages and added tests.

Marc Branchaud (2):
  diff: make the indent heuristic part of diff's basic configuration
  diff: have the diff-* builtins configure diff before initializing
    revisions

Stefan Beller (1):
  diff: enable indent heuristic by default

 builtin/diff-files.c   |  2 +-
 builtin/diff-index.c   |  2 +-
 builtin/diff-tree.c    |  2 +-
 diff.c                 |  8 +++---
 t/t4061-diff-indent.sh | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 73 insertions(+), 7 deletions(-)

-- 
2.13.0.rc1.15.gf67d331ad

