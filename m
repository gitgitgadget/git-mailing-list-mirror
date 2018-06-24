Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A68E01F516
	for <e@80x24.org>; Sun, 24 Jun 2018 10:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbeFXKFW (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Jun 2018 06:05:22 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:26712 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751853AbeFXKFW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jun 2018 06:05:22 -0400
Received: from [91.113.179.170] (helo=[192.168.92.26])
        by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <marc.strapetz@syntevo.com>)
        id 1fX1tX-0002tj-Ek
        for git@vger.kernel.org; Sun, 24 Jun 2018 12:05:19 +0200
From:   Marc Strapetz <marc.strapetz@syntevo.com>
Subject: [PATCH] Documentation: declare "core.ignorecase" as internal variable
To:     git@vger.kernel.org
Message-ID: <7f6b2a42-334d-9443-7b89-625069931ca7@syntevo.com>
Date:   Sun, 24 Jun 2018 12:05:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current description of "core.ignorecase" reads like an option which
is intended to be changed by the user while it's actually expected to
be set by Git only [1].

[1] https://marc.info/?l=git&m=152972992729761&w=2

Signed-off-by: Marc Strapetz <marc.strapetz@syntevo.com>
---
  Documentation/config.txt | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ab641bf5a..c25693828 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -390,7 +390,7 @@ core.hideDotFiles::
  	default mode is 'dotGitOnly'.

  core.ignoreCase::
-	If true, this option enables various workarounds to enable
+	Internal variable which enables various workarounds to enable
  	Git to work better on filesystems that are not case sensitive,
  	like FAT. For example, if a directory listing finds
  	"makefile" when Git expects "Makefile", Git will assume
@@ -399,7 +399,7 @@ core.ignoreCase::
  +
  The default is false, except linkgit:git-clone[1] or linkgit:git-init[1]
  will probe and set core.ignoreCase true if appropriate when the repository
-is created.
+is created. Modifying this value afterwards may result in unexpected 
behavior.

  core.precomposeUnicode::
  	This option is only used by Mac OS implementation of Git.
-- 
2.17.0.rc0.3.gb1b5a51b2

