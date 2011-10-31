From: Kirill Likhodedov <klikh.list@gmail.com>
Subject: Re: git stash show doesn't show stashed untracked files
Date: Mon, 31 Oct 2011 11:36:38 +0300
Message-ID: <503C659A-47BA-4DEA-8EA8-D2B46C2BBF59@gmail.com>
References: <5284251B-7265-493B-981D-DD10B80F85B1@jetbrains.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 09:43:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKnSr-0003MU-E9
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 09:43:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198Ab1JaInY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Oct 2011 04:43:24 -0400
Received: from mail1.intellij.net ([46.137.178.215]:42223 "EHLO
	mail1.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754421Ab1JaInX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Oct 2011 04:43:23 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Oct 2011 04:43:23 EDT
Received: (qmail 11479 invoked by uid 89); 31 Oct 2011 08:36:40 -0000
Received: by simscan 1.1.0 ppid: 11385, pid: 11471, t: 0.0816s
         scanners: regex: 1.1.0
Received: from unknown (HELO loki.labs.intellij.net) (Kirill.Likhodedov@jetbrains.com@195.5.138.42)
  by ip-10-48-137-145.eu-west-1.compute.internal with ESMTPA; 31 Oct 2011 08:36:40 -0000
In-Reply-To: <5284251B-7265-493B-981D-DD10B80F85B1@jetbrains.com>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184494>


Resending: it seems that the message was lost in discussions.

> 
> Git 1.7.7 introduced a very useful feature - stashing untracked files via "-u" option.
> 
> However, there is a problems with it:
> 'git stash show' doesn't show stashed untracked files.
> 
> # git version
> git version 1.7.7
> # touch untracked.txt
> # git stash save -u
> # git stash show         // no output
> 
> If changes in tracked files are stashed along with untracked files, then only tracked changes are shown in "git stash show" output.
> 
> Moreover, if I have the same file in the working tree, I wouldn't be able to 'git stash pop':
> # git stash pop -v
> untracked.txt already exists, no checkout
> Could not restore untracked files from stash
> 
> In this case the only way to access the stashed content is to remove the tracked file and pop the stash again.
> 
