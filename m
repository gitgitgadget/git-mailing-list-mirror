From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] log --format: document %w
Date: Sun, 22 Nov 2009 17:15:31 +0100
Message-ID: <4B0963A3.4060804@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 22 17:15:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCF6C-0000Ak-Ne
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 17:15:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755298AbZKVQP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2009 11:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755295AbZKVQP1
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 11:15:27 -0500
Received: from india601.server4you.de ([85.25.151.105]:45888 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755279AbZKVQP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 11:15:26 -0500
Received: from [10.0.1.101] (p57B7F129.dip.t-dialin.net [87.183.241.41])
	by india601.server4you.de (Postfix) with ESMTPSA id 678822F8051;
	Sun, 22 Nov 2009 17:15:32 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133436>

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
I'm not especially proud of the triple negative in that note.  How to say it
better, yet concise?

 Documentation/pretty-formats.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 0946202..7ff6a6c 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -135,6 +135,10 @@ The placeholders are:
 - '%m': left, right or boundary mark
 - '%n': newline
 - '%x00': print a byte from a hex code
+- '%w([<w>[,<i1>[,<i2>]]])': switch line wrapping, like the -w option of
+  linkgit:git-shortlog[1].  NOTE: Color placeholders (`%C*`) are not
+  recognized as having no width, so they should not be put into wrapped
+  sections.
 
 NOTE: Some placeholders may depend on other options given to the
 revision traversal engine. For example, the `%g*` reflog options will
-- 
1.6.5.3
