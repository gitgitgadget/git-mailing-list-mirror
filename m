From: Xavier Maillard <zedek@gnu.org>
Subject: git-cvsimport: all my files are marked deleted ?
Date: Sat, 10 Mar 2007 19:09:47 +0100
Organization: GNU's Not UNIX!
Message-ID: <200703101809.l2AI9lin005409@localhost.localdomain>
Reply-To: Xavier Maillard <zedek@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 10 19:12:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQ63r-0001aK-3A
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 19:12:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbXCJSMs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 13:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbXCJSMs
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 13:12:48 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:38973 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750808AbXCJSMr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 13:12:47 -0500
Received: from zogzog.home (chn51-3-88-163-173-156.fbx.proxad.net [88.163.173.156])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 0CABC7DB0
	for <git@vger.kernel.org>; Sat, 10 Mar 2007 19:12:46 +0100 (CET)
Received: from localhost.localdomain (IDENT:1001@localhost [127.0.0.1])
	by zogzog.home (8.13.8/8.13.8) with ESMTP id l2AI9m8K005412
	for <git@vger.kernel.org>; Sat, 10 Mar 2007 19:09:48 +0100
Received: (from zedek@localhost)
	by localhost.localdomain (8.13.8/8.13.8/Submit) id l2AI9lin005409;
	Sat, 10 Mar 2007 19:09:47 +0100
X-Authentication-Warning: localhost.localdomain: zedek set sender to zedek@gnu.org using -f
Jabber-ID: zedek@im.lolica.org
User-Agent: Rmail in GNU Emacs 23.0.51.1 on GNU/Linux
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41872>

Hi,

I am slowly moving all my projects from several SCM into GIT.

I am at converting all my CVS managed project for instance and I
miserably failed at understanding what is happening.

So I installed CVSps as per requested (it is version from Yann
Dirson's repository).

I prepared a local and clean checkout from my CVS.

Then I ran git-cvsimport like this:

 git cvsimport -v -A /tmp/author-conv -a -i -C <directory> <cvs module>

I think it finishes successfully but here are the latest messages:

Generating pack...
Done counting 202 objects.
Deltifying 202 objects.
 100% (202/202) done
Writing 202 objects.
 100% (202/202) done
Total 202 (delta 102), reused 0 (delta 0)
Pack pack-8a456d18c811d4a503d1e64183d223407e9d379d created.
Removing unused objects 100%...
Done.
DONE; creating master branch

Then I went back to <directory> and I just did 'ls'. Directory is
empty (except the .git directory).

git status reports this:

# Changed but not updated:
#   (use "git add/rm <file>..." to update what will be committed)
#
#       deleted:    AUTHORS
#	SKIPPED FILES HERE STILL MARKED AS deleted
#
no changes added to commit (use "git add" and/or "git commit -a")

git branch, git tag -l /et caetera/ have all I got onto my CVS.

What can I do to fix that and have "real" content into my project
?

Regards,
-- 
Xavier
