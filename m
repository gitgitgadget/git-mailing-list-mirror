From: Petr Baudis <pasky@suse.cz>
Subject: Re: Closing the merge window for 1.6.0
Date: Mon, 14 Jul 2008 14:43:27 +0200
Message-ID: <20080714124327.GL10151@machine.or.cz>
References: <7vod5kd3im.fsf@gitster.siamese.dyndns.org> <7v3amv1e8n.fsf@gitster.siamese.dyndns.org> <7vprpwhp7t.fsf@gitster.siamese.dyndns.org> <7vlk0ffhw3.fsf@gitster.siamese.dyndns.org> <7vtzf1w0rj.fsf@gitster.siamese.dyndns.org> <7vabgqsc37.fsf@gitster.siamese.dyndns.org> <7vtzetjbif.fsf@gitster.siamese.dyndns.org> <7vzlokhpk7.fsf@gitster.siamese.dyndns.org> <20080714085555.GJ32184@machine.or.cz> <alpine.DEB.1.00.0807141256310.8950@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 14 14:44:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KINPo-0004Ff-Ah
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 14:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753287AbYGNMna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 08:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752969AbYGNMn3
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 08:43:29 -0400
Received: from w241.dkm.cz ([62.24.88.241]:47967 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752853AbYGNMn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 08:43:29 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 65D39393B31D; Mon, 14 Jul 2008 14:43:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807141256310.8950@racer>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88424>

  Hi,

On Mon, Jul 14, 2008 at 12:57:56PM +0100, Johannes Schindelin wrote:
> On Mon, 14 Jul 2008, Petr Baudis wrote:
> 
> > I'm saying this because I believe the best conservative upper bound for 
> > backwards compatibility is Git version in Debian stable. It gets 
> > probably the most stale from all the widely used software distributions 
> > using Git, and it *is* quite widely used. Etch carries v1.4.4.4, which 
> > fails miserably on the new packs.
> 
> Can't we just hit Debian's Git maintainer with a clue bat or a bus, 
> whichever is easier, and force them to upgrade _in_ Etch?  It's not like 
> we haven't had _several_ stable releases in-between.

  the whole point of having a stable distribution is that random version
upgrades don't happen under your hands; sure, 1.4.4.4 can have plenty of
bugs, but it's buggy in a well-defined way, which is better than upgrade
to newer stable version, which may be less buggy, but in a different
way; also, by upgrading to newer version you might find various subtle
compatibility issues, etc.

  Upgrading to newer version, *especially* if it's over then 1.4 - 1.5
boundary, is not something you could seriously expect Debian to do.
At least I actually _hope_ so, as a sysadmin of a network of 40 etch
workstations.

-- 
				Petr "Pasky" Baudis
GNU, n. An animal of South Africa, which in its domesticated state
resembles a horse, a buffalo and a stag. In its wild condition it is
something like a thunderbolt, an earthquake and a cyclone. -- A. Pierce
