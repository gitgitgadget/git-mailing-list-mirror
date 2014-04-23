From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v4 2/6] test: add test_write_lines helper
Date: Wed, 23 Apr 2014 15:14:55 +0300
Message-ID: <1398255277-26303-2-git-send-email-mst@redhat.com>
References: <1398255277-26303-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 23 14:14:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcw4e-0007kz-9h
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 14:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243AbaDWMOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 08:14:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18050 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751363AbaDWMOM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 08:14:12 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3NCEBFd003051
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <git@vger.kernel.org>; Wed, 23 Apr 2014 08:14:12 -0400
Received: from redhat.com (ovpn-116-36.ams2.redhat.com [10.36.116.36])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s3NCE9uA016689
	for <git@vger.kernel.org>; Wed, 23 Apr 2014 08:14:10 -0400
Content-Disposition: inline
In-Reply-To: <1398255277-26303-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246826>

As suggested by Junio.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 t/test-lib-functions.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index aeae3ca..2fa6453 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -712,6 +712,13 @@ test_ln_s_add () {
 	fi
 }
 
+# This function writes out its parameters, one per line
+test_write_lines () {
+	for line in "$@"; do
+		echo "$line"
+	done
+}
+
 perl () {
 	command "$PERL_PATH" "$@"
 }
-- 
MST
