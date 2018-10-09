Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38DFE1F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 18:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbeJJBpm (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 21:45:42 -0400
Received: from mail.weplayciv.com ([162.221.200.53]:60246 "EHLO
        mail.weplayciv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbeJJBpl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 21:45:41 -0400
X-Greylist: delayed 412 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Oct 2018 21:45:41 EDT
Received: from localhost.localdomain (c-3985e555.02-149-6c6b7013.bbcust.telenor.se [85.229.133.57])
        by mail.weplayciv.com (Postfix) with ESMTPSA id 522C294E081;
        Tue,  9 Oct 2018 11:20:34 -0700 (PDT)
From:   Daniels Umanovskis <daniels@umanovskis.se>
To:     git@vger.kernel.org
Cc:     Daniels Umanovskis <daniels@umanovskis.se>
Subject: [PATCH 0/2] branch: introduce --current display option
Date:   Tue,  9 Oct 2018 20:20:04 +0200
Message-Id: <20181009182006.9446-1-daniels@umanovskis.se>
X-Mailer: git-send-email 2.19.1.272.gf84b9b09d.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I often find myself needing the current branch name, for which currently there's git rev-parse --abrev-ref HEAD. I would expect `git branch` to have an option to output the branch name instead.

This is my first patch to Git, so process-related comments (patch formatting, et cetera) are quite welcome.

Daniels Umanovskis (2):
  branch: introduce --current display option
  doc/git-branch: Document the --current option

 Documentation/git-branch.txt |  6 +++++-
 builtin/branch.c             | 16 ++++++++++++++++
 t/t3203-branch-output.sh     | 18 ++++++++++++++++++
 3 files changed, 39 insertions(+), 1 deletion(-)

-- 
2.19.1.272.gf84b9b09d.dirty

