From: Nicolas Pitre <nico@cam.org>
Subject: Re: epic fsck SIGSEGV!
Date: Wed, 10 Dec 2008 21:16:15 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812102110020.14328@xanadu.home>
References: <1228867861.14165.19.camel@starfruit.local>
 <7vd4g051ax.fsf@gitster.siamese.dyndns.org>
 <1228903606.4445.53.camel@starfruit.local> <493FAA5A.8070801@viscovery.net>
 <1228949523.27061.20.camel@starfruit.local>
 <alpine.LFD.2.00.0812101523570.3340@localhost.localdomain>
 <alpine.LFD.2.00.0812102031440.14328@xanadu.home>
 <7vskovwk99.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"R. Tyler Ballance" <tyler@slide.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 03:17:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAb7T-0006su-1V
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 03:17:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754298AbYLKCQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 21:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754286AbYLKCQV
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 21:16:21 -0500
Received: from relais.videotron.ca ([24.201.245.36]:20659 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780AbYLKCQV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 21:16:21 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KBO000V1WZ3WY60@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 10 Dec 2008 21:16:15 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vskovwk99.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102767>

On Wed, 10 Dec 2008, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > On Wed, 10 Dec 2008, Linus Torvalds wrote:
> >
> >> But we should definitely fix this braindamage in fsck. Rather than 
> >> recursively walk the commits, we should add them to a commit list and just 
> >> walk the list iteratively.
> >
> > What about:
> >
> > 	http://marc.info/?l=git&m=122889563424786&w=2
> 
> I have to dig that out of the mail archive (quoting message-id or $gmane
> article number would have been easier for me),

Message-ID: <20081210075338.GA7776@auto.tuwien.ac.at>

> but should I take it as an Ack from you?

I was involved in that thread initially, until bisection showed commit 
271b8d25b25e49b367087440e093e755e5f35aa9 as the culprit.  This might be 
the same issue but I have not experienced it myself.

So I'm merely only connecting email threads here.


Nicolas
