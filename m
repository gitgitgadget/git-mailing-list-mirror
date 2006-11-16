X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 14:03:06 +0100
Message-ID: <455C618A.7080309@xs4all.nl>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>	<87hcx1u934.wl%cworth@cworth.org>	<Pine.LNX.4.64.0611141518590.2591@xanadu.home>	<87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>	<Pine.LNX.4.64.0611141633430.2591@xanadu.home>	<7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0611142007010.2591@xanadu.home>	<7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0611142306090.2591@xanadu.home>	<Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>	<455BBCE9.4050503@xs4all.nl>	<Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>	<455C412D.1030408@xs4all.nl> <7v7ixvbq80.fsf@assigned-by-dhcp.cox.net>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 16 Nov 2006 13:04:04 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 66
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <7v7ixvbq80.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31579>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkguD-0001PM-VH for gcvg-git@gmane.org; Thu, 16 Nov
 2006 14:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423998AbWKPNDr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 08:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423995AbWKPNDr
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 08:03:47 -0500
Received: from main.gmane.org ([80.91.229.2]:41665 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1423998AbWKPNDp (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 08:03:45 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gkgtt-0001Kv-DP for git@vger.kernel.org; Thu, 16 Nov 2006 14:03:29 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Thu, 16 Nov 2006 14:03:29 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 16 Nov 2006 14:03:29
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano escreveu:
> You claim it is _an interface_ issue but it is not.

 >> I don't want ANYTHING to really change, I just want a sane interface 
 >> to it.
 >
 > I agree that you do not want to change anything.  You just
 > needed a bit of handholding, because you deviated from the
 > cookbook usage, to correct your course.

Users (well, I do at least) start fiddling with systems to find out how 
they work.   Reading the manual is usually done as a last resort. I 
think this is pretty well documented in usability research.

I'm trying to show how GIT is badly suited to this. Your response is to 
explain to me what I should have done. That's nice, but that approach 
doesn't scale, because you don't reach the dozens of users out there who 
try the same, fail and give up.

If you really want to find out the weaknesses, you'd have to sit someone 
new to git in front of a computer, and let him figure how to operate it, 
while videotaping everything.

Writing a manual for newbies is also an effective (and simpler and 
cheaper) approach of figuring out what needs to be changed.



As another example:  annoyances regarding program invocation

  - option handling: -x -f -z != -xfz , "--max-count 1" doesn't work, 
but needs an '='

  - git --help lists an unordered set, which is too long scan quickly. 
I'd expect that list to either contain everything or the minimum set for 
daily use. I.e. the set introduced in a first tutorial.  Why are merge, 
prune, verify-tag there?

Try "bzr help" for comparison.

  - --pretty option with wholly uninformative options full, medium, 
short, raw.  It's not even documented what each option does.


I can go on with listing idiosyncrasies, but my point is not to get help 
from you, but rather to show how git can be improved.


>> With GIT, this is what happens
>>
>> [hanwen@haring y]$ git pull ../x
>> fatal: Needed a single revision
>> Pulling into a black hole?
> 
> You asked it to fetch from the neighbour repository and merge it
> into your current branch which does not exist (I presume that
> you omitted to describe what you did in directory y/ and I am
> assuming you did "mkdir y && cd y && git initdb" and nothing
> else).  You are pulling into a black hole.

as you remark in the other reply, there is IMO no reason for not having 
an empty 'master' branch. If master + HEAD gets created on the first 
commit, it might as well be created on the init-db.

-- 
  Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
