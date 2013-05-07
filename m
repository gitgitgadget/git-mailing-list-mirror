From: Dale Worley <worley@ariadne.com>
Subject: [PATCHv3] CodingGuidelines: Documentation/*.txt are the sources
Date: Tue, 7 May 2013 13:39:46 -0400
Message-ID: <201305101823.r4AINj1k018204@freeze.ariadne.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 10 20:23:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uaryz-0007Ek-6D
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 20:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747Ab3EJSXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 14:23:49 -0400
Received: from qmta13.westchester.pa.mail.comcast.net ([76.96.59.243]:56094
	"EHLO qmta13.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751963Ab3EJSXs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 May 2013 14:23:48 -0400
Received: from omta22.westchester.pa.mail.comcast.net ([76.96.62.73])
	by qmta13.westchester.pa.mail.comcast.net with comcast
	id aBJf1l0041ap0As5DJPnlC; Fri, 10 May 2013 18:23:47 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta22.westchester.pa.mail.comcast.net with comcast
	id aJPn1l00K1KKtkw3iJPn3X; Fri, 10 May 2013 18:23:47 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r4AINkMq018205;
	Fri, 10 May 2013 14:23:46 -0400
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r4AINj1k018204;
	Fri, 10 May 2013 14:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1368210227;
	bh=RA5wUy3OzpJBw783ODy21kes6ba8s+1dwKuRd89+0pw=;
	h=Received:Received:Received:Received:Message-Id:To:From:Date:
	 Subject;
	b=NWxQ8JxdZ0S0Lgj7/MDHr5hTsCrQ1nEqH5aizrL5hgzKab+BldezoLyJeZ7GKkp6N
	 uRD1YFi2Yt9gSzAt5Q6mmxawGw16gFUoxpYbjrGf6nkhDXLZTbd5RBPI1ryEiKYeoV
	 42tBkvN5Ixy9i1QYKwuEJWFFnjcBkEVoUJtLQpQfD9dyzMA5njDCPXGuWw7Id3jhI1
	 t8t7y3rlOudsM0Htvvx7YdHcH8bc1FVAkLEhs+hskuFUQAYLjovPvOUuI2cL+jTBYR
	 +NwGT7L+R+N9aGYFDc/KmHAOqu1PviWtNYE2JPKiV8KtKKFDMyHlz61ARTI/X8Y7yS
	 q84TFdOnHL8ng==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223890>


People not familiar with AsciiDoc may not realize they are
supposed to update *.txt files and not *.html/*.1 files when
preparing patches to the project.

Signed-off-by: Dale Worley <worley@ariadne.com>
---
 Documentation/CodingGuidelines |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 7e4d571..559d5f9 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -237,8 +237,10 @@ For Python scripts:
 
 Writing Documentation:
 
- Most (if not all) of the documentation pages are written in AsciiDoc
- and processed into HTML output and manpages.
+ Most (if not all) of the documentation pages are written in the
+ AsciiDoc format in *.txt files (e.g. Documentation/git.txt), and
+ processed into HTML and manpages (e.g. git.html and git.1 in the
+ same directory).
 
  Every user-visible change should be reflected in the documentation.
  The same general rule as for code applies -- imitate the existing
-- 
1.7.7.6
