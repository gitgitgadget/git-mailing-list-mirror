From: Jeff King <peff@peff.net>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 19:04:01 -0400
Message-ID: <20080828230401.GC29609@coredump.intra.peff.net>
References: <20080828090421.GQ10360@machine.or.cz> <18219E52-E56F-43D9-B28D-0CC74E225CC5@cs.indiana.edu> <alpine.LFD.1.10.0808280934160.3300@nehalem.linux-foundation.org> <7BC51BEC-E230-48C5-BD3E-2CECE3C7FC98@cs.indiana.edu> <20080828195211.GA3545@mithlond.arda.local> <4B9831F7-3CB8-49CB-A1DB-111481A271FE@cs.indiana.edu> <20080828212346.GA27867@coredump.intra.peff.net> <1C144B19-DA21-4CB4-B872-C1F154B031CF@cs.indiana.edu> <20080828215907.GE27867@coredump.intra.peff.net> <3DE083DB-ADFF-45E7-B3EB-A76985941271@cs.indiana.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Teemu Likonen <tlikonen@iki.fi>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Petr Baudis <pasky@suse.cz>,
	Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ulrich Windl <ulrich.windl@rz.uni-regensburg.DE>,
	Andi Kleen <andi@firstfloor.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Perry Wagle <wagle@cs.indiana.edu>
X-From: git-owner@vger.kernel.org Fri Aug 29 01:06:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYqYA-0004yT-VL
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 01:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754157AbYH1XEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 19:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753920AbYH1XEF
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 19:04:05 -0400
Received: from peff.net ([208.65.91.99]:1823 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753375AbYH1XEE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 19:04:04 -0400
Received: (qmail 8750 invoked by uid 111); 28 Aug 2008 23:04:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 28 Aug 2008 19:04:02 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Aug 2008 19:04:01 -0400
Content-Disposition: inline
In-Reply-To: <3DE083DB-ADFF-45E7-B3EB-A76985941271@cs.indiana.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94199>

On Thu, Aug 28, 2008 at 03:33:26PM -0700, Perry Wagle wrote:

> Ok.  My suggestion is that it shouldn't have been done in the first  
> place, and we should now revert.  But others are saying over and over  
> "its done!  live with it!".  I came in late.  What did I miss in the last 
> 6 months.  Sounds like people have lots of practice with these  
> water-over-the-dam's, surely this isn't the first time?

No, it really is the first time.

> In March 2008, the sample git-hooks and git-web used git<DASH> commands.  
> That was the last I looked at git until Tuesday of this week.

Yes, and some of the test scripts still have git-* in them. I think in
that respect, the git community has been very bad about eating our own
dog food.

>>    So yes, maybe there _are_ other bugs just like it lurking. But
>>    wouldn't it stand to reason that those bugs have _also_ been
>>    discussed and mentioned in the release notes, or that the developers
>>    would know about them?
>
> This is declared to not be a bug, even though it breaks existing scripts, 
> even those published in the main branch of git itself.

I think the bug is not in the change, but in the deprecation process and
communication. But I think the definition of "bug" is vague enough to
simply be in the eye of the beholder.

> I'm going by the reasoning shown in this thread.  Why not?  I'm looking 
> for a way not to have to do exhaustive testing on those scripts, so would 
> love to hear it.

Ultimately you must be the judge of what and how much to test on your
systems. But if you are asking if there are other similar compatibility
bugs in 1.6.0, then my opinion, as somebody who follows the git list
quite closely and contributes some code, is that no, there are not.

>>  1. I find your claim that such bugs exist to have little evidence to
>>     back it up.
>
> Induction.  If it happened once, it probably happened more than once.   
> This wasn't a show stopper problem.  It wasn't broke, but it was "fixed" 
> anyway.

Induction in this manner is not a very rigorous argument (we're being
engineers, right?). I gave several reasons already why the probability
is low that another such bug exists, mostly related to the lack of
indicators.

> I don't know what I missed, and am not sure how to search for in in ten 
> thousand messages or so since March.  My style is to anticipate problems.

Sure, I wouldn't want to go back and read all of the messages either.
But this was mentioned in the release notes, too. Why don't you start
with them?

> I think I hear you.  Since git is young, I should expect  
> incompatibilities with minor version changes, and not demand that they be 
> held off for major version changes.  That seems very plausible.

That isn't quite what I meant. What I meant was that our idea of a major
version number is the middle number. That is, the time to introduce a
few minor incompatibilities is when that number jumps (but they should
be documented for a significant time period ahead of time, which this
was).  I don't expect to jump to "git 2.0" basically ever. Just as I
don't really expect Linux 3.0 anytime soon. But I, of course, am not in
charge of such things, so you may take that with a grain of salt.

> But I think I'll still remain wary because 1.6 introduced a nearly  
> complete renaming of the API for what, in this thread anyway, completely 
> silly reasons.  If there are good reasons, I haven't seen them.

I think the reasons have been mentioned a few times. Maybe you just
didn't think they were good.

-Peff
