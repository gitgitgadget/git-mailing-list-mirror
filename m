From: Stephen & Linda Smith <ischis2@cox.net>
Subject: Re: [PATCH] user-manual: remove temporary branch entry from todo list
Date: Sun, 27 Dec 2015 23:02:31 -0700
Message-ID: <3065044.ki4VpYSZvR@thunderbird>
References: <1450918023-30309-1-git-send-email-ischis2@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 28 07:02:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDQst-0003gm-7S
	for gcvg-git-2@plane.gmane.org; Mon, 28 Dec 2015 07:02:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbbL1GCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2015 01:02:15 -0500
Received: from fed1rmfepo102.cox.net ([68.230.241.144]:42774 "EHLO
	fed1rmfepo102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826AbbL1GCO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2015 01:02:14 -0500
Received: from fed1rmimpo209 ([68.230.241.160]) by fed1rmfepo102.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20151228060213.BSH7752.fed1rmfepo102.cox.net@fed1rmimpo209>
          for <git@vger.kernel.org>; Mon, 28 Dec 2015 01:02:13 -0500
Received: from thunderbird ([68.231.74.134])
	by fed1rmimpo209 with cox
	id yu2C1r00M2tqoqC01u2CKG; Mon, 28 Dec 2015 01:02:13 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020206.5680D065.0043,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=RNFt6fe+ c=1 sm=1
 a=/Rt4pg3TtX3KzfzhvVoEow==:17 a=kviXuzpPAAAA:8 a=wUQvQvOEmiQA:10
 a=VwQbUJbxAAAA:8 a=oko8Isk52rHqN623ek4A:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
 a=/Rt4pg3TtX3KzfzhvVoEow==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.localnet (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id 8AD93143320;
	Sun, 27 Dec 2015 23:02:31 -0700 (MST)
User-Agent: KMail/5.0.2 (Linux/4.3.0-2-generic; KDE/5.15.0; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283028>

On Sunday, December 27, 2015 06:41:09 PM Junio C Hamano wrote:
> "Stephen P. Smith" <ischis2@cox.net> writes:
> 
> > Remove the suggestion for using a detached HEAD instead of a
> > temporary branch.
> 
> That is something we can read from the patch text.  Please explain
> why it is a good idea to remove it.
> 
> I can think of two completely different reasons:
> 
>  (1) Maybe the task was done some time ago, and we are seeing a
>      stale todo item?
> 
>  (2) The task the todo item hints at was not done, but maybe it is
>      not a good thing to do after all?
> 
> You seem to be hinting the former, but I do not think "the task was
> done" is the case here.
 
I think that this is a stale todo.   
 
The only place there is a mention of temporary branches (which 
is then parenthetically called a topic branch) is in relation to how Tony Luck organizes his work.   
Additionally there is already a subsection on using a detatched head ("Examining an 
old version without creating a new branch). 
 
If there is more that was wanted, then I would be glad to add something, but 
I don't see that there are references to remove.
 
> 
> > Signed-off-by: Stephen P. Smith <ischis2@cox.net>
> > ---
> >
> > Notes:
> >     A search of the user manual found only one location which refers to
> >     temporary branches.  This has to do with how Tony Luck uses them.
> >     
> >     Even then there is a clarifying parenthetical noting that the
> >     temporary branches are topic branches.
> >     
> >     A git blame showed that the last time that the entry was updated was
> >     in 2007.
> >
> >  Documentation/user-manual.txt | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> > index 1c790ac..18e2f1e 100644
> > --- a/Documentation/user-manual.txt
> > +++ b/Documentation/user-manual.txt
> > @@ -4636,9 +4636,6 @@ Scan email archives for other stuff left out
> >  Scan man pages to see if any assume more background than this manual
> >  provides.
> >  
> > -Simplify beginning by suggesting disconnected head instead of
> > -temporary branch creation?
> > -
> 
> What does "beginning" refer to in this sentence, though?

I had that question too even after looking at the 2007 version of the manual.

> 
> After a quick reading of the beginning part of the document, I am
> getting the impression that it refers to the use of the 'new'
> branch, which is initially created out of v2.6.13 and then later
> reset to v2.6.17 while the user is in the sightseeing mode.  And
> this way of working _is_ a remnant from the days back when detached
> HEAD was not with us.
> 
> It is a completely separate matter if it is a good idea to teach
> detached HEAD that early in the tutorial, though.  
 
So are you suggesting a move of the section further down?   
Or are you suggesting that that is excised from the manual?

> So "remove the task because detached HEAD is a bit too weird thing to learn in that
> early stage in the learning curve" (i.e. the latter reason) might
> apply.
 
Could it be there are two reasons to remove the todo?

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
