From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v6 4/7] tests: change info messages from yellow/brown to bold cyan
Date: Sun, 16 Dec 2012 18:28:12 +0000
Message-ID: <1355682495-22382-5-git-send-email-git@adamspiers.org>
References: <1355682495-22382-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 16 19:39:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkJ7S-0007Pf-0j
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 19:39:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507Ab2LPSi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 13:38:57 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:41196 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154Ab2LPSi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 13:38:56 -0500
Received: from localhost (4.8.9.4.4.5.7.d.4.0.6.a.a.2.0.b.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:b02a:a604:d754:4984])
	by coral.adamspiers.org (Postfix) with ESMTPSA id D1E742E664
	for <git@vger.kernel.org>; Sun, 16 Dec 2012 18:28:19 +0000 (GMT)
X-Mailer: git-send-email 1.7.12.1.396.g53b3ea9
In-Reply-To: <1355682495-22382-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211596>

Now that we've adopted a "traffic lights" coloring scheme, yellow is
used for warning messages, so we need to re-color info messages to
something less alarmist.  Blue is a universal color for informational
messages; however we are using that for skipped tests in order to
align with the color schemes of other test suites.  Therefore we use
bold cyan which is also blue-ish, but visually distinct from bold
blue.  This was suggested on the list a while ago and no-one raised
any objections:

http://thread.gmane.org/gmane.comp.version-control.git/205675/focus=205966

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 220b172..5d9d0fc 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -218,7 +218,7 @@ then
 		pass)
 			tput setaf 2;;            # green
 		info)
-			tput setaf 3;;            # brown
+			tput bold; tput setaf 6;; # bold cyan
 		*)
 			test -n "$quiet" && return;;
 		esac
-- 
1.7.12.1.396.g53b3ea9
