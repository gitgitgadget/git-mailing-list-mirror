From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: [PATCH] Remove obsolete bug warning in man git-update-server-info
Date: Sat, 25 Apr 2009 16:26:52 +0530
Message-ID: <20090425105652.GA16297@atcmail.atc.tcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 25 13:50:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxgOM-0003Gd-13
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 13:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbZDYLsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 07:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751714AbZDYLsM
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 07:48:12 -0400
Received: from atcmail.atc.tcs.co.in ([203.200.212.145]:46313 "EHLO
	atcmail.atc.tcs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbZDYLsL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2009 07:48:11 -0400
X-Greylist: delayed 3062 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Apr 2009 07:48:11 EDT
Received: from atcmail.atc.tcs.com (atcmail.atc.tcs.com [127.0.0.1])
	by atcmail.atc.tcs.com (8.14.2/8.14.2) with ESMTP id n3PAutkG016357;
	Sat, 25 Apr 2009 16:26:55 +0530
Received: (from sitaram@localhost)
	by atcmail.atc.tcs.com (8.14.2/8.14.2/Submit) id n3PAuqBB016356;
	Sat, 25 Apr 2009 16:26:52 +0530
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/9286/Fri Apr 24 21:33:12 2009 on atcmail.atc.tcs.com
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on atcmail.atc.tcs.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117550>

The bug referred to was fixed in 60d0526

Signed-off-by: Sitaram Chamarty <sitaramc@gmail.com>
---

It was fixed in September 2005 [thanks to drizzd on irc for
pointing this out].

I'd also make a plea for someone who groks this better than
I do to document what --force does and under what conditions
it may be needed; the code looks to me like parse_pack_def
should take care of the problem, but clearly it was needed
for some reason that I'm not expert enough to understand.

 Documentation/git-update-server-info.txt |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-update-server-info.txt b/Documentation/git-update-server-info.txt
index 35d27b0..035cc30 100644
--- a/Documentation/git-update-server-info.txt
+++ b/Documentation/git-update-server-info.txt
@@ -39,12 +39,6 @@ what they are for:
 * info/refs
 
 
-BUGS
-----
-When you remove an existing ref, the command fails to update
-info/refs file unless `--force` flag is given.
-
-
 Author
 ------
 Written by Junio C Hamano <gitster@pobox.com>
-- 
1.6.2
