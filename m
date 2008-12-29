From: davetron5000 <davetron5000@gmail.com>
Subject: git svn rebase totally confused; just need some sorta reset
Date: Mon, 29 Dec 2008 13:39:45 -0800 (PST)
Message-ID: <cd7145c4-a4bb-4ef6-95db-7c4058b6774c@m16g2000vbp.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 22:41:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHPrU-0008R7-E4
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 22:41:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256AbYL2Vjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 16:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753244AbYL2Vjs
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 16:39:48 -0500
Received: from mail-gx0-f59.google.com ([209.85.217.59]:44841 "EHLO
	mail-gx0-f59.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519AbYL2Vjr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 16:39:47 -0500
Received: by gxk19 with SMTP id 19so5977388gxk.21
        for <git@vger.kernel.org>; Mon, 29 Dec 2008 13:39:45 -0800 (PST)
Received: by 10.101.1.16 with SMTP id d16mr1246161ani.7.1230586785930; Mon, 29 
	Dec 2008 13:39:45 -0800 (PST)
X-IP: 66.92.169.98
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; 
	rv:1.9.0.4) Gecko/2008102920 Firefox/3.0.4,gzip(gfe),gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104129>

So, my repo is in a weird state.  I have committed my changes to svn
via git svn dcommit, and it appears that the svn repository has all my
changes.

However, git svn rebase fails with conflicts, on almost every single
commit I've made.  I think that ultimately, I merged a branch in
numerous times and git seems confused.  BUT, I don't really care about
preserving that; I just want my master branch to be clean.

Is there a way I can basically say:  commit XXX is the same as the
current HEAD of SVN, so treat things as if that's the case.  i.e.
treat things the same as if I had just done a clean git svn clone.
