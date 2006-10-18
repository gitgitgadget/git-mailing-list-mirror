From: Petr Baudis <pasky@suse.cz>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 13:08:41 +0200
Message-ID: <20061018110841.GS20017@pasky.or.cz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <200610171555.56778.jnareb@gmail.com> <vpqr6x711cm.fsf@ecrins.imag.fr> <200610171641.04455.jnareb@gmail.com> <20061018000026.GH20017@pasky.or.cz> <45357596.8050702@utoronto.ca> <20061018003920.GK20017@pasky.or.cz> <845b6e870610180228m39829c49nf37e07e76e744250@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	bazaar-ng@lists.canonical.com, Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 18 13:09:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga9Hy-0003Nv-TJ
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 13:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbWJRLIn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 07:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbWJRLIn
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 07:08:43 -0400
Received: from w241.dkm.cz ([62.24.88.241]:18653 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030196AbWJRLIn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 07:08:43 -0400
Received: (qmail 9710 invoked by uid 2001); 18 Oct 2006 13:08:41 +0200
To: Erik B?gfors <zindar@gmail.com>
Content-Disposition: inline
In-Reply-To: <845b6e870610180228m39829c49nf37e07e76e744250@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29221>

Dear diary, on Wed, Oct 18, 2006 at 11:28:32AM CEST, I got a letter
where Erik B?gfors <zindar@gmail.com> said that...
> On 10/18/06, Petr Baudis <pasky@suse.cz> wrote:
> >Dear diary, on Wed, Oct 18, 2006 at 02:30:14AM CEST, I got a letter
> >where Aaron Bentley <aaron.bentley@utoronto.ca> said that...
> >> Petr Baudis wrote:
> >> > Another aspect of this is that Git (Linus ;) is very focused on getting
> >> > the history right, nice and clean (though it does not _mandate_ it and
> >> > you can just wildly do one commit after another; it just provides tools
> >> > to easily do it).
> >>
> >> Yes, rebasing is very uncommon in the bzr community.  We would rather
> >> evaluate the complete change than walk through its history.  (Bundles
> >> only show the changes you made, not the changes you merged from the
> >> mainline.)
> >>
> >> In an earlier form, bundles contained a patch for every revision, and
> >> people *hated* reading them.  So there's definitely a cultural
> >> difference there.
> >
> >BTW, I think what describes the Git's (kernel's) stance very nicely is
> >what I call the Al Viro's "homework problem":
> >
> >        http://lkml.org/lkml/2005/4/7/176
> >
> >If I understand you right, the bzr approach is what's described as "the
> >dumbest kind" there? (No offense meant!)
> 
> Yes and no, The bundle includes both the full final thing, and each
> step along the way. Each step along the way is something you'll get
> when you merge it.
> 
> Once merged, it will be "next one" in the description above. It would
> typically look something like this in "bzr log"(shortened)  In this
> example, doing C requires doing A and B as well...
> 
> committer: foobar@foobar.com
> message: merged in C
>      -------
>      committer: bar@bar.com
>      message: opps, fix bug in A
>      -------
>      committer: bar@bar.com
>      message: implement B
>      -------
>      committer: bar@bar.com
>      message: implement A
> 
> So, you'll get full history, including errors made :)  You can also
> see who approved it to this branch (foobar) and who did the actual
> work (bar)

I see, that's what I've been missing, thanks. So it's the middle path
(as any other commonly used VCS for that matter, expect maybe darcs?;
patch queues and rebasing count but it's a hack, not something properly
supported by the design of Git, since at this point the development
cannot be fully distributed).

I also assume that given this is the case, the big diff does really not
serve any purpose besides human review?

But somewhere else in the thread it's been said that bundles can also
contain merges. Does that means that bundles can look like:

   1
  / \
 2   4
 |   | _
 3   5  |
  \ /   | a bundle
   6    |
       ~

In that case, against what the big diff from 6 is done? 2? 4? Or even 1?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
