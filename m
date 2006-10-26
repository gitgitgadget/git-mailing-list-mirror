X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: VCS comparison table
Date: Thu, 26 Oct 2006 13:15:56 +0200
Message-ID: <454098EC.8040406@op5.se>
References: <45354AD0.1020107@utoronto.ca> <BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE> <vpq4ptz2uh8.fsf@ecrins.imag.fr> <453DAC87.8050203@research.canon.com.au> <Pine.LNX.4.64.0610232318200.3962@g5.osdl.org> <Pine.LNX.4.64N.0610232336010.30334@attu2.cs.washington.edu> <Pine.LNX.4.64.0610240812410.3962@g5.osdl.org> <Pine.LNX.4.64N.0610241300450.8112@attu4.cs.washington.edu> <20061025084810.GA26618@coredump.intra.peff.net> <Pine.LNX.4.64N.0610250157470.3467@attu1.cs.washington.edu> <20061025094900.GA26989@coredump.intra.peff.net> <Pine.LNX.4.64N.0610250954380.31053@attu2.cs.washington.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 26 Oct 2006 11:16:20 +0000 (UTC)
Cc: Jeff King <peff@peff.net>, Linus Torvalds <torvalds@osdl.org>,
	Lachlan Patrick <loki@research.canon.com.au>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <Pine.LNX.4.64N.0610250954380.31053@attu2.cs.washington.edu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30190>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd3DU-0002DT-Qs for gcvg-git@gmane.org; Thu, 26 Oct
 2006 13:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752143AbWJZLQE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 07:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752144AbWJZLQE
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 07:16:04 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:25227 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1752143AbWJZLQB (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 07:16:01 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588) id 06A1A6BDFC; Thu,
 26 Oct 2006 13:15:59 +0200 (CEST)
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 878D26BE17; Thu, 26 Oct 2006 13:15:56 +0200 (CEST)
To: David Rientjes <rientjes@cs.washington.edu>
Sender: git-owner@vger.kernel.org

David Rientjes wrote:
> On Wed, 25 Oct 2006, Jeff King wrote:
> 
>>> This all became very obvious when the tutorials came out on "how to use 
>>> git in 20 commands or less" effectively.  These tutorials shouldn't need 
>>> to exist with an information manager that started as a quick, efficient, 
>>> and _simple_ project.  You're treating git development in the same light 
>> Sorry, I don't see how this is related to the programming language _at
>> all_. Are you arguing that the interface of git should be simplified so
>> that such tutorials aren't necessary? If so, then please elaborate, as
>> I'm sure many here would like to hear proposals for improvements. If
>> you're arguing that git now has too many features, then which features
>> do you consider extraneous?
>>
> 
> It's not, it's related to the original vision of git which was meant for 
> efficiency and simplicity.

Compared to todays version, original git was neither efficient nor 
simple. Unless you mean "some random version along the way where git had 
everything *I* need and not the useless cruft that other people use", in 
which case it's simply a very egotistical view of things.

>  A year ago it was very easy to pick up the 
> package and start using it effectively within a couple hours.   Keep in
> mind that this was without tutorials, it was just reading man pages.  
> Today it would be very difficult to know what the essential commands are 
> and how to use them simply to get the job done, unless you use the 
> tutorials.

Have you tried "git --help"? It shows the most common commands and a 
short description of what they do. It's a very good pointer to which 
man-pages you need to read, and I imagine this would actually be one of 
the very first commands that new git users try. If they don't but just 
expect things to work according to some premade mental model they have 
of scm's, I'd say they'd be screwed no matter which software they tried.


>  This _inherently_ goes against the approach of trying to 
> provide something that is simple to the developer.
> 
> Revision control is something that should exist in the background that 
> does it's simple job very efficiently.  Unfortunately git has tried to 
> move its presence into the foreground and requiring developers to spend 
> more time on learning the system.
> 

No it hasn't. The ten or so commands that Linus first introduced when 
announcing git still work pretty much the same. Nobody in their right 
mind would ever claim that those ten commands made up anything that even 
remotely resembled a complete scm, but they were something to build on 
by anyone who wanted to extend it. So far, ~220 people have wanted to 
extend it in ways that others thought useful, because their patches are 
apparently in the git tree.

