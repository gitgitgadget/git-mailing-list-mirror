From: Gerrit Pape <pape@smarden.org>
Subject: Re: Closing the merge window for 1.6.0
Date: Mon, 14 Jul 2008 12:41:09 +0000
Message-ID: <20080714124109.25414.qmail@06d015ec9c6744.315fe32.mid.smarden.org>
References: <7vod5kd3im.fsf@gitster.siamese.dyndns.org> <7v3amv1e8n.fsf@gitster.siamese.dyndns.org> <7vprpwhp7t.fsf@gitster.siamese.dyndns.org> <7vlk0ffhw3.fsf@gitster.siamese.dyndns.org> <7vtzf1w0rj.fsf@gitster.siamese.dyndns.org> <7vabgqsc37.fsf@gitster.siamese.dyndns.org> <7vtzetjbif.fsf@gitster.siamese.dyndns.org> <7vzlokhpk7.fsf@gitster.siamese.dyndns.org> <20080714085555.GJ32184@machine.or.cz> <alpine.DEB.1.00.0807141256310.8950@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 14 14:42:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KINN3-0002sk-A0
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 14:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753229AbYGNMki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 08:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753238AbYGNMki
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 08:40:38 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:42933 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753007AbYGNMkh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 08:40:37 -0400
Received: (qmail 25416 invoked by uid 1000); 14 Jul 2008 12:41:09 -0000
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807141256310.8950@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88423>

On Mon, Jul 14, 2008 at 12:57:56PM +0100, Johannes Schindelin wrote:
> On Mon, 14 Jul 2008, Petr Baudis wrote:
> > I'm saying this because I believe the best conservative upper bound for 
> > backwards compatibility is Git version in Debian stable. It gets 
> > probably the most stale from all the widely used software distributions 
> > using Git, and it *is* quite widely used. Etch carries v1.4.4.4, which 
> > fails miserably on the new packs.
> 
> Can't we just hit Debian's Git maintainer with a clue bat or a bus, 

Please don't.  It wouldn't help, rather the opposite I think, espacially
the bus.  We don't introduce new upstream versions into a Debian stable
release, there's a great effort done for each stable release to reach
high quality integration of all the software packages available in
Debian.  Once that status is reached, only security fixes and criticial
usability fixes are added.

The freeze of the packages for the next stable release is planned a few
days from now, so it looks like Debian 'lenny' will include git 1.5.6.x.

Regards, Gerrit.
