X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS24867 82.211.80.0/20
X-Spam-Status: No, score=1.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_RECEIVED,MSGID_FROM_MTA_HEADER
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Path: news.gmane.org!not-for-mail
From: Jeff King <peff@peff.net>
Newsgroups: gmane.comp.version-control.bazaar-ng.general,gmane.comp.version-control.git
Subject: Re: VCS comparison table
Date: Wed, 25 Oct 2006 05:49:00 -0400
Message-ID: <20061025094900.GA26989@coredump.intra.peff.net>
References: <45354AD0.1020107@utoronto.ca>
	<BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE>
	<vpq4ptz2uh8.fsf@ecrins.imag.fr>
	<453DAC87.8050203@research.canon.com.au>
	<Pine.LNX.4.64.0610232318200.3962@g5.osdl.org>
	<Pine.LNX.4.64N.0610232336010.30334@attu2.cs.washington.edu>
	<Pine.LNX.4.64.0610240812410.3962@g5.osdl.org>
	<Pine.LNX.4.64N.0610241300450.8112@attu4.cs.washington.edu>
	<20061025084810.GA26618@coredump.intra.peff.net>
	<Pine.LNX.4.64N.0610250157470.3467@attu1.cs.washington.edu>
NNTP-Posting-Host: main.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: sea.gmane.org 1161769751 32019 80.91.229.2 (25 Oct 2006 09:49:11 GMT)
X-Complaints-To: usenet@sea.gmane.org
NNTP-Posting-Date: Wed, 25 Oct 2006 09:49:11 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
Original-X-From: bazaar-ng-bounces@lists.canonical.com Wed Oct 25 11:49:09 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcfNi-0001ZY-6u
	for gcvbg-bazaar-ng@m.gmane.org; Wed, 25 Oct 2006 11:49:06 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GcfNh-0007vd-D9; Wed, 25 Oct 2006 10:49:05 +0100
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]
	helo=peff.net) by esperanza.ubuntu.com with smtp (Exim 4.60)
	(envelope-from <peff@peff.net>) id 1GcfNe-0007vT-Vb
	for bazaar-ng@lists.canonical.com; Wed, 25 Oct 2006 10:49:03 +0100
Received: (qmail 28974 invoked from network); 25 Oct 2006 05:48:06 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
	by 66-23-211-5.clients.speedfactory.net with SMTP;
	25 Oct 2006 05:48:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation);
	Wed, 25 Oct 2006 05:49:00 -0400
To: David Rientjes <rientjes@cs.washington.edu>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0610250157470.3467@attu1.cs.washington.edu>
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Original-Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Xref: news.gmane.org gmane.comp.version-control.bazaar-ng.general:18745 gmane.comp.version-control.git:30043
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30043>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 25, 2006 at 02:19:15AM -0700, David Rientjes wrote:

> No, my criticism is against the added complexity which makes the 
> modification of git increasingly difficult with every new release.  It's a 

OK, you seemed to imply problems for end users in your first paragraph,
which is what I was responding to.

> _current_ needs.  For any experienced shell programmer it is so much 
> easier to go in and change an option or pipe to a different command or 
> comment out a simple shell command in a .sh file than editing the C code.  

Yes, it's true that some operations might be easier to play with in the
shell. However, does it actually come up that you want to modify
existing git programs? The more common usage seems to be gluing the
plumbing together in interesting ways, and that is still very much
supported.

> And sometimes it's necessary to have several different variations of that 
> command which is very easy with slightly renamed .sh files instead of 
> adding on more and more flags to commands that have become so complex at 
> this point that it's difficult to know the basics of how to manage a 
> project.

You can do the same thing in C. In fact, look at how similar
git-whatchanged, git-log, and git-diff are.

I don't understand how a C->shell conversion has anything to do with
options being added. If you look at all of the conversions, they
replicate the interface _exactly_.

> This all became very obvious when the tutorials came out on "how to use 
> git in 20 commands or less" effectively.  These tutorials shouldn't need 
> to exist with an information manager that started as a quick, efficient, 
> and _simple_ project.  You're treating git development in the same light 

Sorry, I don't see how this is related to the programming language _at
all_. Are you arguing that the interface of git should be simplified so
that such tutorials aren't necessary? If so, then please elaborate, as
I'm sure many here would like to hear proposals for improvements. If
you're arguing that git now has too many features, then which features
do you consider extraneous?

> as you treat Linux development; let's be honest and say that 99% of the 
> necessary git functionality was there almost a year ago and ever since 
> nothing of absolute necessity has been added that serious developers care 
> about in a revision control system.  Look at LKML, nobody is waiting on 

I don't agree with this. There are tons of enhancements that I find
useful (e.g., '...' rev syntax, rebasing with 3-way merge, etc) that I
think other developers ARE using. There are scalability and performance
improvements. And there are new things on the way (Junio's pickaxe work)
that will hopefully make git even more useful than it already is.

If you don't think recent git versions are worthwhile, then why don't
you run an old version? You can even use git to cherry-pick patches onto
your personal branch.

> Absolutely.  I think I've actually documented that fairly well.  Back in 

Where?

> the day git was a very concise, well-written package.  Today, a tour 
> through the source code for the latest release leaves a lot to be desired 
> for any serious C programmer.

I don't agree, but since you haven't provided anything specific enough
to discuss, there's not much to say.

> Functionality wise, no.  But in terms of being able to _customize_ my 
> version of git depending on how I want to use it, I've lost hope on the 
> whole idea.  It's a shame too because it appears as though the original 

Can you name one customization that you would like to perform now that
you feel can't be easily done (and presumably that would have been
easier in the past)?

-Peff



