From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] prune-packed: add -q to usage
Date: Thu, 18 Jan 2007 17:11:13 +0100
Message-ID: <20070118161113.GA6151@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jan 18 17:11:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7ZrE-0005nk-8p
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 17:11:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbXARQLS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 11:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064AbXARQLS
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 11:11:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:39730 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752061AbXARQLR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 11:11:17 -0500
Received: (qmail invoked by alias); 18 Jan 2007 16:11:15 -0000
Received: from pD9EBA48D.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.164.141]
  by mail.gmx.net (mp025) with SMTP; 18 Jan 2007 17:11:15 +0100
X-Authenticated: #5358227
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37118>

---
 builtin-prune-packed.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-prune-packed.c b/builtin-prune-packed.c
index a57b76d..9777300 100644
--- a/builtin-prune-packed.c
+++ b/builtin-prune-packed.c
@@ -2,7 +2,7 @@
 #include "cache.h"
 
 static const char prune_packed_usage[] =
-"git-prune-packed [-n]";
+"git-prune-packed [-n] [-q]";
 
 #define DRY_RUN 01
 #define VERBOSE 02
-- 
1.4.4.4
