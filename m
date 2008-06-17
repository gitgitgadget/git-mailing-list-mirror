From: Saurabh Raje <saurabh.raje@gmail.com>
Subject: git & svn related merge questions ...
Date: Tue, 17 Jun 2008 11:28:53 +0000 (UTC)
Message-ID: <loom.20080617T112816-101@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 13:31:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8ZP7-0007dR-BY
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 13:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755205AbYFQLaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 07:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755124AbYFQLaH
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 07:30:07 -0400
Received: from main.gmane.org ([80.91.229.2]:37966 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755105AbYFQLaG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 07:30:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1K8ZNy-0005cW-La
	for git@vger.kernel.org; Tue, 17 Jun 2008 11:30:03 +0000
Received: from bbs.webaroo.com ([125.18.21.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 11:30:02 +0000
Received: from saurabh.raje by bbs.webaroo.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 11:30:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 125.18.21.2 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9) Gecko/2008052906 Firefox/3.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85290>

Hi All,

I have a question regarding 3-way merge ...

Here's how the subversion commits had happened
- Initially we had 'trunk' at revision T1
- We made a 'branch' (svn cp) at revision B1 (T1 -> B1)
(...development continues in trunk & branch...)
- We merge (svn merge) changes T2 - T1 in branch B2 and resolve all the
conflicts (if any) committing revision B3
(...development continues in trunk...)

After this I imported the entire subversion repository in Git (git-svn clone) &
then tried to merge the 'branch' (@B3) in 'trunk' (@T3).

The problem here is that the common ancestor is considered as T1 for 'trunk' &
branch' & not T2 which causes many more merge conflicts which should not have
been there ... In subversion flow we used to merge diff of branch@B3 and
trunk@T2 in trunk to achieve the result with minimum conflicts.

Any idea of how to fix this?

I just started using Git. It is a fantastic piece of software.
Thank you all.

Regards,

Saurabh Raje 
