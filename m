From: Alfred Perlstein <alfred@freebsd.org>
Subject: [PATCH] Document the 'svn propset' command.
Date: Tue, 14 Jun 2016 22:19:50 -0700
Message-ID: <20160615051950.GA93388@elvis.mu.org>
References: <20160612191550.GA14160@elvis.mu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <e@80x24.org>,
	Joseph Pecoraro <pecoraro@apple.com>,
	David Fraser <davidf@sjsoft.com>,
	Pranit Bauva <pranit.bauva@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 15 07:19:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bD3F6-0007jA-Nt
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 07:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbcFOFTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 01:19:52 -0400
Received: from elvis.mu.org ([192.203.228.196]:30893 "EHLO elvis.mu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717AbcFOFTw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2016 01:19:52 -0400
Received: by elvis.mu.org (Postfix, from userid 1192)
	id 2B510346DFB9; Tue, 14 Jun 2016 22:19:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160612191550.GA14160@elvis.mu.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297355>

Add example usage to the git-svn documentation.

Reported-by: Joseph Pecoraro <pecoraro@apple.com>
Signed-off-by: Alfred Perlstein <alfred@freebsd.org> 
---

Junio, Pranit, + all,

A week ago I was requested to provide documentation for the
'svn propset' command.  I have attached a diff off of the
'maint' branch for this, however it seems to apply cleanly
to 'master' as well.

Thank you for your patience.

This is also available on my github here:
https://github.com/splbio/git/tree/document_propset



 Documentation/git-svn.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index fb23a98..e104824 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -459,6 +459,20 @@ Any other arguments are passed directly to 'git log'
 	Gets the Subversion property given as the first argument, for a
 	file.  A specific revision can be specified with -r/--revision.
 
+'propset'::
+	Sets the Subversion property given as the first argument, to the
+	value given as the second argument for the file given as the
+	third argument.
++
+Example:
++
+------------------------------------------------------------------------
+git svn propset svn:keywords "FreeBSD=%H" devel/py-tipper/Makefile
+------------------------------------------------------------------------
++
+This will set the property 'svn:keywords' to 'FreeBSD=%H' for the file
+'devel/py-tipper/Makefile'.
+
 'show-externals'::
 	Shows the Subversion externals.  Use -r/--revision to specify a
 	specific revision.
-- 
2.7.1
