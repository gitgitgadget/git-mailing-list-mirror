From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] Documentation/gitattributes.txt: Add an example box to demonstrate attributes
Date: Fri, 08 Feb 2008 20:28:01 +0200
Organization: Private
Message-ID: <lk5vtia6.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 08 19:29:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNXyb-0005xk-Vw
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 19:29:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755000AbYBHS24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 13:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760287AbYBHS2z
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 13:28:55 -0500
Received: from main.gmane.org ([80.91.229.2]:36680 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754390AbYBHS2y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 13:28:54 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JNXxz-0007Hf-P6
	for git@vger.kernel.org; Fri, 08 Feb 2008 18:28:51 +0000
Received: from a91-155-178-181.elisa-laajakaista.fi ([91.155.178.181])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 18:28:51 +0000
Received: from jari.aalto by a91-155-178-181.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 18:28:51 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-178-181.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:l+gYRsfOhns5eQCFzOF3DxdWjBE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73122>

Demonstrate the meaning of set, unset, set to value, unspecied in a
asciidoc 'listing block'.
---
 Documentation/gitattributes.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 35a29fd..cd99a8e 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -52,6 +52,12 @@ Unspecified::
 	the path has or does not have the attribute, the
 	attribute for the path is said to be Unspecified.
 
+----------------------------------------------------------------
+# Examples: set, unset, set to value, unspecified
+
+*.txt   attribute -attribute attribute=value !attribute
+----------------------------------------------------------------
+
 When more than one glob pattern matches the path, a later line
 overrides an earlier line.  This overriding is done per
 attribute.
-- 
1.5.3.8


-- 
Welcome to FOSS revolution: we fix and modify until it shines
