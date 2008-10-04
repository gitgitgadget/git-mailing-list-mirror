From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git commit: Repaint the output format bikeshed (again)
Date: Fri, 3 Oct 2008 22:13:49 -0400
Message-ID: <20081004021349.GA4030@coredump.intra.peff.net>
References: <20081001154425.GE21310@spearce.org> <48E3E66E.7020501@op5.se> <20081001220604.GB18058@coredump.intra.peff.net> <20081001223125.GA25267@coredump.intra.peff.net> <48E45ECC.8070104@op5.se> <20081002211309.GB29480@coredump.intra.peff.net> <20081003001556.GS21310@spearce.org> <20081003042405.GB1839@coredump.intra.peff.net> <20081003140951.GU21310@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Oct 04 04:15:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Klwfk-0004kD-Qh
	for gcvg-git-2@gmane.org; Sat, 04 Oct 2008 04:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbYJDCNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 22:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbYJDCNx
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 22:13:53 -0400
Received: from peff.net ([208.65.91.99]:1891 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750951AbYJDCNw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 22:13:52 -0400
Received: (qmail 9781 invoked by uid 111); 4 Oct 2008 02:13:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 03 Oct 2008 22:13:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Oct 2008 22:13:49 -0400
Content-Disposition: inline
In-Reply-To: <20081003140951.GU21310@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97462>

On Fri, Oct 03, 2008 at 07:09:52AM -0700, Shawn O. Pearce wrote:

> I think the hard part now is to get the user docs updated to reflect
> the new format.  We need to get that done before this can merge
> over to master.

Grepping only turned up the two instances that Andreas had changed for
his patch, so I think that is probably it. Here's the patch.

-- >8 --
tutorial: update output of git commit

Commit c85db254 changed the format of the message produced
by "git commit" when creating a commit. This patch updates
the example session in the tutorial to the new format.

It also adds in the missing diffstat summary lines, which
should have been added long ago.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/gittutorial-2.txt |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/gittutorial-2.txt b/Documentation/gittutorial-2.txt
index 8484e7a..bab0f34 100644
--- a/Documentation/gittutorial-2.txt
+++ b/Documentation/gittutorial-2.txt
@@ -32,11 +32,13 @@ Initialized empty Git repository in .git/
 $ echo 'hello world' > file.txt
 $ git add .
 $ git commit -a -m "initial commit"
-Created root-commit 54196cc (initial commit) on master
+[master (root-commit)] created 54196cc: "initial commit"
+ 1 files changed, 1 insertions(+), 0 deletions(-)
  create mode 100644 file.txt
 $ echo 'hello world!' >file.txt
 $ git commit -a -m "add emphasis"
-Created c4d59f3 (add emphasis) on master
+[master] created c4d59f3: "add emphasis"
+ 1 files changed, 1 insertions(+), 1 deletions(-)
 ------------------------------------------------
 
 What are the 7 digits of hex that git responded to the commit with?
-- 
1.6.0.2.636.gaa7b
