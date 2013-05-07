From: worley@ariadne.com (Dale R. Worley)
Subject: [PATCH] CodingGuidelines:  make it clear which files in
 Documentation are the sources
Date: Tue, 7 May 2013 13:52:58 -0400
Message-ID: <201305071752.r47HqwxR001058@hobgoblin.ariadne.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 07 20:00:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZmBI-0008Lm-1N
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 20:00:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757254Ab3EGR77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 13:59:59 -0400
Received: from qmta06.westchester.pa.mail.comcast.net ([76.96.62.56]:42015
	"EHLO qmta06.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752628Ab3EGR76 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 May 2013 13:59:58 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 May 2013 13:59:58 EDT
Received: from omta01.westchester.pa.mail.comcast.net ([76.96.62.11])
	by qmta06.westchester.pa.mail.comcast.net with comcast
	id YztG1l0020EZKEL565sr0D; Tue, 07 May 2013 17:52:51 +0000
Received: from hobgoblin.ariadne.com ([24.34.72.61])
	by omta01.westchester.pa.mail.comcast.net with comcast
	id Z5sq1l00Z1KKtkw3M5sq21; Tue, 07 May 2013 17:52:51 +0000
Received: from hobgoblin.ariadne.com (hobgoblin.ariadne.com [127.0.0.1])
	by hobgoblin.ariadne.com (8.14.5/8.14.5) with ESMTP id r47HqweX001059
	for <git@vger.kernel.org>; Tue, 7 May 2013 13:52:59 -0400
Received: (from worley@localhost)
	by hobgoblin.ariadne.com (8.14.5/8.14.5/Submit) id r47HqwxR001058;
	Tue, 7 May 2013 13:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1367949171;
	bh=sljGQ1ninqYwlhYR0kwnT0yF7eyU03Pfa5i95SFLKWI=;
	h=Received:Received:Received:Received:Date:Message-Id:From:Subject:
	 To;
	b=ABIMJgIl0KsNtq9xrHaccp9KM0rjNOV+Skl1MHfpVJpngSwdnvEM6w5Tzk8vMar9G
	 Cw2/eW052ZI/p4l6hCpWjLxDxnPPoMmd2IgKNWbgvgPhF8W1OGODN8uPpPJAmtaJy3
	 2SEKcNmecdSxspGKyOJGv2BpmczBbCgf2iOXENLguBGaOem12FD/ob2PdoSCR+hVqJ
	 qY7BHExIgGI7YnTD+tJOCNfYEVRooL3wX7M89lEoP40OK1viakmtTV5WS8FZHfD+Zp
	 ECyHVlJXsUuDNBblwdl2BM6OquXjv0HO7V613w5EeFXm3/mIlWevVvsmfFupzNK5xC
	 sXYPyUpYkILTQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223589>

While learning about making a documentation patch, I noticed that
Documentation/CodingGuideles isn't as clear as it could be regarding
how to edit the documentation.  In particular, it says "Most (if not
all) of the documentation pages are written in AsciiDoc - and
processed into HTML output and manpages." without really specifying
the details for those of us who aren't familiar with AsciiDoc.  So I
added a sentence stating explicitly which files are the sources and
which are derived.

It's also a test for submitting a patch.

Dale



>From e87227498ef3d50dc20584c24c53071cce63c555 Mon Sep 17 00:00:00 2001
From: Dale Worley <worley@ariadne.com>
Date: Tue, 7 May 2013 13:39:46 -0400
Subject: [PATCH] CodingGuidelines:  make it clear which files in
 Documentation are the sources

---
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
