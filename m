From: Tim Mazid <timmazid@hotmail.com>
Subject: Re: Tagging stable releases
Date: Wed, 28 Oct 2009 05:17:13 -0700 (PDT)
Message-ID: <26093620.post@talk.nabble.com>
References: <23045562.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 13:17:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N37St-00082X-CQ
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 13:17:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753584AbZJ1MRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 08:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753535AbZJ1MRK
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 08:17:10 -0400
Received: from kuber.nabble.com ([216.139.236.158]:33552 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753520AbZJ1MRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 08:17:09 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1N37Sj-0004h8-VQ
	for git@vger.kernel.org; Wed, 28 Oct 2009 05:17:13 -0700
In-Reply-To: <23045562.post@talk.nabble.com>
X-Nabble-From: timmazid@hotmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131454>



Asaf wrote:
> 
> Hello,
> 
> I'm creating many branches, checkout code, make changes, etc..
> At the end, I always merge these branches to the master branch and delete
> them when I finish,
> 
> 
> At the point where my local master repo seems to be stable, I push the
> changes to an origin repo that is public.
> 
> 
> I guess this is a standard cycle, right?
> 

You don't need to merge everything back into master or delete branches.
When you 'git push', it only pushes remote tracking branches. (Branches that
you fetched from that repo).
If you do 'git push --all', it will push all your branches to the repo.
If you do 'git push REMOTE-REPO BRANCH', it will push just that branch. You
can, of course, list multiple branches.


Asaf wrote:
> 
> What I'm confused about is how to tag correctly versions that are stable,
> Should I locally just add a tag and push the tag to the public repo?
> 

Yup.


Asaf wrote:
> 
> Is it enough to use a lightweight tagging for tagging a certain commit as
> a release?
> 

Yes, but signing it makes others feel more confident, and if you at least
annotate, you can provide some sort of description.


Asaf wrote:
> 
> Is it possible later on to checkout a tag, make a change and push the
> change into the tagged version?
> 

Once again, yup, just do 'git checkout TAG'. Though you may want to do 'git
checkout -b NEW-BRANCH TAG'.

Good luck,
Tim.
-- 
View this message in context: http://www.nabble.com/Tagging-stable-releases-tp23045562p26093620.html
Sent from the git mailing list archive at Nabble.com.
