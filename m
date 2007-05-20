From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Teach mailsplit about Maildir's
Date: Sun, 20 May 2007 20:53:32 +0200
Message-ID: <200705202053.32291.johan@herland.net>
References: <20070520181447.GA10638@ferdyx.org>
 <7v7ir3mjfa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	"Fernando J. Pereda" <ferdy@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 20 20:53:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpqXK-0006l7-Oc
	for gcvg-git@gmane.org; Sun, 20 May 2007 20:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754980AbXETSxl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 14:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755066AbXETSxl
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 14:53:41 -0400
Received: from smtp.getmail.no ([84.208.20.33]:38695 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755065AbXETSxl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 14:53:41 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JIC00103SHBFO00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 20 May 2007 20:53:35 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIC00KPQSH8VJ30@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 20 May 2007 20:53:33 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIC001V3SH8SP90@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 20 May 2007 20:53:32 +0200 (CEST)
In-reply-to: <7v7ir3mjfa.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47886>

On Sunday 20 May 2007, Junio C Hamano wrote:
> "Fernando J. Pereda" <ferdy@gentoo.org> writes:
> 
> > Signed-off-by: Fernando J. Pereda <ferdy@gentoo.org>
> > ---
> >
> > 	I never got ACK or NACK when I sent it the first time, that's why
> > 	I'm resending this one with (almost) no changes.
> 
> Sorry, I had a (n obviously false) impression that you retracted
> this patch due to this:
> 
> > ...
> > +IMPORTANT: Maildir splitting relies upon filenames being sorted to output
> > +patches in the correct order.
> 
> I am sure there are many users who uses Maildir layout on this
> list.  Happy with this patch?  Please speak out.

I use KMail with Maildir for all my mail, except for my "patches" mail folder 
where I copy patches to import into my repos (which is in mbox format). 
KMail makes it easy to mix mbox and Maildir folders, so it's not really a 
big deal for me, but I would of course prefer Maildir support if it's 
possible to get it right.

Not sure how I feel about the usefulness of the patch if it requires correct 
sorting, and most mail clients turn out to _not_ sort correctly. Of course 
I have no idea what most mail clients do, but KMail seems to get it about 
right, AFAICS (mail filename starts with timestamp, so they're at least 
sorted roughly on (arrival) date).


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
