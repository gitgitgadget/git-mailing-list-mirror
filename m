From: Tim Mazid <timmazid@hotmail.com>
Subject: Re: merge confusion
Date: Wed, 28 Oct 2009 05:01:24 -0700 (PDT)
Message-ID: <26093419.post@talk.nabble.com>
References: <24755682.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 13:01:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N37DX-00011b-3N
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 13:01:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299AbZJ1MBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 08:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753221AbZJ1MBU
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 08:01:20 -0400
Received: from kuber.nabble.com ([216.139.236.158]:40867 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220AbZJ1MBT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 08:01:19 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1N37DQ-0003NZ-R8
	for git@vger.kernel.org; Wed, 28 Oct 2009 05:01:24 -0700
In-Reply-To: <24755682.post@talk.nabble.com>
X-Nabble-From: timmazid@hotmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131449>



thepurpleblob wrote:
> 
> I had some unexpected behaviour doing a merge today. I wonder if anybody
> can tell me where I have gone wrong. This is the sequence...
> 
> * clone a remote repo
> * created a local branch to track one of the remote branches
> * did work on the local branch and then created another 'feature' branch
> from that
> * time elapsed and at some point(s) I pulled from the remote but did not
> merge the original local branch
> * finished feature, checkout local branch and merge in feature. 
> 
> What I didn't expect is that all the subsequent changes on the tracked
> remote branch got merged in too. Which I didn't want.
> So the question is - is that what's supposed to happen (ie. if you do any
> merge the tracked branch 'fast forwards' the remote) and, if so, if I want
> a branch that stays a branch (doesn't ever merge with the remote) how
> would I do that?
> 
> Thanks!
> 

Did you 'git pull' or 'git fetch'? 'git pull' automatically merges, where
'git fetch' only gets the data.
You can just do a 'git branch branch-to-merge COMMIT' then 'git merge
branch-to-merge' from your feature branch. Alternatively, you could just do
a straight 'git merge COMMIT' from your feature branch. Though I'm not sure
of the consequences of merging a commit instead of a branch.

Good luck,
Tim.
-- 
View this message in context: http://www.nabble.com/merge-confusion-tp24755682p26093419.html
Sent from the git mailing list archive at Nabble.com.
