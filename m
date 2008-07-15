From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Closing the merge window for 1.6.0
Date: Tue, 15 Jul 2008 02:51:27 +0000
Message-ID: <20080715025127.GC1700@spearce.org>
References: <7vprpwhp7t.fsf@gitster.siamese.dyndns.org> <7vlk0ffhw3.fsf@gitster.siamese.dyndns.org> <7vtzf1w0rj.fsf@gitster.siamese.dyndns.org> <7vabgqsc37.fsf@gitster.siamese.dyndns.org> <7vtzetjbif.fsf@gitster.siamese.dyndns.org> <7vzlokhpk7.fsf@gitster.siamese.dyndns.org> <20080714085555.GJ32184@machine.or.cz> <alpine.DEB.1.00.0807141256310.8950@racer> <20080714124109.25414.qmail@06d015ec9c6744.315fe32.mid.smarden.org> <alpine.LFD.1.10.0807141351540.12484@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Gerrit Pape <pape@smarden.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Jul 15 04:52:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIaeS-0003VJ-EW
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 04:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754905AbYGOCv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 22:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754837AbYGOCv2
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 22:51:28 -0400
Received: from george.spearce.org ([209.20.77.23]:60137 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754068AbYGOCv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 22:51:28 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4057A3836B; Tue, 15 Jul 2008 02:51:27 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0807141351540.12484@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88505>

Nicolas Pitre <nico@cam.org> wrote:
> On Mon, 14 Jul 2008, Gerrit Pape wrote:
> 
> > On Mon, Jul 14, 2008 at 12:57:56PM +0100, Johannes Schindelin wrote:
> > > On Mon, 14 Jul 2008, Petr Baudis wrote:
> > > > I'm saying this because I believe the best conservative upper bound for 
> > > > backwards compatibility is Git version in Debian stable. It gets 
> > > > probably the most stale from all the widely used software distributions 
> > > > using Git, and it *is* quite widely used. Etch carries v1.4.4.4, which 
> > > > fails miserably on the new packs.
> 
> Maybe we can release 1.4.5 with the ability to read index v2?  That 
> wouldn't be hard to backport the reading part of it.

If we consider that supporting 1.4.4.4 clients is still a priority,
due to the widespread distribution of that version in a popular
version of Debian, we shouldn't be rushing the index v2 or OFS_DELTA
functionality on by default in 1.6.0.  Instead we would wait until
Debian stable (and most other widely popular distributions) are on
a modern enough version of Git to understand this format.

Really.  As much as I'd love to see the switch to v2 made by default
I don't think we can/should do it unless the majority of the user
base will be able to grok it.  And Debian etch sounds like it won't.

-- 
Shawn.
