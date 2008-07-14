From: Nicolas Pitre <nico@cam.org>
Subject: Re: Closing the merge window for 1.6.0
Date: Mon, 14 Jul 2008 13:54:34 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0807141351540.12484@xanadu.home>
References: <7vod5kd3im.fsf@gitster.siamese.dyndns.org>
 <7v3amv1e8n.fsf@gitster.siamese.dyndns.org>
 <7vprpwhp7t.fsf@gitster.siamese.dyndns.org>
 <7vlk0ffhw3.fsf@gitster.siamese.dyndns.org>
 <7vtzf1w0rj.fsf@gitster.siamese.dyndns.org>
 <7vabgqsc37.fsf@gitster.siamese.dyndns.org>
 <7vtzetjbif.fsf@gitster.siamese.dyndns.org>
 <7vzlokhpk7.fsf@gitster.siamese.dyndns.org>
 <20080714085555.GJ32184@machine.or.cz>
 <alpine.DEB.1.00.0807141256310.8950@racer>
 <20080714124109.25414.qmail@06d015ec9c6744.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Mon Jul 14 19:55:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KISGu-00089S-TN
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 19:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415AbYGNRyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 13:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753888AbYGNRyg
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 13:54:36 -0400
Received: from relais.videotron.ca ([24.201.245.36]:56116 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352AbYGNRyg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 13:54:36 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K4000EQACEZ8RE0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 14 Jul 2008 13:54:35 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080714124109.25414.qmail@06d015ec9c6744.315fe32.mid.smarden.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88440>

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
> the bus.  We don't introduce new upstream versions into a Debian stable
> release, there's a great effort done for each stable release to reach
> high quality integration of all the software packages available in
> Debian.  Once that status is reached, only security fixes and criticial
> usability fixes are added.

Please consider it as a critical usability problem.

Maybe we can release 1.4.5 with the ability to read index v2?  That 
wouldn't be hard to backport the reading part of it.


Nicolas
