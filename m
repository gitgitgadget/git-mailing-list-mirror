From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2] doc: don't claim that cherry calls patch-id
Date: Wed, 25 Sep 2013 01:33:36 +0300
Message-ID: <1380061947-2353-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 25 00:31:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOb8e-0006Qn-4n
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 00:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754494Ab3IXWbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 18:31:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64030 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750877Ab3IXWbU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 18:31:20 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r8OMVIK4024259
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 24 Sep 2013 18:31:18 -0400
Received: from redhat.com (vpn1-6-23.ams2.redhat.com [10.36.6.23])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id r8OMVGc8031527;
	Tue, 24 Sep 2013 18:31:17 -0400
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235324>

The id is already different for binary files.
The hash used is an implementation detail, so
let's just document how diffs are compared.

Cc: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Changes from v1:
	address comments by Jonathan

 Documentation/git-cherry.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
index f6c19c7..2d0daae 100644
--- a/Documentation/git-cherry.txt
+++ b/Documentation/git-cherry.txt
@@ -14,8 +14,7 @@ DESCRIPTION
 -----------
 The changeset (or "diff") of each commit between the fork-point and <head>
 is compared against each commit between the fork-point and <upstream>.
-The commits are compared with their 'patch id', obtained from
-the 'git patch-id' program.
+The diffs are compared after removing any whitespace and line numbers.
 
 Every commit that doesn't exist in the <upstream> branch
 has its id (sha1) reported, prefixed by a symbol.  The ones that have
-- 
MST
