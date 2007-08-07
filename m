From: David Kastrup <dak@gnu.org>
Subject: [install info (using perl) 2/2] INSTALL: explain info installation and dependencies.
Date: Tue, 7 Aug 2007 12:02:12 +0200
Message-ID: <d8d1bd7bc54a3cd933598be0886a0fbe83e1775f.1186484406.git.dak@gnu.org>
References: <591c5679ea79b76cd5db57443b1d691bde842351.1186484406.git.dak@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 07 13:01:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIMot-00013Z-32
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 13:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758976AbXHGLBo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 07:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756826AbXHGLBo
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 07:01:44 -0400
Received: from main.gmane.org ([80.91.229.2]:56716 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758576AbXHGLBn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 07:01:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IIMoh-0007j9-By
	for git@vger.kernel.org; Tue, 07 Aug 2007 13:01:35 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Aug 2007 13:01:35 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Aug 2007 13:01:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
X-From-Line: d8d1bd7bc54a3cd933598be0886a0fbe83e1775f Mon Sep 17 00:00:00 2001
In-Reply-To: <591c5679ea79b76cd5db57443b1d691bde842351.1186484406.git.dak@gnu.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:yHEgGOAFG4dTzSGekfmyli6eiY8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55245>


Signed-off-by: David Kastrup <dak@gnu.org>
---
 INSTALL |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/INSTALL b/INSTALL
index c62b12c..289b046 100644
--- a/INSTALL
+++ b/INSTALL
@@ -5,8 +5,8 @@ Normally you can just do "make" followed by "make install", and that
 will install the git programs in your own ~/bin/ directory.  If you want
 to do a global install, you can do
 
-	$ make prefix=/usr all doc ;# as yourself
-	# make prefix=/usr install install-doc ;# as root
+	$ make prefix=/usr all doc info ;# as yourself
+	# make prefix=/usr install install-doc install-info ;# as root
 
 (or prefix=/usr/local, of course).  Just like any program suite
 that uses $prefix, the built results have some paths encoded,
@@ -91,9 +91,13 @@ Issues of note:
  - To build and install documentation suite, you need to have
    the asciidoc/xmlto toolchain.  Because not many people are
    inclined to install the tools, the default build target
-   ("make all") does _not_ build them.  The documentation is
-   written for AsciiDoc 7, but "make ASCIIDOC8=YesPlease doc"
-   will let you format with AsciiDoc 8.
+   ("make all") does _not_ build them.
+
+   Building and installing the info file additionally requires
+   makeinfo and docbook2X.  Version 0.8.3 is known to work.
+
+   The documentation is written for AsciiDoc 7, but "make
+   ASCIIDOC8=YesPlease doc" will let you format with AsciiDoc 8.
 
    Alternatively, pre-formatted documentation are available in
    "html" and "man" branches of the git repository itself.  For
-- 
1.5.3.rc4.21.ga63eb
