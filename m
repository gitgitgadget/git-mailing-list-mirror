From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Controversial blob munging series
Date: Mon, 23 Apr 2007 20:49:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704232047480.8822@racer.site>
References: <11772221041630-git-send-email-junkio@cox.net>
 <Pine.LNX.4.64.0704231540580.8822@racer.site> <7vzm4zf1zx.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0704231933560.8822@racer.site> <7virbnexuc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 23 20:50:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg3cD-0000hp-SJ
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 20:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161383AbXDWSuT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 14:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161404AbXDWSuS
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 14:50:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:59710 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161383AbXDWSuR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 14:50:17 -0400
Received: (qmail invoked by alias); 23 Apr 2007 18:50:15 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp041) with SMTP; 23 Apr 2007 20:50:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+NwLEsMrqNxBsraamUhcA6ilxJyOz6Onne5tyzEB
	/swN48J3bb7ttB
X-X-Sender: gene099@racer.site
In-Reply-To: <7virbnexuc.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45352>

Hi,

On Mon, 23 Apr 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Mon, 23 Apr 2007, Junio C Hamano wrote:
> > ...
> >> ... I am inclined to think that this is quite fundamental.  I
> >> think you just fell into category who want "extended semantics"
> >> Linus talked about in $gmane/45214:
> >> 
> >>   I suspect that this gets some complaining off our back, but I *also* 
> >>   suspect that people will actually end up really screwing themselves with 
> >>   something like this and then blaming us and causing a huge pain down the 
> >>   line when we've supported this and people want "extended semantics" that 
> >>   are no longer clean.
> >> 
> >> which is kind of dissapointing.
> 
> I think this was the biggest worry.  If even Dscho, who is among
> a dozen people with the most intimate knowledge of git on the
> planet, gets it wrong, I can almost guarantee that we will get
> into the mess Linus predicted above.

Flattering always works :-)

> >> Even if you somehow solved the issue of "stat" rule, I do not
> >> know what your plans are to manage the blobs that you drop in
> >> the object store.  The list of object names in the mail-index
> >> file you are generating do not count as connectivity for the
> >> purpose of fetch/push/fsck/prune.
> >
> > I had the idea to update a ref, which holds "trees" of message-id -> blob 
> > pairs, and get updated at the same time.
> 
> I somehow thought this mailbox thing was because you wanted to
> transfer mailboxes across repositories.  How would you prevent
> that ref from getting out of sync with the mail-index file git
> knows nothing about its involvement in connectivity?

If your suspicion was that I did not really think it through, then you're 
correct. Of course, I would have transferred _all_ refs anyway, since the 
whole point of the exercise is to lose nothing.

However, I see where your argument is going.

Since Julian pointed out that there is a maildir patch for pine, I'll 
probably go for that one, since it is hanging lower.

Ciao,
Dscho
