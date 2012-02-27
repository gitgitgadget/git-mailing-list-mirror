From: mhagger@alum.mit.edu
Subject: [PATCH 1/2] post-receive-email: remove unused variable
Date: Mon, 27 Feb 2012 19:34:09 +0100
Message-ID: <1330367650-23091-2-git-send-email-mhagger@alum.mit.edu>
References: <1330367650-23091-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, "Kevin P. Fleming" <kpfleming@digium.com>,
	Andy Parkins <andyparkins@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 19:34:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S25P5-0004iB-Oc
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 19:34:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754271Ab2B0SeY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 13:34:24 -0500
Received: from mail.berlin.jpk.com ([212.222.128.130]:54182 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753665Ab2B0SeX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 13:34:23 -0500
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1S25Nv-00065x-Nt; Mon, 27 Feb 2012 19:33:19 +0100
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1330367650-23091-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191644>

From: Michael Haggerty <mhagger@alum.mit.edu>

prep_for_email neither is passed a fourth argument nor uses it.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 contrib/hooks/post-receive-email |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index ba077c1..ac2e0ed 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -85,7 +85,6 @@ prep_for_email()
 	oldrev=$(git rev-parse $1)
 	newrev=$(git rev-parse $2)
 	refname="$3"
-	maxlines=$4
 
 	# --- Interpret
 	# 0000->1234 (create)
-- 
1.7.9
