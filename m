From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 09:07:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610180855270.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<Pine.LNX.4.64.0610171605440.3962@g5.osdl.org>
	<45357411.20500@utoronto.ca>
	<200610180246.18758.jnareb@gmail.com> <45357CC3.4040507@utoronto.ca>
	<871wp6e7o9.wl%cworth@cworth.org> <45359B2A.1070102@utoronto.ca>
	<4535E844.8010604@op5.se> <20061018103220.GS75501@over-yonder.net>
	<45360DAE.8000702@op5.se> <20061018124320.GT75501@over-yonder.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: bazaar-ng@lists.canonical.com, Andreas Ericsson <ae@op5.se>,
	Carl Worth <cworth@cworth.org>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: bazaar-ng-bounces@lists.canonical.com Wed Oct 18 18:08:14 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaDxa-0000hC-EW
	for gcvbg-bazaar-ng@m.gmane.org; Wed, 18 Oct 2006 18:08:02 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GaDx8-0007wq-G4; Wed, 18 Oct 2006 17:07:34 +0100
Received: from smtp.osdl.org ([65.172.181.4])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <torvalds@osdl.org>) id 1GaDww-0007wE-Bx
	for bazaar-ng@lists.canonical.com; Wed, 18 Oct 2006 17:07:23 +0100
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9IG7GaX029801
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 Oct 2006 09:07:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9IG7Bg7007472;
	Wed, 18 Oct 2006 09:07:11 -0700
To: "Matthew D. Fuller" <fullermd@over-yonder.net>
In-Reply-To: <20061018124320.GT75501@over-yonder.net>
X-Spam-Status: No, hits=-0.471 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
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
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29242>



On Wed, 18 Oct 2006, Matthew D. Fuller wrote:

> On Wed, Oct 18, 2006 at 01:19:10PM +0200 I heard the voice of
> Andreas Ericsson, and lo! it spake thus:
> > 
> > It's just that we have this one place where gitweb is installed,
> > which management likes whereas devs don't have that on their laptop.
> > It's also convenient to have one place to find all changes rather
> > than pulling from 1-to-N different people just to have a look at
> > what they've done.
> 
> I think this just by itself lends support to:
> 
> > The point I'm trying to make here is that the star config might be
> > the most common case today because
> 
> c) Stars work well as a mental model for humans.

I really don't think that's even true.

Most projects do tend to have a star-like setup, but I think that's 
largely due to historical tools, not mental models. 

For example, I used CVS professionally for too long a few years ago, and 
the thing I _really_ hated was exactly how it forced people who were 
working on "experimental stuff" to be so tightly organized around the 
central repository (and how they had to do things that were visible and 
annoying to the mainline).

And I think that's where the "star-like" situation breaks down: when you 
have a group of people who go off to do something experimental. Suddenly 
the "mainline" in that case isn't the central and most important 
repository any more, and instead you really have another second (and 
third, fourth etc) "centerpoint" that another group works around.

Now, what does that mean? It means that whenever you look at a big project 
from the outside, you tend to see a star-like thing: there's the "big 
common thing", and you won't even be _seeing_ the off-shoots, because they 
tend to be used by developers to try out new ideas etc. So it looks like a 
star, but it really isn't, and shouldn't be.

An SCM should support the _developers_, not the users. The users don't 
need an SCM, they just need a place to fetch the "standard" thing 
(preferably with a vendor that supports them or at least makes them feel 
comfy). But an SCM really should support the off-shoots, because that's 
where the exciting stuff happens.

Btw, this is also why distribution is so fundamentally important:

Most of the off-shoots tend to be failures, but that is as it should be. 
Again, this is where SVN and CVS and other centralized models fail 
_miserably_. Because branches are in a centralized repository, the cost of 
failure is visible to all, and thus people don't like creating branches 
for things that don't look "obviously viable" to the people around the 
central repository.

In contrast, in a truly distributed environmen, a failed branch is 
something that people don't even KNOW about. Anybody can take the kernel 
git tree, start his own development line (with ten other people) and try 
to improve it. And if it fails, I'd never even know: there is literally 
_zero_ cost to everybody else from failed branches. And if they succeed, 
they'll just say "hey, pull this, it works, and it makes Xyz go five times 
faster".

		Linus
