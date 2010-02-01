From: Ron Garret <ron1@flownet.com>
Subject: GIT_WORK_TREE environment variable not working
Date: Sun, 31 Jan 2010 17:33:47 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-8E7697.17334731012010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 01 02:34:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NblB4-0005Zs-9U
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 02:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755021Ab0BABeD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2010 20:34:03 -0500
Received: from lo.gmane.org ([80.91.229.12]:33298 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754783Ab0BABeB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 20:34:01 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NblAu-0005Vt-Hv
	for git@vger.kernel.org; Mon, 01 Feb 2010 02:34:00 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Feb 2010 02:34:00 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Feb 2010 02:34:00 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138572>

What am I doing wrong here?

[ron@mickey:~/devel/gittest]$ pwd
/Users/ron/devel/gittest
[ron@mickey:~/devel/gittest]$ git status
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#  git/
nothing added to commit but untracked files present (use "git add" to 
track)
[ron@mickey:~/devel/gittest]$ cd
[ron@mickey:~]$ export GIT_WORK_TREE=/Users/ron/devel/gittest
[ron@mickey:~]$ git status
fatal: Not a git repository (or any of the parent directories): .git
[ron@mickey:~]$ git status --work-tree=/Users/ron/devel/gittest
fatal: Not a git repository (or any of the parent directories): .git
[ron@mickey:~]$
