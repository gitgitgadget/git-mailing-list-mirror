From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v5 9/9] Documentation/git-patch-id.txt: default is stable
Date: Thu, 24 Apr 2014 12:31:16 +0300
Message-ID: <1398331809-11309-9-git-send-email-mst@redhat.com>
References: <1398331809-11309-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sunshine@sunshineco.com, jrnieder@gmail.com, peff@peff.net,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 24 11:31:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdG06-0004p5-9o
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 11:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755183AbaDXJaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 05:30:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47611 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754881AbaDXJav (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 05:30:51 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3O9UXIe018803
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2014 05:30:37 -0400
Received: from redhat.com (ovpn-116-36.ams2.redhat.com [10.36.116.36])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s3O9UVvI031789;
	Thu, 24 Apr 2014 05:30:31 -0400
Content-Disposition: inline
In-Reply-To: <1398331809-11309-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246954>

Update documentation to match behaviour change.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 Documentation/git-patch-id.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-patch-id.txt b/Documentation/git-patch-id.txt
index e21b79b..9299b90 100644
--- a/Documentation/git-patch-id.txt
+++ b/Documentation/git-patch-id.txt
@@ -33,12 +33,13 @@ OPTIONS
 	With this option, reordering file diffs that make up a patch or
 	splitting a diff up to multiple diffs that touch the same path
 	does not affect the ID.
-	This is the default if patchid.stable is set to true.
+	This is the default.
 
 --unstable::
 	Use a non-symmetrical sum of hashes, such that reordering
 	or splitting the patch does affect the ID.
-	This is the default.
+	This is the default if patchid.stable is set to false.
+	This was the default value for git 1.9 and older.
 
 <patch>::
 	The diff to create the ID of.
-- 
MST
