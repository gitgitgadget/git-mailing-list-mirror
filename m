Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F5FC433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 19:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 344B36113B
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 19:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbhDWTnT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 15:43:19 -0400
Received: from mav.lukeshu.com ([104.207.138.63]:35084 "EHLO mav.lukeshu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229691AbhDWTnT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 15:43:19 -0400
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 2F7FC80591;
        Fri, 23 Apr 2021 15:42:42 -0400 (EDT)
From:   Luke Shumaker <lukeshu@lukeshu.com>
To:     git@vger.kernel.org
Cc:     Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Luke Shumaker <lukeshu@datawire.io>
Subject: [PATCH 01/30] .gitignore: Ignore /git-subtree
Date:   Fri, 23 Apr 2021 13:42:01 -0600
Message-Id: <20210423194230.1388945-2-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210423194230.1388945-1-lukeshu@lukeshu.com>
References: <20210423194230.1388945-1-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

Running `make -C contrib/subtree/ test` creates a `git-subtree` executable
in the root of the repo.  Add it to the .gitignore so that anyone hacking
on subtree won't have to deal with that noise.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 3dcdb6bb5a..a203678e9e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -162,6 +162,7 @@
 /git-stripspace
 /git-submodule
 /git-submodule--helper
+/git-subtree
 /git-svn
 /git-switch
 /git-symbolic-ref
-- 
2.31.1

