From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v5 8/9] t4204-patch-id.sh: default is now stable
Date: Thu, 24 Apr 2014 12:31:13 +0300
Message-ID: <1398331809-11309-8-git-send-email-mst@redhat.com>
References: <1398331809-11309-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sunshine@sunshineco.com, jrnieder@gmail.com, peff@peff.net,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 24 11:31:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdFzn-0004SX-BJ
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 11:31:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755250AbaDXJa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 05:30:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3517 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754359AbaDXJau (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 05:30:50 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3O9UUAS010770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2014 05:30:30 -0400
Received: from redhat.com (ovpn-116-36.ams2.redhat.com [10.36.116.36])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s3O9URtI027660;
	Thu, 24 Apr 2014 05:30:28 -0400
Content-Disposition: inline
In-Reply-To: <1398331809-11309-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246953>

update test to match behaviour change

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 t/t4204-patch-id.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
index cd13e8e..03f91ce 100755
--- a/t/t4204-patch-id.sh
+++ b/t/t4204-patch-id.sh
@@ -138,8 +138,8 @@ test_expect_success 'splitting patch affects id with --unstable' '
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
