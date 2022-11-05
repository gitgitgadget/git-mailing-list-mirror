Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9C4C4332F
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 18:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiKESpy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 14:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKESpx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 14:45:53 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6682140C3
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 11:45:50 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
        t=1667673949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aDLvZGU1yPOml9Z1AHlnn2PETdL9gIK8y9mKcWAWSVs=;
        b=j0RQ4TaqjbeyNzIC3GG7Bg6UNb0RRcM4Y3W/JQfMRuzyRYxNlrpSx1IS4EoFIFBovYYbZ0
        GbIkj1mU6M+d2J2b3FdGb5wWHUfTfOnckjZSnFay8gLt9PJpvmjQ/3FG1HRMBT5/zUXrQu
        Qio9ABoS77J2BJpcXWFs/53zGYV9M+g=
From:   Ronan Pigott <ronan@rjp.ie>
To:     git@vger.kernel.org
Subject: [PATCH 0/2] git-maintenance quality-of-life improvements
Date:   Sat,  5 Nov 2022 11:45:30 -0700
Message-Id: <20221105184532.457043-1-ronan@rjp.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a pair of quality-of-life patches for git-maintenance that have
helped me in my workflow. PTAL.

Ronan Pigott (2):
  for-each-repo: interpolate repo path arguments
  maintenance: add option to register in a specific config

 Documentation/git-maintenance.txt | 14 +++++++-------
 builtin/for-each-repo.c           |  5 ++++-
 builtin/gc.c                      | 28 +++++++++++++++++-----------
 t/t7900-maintenance.sh            | 15 +++++++++++++++
 4 files changed, 43 insertions(+), 19 deletions(-)

-- 
2.38.1

