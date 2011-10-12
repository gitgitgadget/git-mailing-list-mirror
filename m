From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 4/7] clear_cached_refs(): rename parameter
Date: Wed, 12 Oct 2011 20:44:24 +0200
Message-ID: <1318445067-19279-5-git-send-email-mhagger@alum.mit.edu>
References: <7vty7ggzum.fsf@alter.siamese.dyndns.org>
 <1318445067-19279-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 20:50:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE3sU-0006Yt-Li
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 20:50:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754012Ab1JLStp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 14:49:45 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:58211 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003Ab1JLSto (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 14:49:44 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RE3mW-0008JO-J4; Wed, 12 Oct 2011 20:43:56 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <1318445067-19279-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183392>

...for consistency with the rest of this module.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index b08d476..79e3576 100644
--- a/refs.c
+++ b/refs.c
@@ -158,13 +158,13 @@ static void free_ref_array(struct ref_array *array)
 	array->refs = NULL;
 }
 
-static void clear_cached_refs(struct cached_refs *ca)
+static void clear_cached_refs(struct cached_refs *refs)
 {
-	if (ca->did_loose)
-		free_ref_array(&ca->loose);
-	if (ca->did_packed)
-		free_ref_array(&ca->packed);
-	ca->did_loose = ca->did_packed = 0;
+	if (refs->did_loose)
+		free_ref_array(&refs->loose);
+	if (refs->did_packed)
+		free_ref_array(&refs->packed);
+	refs->did_loose = refs->did_packed = 0;
 }
 
 static struct cached_refs *create_cached_refs(const char *submodule)
-- 
1.7.7.rc2
