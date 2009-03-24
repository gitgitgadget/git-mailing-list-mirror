From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 3/9] builtin-checkout: use warning() instead of fprintf(stderr, "warning: ")
Date: Tue, 24 Mar 2009 02:09:11 +0100
Message-ID: <a1165f8583c71de7fb053e83ddf1d7acd2e48024.1237856682.git.vmiklos@frugalware.org>
References: <cover.1237856682.git.vmiklos@frugalware.org>
 <1fcc4848dd7a24f846bb302bbb555bf1bac795a5.1237856682.git.vmiklos@frugalware.org>
 <9287282d966904f06ae4b3d7cfdf1d79eb645b69.1237856682.git.vmiklos@frugalware.org>
Cc: Jeff King <peff@peff.net>, John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 02:10:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llv9a-0006Vh-VL
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 02:10:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754511AbZCXBI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 21:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753670AbZCXBIZ
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 21:08:25 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:57051 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599AbZCXBIY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 21:08:24 -0400
Received: from vmobile.example.net (catv-89-134-199-25.catv.broadband.hu [89.134.199.25])
	by yugo.frugalware.org (Postfix) with ESMTPA id 1CBC329406F;
	Tue, 24 Mar 2009 02:08:20 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id D40F2186222; Tue, 24 Mar 2009 02:09:18 +0100 (CET)
X-Mailer: git-send-email 1.6.2
In-Reply-To: <9287282d966904f06ae4b3d7cfdf1d79eb645b69.1237856682.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1237856682.git.vmiklos@frugalware.org>
References: <cover.1237856682.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114374>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-checkout.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 9fdfc58..fc55bbe 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -558,8 +558,8 @@ static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
 
 	if (!old.commit && !opts->force) {
 		if (!opts->quiet) {
-			fprintf(stderr, "warning: You appear to be on a branch yet to be born.\n");
-			fprintf(stderr, "warning: Forcing checkout of %s.\n", new->name);
+			warning("You appear to be on a branch yet to be born.");
+			warning("Forcing checkout of %s.", new->name);
 		}
 		opts->force = 1;
 	}
-- 
1.6.2
