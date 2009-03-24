From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 4/9] builtin-fetch-pack: use warning() instead of fprintf(stderr, "warning: ")
Date: Tue, 24 Mar 2009 02:09:12 +0100
Message-ID: <d499d514cd704edfc54ad62422e77aca275c9527.1237856682.git.vmiklos@frugalware.org>
References: <cover.1237856682.git.vmiklos@frugalware.org>
 <1fcc4848dd7a24f846bb302bbb555bf1bac795a5.1237856682.git.vmiklos@frugalware.org>
 <9287282d966904f06ae4b3d7cfdf1d79eb645b69.1237856682.git.vmiklos@frugalware.org>
 <a1165f8583c71de7fb053e83ddf1d7acd2e48024.1237856682.git.vmiklos@frugalware.org>
Cc: Jeff King <peff@peff.net>, John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 02:10:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llv9e-0006Vh-Jc
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 02:10:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754538AbZCXBIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 21:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754718AbZCXBI0
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 21:08:26 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:57052 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754705AbZCXBIY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 21:08:24 -0400
Received: from vmobile.example.net (catv-89-134-199-25.catv.broadband.hu [89.134.199.25])
	by yugo.frugalware.org (Postfix) with ESMTPA id 2176D294070;
	Tue, 24 Mar 2009 02:08:20 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id DE8BA186223; Tue, 24 Mar 2009 02:09:18 +0100 (CET)
X-Mailer: git-send-email 1.6.2
In-Reply-To: <a1165f8583c71de7fb053e83ddf1d7acd2e48024.1237856682.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1237856682.git.vmiklos@frugalware.org>
References: <cover.1237856682.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114378>

---
 builtin-fetch-pack.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index d571253..5d134be 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -605,7 +605,7 @@ static struct ref *do_fetch_pack(int fd[2],
 			/* When cloning, it is not unusual to have
 			 * no common commit.
 			 */
-			fprintf(stderr, "warning: no common commits\n");
+			warning("no common commits");
 
 	if (get_pack(fd, pack_lockfile))
 		die("git fetch-pack: fetch failed.");
-- 
1.6.2
