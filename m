Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=5.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B520820179
	for <e@80x24.org>; Thu, 16 Jun 2016 22:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006AbcFPWxt (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 18:53:49 -0400
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:56713
	"EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753864AbcFPWxt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jun 2016 18:53:49 -0400
X-Greylist: delayed 2282 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Jun 2016 18:53:48 EDT
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1466115344;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=n1zx8kVybpjwowMsOSbhXiOQAt9yD1fr6HO7jboAVKU=;
	b=MVbr5wyE6FJN/yIQ+8Fnz03gg3JSU2gdKORjjcGw2I6OYN7wYNM8M5opfgJwrF4s
	Teb0pXz4dJxxhIaBvc45dyvWbYngJzXjkN5C74vJftsLIPpOM0pkWqzHxpcvTj2il/O
	gZbAxZVHgDe1tLIZ2VuzydoxEy9+KVA25ADLRjaU=
From:	Dave Nicolson <david.nicolson@gmail.com>
To:	git@vger.kernel.org
Message-ID: <010201555b48c824-324d848d-838a-4908-bf88-bc2ee290da76-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020154fd9dec3d-61772857-8b92-4505-ac0f-5058d490f7dc-000000@eu-west-1.amazonses.com>
References: <01020154fd9dec3d-61772857-8b92-4505-ac0f-5058d490f7dc-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2] Documentation: GPG capitalization
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:	Thu, 16 Jun 2016 22:15:44 +0000
X-SES-Outgoing:	2016.06.16-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When "GPG" is used in a sentence it is now consistently capitalized. When referring to the binary it is left as "gpg".

Signed-off-by: David Nicolson <david.nicolson@gmail.com>
---
 Documentation/git-tag.txt           | 2 +-
 Documentation/git-verify-commit.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index abab481..32bc4aa 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -78,7 +78,7 @@ OPTIONS
 
 -v::
 --verify::
-	Verify the gpg signature of the given tag names.
+	Verify the GPG signature of the given tag names.
 
 -n<num>::
 	<num> specifies how many lines from the annotation, if any,
diff --git a/Documentation/git-verify-commit.txt b/Documentation/git-verify-commit.txt
index ecf4da1..92097f6 100644
--- a/Documentation/git-verify-commit.txt
+++ b/Documentation/git-verify-commit.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Validates the gpg signature created by 'git commit -S'.
+Validates the GPG signature created by 'git commit -S'.
 
 OPTIONS
 -------

--
https://github.com/git/git/pull/246
