X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 11:45:01 +0100
Message-ID: <455C412D.1030408@xs4all.nl>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org> <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home> <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org> <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org> <455BBCE9.4050503@xs4all.nl> <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 16 Nov 2006 10:45:59 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 103
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31568>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gkeka-00070l-RM for gcvg-git@gmane.org; Thu, 16 Nov
 2006 11:45:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161980AbWKPKpY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 05:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161991AbWKPKpY
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 05:45:24 -0500
Received: from main.gmane.org ([80.91.229.2]:60891 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1161980AbWKPKpX (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 05:45:23 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gkek5-0006v1-6B for git@vger.kernel.org; Thu, 16 Nov 2006 11:45:13 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Thu, 16 Nov 2006 11:45:13 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 16 Nov 2006 11:45:13
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Linus Torvalds escreveu:
>>>  - git itself has now done it that way for the last 18 months, and the
>>> fact is, the people _complaining_ are a small subset of the people who
>>> actually use git on a daily basis and don't complain.
>>
>> that's not a good argument; the set of git users is a small subset of those
>> that looked at git, and dismissed it because they couldn't wrap their heads
>> around it. 
> 
> And I've said this again, and I'll say it once more: that has basically 
> _nothing_ to do with whether you spell "pull" as "pull" or "merge".
> 
> The reason people have trouble wrapping their heads around git is because 
> they have been braindamaged by CVS and SVN, and just don't understand the 
> fairly fundamental new concepts and workflow.

 > I claim that those "annoying little issues" are totally made up by
 > people
 > who had trouble wrapping their minds about git, and then make up
 > reasons
 > that have nothing to do with reality for why that might be so.

Let me put this more personally: I continue to be bitten by stupid 
naming issues, and the myriad of little mostly non-orthogonal commands.
My head is doing just fine otherwise, and has no problems wrapping it 
around the core of GIT.  I've also used Darcs for almost a year. Darcs, 
which is much less overwhelming.

This is not about CVS or SVN, so don't put them up as a strawman.
If you want to argue that my brain is warped, use other distributed VCs 
as an example.

The following

   mkdir x y
   cd x
   hg init
   echo hoi > bla
   hg add
   hg commit -m 'yes, I am also too stupid to refuse explicit empty 
commit messages'
   cd ../y
   hg init
   hg pull ../x

pretty much works the same in Darcs, bzr and mercurial.

With GIT, this is what happens

[hanwen@haring y]$ git pull ../x
fatal: Needed a single revision
Pulling into a black hole?

[hanwen@haring y]$ git fetch ../x
warning: no common commits
remote: Generating pack...
Done counting 3 objects.
Deltifying 3 objects.
  100% (3/3) done
Total 3, wremote: ritten 3 (delta 0), reused 0 (delta 0)
Unpacking 3 objects
  100% (3/3) done

[hanwen@haring y]$ git checkout
fatal: ambiguous argument 'HEAD': unknown revision or path not in the 
working tree.
Use '--' to separate paths from revisions
fatal: Not a valid object name HEAD

[hanwen@haring y]$ git branch master
fatal: Needed a single revision

at this point, I resort to adding a bogus commit and/or editing 
.git/HEAD by hand. I'm sure there is a saner way of doing it, but I 
still haven't found out what it is.

This might not be typical GIT use, but it does show the typical GIT user 
experience, at least mine.

If you want to have another example of how not to design a 
user-interface, try the above on Monotone.

> That's totally different from then arguing about stupid naming issues.
> 
> Peopel seem to believe that changign a few names or doing other totally 
> _minimal_ UI changes would somehow magically make things understandable. I 
> claim that isn't so at all. The fact is, git is different from CVS and 
> SVN, and git _has_ to be different from CVS and SVN. It has to be 
> different because the whole model of CVS and SVN is simpyl fundamentally 
> BROKEN.
> 
>> It's worth trying to get those on board by fixing the annoying
>> little issues that have popped up in this thread.
> 
> 
> Let's face it, you could just alias "merge" to "pull", and it wouldn't 
> really change ANYTHING.

I don't want ANYTHING to really change, I just want a sane interface to it.


-- 
  Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
