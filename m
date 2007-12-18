From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] provide advance warning of some future pack default changes
Date: Tue, 18 Dec 2007 09:16:20 -0500 (EST)
Message-ID: <alpine.LFD.0.999999.0712180909140.8467@xanadu.home>
References: <7vsl2jh3rb.fsf@gitster.siamese.dyndns.org>
 <46a038f90712171952i4f53876fv55b0e6993d5f4b0a@mail.gmail.com>
 <7vlk7s38aq.fsf@gitster.siamese.dyndns.org>
 <200712181024.52495.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Joel Becker <Joel.Becker@oracle.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 15:16:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4dFe-0007QU-Ar
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 15:16:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755771AbXLROQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 09:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755391AbXLROQX
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 09:16:23 -0500
Received: from relais.videotron.ca ([24.201.245.36]:26391 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbXLROQW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 09:16:22 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JT900L930Z8V3B0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 18 Dec 2007 09:16:21 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <200712181024.52495.jnareb@gmail.com>
User-Agent: Alpine 0.999999 (LFD 847 2007-12-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68750>

On Tue, 18 Dec 2007, Jakub Narebski wrote:

> Junio C Hamano wrote:
> > "Martin Langhoff" <martin.langhoff@gmail.com> writes:
> > 
> >> If cvs 1.11 doesn't talk with 1.12 I'll say there are nuts - minor
> >> revisions should interoperate with end users not even thinking about
> >> it. But 1.5.5 has in its changelog lots of deprecations and interop
> >> changes.
> >>
> >> It's not good communication to label it 1.5.5.
> > 
> > There indeed are handful scheduled removals.  I do not mind declaring
> > that 1.6.0 comes after 1.5.4, or just relabel the removal schedule for
> > 1.6.0 and keep the scheduled change on hold a bit longer.

I think Git development is dynamic enough to justify 1.6.0 right after 
1.5.4.

> By the way, I wonder if there would be packv4 in time for 1.6.0;
> perhaps not enabled by default.

I don't think so.  First, if packv4 actually happens, it might justify 
v2.0.0 and not v1.6.0.

But so far there were steady improvement made to the system even with 
the current pack format, so the return on the investment for packv4 is 
diminishing.  The largest road block for packv4 at the moment is a 
complete refactoring of the tree walking code.


Nicolas
