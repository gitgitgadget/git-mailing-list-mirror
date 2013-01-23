From: "Stefan Schulze" <algroth@gmx.de>
Subject: Moving commits from one branch to another
Date: Wed, 23 Jan 2013 13:04:03 +0100
Message-ID: <000a01cdf961$bcf773d0$36e65b70$@de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 13:04:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Txz4A-0006AD-1E
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 13:04:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754939Ab3AWMEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 07:04:07 -0500
Received: from mout.gmx.net ([212.227.15.19]:51393 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754549Ab3AWMEG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 07:04:06 -0500
Received: from mailout-de.gmx.net ([10.1.76.10]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0M5aK6-1T0N9o0Ddo-00xZPz for
 <git@vger.kernel.org>; Wed, 23 Jan 2013 13:04:04 +0100
Received: (qmail invoked by alias); 23 Jan 2013 12:04:03 -0000
Received: from unknown (EHLO AINBSP0006) [62.154.226.26]
  by mail.gmx.net (mp010) with SMTP; 23 Jan 2013 13:04:03 +0100
X-Authenticated: #2258612
X-Provags-ID: V01U2FsdGVkX19J0jgkbt9JrpN2LRFffxQ+FXnPqdUrK2yDb/3kX3
	/L9c3z8ZkjupJt
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: Ac35YbyFI4XOvY9eTru8m0JZhL7aCw==
Content-Language: de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214313>

Hi,

my team uses a central git-repo since >1500 commits and now we have to sync
(only one-way is necessary for now) our repository every three weeks with an
external svn-repo.
I created the new base-directory (incl. trunk/tags/branches) in svn and
added it to my local repo using git svn init && git fetch.
Now I have two branches in my local repository (master and "svnbranch") and
cherry-picked the very first commit from master to svnbranch (it was
probably not necessary), tagged this commit as "publishedToSvn". Now I want
to add all commits publishedToSvn..master onto svnbranch. I didn't managed
to succeed using git-rebase (probably because of the missing common
commits?) and using git grafts / filter-branch modifies my already published
master.

Is there any way to move/copy commits from one branch to another without a
common base-commit and without a forced push of master?

Thanks in advance,
  Stefan Schulze
