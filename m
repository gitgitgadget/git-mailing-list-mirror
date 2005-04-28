From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: A shortcoming of the git repo format
Date: Wed, 27 Apr 2005 17:57:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504271722260.18901@ppc970.osdl.org>
References: <200504272049.NAA14598@emf.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: hpa@zytor.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 02:50:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQxEK-0001xp-5Y
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 02:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbVD1Azc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 20:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbVD1Azc
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 20:55:32 -0400
Received: from fire.osdl.org ([65.172.181.4]:45253 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262135AbVD1AzM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 20:55:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3S0t9s4005588
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 27 Apr 2005 17:55:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3S0t8fB021636;
	Wed, 27 Apr 2005 17:55:08 -0700
To: Tom Lord <lord@emf.net>
In-Reply-To: <200504272049.NAA14598@emf.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 27 Apr 2005, Tom Lord wrote:
> 
> I think one has to understand Linus' posts as coming from the
> "head-down, steaming ahead for *MY* project cause you all suck"
> perspective and impose corresponding filters on his declarations of
> "LAW".

I'm really being very head-strong on these things, and much more so than I
normally am, because quite frankly, I see "git" as a very different
project from Linux.

(Which is not to say that I'm not opinionated even normally, but I'm 
normally a bit more open to listen to other people ;)

There's two huge differences between git and Linux, and I'm really sorry
if they make me act as an asshole, but they are important to me:

 - with Linux, lots of people know what the "right thing" is, because the 
   UNIX mindset has really been a kind of "social background" that has 
   been around for long enough that it has institutionalized knowledge
   about what an OS is supposed to do.

   This means that in 99% of all technical discussions about the kernel, 
   people are already coming at the problem roughly from the same 
   stand-point. It's not _universally_ true, but I really think that the 
   institutionalized (but not always conscious) philosophy of UNIX is what 
   has made it a lot easier to talk about almost all kernel issues,
   because people have generally the same expectations of what is "good".

   Doing development is a lot about communication. Writing code in many 
   ways is secondary - it's much more important to try to make sure that 
   everybody knows what the goals are, because the _real_ pain in 
   development ends up being not the coding, but the much more fundamental 
   disagreements that happen when people really have totally different 
   expectations of what the end result is going to be.

   SCM's don't have this. Quite the reverse. I see 30 years of "CVS" being 
   the common language for a lot of people, and the fact is, most of the
   people on this mailing list probably never _really_ used BK, and do not
   really understand very deeply about how the distributed model actually 
   ends up workign in _practice_.

   I think a lot of people understand it intellectually, but I really do 
   think that we're lackign the kind of "institutionalized" knowledge
   where people understand things at a much more visceral level.

 - With Linux, I never had something I needed to get _done_. Even when I 
   started, it was just for fun, and by the time others joined in, the 
   system already did much more than I initially envisioned, so everything 
   was really "gravy".

   With git, this isn't the case. The _only_ reason I started git in the 
   first place is that I knew better than pretty much anybody else what my
   needs were, and I was forced to act on them because nothing out there 
   really solved the problem for me.

In other words: I _know_ that I've been unpleasant. I'm sorry about that, 
but I am trying to explain _why_ I'm being an asshole about things, more 
so than I usually am.

I'm not actually all that interested in SCM's. I'd have been much happier
if I never had to start doing git in the first place. But circumstances
not only forced me to do my own, it also so happens that I don't believe
that there are many people around that have ever really _seen_ what my
kind of development requirements are.

What does that boil down to? It means, for example, that to me it doesn't
matter one _whit_ if you've been doing SCM's for the last thirty years,
and you can do xdelta algorithms in your sleep.

Quite the reverse: such a person "knows" a lot of things, but I'm pretty
damn sure that such a person has _never_ actually worked on a system that
works the way the kernel development does, which means that most of the
things that person "knows" are things that may need to be un-learnt.

And because I don't actually _care_ about SCM's, and only care about
getting to the point where I (once more) don't have to even think about
the SCM that I use for the kernel, I also don't have much incentive to
worry about CM models that may well be very valid outside of kernel work.

See? When it comes to my Linux work, I'm very inclusive. Linux already
does everything _I_ need it to do, so in many ways, all that really
motivates me to improve it are really about other peoples needs, and as
such, I'm really really interested in what _other_ people want. I still
say "no, that's now how we do things", but that's much less contentious.

In contrast, with git, I'm totally uninterested in anything that doesn't
make my kernel work go faster or more smoothly, and does so _today_. Which 
makes me a cantancerous old bastard, and bit the heads off anybody who 
isn't focused on that one thing.

And I really _am_ sorry. I don't actually _like_ being nasty about these 
things. But when it comes to git, I have one motivation, and one 
motivation only, and being nice about it isn't going to help. 

The good news? I actually think my needs are very basic. Once gits gets to 
the point where it does what I need it to do, I don't really have any 
motivation to say "this is how we do it" any more. And I think we're 
actually getting to that point fairly soon. That's not saying git is 
"done", any less than Linux was "done" in 1992. It's just that at that 
point I don't have any reason to be a nasty control freak any more.

In fact, I don't see myself even maintaining the project, especially since
there seem to be others that are more motivated to do so than I am. Then
I'll just go back into my dark kernel cave, and hopefully I don't have to
come out again for a while.

But for now, the _only_ point of git is as a kernel maintenance tool. 
There are tons of other SCM systems that are probably better for other 
projects, so if git is "just another SCM project", then git is totally 
pointless. So for now, the absolutely _only_ thing that matters for git 
design (as far as I'm concerned) is "how well does it suit Linus".

			Linus
