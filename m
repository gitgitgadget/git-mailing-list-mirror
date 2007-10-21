From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: Re: [PATCH] git-cherry-pick: improve description of -x.
Date: Sun, 21 Oct 2007 11:36:19 +0200
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071021093618.GC12794@ins.uni-bonn.de>
References: <20071019174134.GD9906@ins.uni-bonn.de> <20071019211152.GN3917@planck.djpig.de> <20071020031917.GR14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Oct 21 11:36:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjXEW-0004Kt-SB
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 11:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbXJUJgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 05:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752588AbXJUJgX
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 05:36:23 -0400
Received: from hermes.iam.uni-bonn.de ([131.220.223.5]:39265 "EHLO
	iam.uni-bonn.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751367AbXJUJgW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 05:36:22 -0400
Received: (qmail 18778 invoked from network); 21 Oct 2007 09:36:20 -0000
Received: from gibraltar.iam.uni-bonn.de (HELO ins.uni-bonn.de) (131.220.223.4)
  by hermes.iam.uni-bonn.de with (EDH-RSA-DES-CBC3-SHA encrypted) SMTP; 21 Oct 2007 09:36:20 -0000
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071020031917.GR14735@spearce.org>
User-Agent: Mutt/1.5.16 (2007-10-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61893>

Reword the first sentence of the description of -x, in order to
make it easier to read and understand.

Signed-off-by: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
---

* Shawn O. Pearce wrote on Sat, Oct 20, 2007 at 05:19:17AM CEST:
> Frank Lichtenheld <frank@lichtenheld.de> wrote:
> > On Fri, Oct 19, 2007 at 07:41:34PM +0200, Ralf Wildenhues wrote:
> > > 
> > > Is that by design (because there were conflicts) or an omission?
> > > In case of the former, maybe the description of -x should mention this.
> > 
> > git commit currently doesn't know that you commit a cherry-pick. The -c
> > only says to use the commit message of the original commit. So this is
> > currently by design.
> 
> Ralf, can you submit an updated version of this patch that describes
> the current behavior better, given the "by design" remark above
> from Frank?

Here it goes.  Still makes me wonder whether that is the ideal mode of
operation or not.

FWIW, I think the previous passive voice wording was correct English,
but here's a rewrite using mostly active voice (sound nicer anyway).

Cheers,
Ralf

 Documentation/git-cherry-pick.txt |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 47b1e8c..76a2edf 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -27,11 +27,12 @@ OPTIONS
 	message prior committing.
 
 -x::
-	Cause the command to append which commit was
-	cherry-picked after the original commit message when
-	making a commit.  Do not use this option if you are
-	cherry-picking from your private branch because the
-	information is useless to the recipient.  If on the
+	When recording the commit, append to the original commit
+	message a note that indicates which commit this change
+	was cherry-picked from.  Append the note only for cherry
+	picks without conflicts.  Do not use this option if
+	you are cherry-picking from your private branch because
+	the information is useless to the recipient.  If on the
 	other hand you are cherry-picking between two publicly
 	visible branches (e.g. backporting a fix to a
 	maintenance branch for an older release from a
-- 
1.5.3.1.153.g89df5
