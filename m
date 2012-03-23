From: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
Subject: Git commit error: fatal: Repository has been updated, but unable to write new_index file.
Date: Fri, 23 Mar 2012 19:17:18 +0400
Message-ID: <2BED7901-8161-48B2-ABCD-C456173B0B59@jetbrains.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 16:24:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB6La-0001hO-93
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 16:24:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758754Ab2CWPYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 11:24:05 -0400
Received: from mail1.intellij.net ([46.137.178.215]:50480 "EHLO
	mail1.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758710Ab2CWPYE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Mar 2012 11:24:04 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Mar 2012 11:24:03 EDT
Received: (qmail 1328 invoked by uid 89); 23 Mar 2012 15:17:20 -0000
Received: by simscan 1.1.0 ppid: 1270, pid: 1318, t: 0.1014s
         scanners: regex: 1.1.0 clamav: 0.97/m:53/d:13443
Received: from unknown (HELO loki.labs.intellij.net) (Kirill.Likhodedov@jetbrains.com@195.5.138.42)
  by ip-10-48-137-145.eu-west-1.compute.internal with ESMTPA; 23 Mar 2012 15:17:19 -0000
X-Mailer: Apple Mail (2.1257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193766>


Hello,

I'm developing a Git integration with an IDE. Several users of the program report the following error which was returned by Git during commit:

fatal: Repository has been updated, but unable to write
new_index file. Check that disk is not full or quota is
not exceeded, and then "git reset HEAD" to recover.

Here is the command which IDE executes to make a commit: 

# git commit --only -F <message file> -- <several files chosen to commit>

The interesting thing is that commit was actually successful, i.e. all files are committed, git status reports correctly, no other mistakes were noticed by users.
Here is the bugreport with some more details: http://youtrack.jetbrains.com/issue/IDEA-82108
One of the users says, that the situation happens quite often.

Users say that the thing has never happened with them while they were using Tortoise Git, so I'm pretty sure, that it is my bug caused my some misusage of Git (although I asked users to perform more experiments).

Unfortunately, I didn't find any information about the possible cause of this error.

Could you please help me to figure out why it can happen? What situation can lead to this error?

Thanks a lot.

----------------------------------
Kirill Likhodedov
JetBrains, Inc
http://www.jetbrains.com
"Develop with pleasure!"
