From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: clang static analyzer
Date: Mon, 7 Dec 2009 00:49:02 +0100
Message-ID: <20091206234902.GA12932@vidovic>
References: <33ABC714-2BCC-4910-BCAE-D331AAF2A724@dbservice.com> <20091206145744.GA6725@coredump.intra.peff.net> <alpine.LFD.2.00.0912061032380.31174@xanadu.home> <20091206160436.GA7140@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Tomas Carnecky <tom@dbservice.com>,
	git list <git@vger.kernel.org>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 07 00:49:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHQqu-00067h-Fk
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 00:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758028AbZLFXtC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 18:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757896AbZLFXtB
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 18:49:01 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:42437 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757895AbZLFXtA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 18:49:00 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1021582eyd.19
        for <git@vger.kernel.org>; Sun, 06 Dec 2009 15:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=92xB/L7uwSPHLTnh9AmkFdbhWEvlYkHUEMGD83NElcQ=;
        b=rtV0SHIZYAmYNvZoRph4tc3oF2b6FEX7MuVs0KQi/cRZVtL8tXM9TeY5gU/HWZH0cr
         Lylr9FARMmyOHh52k5wH/wkpW2ZwfNQj8Ji7o4PYHPCqTIrXSWwwBcs8IdM3EYRMvMrz
         NAmWUoKOyhTEZ/1kzCjIpR2NgEP9vaAWewO5s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fMROuRMux+XnwBPjTYo28BjYKpiuZPZgXaRSEJsNjSQpFQHUK+VVmAvohCK3plrnV5
         Zzh52pw4JsvJESh+VC6FdJWPyXxJSdIsnt7ZOuJdJzWDGdj9M+G14rpxXGZJbRnV9v6N
         tedF5SBdOflbesGnl0aZ7lVcQxpnt9cB5MR0I=
Received: by 10.213.37.76 with SMTP id w12mr653331ebd.84.1260143346227;
        Sun, 06 Dec 2009 15:49:06 -0800 (PST)
Received: from @ (88-121-121-28.rev.libertysurf.net [88.121.121.28])
        by mx.google.com with ESMTPS id 13sm3138968ewy.9.2009.12.06.15.49.04
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 06 Dec 2009 15:49:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091206160436.GA7140@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134695>

The 06/12/09, Jeff King wrote:
> On Sun, Dec 06, 2009 at 10:39:56AM -0500, Nicolas Pitre wrote:
> 
> > >   2. If it is a false positive, see what it would take to silence clang
> > >      and submit a patch.  I don't think we are opposed to annotations
> > >      that help analysis tools as long as those annotations aren't too
> > >      intrusive or make the code less readable.
> > 
> > I'm a bit skeptical here.  Going down that route might mean that we'll 
> > eventually have to add all sort of crap to accommodate everyone's 
> > preferred static analysis tool of the day.  Would be far nicer to try to 
> > make those tools more intelligent instead, or at least make them 
> > understand an out-of-line annotation format that does not clutter the 
> > code itself.
> 
> To be clear, I am a bit skeptical, too. 

Me too. I have no idea about how clang works but if there are enough
work done to support such a tool in the code itself, it would be sad to
not share and promote this work. If Junio cares enough himself, he could
set up a public dedicated branch. Now if he doesn't, it's not necessary
at all. Tomas or anyone else with enough time and motivation can fork
the repository for this purpose.

The latter option would be good and appreciated by everybody here, I
think.

-- 
Nicolas Sebrecht
