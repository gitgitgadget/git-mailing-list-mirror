From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fix parallel make problem
Date: Fri, 31 Aug 2007 17:11:43 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708311711210.28586@racer.site>
References: <20070830063810.GD16312@mellanox.co.il> <7v7inda5ar.fsf@gitster.siamese.dyndns.org>
 <20070830072748.GF16312@mellanox.co.il> <7vmyw85uml.fsf@gitster.siamese.dyndns.org>
 <20070831080651.GA17637@mellanox.co.il> <7vabs82kcq.fsf@gitster.siamese.dyndns.org>
 <20070831081517.GB17637@mellanox.co.il> <7v4pig2j91.fsf@gitster.siamese.dyndns.org>
 <20070831152120.GC17637@mellanox.co.il> <7vr6lj1zg3.fsf@gitster.siamese.dyndns.org>
 <20070831160043.GA1973@mellanox.co.il>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Fri Aug 31 18:11:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR96D-0007Ec-Mw
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 18:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757278AbXHaQLw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 12:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758042AbXHaQLw
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 12:11:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:45020 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756346AbXHaQLv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 12:11:51 -0400
Received: (qmail invoked by alias); 31 Aug 2007 16:11:50 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp031) with SMTP; 31 Aug 2007 18:11:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/zCIwg3TzztLrakICiRRSTsPBgVjfHV8vAimbgZ7
	I05FLESf6+dbv4
X-X-Sender: gene099@racer.site
In-Reply-To: <20070831160043.GA1973@mellanox.co.il>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57180>

Hi,

On Fri, 31 Aug 2007, Michael S. Tsirkin wrote:

> > Quoting Junio C Hamano <gitster@pobox.com>:
> > Subject: Re: [PATCH] fix parallel make problem
> > 
> > "Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:
> > 
> > >> > So how did this end up in your mail?
> > >> 
> > >> Because it is not a format-patch output.
> > >> 
> > >> I often run "git diff --stat -p HEAD" from inside MUA in order
> > >> to get the patch from my work tree, write a proposed commit
> > >> message, and then reset the change away without committing after
> > >> sending that message (yes I do not need "git stash" --- gmane
> > >> and vger are my stashes, Mwhhhaaaa).
> > >
> > > So maybe we can suppress the warning when the output is not a tty?
> > 
> > What's your point?
> 
> Well, git diff currently says "consider running git-status", and one
> wanders why doesn't it just go ahead and run git status instead
> of asking the user to do it.

I knew why I was opposed to that change.  But others shouted louder, I 
guess.

Ciao,
Dscho
