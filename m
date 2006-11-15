X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 13:43:44 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611151315291.2591@xanadu.home>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
 <87hcx1u934.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0611141518590.2591@xanadu.home>
 <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
 <Pine.LNX.4.64.0611141633430.2591@xanadu.home>
 <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142007010.2591@xanadu.home>
 <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142306090.2591@xanadu.home>
 <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 15 Nov 2006 18:44:33 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31465>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkPkK-0000l2-Kp for gcvg-git@gmane.org; Wed, 15 Nov
 2006 19:44:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030850AbWKOSns (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 13:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030849AbWKOSns
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 13:43:48 -0500
Received: from relais.videotron.ca ([24.201.245.36]:51178 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1030846AbWKOSnr
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 13:43:47 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J8S00D1AC0W4AT0@VL-MH-MR001.ip.videotron.ca> for git@vger.kernel.org; Wed,
 15 Nov 2006 13:43:44 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Wed, 15 Nov 2006, Linus Torvalds wrote:

> 
> 
> On Tue, 14 Nov 2006, Nicolas Pitre wrote:
> > 
> > But the fact is that HG (which has a growing crowd of happy campers, 
> > maybe even larger than the BK crowd now) did work with and got used to a 
> > sensible definition of what a "pull" is.
> 
> Guys, before you start thinking this way, the fact is, there's a lot of 
> happy git users. 
> 
> So the reason for using "git pull" is
> 
>  - bk did it that way, and like it or not, bk was the first usable 
>    distributed system. hg is totally uninteresting.
> 
>  - git itself has now done it that way for the last 18 months, and the 
>    fact is, the people _complaining_ are a small subset of the people who 
>    actually use git on a daily basis and don't complain.

Those arguments are somewhat flawed.  If we stick to "BK did it that way 
and it was first", then following that logic we would also carry a lot 
of CVS baggage because "CVS did it that way, and it was the most 
successful of its kind".  Still, we decided not to follow CVS nor BK in 
many ways already.

As for the fraction of people complaining being a small fraction of 
current GIT users: that is easily explainable by the fact that most 
people who would have grown the complainers group are simply not GIT 
users anymore since they were turned away by GIT's current user 
interface issues.  The only complainers remaining are those who see 
value in the GIT technology but who would like to bring more 
intuitiveness to the GIT interface instead of going for the alternative 
technology.  And those kind of people are always few.

> So don't fall for the classic "second system syndrome". The classic reason 
> for getting the second system wrong is because you focus on the issues 
> people complain about, and not on the issues that work well (because the 
> issues that work fine are obviously not getting a lot of attention).

The counter part of that is the possibility to fall for the "ivory tower 
syndrome" where seasoned GIT users feel they are well satisfied with 
what is currently available and unwilling to consider changes that would 
reduce the barrier to entry for new users... simply because they are so 
used to the way things work that they can't see why others have problems 
with it.

> If you think "pull" is confusing, I can guarantee you that _changing_ the 
> name is a hell of a lot more confusing.

Agreed.  This is why the current discussion led to a proposition that 
allows for "pull" to remain as is but to have a "get" version that would 
be the alternate (saner) version.

> In fact, I think a lot of the 
> confusion comes from cogito, not from git - the fact that cogito used 
> different names and different syntax was a mistake, I think.
> 
> And that '#' for branch naming in particular was (and is) total 
> braindamage. The native git branch naming convention is just fundamentally 
> much better, and allows you to very naturally fetch multiple branches at 
> once, in a way that cogito's syntax does not.
> 
> So when I see suggestions of using that brain-damaged cogito syntax as an 
> "improvement", I know for a fact that somebody hasn't thought things 
> through, and only thinks it's a better syntax beause of totally bogus 
> reasons.

Do you have comments on my proposed syntax (that would be implemented 
with a git-get command) which I think doesn't really look like cogito?

> I do agree that we probably could/should re-use the "git merge" name. The 
> current "git merge" is an esoteric internal routine, and I doubt a lot of 
> people use it as-is. I don't think it would be a mistake to make "git 
> merge" basically be an alias for "git pull", for example, and I doubt many 
> people would really even notice.

Agreed.

> But the fact is, git isn't really that hard to work out, and the commands 
> aren't that complicated.

I agree with you in general, except for the "pull" behavior which is 
really really odd.  Maybe it made sense in the BK context, maybe it is 
fine _once_ you get used to it, but otherwise it is really overloaded.

> But trying to rename "pull" (or the "git" name itself) is just going to 
> cause more confusion than you fix.

Agreed again.


