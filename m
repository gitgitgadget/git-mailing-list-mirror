From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] Add for_each_remote() function, and extend
 remote_find_tracking()
Date: Tue, 10 Jul 2007 20:28:58 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707102026010.4047@racer.site>
References: <Pine.LNX.4.64.0707062252390.4093@racer.site>
 <7vhcof2rur.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707081336020.4248@racer.site>
 <7vzm2620wp.fsf@assigned-by-dhcp.cox.net> <46919692.5020708@gnu.org>
 <7vhcoexqeh.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707091228290.5546@racer.site>
 <7v4pkduw2f.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707092203100.5546@racer.site>
 <7vzm25tex6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707100401070.4131@racer.site>
 <7vy7hosv7v.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707101848050.4047@racer.site>
 <7vtzscqf2r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 10 21:36:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8LVt-0002pX-Bc
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 21:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756176AbXGJTgm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 15:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752044AbXGJTgm
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 15:36:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:60843 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756153AbXGJTgl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 15:36:41 -0400
Received: (qmail invoked by alias); 10 Jul 2007 19:36:39 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp002) with SMTP; 10 Jul 2007 21:36:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18SOvRgkoMS6g1BF3yekTxbx7dcLGnximIBORxyt1
	JIv3fegKFY6NNv
X-X-Sender: gene099@racer.site
In-Reply-To: <7vtzscqf2r.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52108>

Hi,

On Tue, 10 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > The function for_each_remote() does exactly what the name suggests.
> >
> > The function remote_find_tracking() was extended to be able to search
> > remote refs for a given local ref.  You have to set the parameter
> > "reverse" to true for that behavior.
> 
> The updated patch does not use "reverse" but the old description
> is still there.

Urgh. Right. May I ask you to paste this instead?

The function remote_find_tracking() was extended to be able to search 
remote refs for a given local ref.  You have to set either src or dst in 
the refspec, and remote_find_tracking() will fill in the other and return 
0.

> Daniel, one thing I fear about your "I want to store the message
> in the object store so that I can reuse even after I re-polish
> the series" desire on the cover letter topic is this kind of
> gotcha, and that is why I suggested "*** BLURB GOES HERE ***".

I am happy that my fsckup served a purpose, then.  (And maybe this would 
be a good hint in rebase -i's man page, too, since that is how the error 
was introduced here.)

Ciao,
Dscho
