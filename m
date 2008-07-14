From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Closing the merge window for 1.6.0
Date: Mon, 14 Jul 2008 13:56:19 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807141354310.8950@racer>
References: <7vod5kd3im.fsf@gitster.siamese.dyndns.org> <7v3amv1e8n.fsf@gitster.siamese.dyndns.org> <7vprpwhp7t.fsf@gitster.siamese.dyndns.org> <7vlk0ffhw3.fsf@gitster.siamese.dyndns.org> <7vtzf1w0rj.fsf@gitster.siamese.dyndns.org> <7vabgqsc37.fsf@gitster.siamese.dyndns.org>
 <7vtzetjbif.fsf@gitster.siamese.dyndns.org> <7vzlokhpk7.fsf@gitster.siamese.dyndns.org> <20080714085555.GJ32184@machine.or.cz> <alpine.DEB.1.00.0807141256310.8950@racer> <20080714124109.25414.qmail@06d015ec9c6744.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Mon Jul 14 14:58:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KINcG-0001Z3-9g
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 14:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753113AbYGNM4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 08:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753103AbYGNM4V
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 08:56:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:39709 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752959AbYGNM4U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 08:56:20 -0400
Received: (qmail invoked by alias); 14 Jul 2008 12:56:18 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp007) with SMTP; 14 Jul 2008 14:56:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/dcN8x+UbdBB4OdfZ4ntCjryIDdRxr77M6RjOmi2
	pv+cnyyAOa6JrA
X-X-Sender: gene099@racer
In-Reply-To: <20080714124109.25414.qmail@06d015ec9c6744.315fe32.mid.smarden.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88426>

Hi,

On Mon, 14 Jul 2008, Gerrit Pape wrote:

> On Mon, Jul 14, 2008 at 12:57:56PM +0100, Johannes Schindelin wrote:
> > On Mon, 14 Jul 2008, Petr Baudis wrote:
> > > I'm saying this because I believe the best conservative upper bound for 
> > > backwards compatibility is Git version in Debian stable. It gets 
> > > probably the most stale from all the widely used software distributions 
> > > using Git, and it *is* quite widely used. Etch carries v1.4.4.4, which 
> > > fails miserably on the new packs.
> > 
> > Can't we just hit Debian's Git maintainer with a clue bat or a bus, 
> 
> Please don't.  It wouldn't help, rather the opposite I think, espacially
> the bus.

Heh.  It was a feeble attempt at humor production ;-)

> We don't introduce new upstream versions into a Debian stable release, 
> there's a great effort done for each stable release to reach high 
> quality integration of all the software packages available in Debian.  
> Once that status is reached, only security fixes and criticial usability 
> fixes are added.

If that is the case, we might need to think about fixing that segmentation 
fault to 1.4.4.5...  Which would be a minor pain in the donkey, I guess.

> The freeze of the packages for the next stable release is planned a few 
> days from now, so it looks like Debian 'lenny' will include git 1.5.6.x.

>From my memories of IRC, it seems that quite a few people do not even 
consider upgrading.

Ciao,
Dscho
