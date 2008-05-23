From: Chris Frey <cdfrey@foursquare.net>
Subject: [PATCH] INSTALL: explain Error.pm dependency
Date: Fri, 23 May 2008 15:22:31 -0400
Message-ID: <20080523192231.GA31416@foursquare.net>
References: <20080517011614.GA11029@foursquare.net> <20080521222150.GA29696@foursquare.net> <7vzlqjz2wz.fsf@gitster.siamese.dyndns.org> <20080521235647.GA21340@foursquare.net> <alpine.DEB.1.00.0805221245240.30431@racer> <20080522164300.GA19765@foursquare.net> <7vd4new8qx.fsf@gitster.siamese.dyndns.org> <20080522181240.GA12725@foursquare.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 23 21:24:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzcsN-0004hy-Ph
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 21:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022AbYEWTXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 15:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753392AbYEWTXT
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 15:23:19 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:50519 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112AbYEWTXT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 15:23:19 -0400
X-Originating-Ip: 216.16.235.2
Received: from localhost (rubicon.netdirect.ca [216.16.235.2])
	by rubicon.netdirect.ca (8.13.1/8.13.1) with ESMTP id m4NJMVNQ031919;
	Fri, 23 May 2008 15:22:31 -0400
Content-Disposition: inline
In-Reply-To: <20080522181240.GA12725@foursquare.net>
User-Agent: Mutt/1.4.1i
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (not cached, score=-16.8, required 5,
	autolearn=not spam, ALL_TRUSTED -1.80, BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: <cdfrey@netdirect.ca>
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82728>

Signed-off-by: Chris Frey <cdfrey@foursquare.net>
---
 INSTALL |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/INSTALL b/INSTALL
index d9b425f..c5cafc4 100644
--- a/INSTALL
+++ b/INSTALL
@@ -86,6 +86,13 @@ Issues of note:
 	- "cpio" is used by git-clone when doing a local (possibly
 	  hardlinked) clone.
 
+	- "Error.pm" version >= 0.15009 is required by perl scripts.
+
+	  If you don't have a fresh enough Error.pm, git will install its
+	  own.  If you already have git installed, it will not install
+	  another Error.pm.  If this causes problems for you, uninstall
+	  git before compiling, or just install your distro's Error.pm.
+
  - Some platform specific issues are dealt with Makefile rules,
    but depending on your specific installation, you may not
    have all the libraries/tools needed, or you may have
-- 
1.5.4.4
