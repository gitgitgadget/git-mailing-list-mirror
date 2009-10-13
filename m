From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: How do I see all of my changes on a branch?
Date: Tue, 13 Oct 2009 13:23:00 -0700
Message-ID: <20091013202300.GC9261@spearce.org>
References: <25879435.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jonhud <jon@huddler-inc.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 22:26:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxnwk-0006OW-FF
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 22:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761225AbZJMUXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 16:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761218AbZJMUXh
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 16:23:37 -0400
Received: from george.spearce.org ([209.20.77.23]:57849 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760926AbZJMUXh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 16:23:37 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A4E47381FF; Tue, 13 Oct 2009 20:23:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <25879435.post@talk.nabble.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130204>

jonhud <jon@huddler-inc.com> wrote:
> We are using github (but that's more or less irrelevant, since I'm just
> running git 1.6 locally on Ubuntu). Some time ago, I created a new branch
> (release.2.2) and pushed it out to the remote repository. All the digging
> through log, gitk, etc. has not made it possible for me to figure out the
> commit (or point in time) at which I cut the branch. 

git merge-base release2.2 HEAD

Which really lets you do:

  git diff $(git merge-base release.2.2 HEAD) HEAD

Which is the long form of:

  git diff release-2.2...HEAD

(diff triple dot operator does the merge base computation for you).
 
-- 
Shawn.
