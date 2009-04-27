From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] Removed redundant static functions such as update_tracking_ref()
 and verify_remote_names() from builtin-send-pack.c, and made the ones in
 transport.c not be static so they can be used instead.
Date: Tue, 28 Apr 2009 02:38:47 +1200
Message-ID: <49F5C377.9010200@vilain.net>
References: <1240546432-26212-1-git-send-email-andy@petdance.com> <20090424210418.GC13561@coredump.intra.peff.net> <99B4BF12-01B9-4A68-B2E0-EF5DF2595FF0@petdance.com> <alpine.DEB.1.00.0904250206250.10279@pacific.mpi-cbg.de> <4B2541E8-7A27-45D5-B77D-AE93C0430EA8@petdance.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	gitster@pobox.com
To: Andy Lester <andy@petdance.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 16:47:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyS6f-00020C-9P
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 16:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758174AbZD0Oqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 10:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758353AbZD0Oqs
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 10:46:48 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:40562 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758307AbZD0Oqr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 10:46:47 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1003)
	id D8A5121C798; Tue, 28 Apr 2009 02:46:17 +1200 (NZST)
In-Reply-To: <4B2541E8-7A27-45D5-B77D-AE93C0430EA8@petdance.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117673>

Andy Lester wrote:
> > I dunno.  The most important part of CodingGuidelines is this:
> >     As for more concrete guidelines, just imitate the existing code
> >     (this is a good guideline, no matter which project you are
> >     contributing to).
> > (And of course, this holds for the style of commit messages, too.)
> Would you rather I not bother?  Far be it from me to try to force
> myself on any project.

Bother?  What bother?  Do you think we're kidding? :-)

Subject: [PATCH] SubmittingPatches: itemize and reflect upon well written changes

The SubmittingPatches file was trimmed down from a somewhat
overwhelming set of requirements from the Linux Kernel equivalent;
however perhaps a little of it can be returned without making the
text too long.

Signed-off-by: Sam Vilain <sam@vilain.net>
---
 <insert funny meta-circular joke here>

 Documentation/SubmittingPatches |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 8d818a2..76fc84d 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -6,9 +6,13 @@ Checklist (and a short version for the impatient):
 	- check for unnecessary whitespace with "git diff --check"
 	  before committing
 	- do not check in commented out code or unneeded files
-	- provide a meaningful commit message
 	- the first line of the commit message should be a short
 	  description and should skip the full stop
+	- the body should provide a meaningful commit message, which:
+		- uses the imperative, present tense: "change",
+		  not "changed" or "changes".
+		- includes motivation for the change, and contrasts
+		  its implementation with previous behaviour
 	- if you want your work included in git.git, add a
 	  "Signed-off-by: Your Name <you@example.com>" line to the
 	  commit message (or just use the option "-s" when
@@ -62,6 +66,14 @@ Describe the technical detail of the change(s).
 
 If your description starts to get too long, that's a sign that you
 probably need to split up your commit to finer grained pieces.
+That being said, patches which plainly describe the things that
+help reviewers check the patch, and future maintainers understand
+the code, are the most beautiful patches.  Descriptions that summarise
+the point in the subject well, and describe the motivation for the
+change, the approach taken by the change, and if relevant how this
+differs substantially from the prior version, can be found on Usenet
+archives back into the late 80's.  Consider it like good Netiquette,
+but for code.
 
 Oh, another thing.  I am picky about whitespaces.  Make sure your
 changes do not trigger errors with the sample pre-commit hook shipped
-- 
1.6.2.234.g28eec
