From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 7/9] builtin-show-branch: use warning() instead of fprintf(stderr, "warning: ")
Date: Tue, 24 Mar 2009 02:09:15 +0100
Message-ID: <5e3412be5d72bce2bf36fdcc2734b89386fdfc21.1237856682.git.vmiklos@frugalware.org>
References: <cover.1237856682.git.vmiklos@frugalware.org>
 <1fcc4848dd7a24f846bb302bbb555bf1bac795a5.1237856682.git.vmiklos@frugalware.org>
 <9287282d966904f06ae4b3d7cfdf1d79eb645b69.1237856682.git.vmiklos@frugalware.org>
 <a1165f8583c71de7fb053e83ddf1d7acd2e48024.1237856682.git.vmiklos@frugalware.org>
 <d499d514cd704edfc54ad62422e77aca275c9527.1237856682.git.vmiklos@frugalware.org>
 <6ca31ce7256d8945f520b7d57e2a14b890731abd.1237856682.git.vmiklos@frugalware.org>
 <83e5caf5764a146779d8cefbf874f540a6160eb4.1237856682.git.vmiklos@frugalware.org>
Cc: Jeff King <peff@peff.net>, John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 02:10:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llv9g-0006Vh-2R
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 02:10:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754761AbZCXBIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 21:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754406AbZCXBIj
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 21:08:39 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:57065 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754678AbZCXBI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 21:08:26 -0400
Received: from vmobile.example.net (catv-89-134-199-25.catv.broadband.hu [89.134.199.25])
	by yugo.frugalware.org (Postfix) with ESMTPA id 52C7A294073;
	Tue, 24 Mar 2009 02:08:20 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 0C5FC186227; Tue, 24 Mar 2009 02:09:19 +0100 (CET)
X-Mailer: git-send-email 1.6.2
In-Reply-To: <83e5caf5764a146779d8cefbf874f540a6160eb4.1237856682.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1237856682.git.vmiklos@frugalware.org>
References: <cover.1237856682.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114380>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-show-branch.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 306b850..828e6f8 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -365,8 +365,7 @@ static int append_ref(const char *refname, const unsigned char *sha1,
 				return 0;
 	}
 	if (MAX_REVS <= ref_name_cnt) {
-		fprintf(stderr, "warning: ignoring %s; "
-			"cannot handle more than %d refs\n",
+		warning("ignoring %s; cannot handle more than %d refs",
 			refname, MAX_REVS);
 		return 0;
 	}
-- 
1.6.2
