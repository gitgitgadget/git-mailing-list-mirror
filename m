From: Sebastian Morr <sebastian@morr.cc>
Subject: [PATCH] Add MYMETA.yml to perl/.gitignore
Date: Thu, 1 Dec 2011 21:31:15 +0100
Message-ID: <20111201203114.GA12796@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 21:39:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWDQD-0000cE-5T
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 21:39:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753663Ab1LAUjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Dec 2011 15:39:52 -0500
Received: from static.148.34.47.78.clients.your-server.de ([78.47.34.148]:60799
	"EHLO morr.cc" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753332Ab1LAUjv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2011 15:39:51 -0500
X-Greylist: delayed 513 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Dec 2011 15:39:51 EST
Received: by morr.cc (Postfix, from userid 1001)
	id 000184760955; Thu,  1 Dec 2011 21:31:16 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on morr.cc
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED autolearn=ham
	version=3.3.1
Received: from thinkpad (port-92-196-111-124.dynamic.qsc.de [92.196.111.124])
	by morr.cc (Postfix) with ESMTPSA id 4FC7C4760953
	for <git@vger.kernel.org>; Thu,  1 Dec 2011 21:31:16 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186191>

This file is auto-generated in the process of building the Perl
extension.

Signed-off-by: Sebastian Morr <sebastian@morr.cc>
---

Good day, fine Sirs and Madams,

I just built Git for the first time, issued "git status", and there
was this untracked file. I guess you could call that an itch. This patch
fixes that, however, I'm not sure whether this is a relevant issue.

Didn't know whom to Cc, as the perl directory doesn't seem to get much
attention lately.

Kind regards,
Sebastian

 perl/.gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/perl/.gitignore b/perl/.gitignore
index 98b2477..9235e73 100644
--- a/perl/.gitignore
+++ b/perl/.gitignore
@@ -1,5 +1,6 @@
 perl.mak
 perl.mak.old
+MYMETA.yml
 blib
 blibdirs
 pm_to_blib
-- 
1.7.8.rc4.dirty
