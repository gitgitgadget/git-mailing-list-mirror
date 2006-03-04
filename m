From: Matt McCutchen <hashproduct@verizon.net>
Subject: Producing tar file with 666/777 permissions
Date: Fri, 03 Mar 2006 23:25:31 -0500
Message-ID: <1141446331.3171.4.camel@mattlaptop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Mar 04 05:25:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFOKn-0002fF-M5
	for gcvg-git@gmane.org; Sat, 04 Mar 2006 05:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbWCDEZe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Mar 2006 23:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbWCDEZe
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Mar 2006 23:25:34 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:36995 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S1750887AbWCDEZe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Mar 2006 23:25:34 -0500
Received: from [192.168.1.5] ([68.239.112.147])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-4.02 (built Sep
 9 2005)) with ESMTPA id <0IVL001D05MKEFJ7@vms044.mailsrvcs.net> for
 git@vger.kernel.org; Fri, 03 Mar 2006 22:25:33 -0600 (CST)
To: git@vger.kernel.org
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17170>

Dear GIT people,

How do I package a git repository in a tar file with 666 and 777
embedded permissions?  There's evidently some way to do it because the
Linux kernel source packages have 666 and 777 embedded permissions, but
git-tar-tree gives me a tar file with 644 and 755 permissions and
there's no obvious way to tell it to do otherwise.

There was lots of discussion on the mailing list about what permissions
to preserve when copying in and out of repositories (I obviously side
with those who want a single execute bit), but I could not find any
mention of permission issues in reference to git-tar-tree.

Please reply to me as I am off-list.
-- 
Matt McCutchen
hashproduct@verizon.net
http://hashproduct.metaesthetics.net/
