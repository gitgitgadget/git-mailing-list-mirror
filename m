From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v3 11/23] Added the class PathNotInProjectDirectoryException.
Date: Fri, 23 May 2008 22:34:20 +0200
Message-ID: <1211574872-23676-12-git-send-email-florianskarten@web.de>
References: <1211574872-23676-1-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 22:36:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jze08-0006CA-Ib
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 22:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758927AbYEWUfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 16:35:25 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756799AbYEWUfY
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 16:35:24 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:35504 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758869AbYEWUet (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 16:34:49 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 2B29AE083D27
	for <git@vger.kernel.org>; Fri, 23 May 2008 22:34:39 +0200 (CEST)
Received: from [84.150.81.80] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JzdyI-0005iq-01; Fri, 23 May 2008 22:34:38 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1211574872-23676-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX19J4SMlTw0TYJAz/MRKbfgU+ZuLQTFb1upK4CdS
	skdJLK0gbM8KmQj4KWLEUSW7nevAchmTs32yeEzXpupVhLkzLh
	x0/S04f8LRbXUulTVN+A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82744>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../errors/PathNotInProjectDirectoryException.java |   25 ++++++++++++=
++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/errors/PathNo=
tInProjectDirectoryException.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/errors/PathNotInProj=
ectDirectoryException.java b/org.spearce.jgit/src/org/spearce/jgit/erro=
rs/PathNotInProjectDirectoryException.java
new file mode 100644
index 0000000..a406aef
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/errors/PathNotInProjectDire=
ctoryException.java
@@ -0,0 +1,25 @@
+/*
+ *  Copyright (C) 2008 Florian K=C3=B6berle
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public
+ *  License, version 2, as published by the Free Software Foundation.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public
+ *  License along with this library; if not, write to the Free Softwar=
e
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  021=
10-1301
+ */
+package org.spearce.jgit.errors;
+
+/**
+ * Thrown when a path wasn't in the project directory, but expected to=
 be.
+ *=20
+ */
+public class PathNotInProjectDirectoryException extends
+		IllegalArgumentException {
+}
--=20
1.5.4.3
