From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] cvsimport: Add a note about crlf options to the
	documentation
Date: Tue, 31 Mar 2009 18:53:39 +0200
Message-ID: <20090331165339.GC72569@macbook.lan>
References: <20090323195304.GC26678@macbook.lan> <49C7F233.9050205@pelagic.nl> <20090330221729.GB68118@macbook.lan> <49D1ABD0.8070707@pelagic.nl> <20090331162103.GA72569@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Tue Mar 31 18:57:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LohF5-0004nD-15
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 18:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754486AbZCaQxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 12:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753817AbZCaQxn
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 12:53:43 -0400
Received: from darksea.de ([83.133.111.250]:49830 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751502AbZCaQxm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 12:53:42 -0400
Received: (qmail 14291 invoked from network); 31 Mar 2009 18:53:29 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 31 Mar 2009 18:53:29 +0200
Content-Disposition: inline
In-Reply-To: <20090331162103.GA72569@macbook.lan>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115284>

---
This is a proper resend of the crlf note patch for Junio's import convenience

 Documentation/git-cvsimport.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index e1fd047..d4e7fd4 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -40,6 +40,11 @@ probably want to make a bare clone of the imported repository,
 and use the clone as the shared repository.
 See linkgit:gitcvs-migration[7].
 
+Note: All revisions are imported using the index so settings of
+core.autocrlf and core.safecrlf are applied. This way you can change or
+safety check the import. If you do not want this make sure these options
+are both set to false.
+
 
 OPTIONS
 -------
-- 
1.6.1.2.390.gba743
