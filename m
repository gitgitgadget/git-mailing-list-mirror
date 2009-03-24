From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 8/9] builtin-show-ref: use warning() instead of fprintf(stderr, "warning: ")
Date: Tue, 24 Mar 2009 02:09:16 +0100
Message-ID: <607f1ab07464931305b62599805f898e2bf2ca98.1237856682.git.vmiklos@frugalware.org>
References: <cover.1237856682.git.vmiklos@frugalware.org>
 <1fcc4848dd7a24f846bb302bbb555bf1bac795a5.1237856682.git.vmiklos@frugalware.org>
 <9287282d966904f06ae4b3d7cfdf1d79eb645b69.1237856682.git.vmiklos@frugalware.org>
 <a1165f8583c71de7fb053e83ddf1d7acd2e48024.1237856682.git.vmiklos@frugalware.org>
 <d499d514cd704edfc54ad62422e77aca275c9527.1237856682.git.vmiklos@frugalware.org>
 <6ca31ce7256d8945f520b7d57e2a14b890731abd.1237856682.git.vmiklos@frugalware.org>
 <83e5caf5764a146779d8cefbf874f540a6160eb4.1237856682.git.vmiklos@frugalware.org>
 <5e3412be5d72bce2bf36fdcc2734b89386fdfc21.1237856682.git.vmiklos@frugalware.org>
Cc: Jeff King <peff@peff.net>, John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 02:12:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlvBm-000760-Be
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 02:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755043AbZCXBIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 21:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754681AbZCXBIq
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 21:08:46 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:57064 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753763AbZCXBI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 21:08:26 -0400
Received: from vmobile.example.net (catv-89-134-199-25.catv.broadband.hu [89.134.199.25])
	by yugo.frugalware.org (Postfix) with ESMTPA id 50DB2294072;
	Tue, 24 Mar 2009 02:08:20 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 198F8186228; Tue, 24 Mar 2009 02:09:19 +0100 (CET)
X-Mailer: git-send-email 1.6.2
In-Reply-To: <5e3412be5d72bce2bf36fdcc2734b89386fdfc21.1237856682.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1237856682.git.vmiklos@frugalware.org>
References: <cover.1237856682.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114381>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-show-ref.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-show-ref.c b/builtin-show-ref.c
index 572b114..dc76c50 100644
--- a/builtin-show-ref.c
+++ b/builtin-show-ref.c
@@ -140,7 +140,7 @@ static int exclude_existing(const char *match)
 				continue;
 		}
 		if (check_ref_format(ref)) {
-			fprintf(stderr, "warning: ref '%s' ignored\n", ref);
+			warning("ref '%s' ignored", ref);
 			continue;
 		}
 		if (!string_list_has_string(&existing_refs, ref)) {
-- 
1.6.2
