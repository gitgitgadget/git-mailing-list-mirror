From: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
Subject: Git commit error: fatal: Repository has been updated, but unable to write new_index file.
Date: Tue, 27 Mar 2012 11:35:08 +0400
Message-ID: <34E530A4-A792-42AC-8C19-5F7CB71FA46C@jetbrains.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 27 09:35:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCQw1-0000pv-Q4
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 09:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756822Ab2C0HfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 03:35:12 -0400
Received: from mail1.intellij.net ([46.137.178.215]:49024 "EHLO
	mail1.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755240Ab2C0HfM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Mar 2012 03:35:12 -0400
Received: (qmail 2999 invoked by uid 89); 27 Mar 2012 07:35:10 -0000
Received: by simscan 1.1.0 ppid: 2943, pid: 2974, t: 0.0803s
         scanners: regex: 1.1.0 clamav: 0.97/m:53/d:13443
Received: from unknown (HELO loki.labs.intellij.net) (Kirill.Likhodedov@jetbrains.com@195.5.138.42)
  by ip-10-48-137-145.eu-west-1.compute.internal with ESMTPA; 27 Mar 2012 07:35:10 -0000
X-Mailer: Apple Mail (2.1257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194030>


Reposting, since there were no replies - probably, the message was missed.
I would appreciate help in understanding what the Git error could be cause by.
Thanks!

-------

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