> Have you never tried to show other people git without giving them a 
> tutorial on the most common uses?  Try it and you'll see the confusion.  
> That _specifically_ illustrates the ever-increasing lack of simplicity 
> that git has acquired.
> 

Well, my head hurt when I tried to learn CVS without a tutorial, and 
mercurial and darcs and svn as well. I didn't pick up the functionality 
of the 'ls' command completely without reading the man-page for it. If 
you want something that works for everyone without having to read any 
documentation what so ever, buy Lego, cause computers ain't for you, my 
friend.

>> I don't agree with this. There are tons of enhancements that I find
>> useful (e.g., '...' rev syntax, rebasing with 3-way merge, etc) that I
>> think other developers ARE using. There are scalability and performance
>> improvements. And there are new things on the way (Junio's pickaxe work)
>> that will hopefully make git even more useful than it already is.
>>
> 
> There are _not_ scalability improvements.  There may be some slight 
> performance improvements, but definitely not scalability.  If you have 
> ever tried to use git to manage terabytes of data, you will see this 
> becomes very clear.  And "rebasing with 3-way merge" is not something 
> often used in industry anyway if you've followed the more common models 
> for revision control within large companies with thousands of engineers.  
> Typically they all work off mainline.
> 

Actually, I don't see why git shouldn't be perfectly capable of handling 
a repo containing several terabytes of data, provided you don't expect 
it to turn up the full history for the project in a couple of seconds 
and you don't actually *change* that amount of data in each revision. If 
you want a vcs that handles that amount with any kind of speed, I think 
you'll find rsync and raw rvs a suitable solution.

On the other hand, you fellas at google don't really use git to store 
the data from the search database, do you? I mean, it's written for 
source control management. People that tried to keep their mboxes in git 
failed miserably, because large files that constantly change just 
doesn't work well with git.

>> If you don't think recent git versions are worthwhile, then why don't
>> you run an old version? You can even use git to cherry-pick patches onto
>> your personal branch.
>>
> 
> I do.  And that's why I would recommend to any serious developer to use 
> 1.2.4; this same version that I used for kernel development at Google.
> 
>> Where?
>>
> 
> Few months back here on the mailing list.  When I tried cleaning up even 
> one program, I got the response back from the original author "why fix a 
> non-problem?" because his argument was that since it worked the code 
> doesn't matter.
> 
> 	http://marc.theaimsgroup.com/?l=git&m=115589472706036
> 
> And that is simply one thread of larger conversations that have taken 
> place off-list and aren't archived.
> 

First off, the code got changed as per Junio's desires. He's the 
maintainer and gets to choose about coding style and readability vs 
microoptimizations.

Second, why keep discussions about git development off-list?

Third, if you still have issues with it, why not provide a patch and see 
if Junio accepts it? Cleaner and faster code will, in my experience, 
always get accepted. Code that is cleaner from one devs point of view 
but doesn't actually provide any other benefits will be dropped to the 
floor, and rightly so.


>> I don't agree, but since you haven't provided anything specific enough
>> to discuss, there's not much to say.
>>
> 
> If there's a question about some of the sloppiness in the git source code 
> as it stands today, that's a much bigger issue than the sloppiness.  My 
> advice would be to pick up a copy of K&R's 2nd edition C programming 
> language book, read it, and then take a tour of the source code.
> 

The first sentence doesn't make sense. The second one is just rude, and 
formed by your own opinion on how code should be written. But again, 
submit patches and see if Junio accepts them. If he doesn't, and you 
really, really *really* can't stand the changes he and the rest of the 
git community wants in, fork your own version and hack away til your 
heart's content. Git makes it easy for you, whichever version you use.

>> Can you name one customization that you would like to perform now that
>> you feel can't be easily done (and presumably that would have been
>> easier in the past)?
>>
> 
> Yes, those mentioned above.
> 

Which ones? The git-mv changes you submitted were applied (although in a 
different shape), so there must be other ones. Rewriting C builtins as 
shell-scripts is not really an option, because portability and 
performance *does* matter.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
