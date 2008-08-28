From: Jeff King <peff@peff.net>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 17:59:08 -0400
Message-ID: <20080828215907.GE27867@coredump.intra.peff.net>
References: <F86A1E37-8015-41B5-A462-F044B8D1C2B1@cs.indiana.edu> <BD6DEBB7-4D1C-43E9-B3D2-B46E42D9771D@cs.indiana.edu> <20080828090421.GQ10360@machine.or.cz> <18219E52-E56F-43D9-B28D-0CC74E225CC5@cs.indiana.edu> <alpine.LFD.1.10.0808280934160.3300@nehalem.linux-foundation.org> <7BC51BEC-E230-48C5-BD3E-2CECE3C7FC98@cs.indiana.edu> <20080828195211.GA3545@mithlond.arda.local> <4B9831F7-3CB8-49CB-A1DB-111481A271FE@cs.indiana.edu> <20080828212346.GA27867@coredump.intra.peff.net> <1C144B19-DA21-4CB4-B872-C1F154B031CF@cs.indiana.edu>
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
X-From: git-owner@vger.kernel.org Fri Aug 29 00:00:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYpXP-0003yS-QA
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 00:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756243AbYH1V7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 17:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756193AbYH1V7O
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 17:59:14 -0400
Received: from peff.net ([208.65.91.99]:3035 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755908AbYH1V7K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 17:59:10 -0400
Received: (qmail 8217 invoked by uid 111); 28 Aug 2008 21:59:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 28 Aug 2008 17:59:09 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Aug 2008 17:59:08 -0400
Content-Disposition: inline
In-Reply-To: <1C144B19-DA21-4CB4-B872-C1F154B031CF@cs.indiana.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94189>

On Thu, Aug 28, 2008 at 02:41:52PM -0700, Perry Wagle wrote:

>>> But, my problem is not git<DASH> vs git<SPACE>, but the slap-dash way
>>> upward compatibility was broken and the "water over the dam" slippery
>>> slope rationalizations that refuse to consider reverting.  "You" will 
>>> do
>>> it again in the future since you are declaring success here.  And  
>>> "you"
>>> have likely done it in the past 6 months.
>>
>> I don't think Junio is declaring success. In fact, I think he has sent
>> several messages saying (paraphrasing of course):
>
> I did not name anyone, and put "you" in quotes to try to not even imply I 
> was pointing at one person.  Several people have declared success, but 
> Junio wasn't one of them.  I think (?) that he was just the unwilling 
> gunman.  8)

Sorry, I thought you meant "the git community has put these bugs into
git" in the past 6 months. And I don't think that is true.

> I now have to TEST to find those crazy backwards-incompatibility bugs  
> before I can upgrade us to 1.6.0.  To test, I have to try to imagine what 
> I and others were assuming about git.  And this episode means that I can't 
> make any assumptions about the sanity of any changes since March, which is 
> the version I'm thinking of upgrading.
>
> But note that THIS upward compatibility bug has been declared to not be a 
> bug.  Will any others receive the same stamp?
>
> So please put on your engineer hat, and stop talking about "specious  
> claims" and hurting feelings.

My engineer hat _is_ on. Here is the logic that led to my use of the
phrase "specious claims":

  - you are claiming that there are backwards incompatibility changes
    lurking in git (or at least that is what I believe you to mean)

  - there has been _one_ such problem, and the person responsible for
    vetting such changes has solicited suggestions for doing better in
    the future. I don't think that is indicative of a pattern of such
    changes.

  - But let's say you have lost some faith in the git development
    process due to _this_ bug. But let's look at the history of this
    bug. It has been discussed several times for the past 2 years, along
    with a mention in the release notes several versions ago. It was not
    a surprise to anybody who has been developing git.

    So yes, maybe there _are_ other bugs just like it lurking. But
    wouldn't it stand to reason that those bugs have _also_ been
    discussed and mentioned in the release notes, or that the developers
    would know about them?

    In other words, I can see you losing enough faith to say "wow, the
    git developers don't communicate very well and I need to vet their
    changes and notes more carefully". I don't think it is reasonable to
    say that there are likely to be other, totally unknown backwards
    incompatible changes.

So

  1. I find your claim that such bugs exist to have little evidence to
     back it up.

  2. As an engineer, I have seen evidence of one problem (insufficient
     communication) but not of another (introduction of
     incompatibilities without on-list discussion). So I would choose to
     focus my resources on fixing the problem I have seen.

> Heck, I even got Linus himself to ask if us people were on drugs, and
> I didn't take it personally.  At least I'm saying something that can
> be disputed, and not ad hominem like Linus.  8)

Sorry, but I'm not impressed by your getting Linus to yell at you. It's
like shooting fish in a barrel. :)

> How to better notify them is to do it on a major release, like Git 2.0.  
> THEN, they expect upward compatibility to break.

Now that _is_ a reasonable suggestion. This change _did_ wait until the
jump to 1.6.0, which we thought of as a major version jump (just as 1.4
to 1.5 introduced a few minor but documented changes). I don't think
there is a plan for "git 2.0" short of serious incompatibilities in the
repo format (i.e., you can't use 2.x tools on 1.x repos and vice versa).
So perhaps our numbering should be more emphatic.

-Peff
