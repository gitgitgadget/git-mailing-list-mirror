From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Begin SubmittingPatches with a check list
Date: Mon, 5 Mar 2007 16:37:54 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703051631350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200703050823.l258NgT9008266@localhost.localdomain>
 <20070305095101.GA792@diana.vm.bytemark.co.uk>
 <Pine.LNX.4.63.0703051554240.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070305150418.GD3481@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-781996589-1173109074=:22628"
Cc: Xavier Maillard <zedek@gnu.org>, git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 16:39:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOFHJ-0006d9-Jn
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 16:39:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933526AbXCEPh5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 10:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933528AbXCEPh5
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 10:37:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:52960 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933526AbXCEPh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 10:37:56 -0500
Received: (qmail invoked by alias); 05 Mar 2007 15:37:55 -0000
X-Provags-ID: V01U2FsdGVkX1+oBtMDjqOoDjdKvhvxFlCQlXNkihYtt6yOkWnghM
	IiI+tjFtJvNrMC
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070305150418.GD3481@diana.vm.bytemark.co.uk>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41452>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-781996589-1173109074=:22628
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT


It seems that some people prefer a short list to a long text. But even for 
the latter group, a quick reminder list is useful. So, add a check list to 
Documentation/SubmittingPatches of what to do to get your patch accepted.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	On Mon, 5 Mar 2007, Karl Hasselström wrote:

	> On 2007-03-05 15:54:46 +0100, Johannes Schindelin wrote:
	> 
	> > On Mon, 5 Mar 2007, Karl Hasselström wrote:
	> >
	> > > Yes, Documentation/SubmittingPatches is a loooong text ...
	> >
	> > Unless you count all the MUA specific things, it is just 162
	> > lines...
	> 
	> There's still a lot of information in there. It's not hard to 
	> forget one out of the ~28 paragraphs of non-MUA-specific info.

 Documentation/SubmittingPatches |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 285781d..b6b3dd5 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -1,3 +1,28 @@
+Short version for the impatient:
+
+	- make commits of logical units
+	- check for unnecessary whitespace with "git diff --check"
+	  before committing
+	- do not check in commented out code or unneeded files
+	- provide a meaningful commit message
+	- the first line of the commit message should be a short
+	  description and should skip the full stop
+	- if you want your work included in git.git, add a
+	  "Signed-off-by: Your Name <your@email.com>" line to the
+	  commit message (or just use the option "-s" when
+	  committing) to confirm that you agree to the Developer's
+	  Certificate of Origin
+	- do not PGP sign your patch
+	- use "git format-patch -M" to create the patch
+	- do not attach your patch, but paste it in the mail
+	  mail body, unless you cannot teach your mailer to
+	  leave the formatting of the patch alone
+	- provide additional information (which is unsuitable for
+	  the commit message) between the "---" and the diffstat
+	- send the patch to the list _and_ the maintainer
+
+Long version:
+
 I started reading over the SubmittingPatches document for Linux
 kernel, primarily because I wanted to have a document similar to
 it for the core GIT to make sure people understand what they are
---1148973799-781996589-1173109074=:22628--
