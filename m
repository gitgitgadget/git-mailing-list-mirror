Return-Path: <SRS0=8AI5=7T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94939C433E0
	for <git@archiver.kernel.org>; Sat,  6 Jun 2020 11:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 668FD20663
	for <git@archiver.kernel.org>; Sat,  6 Jun 2020 11:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591442423;
	bh=oNcW2VhFW/iWd6vzfoiIV/XwOhdZjOrKhXrSbF1+1sE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=l2MzvvPrSPwg7zf05gelPLHXNCDYr43s72A0wvD8hMWlTSUVtPmL6mbU5A8t/LKeA
	 lhpFBL4RdTb2qifKDAv5Kj7tYvVNpI4EF5Qqsed/GRhaVfrsAOuPQwtCluvmTv4Gxf
	 9AwaezEDIG+ngvkaTmHttL22fM3aCx2FHGR4S+aU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgFFLUT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Jun 2020 07:20:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbgFFLUT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jun 2020 07:20:19 -0400
Received: from localhost (p54b336ab.dip0.t-ipconnect.de [84.179.54.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F90520663;
        Sat,  6 Jun 2020 11:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591442418;
        bh=oNcW2VhFW/iWd6vzfoiIV/XwOhdZjOrKhXrSbF1+1sE=;
        h=From:To:Cc:Subject:Date:From;
        b=BYIItkE3Lnyy5qx9UnfnWbX38WfXkYYWZ9brKkZ0FA2mwwiHcB+H+Tm6R/DSDR8Ts
         fhtkPR0BlIiCLWcJiW9mNvHEH1O/CTIsFcRx/rgl96I6gERSKEqyypnwYDjot8uC/W
         v7raqbiCCBjDnr3JPbJNOyebm4hJ40ktotpUPOz4=
From:   Wolfram Sang <wsa@kernel.org>
To:     git@vger.kernel.org
Cc:     Jonas Fonseca <jonas.fonseca@gmail.com>,
        Wolfram Sang <wsa@kernel.org>
Subject: [PATCH tig] Mention again that 'generic' keymap can be overridden
Date:   Sat,  6 Jun 2020 13:20:06 +0200
Message-Id: <20200606112006.6896-1-wsa@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is a paragraph above to explain it in detail. However, redundancy
is not a bad thing in documentation IMO. In other words, I missed it
before.

Signed-off-by: Wolfram Sang <wsa@kernel.org>
---

This patch is for 'tig' not 'git'.

 doc/tigrc.5.adoc | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/doc/tigrc.5.adoc b/doc/tigrc.5.adoc
index 6b40afe..179d738 100644
--- a/doc/tigrc.5.adoc
+++ b/doc/tigrc.5.adoc
@@ -607,8 +607,9 @@ Keymaps::
 
 Valid keymaps are: *main*, *diff*, *log*, *reflog*, *help*, *pager*, *status*,
 *stage*, *tree*, *blob*, *blame*, *refs*, *stash*, *grep* and *generic*. Use
-*generic* to set key mapping in all keymaps. Use *search* to define keys for
-navigating search results during search.
+*generic* to set key mapping in all keymaps (which may still be overridden by a
+specific view keybinding). Use *search* to define keys for navigating search
+results during search.
 
 Key values::
 
-- 
2.20.1

