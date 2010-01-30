From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 23:39:25 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001292305500.1681@xanadu.home>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
 <7vaavwh6yh.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001291833580.1681@xanadu.home>
 <7vy6jgcutb.fsf@alter.siamese.dyndns.org>
 <fabb9a1e1001291618m71f61209v4f26fb66c6ad99ae@mail.gmail.com>
 <7viqakcu56.fsf@alter.siamese.dyndns.org>
 <ca433831001291701m50b8c2b7p16bcc6fd4f3f3d55@mail.gmail.com>
 <alpine.LFD.2.00.1001292013150.1681@xanadu.home>
 <ca433831001291840o751fa02eve1ae301537674325@mail.gmail.com>
 <alpine.LFD.2.00.1001292208470.1681@xanadu.home>
 <ca433831001291959m76ed6adap32a17c10e465af1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_QGNQf8lRwRLQkqtItimMhA)"
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>, Ron1 <ron1@flownet.com>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 05:39:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb57N-0002Bm-GW
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 05:39:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477Ab0A3Ej1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 23:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476Ab0A3Ej1
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 23:39:27 -0500
Received: from relais.videotron.ca ([24.201.245.36]:57359 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046Ab0A3Ej1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 23:39:27 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KX1004PKM9PECG0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 29 Jan 2010 23:39:25 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <ca433831001291959m76ed6adap32a17c10e465af1f@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138439>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_QGNQf8lRwRLQkqtItimMhA)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Fri, 29 Jan 2010, Mark Lodato wrote:

> On Fri, Jan 29, 2010 at 10:11 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Fri, 29 Jan 2010, Mark Lodato wrote:
> >> On Fri, Jan 29, 2010 at 8:22 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> >> > On Fri, 29 Jan 2010, Mark Lodato wrote:
> >> >
> >> >> Still, I find it slightly confusing and unfriendly.  How about the following?
> >> >
> >> >> Checking out commit 'master^0'.
> >> >>
> >> >> Since this is not a local branch head, any commits you make will be lost
> >> >> when you check out another branch or commit.  (In git terminology, HEAD
> >> >> is detached.)  If you just wish to look at files without committing,
> >> >> this is fine.  If you wish to make commits and retain them, you may
> >> >> create a new branch by running:
> >> >>
> >> >>   git checkout -b <new_branch_name>
> >> >
> >> > This gives the impression that any commit you make on a detached HEAD
> >> > are going to be lost, unless you create a new branch first.
> >>
> >> What about "...you may want to create..."?  This does not imply that
> >> creating a new branch now is the *only* way, just the most likely.  If
> >> a user knows another way, that user probably does not need this
> >> warning in the first place.
> >
> > Still, you don't know what way the unsuspected user will take to get
> > there.
> 
> Sorry, I don't understand.  What do you mean by "take to get there"?
> Are you referring to how the user arrived in this detached HEAD state,

Yes.

> or what the user wishes to do next?  Either way, I still am not sure
> why this wording is no good.  Could please elaborate?

First, I'm afraid that "Checking out commit 'foobar'" might be confusing 
as this may happen through either a remote branch, a tag, or any random 
commit.  It seems to me that "Checking out 'v2.5'" is less confusing 
than "Checking out commit 'v2.5'".  But that's a minor detail and 
probably a personal preference.

>   Note: 'master^0' isn't a local branch head;
> 
> This isn't very friendly.  It sounds like an admonition.  Rather, I
> suggest that the first sentence be similar to, but distinct from,
> "Switched to branch foo," to inform the user that they did something
> different, which may or may not be intentional.

I consider that starting the explanation paragraph with " any commits 
you make will be lost" is even more unfriendly, and misleading.  That is 
sure to scare people needlessly.

>   You are in 'detached HEAD' state. You can look around, make experimental
>   changes and commit them, and you can discard any commits you make in this
>   state without impacting any branches by checking out another branch.
> 
> First, we shouldn't start off with the term "detached HEAD".  I used a
> parenthetical comment to mention it, in case the user wants to look it
> up or refer to this state.  Otherwise, the term conveys no meaning,
> unless one understand enough about git to not need this advice.

To the contrary: this "detached HEAD" is exactly what you need if you 
want to relate to any documentation or perform a search for more 
information.  Like it or not, this detached HEAD term is exactly what 
this Git concept is all about and how it is designated everywhere.  The 
sooner Git users see and learn about it the better.

> Second, this advice should be a warning that commits may be lost
> unless one knows what one is doing.  Saying "you can discard commits"
> makes it sound like a feature!  Sure, that may be so for advanced
> users, but for beginners (for whom this advice is intended), this is a
> common trap.  I tried to word the advice so that the users will know
> that they should not commit without first creating a branch (or
> knowing what they're doing), but that if they don't commit, there's no
> problem.  The wording quoted above does not convey this meaning to me.

I think your wording is just too far on the negative side, and makes Git 
look like an even more difficult tool than it actually is.  And you help 
no one by stating things that are not exactly true even if the truth 
implies that you need to know what you're doing.  The _whole_ and only 
point of a detached HEAD is actually to be able to make commits even 
without having to create a new branch first.

> This discussion brings up another good point: The main worry about a
> detached head is losing commits.  Back in 2008, it was suggested to
> have a warning when committing on a detached HEAD:
> 
> http://kerneltrap.org/mailarchive/git/2008/9/2/3169744
> 
> This was before the advice system, so folks complained about it
> getting in the way, and it was never implemented.  Since we now have a
> way to easily turn off the warning, perhaps we should bring this topic
> up again (probably as a separate thread.)

Possibly.  I don't like the message proposed in that patch though.  
Since the warning when actually detaching HEAD is about to become way 
more prominent, the per-commit warning doesn't have to be that noisy 
anymore.


Nicolas

--Boundary_(ID_QGNQf8lRwRLQkqtItimMhA)--
