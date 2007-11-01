From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Newbie: report of first experience with git-rebase.
Date: Thu, 1 Nov 2007 14:24:37 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711011423440.4362@racer.site>
References: <87d4uv3wh1.fsf@osv.gnss.ru> <20071031195702.GB24332@atjola.homenet>
 <874pg73u6h.fsf@osv.gnss.ru> <Pine.LNX.4.64.0710312111170.4362@racer.site>
 <7vhck7gdzs.fsf@gitster.siamese.dyndns.org> <87ve8m2mfn.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 15:25:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InazJ-0001RG-TT
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 15:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753940AbXKAOZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 10:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbXKAOZY
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 10:25:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:37451 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753837AbXKAOZX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 10:25:23 -0400
Received: (qmail invoked by alias); 01 Nov 2007 14:25:21 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp028) with SMTP; 01 Nov 2007 15:25:21 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+DjJgEpEyDfCpYEVpqQ3DLHEPHDhuU9LN1odNsyj
	mBPUnRQngQPjxv
X-X-Sender: gene099@racer.site
In-Reply-To: <87ve8m2mfn.fsf@osv.gnss.ru>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62965>

Hi,

On Thu, 1 Nov 2007, Sergei Organov wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> >> On Wed, 31 Oct 2007, Sergei Organov wrote:
> >>
> >>> Yes, and that's the problem. Why 'git --continue' didn't just skip this 
> >>> patch that *already became no-op* after conflict resolution and forced 
> >>> me to explicitly use 'git --skip' instead?
> >>
> >> Isn't that obvious?  To prevent you from accidentally losing a commit.
> >
> > In case it is not obvious...
> >
> > A rebase conflict resolution that results in emptiness is a
> > rather rare event (especially because rebase drops upfront the
> > identical changes from the set of commits to be replayed), but
> > it does happen.
> 
> Funny how 2 of my first 3 commits suffer from this "rather rare event",
> and it was not Friday, 13 ;)

They are rare events.  In your case I guess that subtly different versions 
were _actually_ applied (such as white space fixes), which is why such a 
rare event hit you.

Ciao,
Dscho
