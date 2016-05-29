From: Dave Nicolson <david.nicolson@gmail.com>
Subject: [PATCH] Documentation: GPG capitalization
Date: Sun, 29 May 2016 17:44:25 +0000
Message-ID: <01020154fd9dec3d-61772857-8b92-4505-ac0f-5058d490f7dc-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 29 21:27:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b76Mi-0002j5-4m
	for gcvg-git-2@plane.gmane.org; Sun, 29 May 2016 21:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161012AbcE2T1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 May 2016 15:27:07 -0400
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:57912
	"EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161005AbcE2T1G (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2016 15:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1464543865;
	h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=vPZmTsfu/ydADa7mneGRiGNkYSlLNqoYJA+KVB0H8s0=;
	b=NqFaNRtPdqnPGJ6PQ9biJw7DCUS06XrpgLc4HGH4xdDb7yZe53l1n+FpeNKMhII6
	M+ZwLZCsTgGHt1GpEBAvhvz4yqj9jRiZzTLYBJjDfEyjMaC2ngynxPDH4VwYubZPQlj
	M3PxKNdLCwSe0io/binjawXjPjYB/jUKnmGMwmBU=
X-SES-Outgoing: 2016.05.29-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295842>

When "GPG" is used in a sentence it is now consistently capitalized. When referring to the binary it is left as "gpg".

Signed-off-by: David Nicolson <david.nicolson@gmail.com>
---
 Documentation/git-mktag.txt         | 2 +-
 Documentation/git-tag.txt           | 2 +-
 Documentation/git-verify-commit.txt | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
index fa6a756..724408d 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -32,7 +32,7 @@ followed by some 'optional' free-form message (some tags created
 by older Git may not have `tagger` line).  The message, when
 exists, is separated by a blank line from the header.  The
 message part may contain a signature that Git itself doesn't
-care about, but that can be verified with gpg.
+care about, but that can be verified with GPG.
 
 GIT
 ---
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
index ecf4da1..0101f0f 100644
--- a/Documentation/git-verify-commit.txt
+++ b/Documentation/git-verify-commit.txt
@@ -12,12 +12,12 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Validates the gpg signature created by 'git commit -S'.
+Validates the GPG signature created by 'git commit -S'.
 
 OPTIONS
 -------
 --raw::
-	Print the raw gpg status output to standard error instead of the normal
+	Print the raw GPG status output to standard error instead of the normal
 	human-readable output.
 
 -v::

--
https://github.com/git/git/pull/246
