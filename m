From: mfine <eboats@gmail.com>
Subject: HEAD file location
Date: Tue, 24 Jan 2012 03:42:46 +0000 (UTC)
Message-ID: <loom.20120124T043119-263@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 24 04:45:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpXKB-0007sy-O0
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 04:45:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877Ab2AXDpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 22:45:07 -0500
Received: from lo.gmane.org ([80.91.229.12]:40670 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751443Ab2AXDpF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 22:45:05 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RpXJf-0007gN-PZ
	for git@vger.kernel.org; Tue, 24 Jan 2012 04:45:04 +0100
Received: from c-98-247-202-226.hsd1.wa.comcast.net ([98.247.202.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Jan 2012 04:45:03 +0100
Received: from eboats by c-98-247-202-226.hsd1.wa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Jan 2012 04:45:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 98.247.202.226 (Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; WOW64; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; InfoPath.2; .NET CLR 1.1.4322; BRI/2))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189036>

I'm working on a Git project and had a question about HEAD.  

In our remote Git repository, I see the file

git_repo_home/HEAD

and another file 

git_repo_home/refs/heads/HEAD

The content of the former file is  refs/heads/master  which looks ok because 
we want HEAD pointing at master.

However, should the latter file exist?  I had thought only branches
should exist in /refs/heads and HEAD isn't a branch right?  I'm wondering
if we erroneously created a HEAD branch.

Thanks for any help!  
