From: Jon Forrest <nobozo@gmail.com>
Subject: What's The Right Way to Do This?
Date: Fri, 23 Sep 2011 04:48:36 +0000 (UTC)
Message-ID: <loom.20110923T064720-366@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 06:50:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6xiM-0008KF-Ry
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 06:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116Ab1IWEuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 00:50:06 -0400
Received: from lo.gmane.org ([80.91.229.12]:34503 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751078Ab1IWEuF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 00:50:05 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1R6xi8-0008FL-46
	for git@vger.kernel.org; Fri, 23 Sep 2011 06:50:04 +0200
Received: from c-98-248-228-150.hsd1.ca.comcast.net ([98.248.228.150])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Sep 2011 06:50:04 +0200
Received: from nobozo by c-98-248-228-150.hsd1.ca.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Sep 2011 06:50:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 98.248.228.150 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0.2) Gecko/20100101 Firefox/6.0.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181941>

I'm just now starting to use git for more than trivial things.
Today I got myself in trouble. Here's what happened:

1) I pulled the master branch from the IT repository from our
main git server.

2) I created a branch from this called "J" and started making changes.

3) Other people pulled master from IT and then pushed changes back.

4) I merged J with my master branch.

5) I tried pushing my master back to origin but this failed with
the usual message saying I first needed to pull from origin.
So, I pulled and then pushed. This worked.

6) On another server where I was going to use my changes I pulled
master from IT.

6) It turned out that my changes were incorrect. So, I tried to revert
using various methods I found by googling "git revert". What happened
was that when I tried to revert back to the commit before the one I
made, the files I had modified *and* the files that apparently were
modified by other people in #3 above were reverted. This wasn't what
I wanted. I only wanted to revert the changes I had made.

With the help of someone more experienced than me we were able to get
things back to normal but this experience left me wondering what I
should have done in the first place. There's a chance I'm going to
have to go through all this again as I try to fix the problem with
my changes.

Any suggestions would be appreciated.

Thanks,
Jon Forrest 
