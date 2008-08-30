From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Sat, 30 Aug 2008 10:08:24 -0400 (EDT)
Message-ID: <alpine.DEB.1.10.0808301004010.28765@gandalf.stny.rr.com>
References: <BD6DEBB7-4D1C-43E9-B3D2-B46E42D9771D@cs.indiana.edu> <20080828090421.GQ10360@machine.or.cz> <18219E52-E56F-43D9-B28D-0CC74E225CC5@cs.indiana.edu> <alpine.LFD.1.10.0808280934160.3300@nehalem.linux-foundation.org> <7BC51BEC-E230-48C5-BD3E-2CECE3C7FC98@cs.indiana.edu>
 <20080828195211.GA3545@mithlond.arda.local> <4B9831F7-3CB8-49CB-A1DB-111481A271FE@cs.indiana.edu> <20080828212346.GA27867@coredump.intra.peff.net> <06844986-44BF-4B82-A45F-0781B3513409@wincent.com> <alpine.DEB.1.10.0808300916510.28765@gandalf.stny.rr.com>
 <20080830135012.GA3124@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Wincent Colaiuta <win@wincent.com>, Jeff King <peff@peff.net>,
	Perry Wagle <wagle@cs.indiana.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Petr Baudis <pasky@suse.cz>,
	Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Ulrich Windl <ulrich.windl@rz.uni-regensburg.DE>,
	Andi Kleen <andi@firstfloor.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Sat Aug 30 16:09:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZR8u-0008Gn-8Z
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 16:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbYH3OI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 10:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbYH3OI0
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 10:08:26 -0400
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:41126 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbYH3OI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 10:08:26 -0400
Received: from gandalf ([74.74.65.243]) by hrndva-omta01.mail.rr.com
          with ESMTP
          id <20080830140825.NBMB9451.hrndva-omta01.mail.rr.com@gandalf>;
          Sat, 30 Aug 2008 14:08:25 +0000
X-X-Sender: rostedt@gandalf.stny.rr.com
In-Reply-To: <20080830135012.GA3124@mithlond.arda.local>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94379>



On Sat, 30 Aug 2008, Teemu Likonen wrote:

> Steven Rostedt wrote (2008-08-30 09:24 -0400):
> 
> > But after getting use to the dash version, and having that go away,
> > makes me need to retrain myself to do things another way. This feels
> > more like losing a pet, and complaining about that. This is a much
> > more painful change than having to live with hordes of git commands.
> 
> Don't worry, you didn't lose your pet. You have actually two pets now 
> and it has become easier to play with both of them. Just shout
> 
>     PATH="$PATH:$(git --exec-path)"
> 
> and the older pet will come. However, it's preferred that you mostly 
> show the new one to your neighbours.

Heh, yeah, I saw this. I was just letting people know that the number of 
complaints do not always measure the level people are complaining about.

The complaint I did about seeing the 140 git-* commands was more of a 
knee-jerk reaction, as suppose to the complaint about git-* going away, 
which would have been something that would affect me every time I hit '-'. 

Remember, before Linus stated that the 'git --exec-path' is not going to 
be deprecated, that was soon to disappear too.

-- Steve
