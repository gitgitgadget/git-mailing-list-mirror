From: jidanni@jidanni.org
Subject: [PATCH] Documentation/git-rev-parse.txt: Clarify minimum length=4
Date: Wed, 31 Dec 2008 10:38:40 +0800
Message-ID: <87r63pm5lb.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 31 03:55:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHrEy-0004uy-7r
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 03:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755237AbYLaCyB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 21:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755234AbYLaCx7
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 21:53:59 -0500
Received: from sd-green-bigip-74.dreamhost.com ([208.97.132.74]:33911 "EHLO
	homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755229AbYLaCx6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Dec 2008 21:53:58 -0500
Received: from jidanni.org (122-127-43-96.dynamic.hinet.net [122.127.43.96])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id 7F876119DCE
	for <git@vger.kernel.org>; Tue, 30 Dec 2008 18:53:57 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104243>

Here I merely repeat "The minimum length is 4." from another part of
the page. However I do it in a critical spot, else users will think
that there is just no dress code for how short one's strings can be.

Proof: only the last line of:
git init
touch z
git add z
git cat-file -t e
git cat-file -t e6
git cat-file -t e69
git cat-file -t e69d
will finally output "blob".

Signed-off-by: jidanni <jidanni@jidanni.org>
---
 Documentation/git-rev-parse.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 2921da3..8a4cdfc 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -154,6 +154,7 @@ blobs contained in a commit.
   E.g. dae86e1950b1277e545cee180551750029cfe735 and dae86e both
   name the same commit object if there are no other object in
   your repository whose object name starts with dae86e.
+  The minimum length is 4.
 
 * An output from 'git-describe'; i.e. a closest tag, optionally
   followed by a dash and a number of commits, followed by a dash, a
-- 
1.6.0.6
