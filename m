From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v6 5/5] t4204-patch-id.sh: default is now stable
Date: Sun, 27 Apr 2014 21:15:59 +0300
Message-ID: <1398622524-26207-5-git-send-email-mst@redhat.com>
References: <1398622524-26207-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sunshine@sunshineco.com, jrnieder@gmail.com, peff@peff.net,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 27 20:16:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeTcZ-0000YU-8p
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 20:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533AbaD0SQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2014 14:16:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37997 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752399AbaD0SPW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2014 14:15:22 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3RIFCPt000690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 27 Apr 2014 14:15:13 -0400
Received: from redhat.com (ovpn-116-40.ams2.redhat.com [10.36.116.40])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s3RIF9wG009313;
	Sun, 27 Apr 2014 14:15:10 -0400
Content-Disposition: inline
In-Reply-To: <1398622524-26207-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247214>

update test to match behaviour change

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 t/t4204-patch-id.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
index 7732370..a8b0c2c 100755
--- a/t/t4204-patch-id.sh
+++ b/t/t4204-patch-id.sh
@@ -112,8 +112,8 @@ test_expect_success 'file order is relevant with --unstable' '
 '
 
 #Now test various option combinations.
-test_expect_success 'default is unstable' '
-	test_patch_id relevant default
+test_expect_success 'default is stable' '
+	test_patch_id irrelevant default
 '
 
 test_expect_success 'patchid.stable = true is stable' '
-- 
MST
