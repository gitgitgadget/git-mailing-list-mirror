From: lists@haller-berlin.de (Stefan Haller)
Subject: Find out on which branch a commit was originally made
Date: Sat, 18 Sep 2010 11:19:53 +0200
Message-ID: <1jp0h7e.lgk0kp19qe5bbM%lists@haller-berlin.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 18 11:20:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Owtab-00033t-Pp
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 11:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755344Ab0IRJT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 05:19:59 -0400
Received: from mail.ableton.net ([62.96.12.115]:60524 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755314Ab0IRJT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 05:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Message-ID:Date:From:Subject:To; bh=XMf2ZayKOKJNey7I6eXzO1p3Rmscam+wGRxamghsUR4=;
	b=ackJi+8qCIjoBJCgB2WkIjUmW0PpRbRSaHR7XRDeLTtH+YMKzFlOhY9EZ80DZMZbtHHrI0GASE0q1RkgD5uJwhuhBSqlHKs0fju2FQCBgDJ1d/sjK5xZHxmLzjovwt1rH8j8Yk9r6tgK0keqpdLAnTrE9FgWVb4sB+YOls0MdJA=;
Received: from [10.1.15.238]
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1OwtZ1-0008U9-W4
	for git@vger.kernel.org; Sat, 18 Sep 2010 11:18:32 +0200
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.4 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156443>

I'm trying to pursuade my co-workers to switch from Subversion to Git;
some of them prefer Mercurial.

One concern that they are raising is that in Git there doesn't seem to
be an easy way to find out on which branch a given commit was originally
made, after the branch is merged back and deleted. They consider this a
show-stopper.  In Mercurial, branch information is meta data attached to
each commit, so you can easily get this information even after a branch
is closed.

Three questions:

1) Is this not something that Git users miss sometimes?  Why not?

2) Is there an easy way to get this information that I might have
missed?  (Typical use-case: you blame a line of code with git gui blame,
choose "Show history context" to show the changeset in gitk, and from
there you want to go up to the next merge commit to see if the merge
commit message mentions the name of the branch. I can't seem to figure
out how to find this merge commit in gitk, and besides, "Show history
context" shows me only 7 days of context by default, so the merge commit
is likely not to be in my current list anyway.)

3) As a possible work-around, they suggest to require encoding the
branch information in some format in the commit messages, maybe
automatically with a commit-msg hook.  Does this sound like a feasible
idea?  One drawback would be that it becomes awkward when you
accidentally make a commit on the wrong branch, and want to rebase it
onto the correct one.

Any insights and thoughts about this are much appreciated.

Thanks,
   Stefan


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
