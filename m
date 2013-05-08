From: worley@alum.mit.edu (Dale R. Worley)
Subject: [PATCHv2] CodingGuidelines:  make it clear which files in
 Documentation/ are the sources
Date: Wed, 8 May 2013 16:24:17 -0400
Message-ID: <201305082024.r48KOH55003964@freeze.ariadne.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 08 22:24:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaAub-000167-Gs
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 22:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758107Ab3EHUYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 16:24:22 -0400
Received: from qmta15.westchester.pa.mail.comcast.net ([76.96.59.228]:57139
	"EHLO qmta15.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757954Ab3EHUYT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 May 2013 16:24:19 -0400
Received: from omta05.westchester.pa.mail.comcast.net ([76.96.62.43])
	by qmta15.westchester.pa.mail.comcast.net with comcast
	id ZNcX1l0020vyq2s5FYQJBa; Wed, 08 May 2013 20:24:18 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta05.westchester.pa.mail.comcast.net with comcast
	id ZYQJ1l00Y1KKtkw3RYQJA2; Wed, 08 May 2013 20:24:18 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r48KOHos003966
	for <git@vger.kernel.org>; Wed, 8 May 2013 16:24:17 -0400
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r48KOH55003964;
	Wed, 8 May 2013 16:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1368044658;
	bh=fTgC68wLUxfrPg4cdaIDEvbzMBXBXe+JX/pUraptOUY=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=ltrOPcl/b8OwKoI+QC13HS/wCZi+bBal1NMO+LhkFkBUVaO7xl/9DrPnKWdNMMJKU
	 E+VyNigmQA6RjIHu0HsbrAT14q1moVX568r0nqHqsyaIpz3Ou32DRBcdNv13DvjalQ
	 qc8sSt0Opo93f94KM+EyX9ZV0OG9CUgoHqrw/OOs+62xZlpG5TTYmURWVagyJ9fa6m
	 HKwpwpnoJntlohYMfQTX2faAyfybV7iRY33i7mHCcDv2Y+THo+Ue3r//bttGPMqvgN
	 PULxcy1SdLB3mQun4l3aGqWhre7/ItT8eXT+zcvahsUwYCevaIIqxDXcWeDa0c1LJ5
	 UQ98gjEjZcm3w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223683>

>From e87227498ef3d50dc20584c24c53071cce63c555 Mon Sep 17 00:00:00 2001
From: Dale Worley <worley@ariadne.com>
Date: Tue, 7 May 2013 13:39:46 -0400
Subject: [PATCH] CodingGuidelines:  make it clear which files in
 Documentation/ are the sources

Signed-off-by: Dale R. Worley <worley@ariadne.com>
---
While learning about making a documentation patch, I noticed that
Documentation/CodingGuideles isn't as clear as it could be regarding
how to edit the documentation.  In particular, it says "Most (if not
all) of the documentation pages are written in AsciiDoc - and
processed into HTML output and manpages." without really specifying
the details for those of us who aren't familiar with AsciiDoc.  So I
added a sentence stating explicitly which files are the sources and
which are derived.

It's also a test for submitting a patch.  I've read SubmittingPatches
again, more carefully, and have corrected some problem with my
previous message.

 Documentation/CodingGuidelines |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 7e4d571..b8eef7c 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -238,7 +238,9 @@ For Python scripts:
 Writing Documentation:
 
  Most (if not all) of the documentation pages are written in AsciiDoc
- and processed into HTML output and manpages.
+ and processed into HTML output and manpages.  This means that the *.txt
+ files in this directory are usually the sources from which the
+ corresponding *.html, *.1, and *.xml files are generated.
 
  Every user-visible change should be reflected in the documentation.
  The same general rule as for code applies -- imitate the existing
-- 
1.7.7.6
