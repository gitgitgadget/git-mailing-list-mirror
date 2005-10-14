From: Paul Eggert <eggert@CS.UCLA.EDU>
Subject: Re: [PATCH] Try URI quoting for embedded TAB and LF in pathnames
Date: Thu, 13 Oct 2005 17:57:21 -0700
Message-ID: <87ek6ork3y.fsf@penguin.cs.ucla.edu>
References: <7vu0ftyvbc.fsf@assigned-by-dhcp.cox.net>
	<20051007232909.GB8893@steel.home>
	<7vpsqgyjrj.fsf@assigned-by-dhcp.cox.net>
	<20051008064555.GA3831@steel.home>
	<7vachks7aq.fsf@assigned-by-dhcp.cox.net>
	<20051008133032.GA32079@localhost>
	<7v64s7svya.fsf@assigned-by-dhcp.cox.net>
	<7vu0frpxs1.fsf@assigned-by-dhcp.cox.net>
	<87mzlgh8xa.fsf@penguin.cs.ucla.edu>
	<Pine.LNX.4.64.0510110802470.14597@g5.osdl.org>
	<87ek6s0w34.fsf@penguin.cs.ucla.edu>
	<Pine.LNX.4.64.0510111121030.14597@g5.osdl.org>
	<87slv7zvqj.fsf@penguin.cs.ucla.edu>
	<Pine.LNX.4.64.0510111346220.14597@g5.osdl.org>
	<877jcjmdmq.fsf@penguin.cs.ucla.edu>
	<Pine.LNX.4.64.0510120749230.14597@g5.osdl.org>
	<87vf02qy79.fsf@penguin.cs.ucla.edu>
	<Pine.LNX.4.64.0510121355280.15297@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Robert Fitzsimons <robfitz@273k.net>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Kai Ruemmler <kai.ruemmler@gmx.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 02:58:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQDtM-00036Y-8K
	for gcvg-git@gmane.org; Fri, 14 Oct 2005 02:57:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbVJNA5i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Oct 2005 20:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932571AbVJNA5i
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Oct 2005 20:57:38 -0400
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:8864 "EHLO kiwi.cs.ucla.edu")
	by vger.kernel.org with ESMTP id S932197AbVJNA5h (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Oct 2005 20:57:37 -0400
Received: from penguin.cs.ucla.edu (Penguin.CS.UCLA.EDU [131.179.64.200])
	by kiwi.cs.ucla.edu (8.11.7p1+Sun/8.11.7/UCLACS-5.2) with ESMTP id j9E0vL425894;
	Thu, 13 Oct 2005 17:57:21 -0700 (PDT)
Received: from eggert by penguin.cs.ucla.edu with local (Exim 4.50)
	id 1EQDsv-0008IE-IQ; Thu, 13 Oct 2005 17:57:21 -0700
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510121355280.15297@g5.osdl.org> (Linus
 Torvalds's message of "Wed, 12 Oct 2005 14:05:25 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10095>

Linus Torvalds <torvalds@osdl.org> writes:

> I find that email is very robust - it's basically 8-bit clean. No 
> character encoding, no crap. Just a byte stream. It really _is_ the most 
> reliable format.

I found another amusing bit of info that tends to undercut this claim.

This discussion thread is archived at
<http://marc.theaimsgroup.com/?t=112877773400002&r=1&w=2&n=22>.
But there's an item missing from the archive: my message with
Message-ID <87vf02qy79.fsf@penguin.cs.ucla.edu>.  This is the message
with the joke "Aach!  Those Finns!  Always on the trailing edge of
technology!".

All my other messages are achived.  What was special about this
one?  Surely there's not a joke filter at theaimsgroup.com!

I nosed around through the archive and here's my guess as to what
happened.  My message's email header contained this:

   Content-Type: text/plain; charset=utf-8
   Content-Transfer-Encoding: quoted-printable

and my guess is that the web archiver can't handle that format.

This is just a guess.  I can't confirm it because (among other things)
the web archiver won't give me all the bytes of the messages that it
archives.  Even its "Download message RAW" doesn't do that: it omits
the header.  But I have a strong suspicion.  Let's put it this way: I
think mine was the only message in the thread that said
"charset=utf-8".

If my guess is right, the archiver dropped my email on the floor
simply because it contained UTF-8.  This is not a good sign for
putting UTF-8 into email, or for relying on email to transmit byte
streams.
