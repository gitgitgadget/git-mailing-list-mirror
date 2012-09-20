From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v5 3/3] Color skipped tests bold blue
Date: Thu, 20 Sep 2012 10:08:38 +0100
Message-ID: <1348132118-23139-1-git-send-email-git@adamspiers.org>
References: <505AAE34.2020408@viscovery.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 11:08:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEckc-0002wB-Ri
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 11:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106Ab2ITJIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 05:08:41 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:45564 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880Ab2ITJIl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 05:08:41 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id AEC3C2E5D3;
	Thu, 20 Sep 2012 10:08:39 +0100 (BST)
X-Mailer: git-send-email 1.7.12.147.g6d168f4
In-Reply-To: <505AAE34.2020408@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206043>

Skipped tests indicate incomplete test coverage.  Whilst this is
not a test failure or other error, it's still not complete
success, so according to the universal traffic lights coloring
scheme, yellow/brown seems more suitable than green.  However,
it's more informational than cautionary, so instead we use blue
which is a universal color for information signs.  Bold blue
should work better on both black and white backgrounds than
normal blue.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 t/test-lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 5293830..5ef87d4 100755
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -182,13 +182,13 @@ then
 		error)
 			tput bold; tput setaf 1;; # bold red
 		skip)
-			tput bold; tput setaf 2;; # bold green
+			tput bold; tput setaf 4;; # bold blue
 		warn)
 			tput bold; tput setaf 3;; # bold yellow
 		pass)
 			tput setaf 2;;            # green
 		info)
-			tput setaf 3;;            # brown
+			tput setaf 3;;            # yellow/brown
 		*)
 			test -n "$quiet" && return;;
 		esac
-- 
1.7.12.147.g6d168f4
