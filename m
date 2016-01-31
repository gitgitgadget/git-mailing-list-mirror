From: Philip Oakley <philipoakley@iee.org>
Subject: [RFC/PATCH] Git doc: GPL2 does not apply to repo data
Date: Sun, 31 Jan 2016 21:00:11 +0000
Message-ID: <1454274011-4880-1-git-send-email-philipoakley@iee.org>
References: <alpine.DEB.2.20.1601280913450.2964@virtualbox>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Smith <Jonathan.Smith@fphcare.co.nz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Philip Oakley <philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 31 22:01:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPz7M-0008Nx-Bx
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 22:01:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757390AbcAaVAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 16:00:47 -0500
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:61783 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757243AbcAaVAr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jan 2016 16:00:47 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2B+DACida5WPAYjFlxdGQEBAQELAQEBAQEBAQGCOVEiMG2IWKoIhR+DewkYDII7gyoEAgKBIk0BAQEBAQEHAQEBAUE/hEIBAQRWIxBROQoUBhMJiBYKtBiIdQEBAQEBBQEBAQEchg+IU4JeC0CBJwWHU48chUeJX0qMS4psg1KETjwuAQEBh0KBOAEBAQ
X-IPAS-Result: A2B+DACida5WPAYjFlxdGQEBAQELAQEBAQEBAQGCOVEiMG2IWKoIhR+DewkYDII7gyoEAgKBIk0BAQEBAQEHAQEBAUE/hEIBAQRWIxBROQoUBhMJiBYKtBiIdQEBAQEBBQEBAQEchg+IU4JeC0CBJwWHU48chUeJX0qMS4psg1KETjwuAQEBh0KBOAEBAQ
X-IronPort-AV: E=Sophos;i="5.22,377,1449532800"; 
   d="scan'208";a="859677280"
Received: from host-92-22-35-6.as13285.net (HELO localhost.localdomain) ([92.22.35.6])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 31 Jan 2016 21:00:18 +0000
X-Mailer: git-send-email 2.7.0.windows.1
In-Reply-To: <alpine.DEB.2.20.1601280913450.2964@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285172>

Some potential commercial users may be put off by the FUD
(Fear, Uncertainty and Doubt) that has been raised in the past
regarding the use of FOSS software.

In such communities, even the legal advice may be misinformed
and over-cautious regarding the storage of code and other
intellectual property in a Git repository for fear that Git's
GPL2 licence may somehow 'infect' the respository.

Add simple statements highlighting Git's licence, it's use
for Linux, to imply industrial-strength, and that users should
apply a suitable licence of their choice because the Git GPL
licence does not apply to their repo data.

It should be noted that a 'git init' will create a repo that while
empty of user data does provide the .git directory structure, which
includes a number of template files ('hooks\pre-rebase.sample' is
explicitly copyright), default refs and config file. Some may suggest
that these carry the GPL2 to the repo.

The GPL2 will still apply to the hook templates and the other
template files, but these, even if modified (becoming derived works)
would be distributed with the repo, satisfying the GPL.

The new content copyright belongs to user. Request that they state
their licence terms in line with recent FOSS industry practice.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
asciidoc formatting not checked.

The fear of 'infection' of a repo by the templates copied to the
repo by 'git init', should not be underestimated, given the need
for the Bison exception. Sometimes it has to be spelt out why it's
not an issue (in the commit messsage)

https://help.github.com/articles/open-source-licensing/

http://thread.gmane.org/gmane.comp.version-control.git/284715/
---
 Documentation/git.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index bff6302..137c89c 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1132,6 +1132,17 @@ of clones and fetches.
 	  - any external helpers are named by their protocol (e.g., use
 	    `hg` to allow the `git-remote-hg` helper)
 
+Licencing: Your data, and the Git tool[[Licencing]]
+---------------------------------------------------
+
+Git is an open source tool provided under GPL2.
+Git was designed to be, and is, the version control system
+for the Linux codebase.
+Your respository data created by Git is not subject to Git's GNU2
+licence, see GPL FAQs
+http://www.gnu.org/licenses/old-licenses/gpl-2.0-faq.en.html#TOCGPLOutput).
+
+User should apply a licence of their own choice to their repository data.
 
 Discussion[[Discussion]]
 ------------------------
-- 
2.7.0.windows.1
