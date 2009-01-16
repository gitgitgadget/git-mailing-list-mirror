From: Petr Baudis <pasky@suse.cz>
Subject: Re: 'mail' link on http://repo.or.cz/w/git.git no workee?
Date: Fri, 16 Jan 2009 03:24:08 +0100
Message-ID: <20090116022408.GG12275@machine.or.cz>
References: <alpine.DEB.1.00.0901151651460.3586@pacific.mpi-cbg.de> <20090116015439.GF12275@machine.or.cz> <7vmydsovs5.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901160315170.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 16 03:25:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNeOw-0003Au-9O
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 03:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761554AbZAPCYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 21:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760818AbZAPCYM
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 21:24:12 -0500
Received: from w241.dkm.cz ([62.24.88.241]:57027 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756661AbZAPCYL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 21:24:11 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 770031E4C02D; Fri, 16 Jan 2009 03:24:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901160315170.3586@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105910>

On Fri, Jan 16, 2009 at 03:17:14AM +0100, Johannes Schindelin wrote:
> On Thu, 15 Jan 2009, Junio C Hamano wrote:
> 
> > Petr Baudis <pasky@suse.cz> writes:
> > 
> > >> That is, it links to marc (not gmane?) but finds no matches...
> > >
> > >   what mailing list post should it point to?
> 
> I found gmane to be much nicer to click through than marc.

IIRC I found no way to actually make a gmane link since it requires POST
query for the searches or something.

> > I think Dscho's point is that you shouldn't be generating these links 
> > that lead to nowhere ;-).
> 
> Almost.
> 
> I wondered what the point was, and I would _welcome_ links that pointed to 
> the mails containing the patches (identified either by patch ids or by 
> manual editing; best would be to have both methods at the same time).

Well, but you already have that, or at least an approximation. Do you
think the approximation is inadequate? I would expect linking to a
commit showing the inadequacy - I don't see how a false positive is
inadequate at all, actually; even if we had a separate database with the
mapping, for no records I think falling back to linking to a mailing
list search still makes more sense than showing no link.

I was not actually planning to carry the patch over the next gitweb
update since I got no feedback on it (IIRC) since I implemented it.

-- 
				Petr "Pasky" Baudis
The average, healthy, well-adjusted adult gets up at seven-thirty
in the morning feeling just terrible. -- Jean Kerr
