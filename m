From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Update to SubmittingPatches
Date: Sun, 3 Jun 2007 01:46:47 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706030145420.4046@racer.site>
References: <11807320922292-git-send-email-hoegsberg@gmail.com>
 <7vd50eqjef.fsf@assigned-by-dhcp.cox.net> <7v8xb2qj37.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-2094596267-1180831607=:4046"
Cc: Kristian =?utf-8?Q?H=C3=B8gsberg?= <hoegsberg@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Jun 03 02:48:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HueH9-0003eT-Dt
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 02:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344AbXFCAsr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 20:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753812AbXFCAsr
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 20:48:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:59880 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752344AbXFCAsr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 20:48:47 -0400
Received: (qmail invoked by alias); 03 Jun 2007 00:48:45 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp047) with SMTP; 03 Jun 2007 02:48:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/EjJZucHbEtOijCjO9iZe/s9m9/Ggb8pbvbPgfDf
	5JhAszaItJH7X6
X-X-Sender: gene099@racer.site
In-Reply-To: <7v8xb2qj37.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48966>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-2094596267-1180831607=:4046
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT


Make people aware of our testsuite, and of non-ASCII encodings.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Sat, 2 Jun 2007, Junio C Hamano wrote:

	> Junio C Hamano <junkio@cox.net> writes:
	> 
	> > Kristian Høgsberg <hoegsberg@gmail.com> writes:
	> >
	> >> Encode ' ' using '=20' even though rfc2047 allows using '_' for
	> >> readability..
	> >
	> > Thanks.
	> >
	> > Your message was marked as iso-8859-1 even though it was utf-8
	> > (your signed-off-by line), so I'll fix it up with your From:
	> > header.
	> 
	> Oh, another thing.  Before you submit a patch, make sure the
	> whole testsuite in t/ passes by running "make test".

	We should remind people of both.

 Documentation/SubmittingPatches |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index b5f2ecd..b6e5847 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -14,6 +14,8 @@ Checklist (and a short version for the impatient):
 	  commit message (or just use the option "-s" when
 	  committing) to confirm that you agree to the Developer's
 	  Certificate of Origin
+	- make sure that you have tests for the bug you are fixing
+	- make sure that the test suit passes after your commit
 
 	Patch:
 
@@ -33,6 +35,8 @@ Checklist (and a short version for the impatient):
 	- if you change, add, or remove a command line option or
 	  make some other user interface change, the associated
 	  documentation should be updated as well.
+	- if your name is not writable in ASCII, make sure that 
+	  you send off a message in the correct encoding.
 
 Long version:
 
-- 
1.5.2.2663.gd77e7-dirty

--8323584-2094596267-1180831607=:4046--
