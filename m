From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v5 2/9] test: add test_write_lines helper
Date: Thu, 24 Apr 2014 12:30:54 +0300
Message-ID: <1398331809-11309-2-git-send-email-mst@redhat.com>
References: <1398331809-11309-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sunshine@sunshineco.com, jrnieder@gmail.com, peff@peff.net,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 24 12:04:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdGWR-0004ov-17
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 12:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754848AbaDXKEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 06:04:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59427 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754370AbaDXKEj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 06:04:39 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3OA4Rmu001931
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2014 06:04:28 -0400
Received: from redhat.com (ovpn-116-36.ams2.redhat.com [10.36.116.36])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s3O9U85I001348;
	Thu, 24 Apr 2014 05:30:09 -0400
Content-Disposition: inline
In-Reply-To: <1398331809-11309-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246958>

API and implementation as suggested by Junio.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 t/test-lib-functions.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index aeae3ca..0e21275 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -712,6 +712,11 @@ test_ln_s_add () {
 	fi
 }
 
+# This function writes out its parameters, one per line
+test_write_lines () {
+	printf "%s\n" "$@";
+}
+
 perl () {
 	command "$PERL_PATH" "$@"
 }
-- 
MST
