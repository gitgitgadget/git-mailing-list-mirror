From: Fredrik Skolmli <fredrik@frsk.net>
Subject: [PATCH] Documentation: Clarify which paths git-clean will affect
Date: Tue, 5 May 2009 11:13:03 +0200
Message-ID: <20090505091302.GB27900@frsk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 05 11:41:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1H8L-0002ZT-CA
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 11:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754227AbZEEJkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2009 05:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753975AbZEEJkJ
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 05:40:09 -0400
Received: from cassarossa.samfundet.no ([129.241.93.19]:43101 "EHLO
	cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753495AbZEEJkI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2009 05:40:08 -0400
X-Greylist: delayed 1618 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 May 2009 05:40:08 EDT
Received: from asterix.samfundet.no ([2001:700:300:1800::f] helo=asterix.frsk.net)
	by cassarossa.samfundet.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <fredrik@frsk.net>)
	id 1M1Ghz-0004dn-Db; Tue, 05 May 2009 11:13:03 +0200
Received: from fredrik by asterix.frsk.net with local (Exim 4.69)
	(envelope-from <fredrik@frsk.net>)
	id 1M1Ghz-0007yd-3o; Tue, 05 May 2009 11:13:03 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118285>


Signed-off-by: Fredrik Skolmli <fredrik@frsk.net>
---
 Documentation/git-clean.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 43b2de7..ec6f743 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -23,6 +23,9 @@ example, be useful to remove all build products.
 If any optional `<path>...` arguments are given, only those paths
 are affected.
 
+If no arguments are given, the cleaning is recursive, starting at the current
+path.
+
 OPTIONS
 -------
 -d::
-- 
1.6.3.rc4.106.g0303f

-- 
Fredrik Skolmli
