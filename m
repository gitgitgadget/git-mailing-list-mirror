From: davetron5000 <davetron5000@gmail.com>
Subject: Re: Getting git-svn to recognize branchpoints?
Date: Sat, 7 Jun 2008 10:13:56 -0700 (PDT)
Message-ID: <0fbb1aa1-fb40-4474-aa48-82505dd198d2@2g2000hsn.googlegroups.com>
References: <a12182cd-2cd3-42a6-b3b4-f99907576741@d77g2000hsb.googlegroups.com> 
	<e06498070806070836m4c3ffd93ye4e4d7ddd149a5a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 19:14:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K520C-0001fT-Jr
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 19:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755013AbYFGRN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 13:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754518AbYFGRN7
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 13:13:59 -0400
Received: from wr-out-0708.google.com ([64.233.184.246]:43283 "EHLO
	wr-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754823AbYFGRN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 13:13:58 -0400
Received: by wr-out-0708.google.com with SMTP id 63so4667905wra.10
        for <git@vger.kernel.org>; Sat, 07 Jun 2008 10:13:56 -0700 (PDT)
Received: by 10.100.253.5 with SMTP id a5mr13347ani.25.1212858836353; Sat, 07 
	Jun 2008 10:13:56 -0700 (PDT)
In-Reply-To: <e06498070806070836m4c3ffd93ye4e4d7ddd149a5a7@mail.gmail.com>
X-IP: 98.218.223.189
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-US; 
	rv:1.8.1.14) Gecko/20080404 Firefox/2.0.0.14,gzip(gfe),gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84217>

OK, gitk is now showing it using the --all.

I did get the entire history.  It seems like when I merge, every file
that was changed on trunk since the branch shows up as a conflict,
including files that I have not changed on my branch.

For one particular file, the history is:

6/4/07 - File Created
8/9/07 - File modified
12/3/07 - File modified
4/24/08 - Branch created

The diffs of the conflict make no sense, e.g.

<< From Trunk
some_stuff();
that_was_added();
====
>> From My Branch

I've tried all the merge strategies, and nothing makes a difference...

On Jun 7, 11:36 am, "Steven Walter" <stevenrwal...@gmail.com> wrote:
> On Fri, Jun 6, 2008 at 3:07 PM, davetron5000 <davetron5...@gmail.com> wrote:
> > I was given a branch in an SVN repo to work on.  My plan is to merge
> > it with trunk in Git to indicate how much easier it would be to use
> > Git.
>
> > Unfortunately, Git doesn't seem to realize that my branch is a branch
> > from SVN's trunk.  For example, I have made no changes to file foo.c
>
> > The main trunk has changes to foo.c
>
> > When I merge, those changes show up as conflicts.
>
> > gitk doesn't show any branch points, and I'm thinking that Git just
> > doesn't see the branches as they are in SVN.
>
> How much history did you fetch from subversion?  If you didn't fetch
> at least to the branch point, then that could explain what you're
> seeing.  If the SVN repository isn't too large, it is probably worth
> the time to fetch the entire history (from r1 forward).
>
> > The sha-1 of the branch commit from SVN shows up in gitk when I've
> > checked out my branch, but not if I have the trunk checked out (though
> > a git log DOES show it).
>
> That's expected; it sounds like you want "gitk --all"
> --
> -Steven Walter <stevenrwal...@gmail.com>
> "A human being should be able to change a diaper, plan an invasion,
> butcher a hog, conn a ship, design a building, write a sonnet, balance
> accounts, build a wall, set a bone, comfort the dying, take orders,
> give orders, cooperate, act alone, solve equations, analyze a new
> problem, pitch manure, program a computer, cook a tasty meal, fight
> efficiently, die gallantly. Specialization is for insects."
>  -Robert Heinlein
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majord...@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
