From: Tim Mazid <timmazid@hotmail.com>
Subject: Re: How do I see all of my changes on a branch?
Date: Wed, 28 Oct 2009 05:08:21 -0700 (PDT)
Message-ID: <26093515.post@talk.nabble.com>
References: <25879435.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 13:08:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N37KF-00048I-3t
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 13:08:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753418AbZJ1MIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 08:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753397AbZJ1MIR
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 08:08:17 -0400
Received: from kuber.nabble.com ([216.139.236.158]:56545 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753299AbZJ1MIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 08:08:16 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1N37K9-00044x-8X
	for git@vger.kernel.org; Wed, 28 Oct 2009 05:08:21 -0700
In-Reply-To: <25879435.post@talk.nabble.com>
X-Nabble-From: timmazid@hotmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131451>



jonhud wrote:
> 
> Hi,
> 
> We are using github (but that's more or less irrelevant, since I'm just
> running git 1.6 locally on Ubuntu). Some time ago, I created a new branch
> (release.2.2) and pushed it out to the remote repository. All the digging
> through log, gitk, etc. has not made it possible for me to figure out the
> commit (or point in time) at which I cut the branch. 
> 

Um, unfortunately, all the commits that are prior to HEAD count as being on
the branch.
Have you tried using 'gitk --all' to look through? You should be able to see
the split point there.


jonhud wrote:
> 
> What I want to do is to get a list of files (and/or diffs for those files)
> from that point in time to HEAD on the branch. I understand that git-diff
> --name-only is part of the solution. What I can't figure out is how to
> pinpoint the first commit. So that's my first question... how do I do
> that?
> 

Once you've found the commit, you can 'git diff COMMIT', or you can even,
straight in gitk, (make sure you have your branch selected), right click on
the commit and select 'diff this->selected'.


jonhud wrote:
> 
> To complicate things, I was also working on a side branch which I merged
> to master before cutting the release.2.2 branch. In the best of all
> worlds, I would trace my changes back to the point at which I cut *that*
> branch and follow through the HEAD of release.2.2. How do I do that? I
> know I might have to take 2 passes, one for release 2.2 and one for the
> side branch and that's OK.
> 
> Thanks!
> 
> Jon
> 

The same method should work for that as well.

Good luck,
Tim.
-- 
View this message in context: http://www.nabble.com/How-do-I-see-all-of-my-changes-on-a-branch--tp25879435p26093515.html
Sent from the git mailing list archive at Nabble.com.
