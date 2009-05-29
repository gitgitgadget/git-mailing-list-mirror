From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: [PATCH] git-apply(1): Clarify that one can select where to apply
	the patch
Date: Fri, 29 May 2009 12:21:24 +0200
Message-ID: <20090529102124.GA9332@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Pieter de Bie <pdebie@ai.rug.nl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 29 12:21:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9zDX-0005Sh-0k
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 12:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756495AbZE2KV1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 May 2009 06:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756423AbZE2KV0
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 06:21:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:38957 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755186AbZE2KV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 06:21:26 -0400
Received: (qmail invoked by alias); 29 May 2009 10:21:25 -0000
Received: from i59F55A14.versanet.de (EHLO atjola.local) [89.245.90.20]
  by mail.gmx.net (mp039) with SMTP; 29 May 2009 12:21:25 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18A08lOCNEAR2JPY6Hw3+QiNQId7/n3zbHXIh+tmF
	LGWDdEAkjLDLpR
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120268>

The patch can be applied to the work tree, the index or both, but the
short description made it look like it's always applied to both.

Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
---
 Documentation/git-apply.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 9e5baa2..735374d 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -3,7 +3,7 @@ git-apply(1)
=20
 NAME
 ----
-git-apply - Apply a patch on a git index file and a working tree
+git-apply - Apply a patch on a git index file and/or a working tree
=20
=20
 SYNOPSIS
--=20
1.6.3.1.169.g33fd
