From: Florian La Roche <laroche@redhat.com>
Subject: [PATCH] Change git-gc documentation to reflect gc.packrefs implementation.
Date: Mon, 7 Jan 2008 17:21:23 +0100
Message-ID: <20080107162123.GA17555@dudweiler.stuttgart.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 07 17:21:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBujb-0005XO-49
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 17:21:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754836AbYAGQV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 11:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754819AbYAGQV0
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 11:21:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52654 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754801AbYAGQV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 11:21:26 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m07GLPpi027409
	for <git@vger.kernel.org>; Mon, 7 Jan 2008 11:21:25 -0500
Received: from pobox.stuttgart.redhat.com (pobox.stuttgart.redhat.com [172.16.2.10])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m07GLOpv028047
	for <git@vger.kernel.org>; Mon, 7 Jan 2008 11:21:24 -0500
Received: from dudweiler.stuttgart.redhat.com (dudweiler.stuttgart.redhat.com [10.32.5.60])
	by pobox.stuttgart.redhat.com (8.13.1/8.13.1) with ESMTP id m07GLOpS001197
	for <git@vger.kernel.org>; Mon, 7 Jan 2008 11:21:24 -0500
Received: from dudweiler.stuttgart.redhat.com (localhost.localdomain [127.0.0.1])
	by dudweiler.stuttgart.redhat.com (8.13.8/8.13.8) with ESMTP id m07GLNHY017577
	for <git@vger.kernel.org>; Mon, 7 Jan 2008 17:21:23 +0100
Received: (from laroche@localhost)
	by dudweiler.stuttgart.redhat.com (8.13.8/8.13.8/Submit) id m07GLN9e017574
	for git@vger.kernel.org; Mon, 7 Jan 2008 17:21:23 +0100
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69794>

Change git-gc documentation to reflect gc.packrefs implementation.

---
 Documentation/git-gc.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index c4354bb..4b2dfef 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -90,9 +90,9 @@ how long records of conflicted merge you have not resolved are
 kept.  This defaults to 15 days.
 
 The optional configuration variable 'gc.packrefs' determines if
-`git gc` runs `git-pack-refs`.  Without the configuration, `git-pack-refs`
-is not run in bare repositories by default, to allow older dumb-transport
-clients fetch from the repository,  but this will change in the future.
+`git gc` runs `git-pack-refs`. This can be set to "nobare" to enable
+it within all non-bare repos or it can be set to a boolean value.
+This defaults to true.
 
 The optional configuration variable 'gc.aggressiveWindow' controls how
 much time is spent optimizing the delta compression of the objects in
-- 
1.5.3.7
