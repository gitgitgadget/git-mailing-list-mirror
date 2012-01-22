From: Mikolas <mikolas.janota@gmail.com>
Subject: What does "modified" in git status mean?
Date: Sun, 22 Jan 2012 16:57:52 +0000 (UTC)
Message-ID: <loom.20120122T174204-274@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 22 18:25:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rp1Ac-0004bP-MV
	for gcvg-git-2@lo.gmane.org; Sun, 22 Jan 2012 18:25:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974Ab2AVRZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jan 2012 12:25:18 -0500
Received: from lo.gmane.org ([80.91.229.12]:48615 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751914Ab2AVRZR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jan 2012 12:25:17 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Rp1AB-0004Lx-43
	for git@vger.kernel.org; Sun, 22 Jan 2012 18:25:11 +0100
Received: from delphinus.inesc-id.pt ([146.193.36.25])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Jan 2012 18:25:07 +0100
Received: from mikolas.janota by delphinus.inesc-id.pt with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Jan 2012 18:25:07 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 146.193.36.25 (Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0; MALC))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188967>

I am using git version 1.7.5.1 under cygwin and I'm getting behavior that I'm 
not understanding.

When I do 'git status' in the root directory of the repository, it shows no 
difference. Once I cd to a subdirectory, it starts showing modifications. 
However, 'git diff' shows nothing. 

So it looks something like this:
$ git status
# On branch master
nothing to commit (working directory clean)

$ cd foo
$ git status
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#       modified:   ../foo/bar

$ git diff
$

I put the following in my gitconfig but that doesn't seem to be doing much.
[core]
       trustctime = false
       autocrlf = input

So my questions are 
1) Is there some way how to tell status to tell me *why* the files are marked 
as modified?
2) Is it normal that git status behaves differently in different directories?

--mikolas



 
