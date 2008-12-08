From: davetron5000 <davetron5000@gmail.com>
Subject: Can someone confirm what the contents of refs/heads/master means?
Date: Mon, 8 Dec 2008 11:23:46 -0800 (PST)
Message-ID: <f78b0fcc-6165-440a-b76b-b1b0a281b15c@k8g2000yqn.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 20:25:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9lj8-0008Tl-Ft
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 20:25:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbYLHTXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 14:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbYLHTXs
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 14:23:48 -0500
Received: from yx-out-2122.google.com ([74.125.44.25]:42206 "EHLO
	yx-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbYLHTXs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 14:23:48 -0500
Received: by yx-out-2122.google.com with SMTP id 35so361968yxh.1
        for <git@vger.kernel.org>; Mon, 08 Dec 2008 11:23:46 -0800 (PST)
Received: by 10.100.207.14 with SMTP id e14mr302349ang.3.1228764226430; Mon, 
	08 Dec 2008 11:23:46 -0800 (PST)
X-IP: 66.92.169.98
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; 
	rv:1.9.0.4) Gecko/2008102920 Firefox/3.0.4,gzip(gfe),gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102575>

I'm using git-svn to interact with an SVN repo that has branches.

After my clone via:

git svn clone $REPO/main -T trunk -b branches -t tags

my 'master' branch pointed to one of the branches in svn and not to
the main trunk. (my .git/config looked correct for svn interaction,
i.e. trunk pointed to the right place).

So, I overwrote refs/heads/master with the contents of refs/remotes/
trunk (i.e. the SHA-1 of the svn trunk).

Things seem to be working; git svn dcommit commits to the trunk and
git svn rebase updates from svn's trunk.

So, I want to make sure that refs/heads/master actuall does, in fact,
point to the head revision of whatever branch is considered "master".
Can someone comfirm this (or provide the actual explanation if I'm
wrong?)

Thanks!

Dave
