From: Nemina Amarasinghe <neminaa@gmail.com>
Subject: Re: [PATCH][GSoC]simplified =?utf-8?b?YnJhbmNoLmM6aW5zdGFsbF9icmFuY2hfY29uZmlnKCk=?= if() statement
Date: Tue, 11 Mar 2014 07:16:22 +0000 (UTC)
Message-ID: <loom.20140311T081018-894@post.gmane.org>
References: <loom.20140310T083649-236@post.gmane.org> <loom.20140310T085652-521@post.gmane.org> <CAPig+cRAqEQ8320Gq2Njoioq5UU=d+W+hzF+YZAZ7Po9XjMq0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 11 08:16:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNGvo-0007sI-DJ
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 08:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262AbaCKHQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 03:16:52 -0400
Received: from plane.gmane.org ([80.91.229.3]:40852 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752784AbaCKHQv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 03:16:51 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WNGvh-0007p6-IZ
	for git@vger.kernel.org; Tue, 11 Mar 2014 08:16:49 +0100
Received: from 61.245.163.17 ([61.245.163.17])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 08:16:49 +0100
Received: from neminaa by 61.245.163.17 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 08:16:49 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 61.245.163.17 (Mozilla/5.0 (Windows NT 6.3; WOW64; rv:27.0) Gecko/20100101 Firefox/27.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243845>

I hope this is the correct format for  patch. Please comment on this if
something is wrong. 

Signed-off-by:Nemina Amarasinghe <neminaa@gmail.com>
---
 branch.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/branch.c b/branch.c
index 0304a7a..fd93603 100644
--- a/branch.c
+++ b/branch.c
@@ -87,12 +87,7 @@ void install_branch_config(int flag, const char *local,
const char *origin, cons
 				  _("Branch %s set up to track local branch %s by rebasing.") :
 				  _("Branch %s set up to track local branch %s."),
 				  local, shortname);
-		else if (!remote_is_branch && origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track remote ref %s by rebasing.") :
-				  _("Branch %s set up to track remote ref %s."),
-				  local, remote);
-		else if (!remote_is_branch && !origin)
+		else if (!remote_is_branch)
 			printf_ln(rebasing ?
 				  _("Branch %s set up to track remote ref %s by rebasing.") :
 				  _("Branch %s set up to track remote ref %s."),
-- 
1.9.0.152.g6ab4ae2
