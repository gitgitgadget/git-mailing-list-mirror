From: jonhud <jon@huddler-inc.com>
Subject: How do I see all of my changes on a branch?
Date: Tue, 13 Oct 2009 12:40:19 -0700 (PDT)
Message-ID: <25879435.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 21:49:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxnMy-0002YX-IS
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 21:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934236AbZJMTk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 15:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934234AbZJMTk4
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 15:40:56 -0400
Received: from kuber.nabble.com ([216.139.236.158]:57666 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934233AbZJMTkz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 15:40:55 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1MxnEJ-0003lx-An
	for git@vger.kernel.org; Tue, 13 Oct 2009 12:40:19 -0700
X-Nabble-From: jon@huddler-inc.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130194>


Hi,

We are using github (but that's more or less irrelevant, since I'm just
running git 1.6 locally on Ubuntu). Some time ago, I created a new branch
(release.2.2) and pushed it out to the remote repository. All the digging
through log, gitk, etc. has not made it possible for me to figure out the
commit (or point in time) at which I cut the branch. 

What I want to do is to get a list of files (and/or diffs for those files)
from that point in time to HEAD on the branch. I understand that git-diff
--name-only is part of the solution. What I can't figure out is how to
pinpoint the first commit. So that's my first question... how do I do that?

To complicate things, I was also working on a side branch which I merged to
master before cutting the release.2.2 branch. In the best of all worlds, I
would trace my changes back to the point at which I cut *that* branch and
follow through the HEAD of release.2.2. How do I do that? I know I might
have to take 2 passes, one for release 2.2 and one for the side branch and
that's OK.

Thanks!

Jon
-- 
View this message in context: http://www.nabble.com/How-do-I-see-all-of-my-changes-on-a-branch--tp25879435p25879435.html
Sent from the git mailing list archive at Nabble.com.
