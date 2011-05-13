From: Johan Herland <johan@herland.net>
Subject: [PATCH 1/2] t5400: Fix a couple of typos
Date: Fri, 13 May 2011 18:43:29 +0200
Message-ID: <201105131843.30159.johan@herland.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 13 18:43:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKvSo-0004jS-Vf
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 18:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759563Ab1EMQnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 12:43:37 -0400
Received: from smtp.opera.com ([213.236.208.81]:53953 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759198Ab1EMQng (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 12:43:36 -0400
Received: from johanh.localnet (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p4DGhVLA016471
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 13 May 2011 16:43:31 GMT
User-Agent: KMail/1.13.7 (Linux/2.6.38-ARCH; KDE/4.6.3; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173547>

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t5400-send-pack.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index b0b2684..0eace37 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -190,7 +190,7 @@ test_expect_success 'pushing explicit refspecs respects forcing' '
 	        +refs/heads/master:refs/heads/master
 	) &&
 	parent_head=$(cd parent && git rev-parse --verify master) &&
-	child_head=$(cd parent && git rev-parse --verify master) &&
+	child_head=$(cd child && git rev-parse --verify master) &&
 	test "$parent_head" = "$child_head"
 '
 
@@ -210,7 +210,7 @@ test_expect_success 'pushing wildcard refspecs respects forcing' '
 	        "+refs/heads/*:refs/heads/*"
 	) &&
 	parent_head=$(cd parent && git rev-parse --verify master) &&
-	child_head=$(cd parent && git rev-parse --verify master) &&
+	child_head=$(cd child && git rev-parse --verify master) &&
 	test "$parent_head" = "$child_head"
 '
 
-- 
1.7.5.1.354.g761178


-- 
Johan Herland, <johan@herland.net>
www.herland.net
