From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] t6024-recursive-merge.sh: hide spurious output when not running verbosely
Date: Fri, 29 Feb 2008 23:23:25 +0100
Message-ID: <1204323805-23185-1-git-send-email-mh@glandium.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 29 23:20:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVDax-0003mz-Ka
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 23:20:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754275AbYB2WUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 17:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753396AbYB2WUK
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 17:20:10 -0500
Received: from vuizook.err.no ([194.24.252.247]:58961 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753887AbYB2WUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 17:20:09 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JVDaB-000639-47; Fri, 29 Feb 2008 23:20:05 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JVDdV-00062K-US; Fri, 29 Feb 2008 23:23:25 +0100
X-Mailer: git-send-email 1.5.4.3.340.g97b97.dirty
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75579>


Signed-off-by: Mike Hommey <mh@glandium.org>
---
 t/t6024-recursive-merge.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t6024-recursive-merge.sh b/t/t6024-recursive-merge.sh
index 149ea85..43b5f15 100755
--- a/t/t6024-recursive-merge.sh
+++ b/t/t6024-recursive-merge.sh
@@ -81,7 +81,7 @@ EOF
 
 test_expect_success "virtual trees were processed" "git diff expect out"
 
-git reset --hard
+git reset --hard >&3 2>&4
 test_expect_success 'refuse to merge binary files' '
 	printf "\0" > binary-file &&
 	git add binary-file &&
-- 
1.5.4.3.340.g97b97.dirty

