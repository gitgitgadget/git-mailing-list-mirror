From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 2/1] gitweb: Use fixed string for "next" link in commitdiff view
Date: Tue, 24 Oct 2006 19:26:27 +0200
Message-ID: <20061024172627.GU18879@pasky.or.cz>
References: <200610230037.57183.jnareb@gmail.com> <7vd58k0wmx.fsf@assigned-by-dhcp.cox.net> <200610240008.08325.jnareb@gmail.com> <20061024114923.GD20017@pasky.or.cz> <7vu01thbvb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 19:27:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcQ2q-0000NF-9d
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 19:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030441AbWJXR03 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 13:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030444AbWJXR03
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 13:26:29 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41622 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030441AbWJXR03 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 13:26:29 -0400
Received: (qmail 16056 invoked by uid 2001); 24 Oct 2006 19:26:27 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu01thbvb.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29993>

On Tue, Oct 24, 2006 at 07:17:28PM CEST, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> >> > Would it even be necessary to use any SHA-1 name in these cases,
> >> > I wonder.  Would it make the page less useful if we replace all
> >> > of the above _commit_ with a fixed string, say, "parent"?
> >
> > I really disagree here - what's the point of not using SHA-1? The extra
> > string carries zero information in comparison with the previous state
> > and I just can't see how it *improves* stuff. If you're walking in a
> > maze and making marks on walls, it's still more useful if you have
> > corridors named by "A", "B", "C", "D" on junctions if you sometimes want
> > to walk back to the marked corridors.
> 
> I think people would recognize A B C D as names but not 40- or
> 8- hexadecimal letters.

40-digit hex numbers is insane, I agree. But at least I personally tend
to recognize 8-digit hex numbers when dancing around them intensively
for a few minutes. Besides, it can be just "now I took the 8c5 way",
which is much easier to train your neurons too than "now I took the
fourth, uh, or was it the fifth parent? one, two, three, four, fifth...
hmm, what's in the statusbar?".

My point is that this does not improve the situation, and some people
(me) think it makes it worse, so what's the point of the change?

> I do not care much either way, actually, but I think it might
> make more sense to use abbreviated object names.  On the other
> hand it may be Ok to have full 40 letters depending on the
> layout (e.g. the set of merge parents are shown on a single line
> in which case it would not fit, etc.).

Yes, I'm all for abbreviated names, but I'm against just writing
"parent" everywhere.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
