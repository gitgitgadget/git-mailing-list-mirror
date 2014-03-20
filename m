From: Jeff King <peff@peff.net>
Subject: [PATCH 02/12] t/test-lib: drop redundant unset of GIT_CONFIG
Date: Thu, 20 Mar 2014 19:13:36 -0400
Message-ID: <20140320231336.GB8479@sigill.intra.peff.net>
References: <20140320231159.GA7774@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Tran <unsignedzero@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 00:13:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQm9g-0005YV-LA
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 00:13:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760057AbaCTXNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 19:13:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:43561 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760049AbaCTXNi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 19:13:38 -0400
Received: (qmail 27609 invoked by uid 102); 20 Mar 2014 23:13:38 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Mar 2014 18:13:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Mar 2014 19:13:36 -0400
Content-Disposition: inline
In-Reply-To: <20140320231159.GA7774@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244603>

This is already handled by the mass GIT_* unsetting added by
95a1d12 (tests: scrub environment of GIT_* variables,
2011-03-15).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1531c24..625f06e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -649,7 +649,6 @@ else # normal case, use ../bin-wrappers only unless $with_dashes:
 	fi
 fi
 GIT_TEMPLATE_DIR="$GIT_BUILD_DIR"/templates/blt
-unset GIT_CONFIG
 GIT_CONFIG_NOSYSTEM=1
 GIT_ATTR_NOSYSTEM=1
 export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_ATTR_NOSYSTEM
-- 
1.9.0.560.g01ceb46
