From: Stephen & Linda Smith <ischis2@cox.net>
Subject: Re: merging commit history
Date: Tue, 16 Jul 2013 18:08:18 -0700
Message-ID: <2783346.mfr0aMU5vx@thunderbird>
References: <3186432.VaN86YJOtL@thunderbird>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 17 03:08:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzGE5-0001q4-9F
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 03:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864Ab3GQBIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 21:08:13 -0400
Received: from fed1rmfepo102.cox.net ([68.230.241.144]:33423 "EHLO
	fed1rmfepo102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783Ab3GQBIM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 21:08:12 -0400
Received: from fed1rmimpo210 ([68.230.241.161]) by fed1rmfepo102.cox.net
          (InterMail vM.8.01.05.09 201-2260-151-124-20120717) with ESMTP
          id <20130717010811.WOUV3896.fed1rmfepo102.cox.net@fed1rmimpo210>
          for <git@vger.kernel.org>; Tue, 16 Jul 2013 21:08:11 -0400
Received: from thunderbird ([24.251.82.172])
	by fed1rmimpo210 with cox
	id 1D8B1m00W3j4oj401D8B2a; Tue, 16 Jul 2013 21:08:11 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020208.51E5EE7B.00DE,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=drIF/Sc4 c=1 sm=1
 a=+a/fVzVtFbLp+jmGrq7Gkg==:17 a=k0fhm0m3bZ4A:10 a=G8Uczd0VNMoA:10
 a=kj9zAlcOel0A:10 a=kviXuzpPAAAA:8 a=BYRrSOaJqooA:10 a=VwQbUJbxAAAA:8
 a=4Ho5dsHkvGTqLVxPZA4A:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
 a=4vB-4DCPJfMA:10 a=+a/fVzVtFbLp+jmGrq7Gkg==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.localnet (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id 1E31A1403EC;
	Tue, 16 Jul 2013 11:08:19 -0700 (MST)
User-Agent: KMail/4.10.4 (Linux/3.8.0-26-generic; KDE/4.10.4; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230599>

I did as Andrew suggested and created two git repositories  with one  branch using oldCM history and the second branch using having the svn history.  

Then I checked out the svn branch and rebased onto oldCM.   The head of the combined branch is named master.

How do I manually set git/git-svn up so that HEAD  points to -r rev  in the svn repository?    Googling doesn't come up with a solution; I previously thought google knows all.

When done, I would like git svn dcommit to be able to commit to the svn repo.

Thanks
sps

On Friday, July 12, 2013 10:11:41 AM Andrew Ardill wrote:
> On 12 July 2013 09:43, Stephen & Linda Smith <ischis2@cox.net> wrote:
> > I'm working on a project that used to use a proprietary CM system (aka oldCM).   At a point in time, the state of the code was frozen and used as the basis for commits in SVN.
> >
> > What I would like to to do is take the individal commits from the oldCM and place them into git knowing that the time/date stamps won't match.  Then I want to do whatever is necessary to
> > setup git so that I can run "svn rebase" to pull in the commits from the SVN repository.
> >
> > What is the easy way to do this?
> 
> 
> There may be other tools that make this easier, but if I had this
> problem I would simply create two repositories, one for oldCM and one
> for SVN. I would then merge the two together (as branches with
> different roots) and do my rebase from there.
> 
> I haven't tried this, and maybe there is something I am missing, but
> there shouldn't be too much pain going that way.
> 
> 
> Regards,
> 
> Andrew Ardill
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
