Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03EE6201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 12:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754565AbdBVMes (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 07:34:48 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:40098 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753108AbdBVMer (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Feb 2017 07:34:47 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 2E6E0280AD;
        Wed, 22 Feb 2017 12:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487766886;
        bh=pendZFQCij63eDVzY1T9ujeaMo6AFqIGUjwT6e+j4tk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cBui9bJ9o3bfhH6uanLYfJ//BFNml0dPF1juA/ktQdi3fe51tXCELXHwEAZ1RGtpW
         w5QA20lE78jSyU9wXGyuXdXJnYiFMQXz4GhLzHBs89dDQpC3bch8ovBvWpGkR2ut8m
         41EY1Biumgw1RzXrAkk/PU0cQKlM/VDtuMoOJJ1LYLlqFdX3JOPn2U/nQA7luJ0R6T
         8p7ZbRgri03o2q8RzWEZrjJ42se16UsuUyhoamgpjTRgWra8sEMBGqFXLduSyBynpe
         SwlOh1/kv1nIW+gfqgy4Ts+yvqfbCDiZsz6dMf9GSA9Nw4kAOyH0y9nsEDiHj+FbXo
         Un2+1yBgFX8813uukdnmBtKxWKYHWak4G6DbzTVWTODTuejVrteZHOdUjY3HB16Dda
         YrECSB7EokW+jKcS/FYdfDXvZlYlJWMzgZC99TAhzcOg9XaqHCPRmY7xdK55JYn1Nt
         vNEOWcKTwTdciVoLjYOIRH/4MaWuv0+vewKzD14LejrKl0PVQZw
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Casey Rodarmor <casey@rodarmor.com>
Subject: [PATCH] Documentation: correctly spell git worktree --detach
Date:   Wed, 22 Feb 2017 12:34:42 +0000
Message-Id: <20170222123442.923694-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <CANLPe+OaSnNb1jhAnFtMsOCfho0H7mHVHiXs7rqo6ZHNvRe3-w@mail.gmail.com>
References: <CANLPe+OaSnNb1jhAnFtMsOCfho0H7mHVHiXs7rqo6ZHNvRe3-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The option is “--detach”, but we accidentally spelled it “--detached” at
one point in the man page.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Reported-by: Casey Rodarmor <casey@rodarmor.com>
---
 Documentation/git-worktree.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index e257c19ebe..553cf8413f 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -52,7 +52,7 @@ is linked to the current repository, sharing everything except working
 directory specific files such as HEAD, index, etc. `-` may also be
 specified as `<branch>`; it is synonymous with `@{-1}`.
 +
-If `<branch>` is omitted and neither `-b` nor `-B` nor `--detached` used,
+If `<branch>` is omitted and neither `-b` nor `-B` nor `--detach` used,
 then, as a convenience, a new branch based at HEAD is created automatically,
 as if `-b $(basename <path>)` was specified.
 
