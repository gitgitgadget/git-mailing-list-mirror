From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Document that rev-list --graph triggers parent rewriting.
Date: Fri, 12 Nov 2010 09:48:58 +0100
Message-ID: <1289551738-5498-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 12 09:49:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGpJq-0006nB-KO
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 09:49:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755865Ab0KLItI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 03:49:08 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:48626 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755705Ab0KLItH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 03:49:07 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 2C679D48196;
	Fri, 12 Nov 2010 09:49:00 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PGpJb-0001RG-Vo; Fri, 12 Nov 2010 09:48:59 +0100
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161331>

This may help to understand why --graph causes more comments to
be selected.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---
 Documentation/rev-list-options.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 7a42567..f4f105f 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -95,6 +95,8 @@ you would get an output like this:
 	to be printed in between commits, in order for the graph history
 	to be drawn properly.
 +
+This enables parent rewriting, see 'History Simplification' below.
++
 This implies the '--topo-order' option by default, but the
 '--date-order' option may also be specified.
 
-- 
1.7.2.3
