From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: How to get rid of tracking branch?
Date: Wed, 14 Feb 2007 14:24:31 +0100
Organization: eudaptics software gmbh
Message-ID: <45D30D8F.50261DB0@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 14 14:22:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHK65-0006gT-53
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 14:22:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbXBNNWy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 08:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbXBNNWy
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 08:22:54 -0500
Received: from main.gmane.org ([80.91.229.2]:51386 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932244AbXBNNWx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 08:22:53 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HHK5q-0006wQ-Ug
	for git@vger.kernel.org; Wed, 14 Feb 2007 14:22:42 +0100
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Feb 2007 14:22:42 +0100
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Feb 2007 14:22:42 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39641>

Call me clueless, but how the heck do I get rid of a tracking remote
branch? I've cloned a repo locally, but in the clone I don't want to
track all the topic branches of the origin. But git branch -d keeps
saying it doesn't find the remote branch:

$ git version
git version 1.5.0
$ git clone mingw-git/ mingw-git2
[... all looks fine ...]
$ cd mingw-git2/
$ git branch -a
* devel
  origin/HEAD
  origin/devel
  origin/master
  origin/origin
  origin/repo-devel
$ git branch -d origin/repo-devel
error: branch 'origin/repo-devel' not found.
$ git branch -d remotes/origin/repo-devel
error: branch 'remotes/origin/repo-devel' not found.
$ git branch -d heads/remotes/origin/repo-devel
error: branch 'heads/remotes/origin/repo-devel' not found.
$ git branch -d refs/heads/remotes/origin/repo-devel
error: branch 'refs/heads/remotes/origin/repo-devel' not found.


How do I delete remote branches? Do I have to

 rm .git/refs/heads/remotes/origin/repo-devel

(I know I have to update the config, too, so that the next pull doesn't
draw the branch in again, but I haven't done that at this point.)

-- Hannes
