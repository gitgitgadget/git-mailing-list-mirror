From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH v2 16/23] contrib/subtree: Document pull-all and push-all
Date: Sun, 10 Mar 2013 23:41:24 +0000
Message-ID: <1362958891-26941-17-git-send-email-pcampbell@kemitix.net>
References: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
Cc: David Greene <greened@obbligato.org>,
	Herman van Rink <rink@initfour.nl>,
	Paul Campbell <pcampbell@kemitix.net>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	"Michael Schubert" <mschub@elegosoft.com>,
	"Wayne Walter" <wayne@tickzoom.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 11 00:45:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEpvw-0004y2-TL
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 00:45:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426Ab3CJXpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 19:45:11 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:36171 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab3CJXpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 19:45:09 -0400
Received: by mail-wg0-f49.google.com with SMTP id 15so4511068wgd.16
        for <git@vger.kernel.org>; Sun, 10 Mar 2013 16:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=tQ1XgXMLt6k5fGDgz+euQYqZsTm0cCe2MLNsWmV1iek=;
        b=NxuI6DAqd+Xz3euWp/UAcjFByO1NktOr7lMf36e647yTj3S3qQ5KYC0/Q87ympl+dI
         TnC3ndkNEgm3zpsJ+tHy1+Gh2GbooUvCIUvdgeTXpujQKjYg4+pL58lBU2DNlBC/lLf+
         4N8j2sIIfuvWhlkHgdJzo4jTwswbej1/SdWtUE9/rhlCVjHAr6ddhto+oC3bSMoOKcEw
         EgEd6cJ1ZnZoKfl+8UK8+nY/iq2gBjWWY0xQ752yDm2t1Sqa2ZV3U+FLNPfxEASzYa3k
         6zIqS4MXxh6f1ssVvMB+fVpA9nZj/MsbKRZA3eiFUW71pBCvUH4QgAbnEfpxsHvB6IHy
         vwGA==
X-Received: by 10.194.82.34 with SMTP id f2mr15658554wjy.25.1362959108841;
        Sun, 10 Mar 2013 16:45:08 -0700 (PDT)
Received: from coyote.home (host-2-102-87-75.as13285.net. [2.102.87.75])
        by mx.google.com with ESMTPS id r7sm13757148wiz.2.2013.03.10.16.45.02
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 10 Mar 2013 16:45:07 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.rc1
In-Reply-To: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
X-Gm-Message-State: ALoCoQn07cqgTyLC3XVuks1o5yGxB+Slj1hAisG5DniAIsQSV1UodrAyxMMBEJsuxH3TycKA/yDM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217836>

From: Herman van Rink <rink@initfour.nl>

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/git-subtree.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index e0957ee..c8fc103 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -92,13 +92,19 @@ pull::
 	Exactly like 'merge', but parallels 'git pull' in that
 	it fetches the given commit from the specified remote
 	repository.
-	
+
+pull-all::
+	Perform a pull operation on all in .gittrees registered subtrees.
+
 push::
 	Does a 'split' (see below) using the <prefix> supplied
 	and then does a 'git push' to push the result to the 
 	repository and refspec. This can be used to push your
 	subtree to different branches of the remote repository.
 
+push-all::
+	Perform a pull operation on all in .gittrees registered subtrees.
+
 split::
 	Extract a new, synthetic project history from the
 	history of the <prefix> subtree.  The new history
-- 
1.8.2.rc1
