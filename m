From: Jeff King <peff@peff.net>
Subject: Re: cherry picking changesets instead of commits
Date: Wed, 28 May 2008 18:48:19 -0400
Message-ID: <20080528224819.GA15252@sigill.intra.peff.net>
References: <7f9d599f0805281106w746a0469u6c483d64cf75b823@mail.gmail.com> <7v1w3muw8j.fsf@gitster.siamese.dyndns.org> <190C4133-35C9-4CE0-816B-603B8F661A56@gmail.com> <7vod6qtgfs.fsf@gitster.siamese.dyndns.org> <7f9d599f0805281242w5769a100s1153c2101992ff55@mail.gmail.com> <7v3ao2tawd.fsf@gitster.siamese.dyndns.org> <7f9d599f0805281414x6b97070ag7a1cc36f5d3c5a36@mail.gmail.com> <20080528223858.GA15107@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Geoffrey Irving <irving@naml.us>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 29 00:49:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1USH-0001WG-EX
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 00:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297AbYE1WsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 18:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753261AbYE1WsW
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 18:48:22 -0400
Received: from peff.net ([208.65.91.99]:3320 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752587AbYE1WsV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 18:48:21 -0400
Received: (qmail 32253 invoked by uid 111); 28 May 2008 22:48:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 28 May 2008 18:48:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 May 2008 18:48:19 -0400
Content-Disposition: inline
In-Reply-To: <20080528223858.GA15107@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83142>

On Wed, May 28, 2008 at 06:38:58PM -0400, Jeff King wrote:

> which will turn it into the text you wrote for a manpage, or a link in
> the HTML version. Looks like we already have a few of the style you used
> that should probably be fixed, though.

Actually, it looks like there is only one; patch is below. There are a
few false positives in gitk.txt, but they point to projects outside of
core git (like qgit, gitview, and tig), and so must be left as straight
text.

-- >8 --
doc/git-gui: make gitk "see also" a link

Even though git-gui and gitk are both maintained separately,
the documentation is part of core git, and thus it makes
sense to use the linkgit macro to create an href in the HTML
documentation.
---
 Documentation/git-gui.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-gui.txt b/Documentation/git-gui.txt
index 6d6cd5d..cf2541f 100644
--- a/Documentation/git-gui.txt
+++ b/Documentation/git-gui.txt
@@ -81,7 +81,7 @@ git gui browser maint::
 
 See Also
 --------
-'gitk(1)'::
+linkgit:gitk[1]::
 	The git repository browser.  Shows branches, commit history
 	and file differences.  gitk is the utility started by
 	git-gui's Repository Visualize actions.
-- 
1.5.6.rc0.143.ge5cbe0
