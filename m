From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] BUG: git push on an empty clone segfaults.
Date: Mon, 20 Apr 2009 22:46:04 +0200
Message-ID: <20090420204604.GF8940@machine.or.cz>
References: <1240220930-24679-1-git-send-email-Matthieu.Moy@imag.fr> <7vfxg3ipib.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0904201252120.6955@intel-tinevez-2-302> <20090420135532.GC8940@machine.or.cz> <alpine.DEB.1.00.0904201629280.6771@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Nguy?n =?iso-8859-2?Q?Th=E1i?= Ng?c Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 20 22:47:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw0P7-0007wH-AL
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 22:47:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756504AbZDTUqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 16:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757213AbZDTUqI
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 16:46:08 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58110 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757092AbZDTUqH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 16:46:07 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id A9B05204C0C8; Mon, 20 Apr 2009 22:46:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0904201629280.6771@intel-tinevez-2-302>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117031>

On Mon, Apr 20, 2009 at 04:30:38PM +0200, Johannes Schindelin wrote:
> On Mon, 20 Apr 2009, Petr Baudis wrote:
> 
> > On Mon, Apr 20, 2009 at 12:55:10PM +0200, Johannes Schindelin wrote:
> > > I fetched from repo.or.cz and tested with 'master', and it was broken.  
> > > Apparently git://repo.or.cz/git.git is lagging behind by 5 days.  
> > > Pasky?
> > 
> >   yes, I noticed that the mirroring got hanging on some dead repository 
> > earlier today and restarted it, but it might take a while until a full 
> > mirror cycle refreshes everything.
> 
> I always wondered why it should make sense to have a mirror git.git, and 
> in addition a repository alt-git.git that Junio pushes to.
> 
> Maybe it is time to fix that?
> 
> I mean, I am hardly a Git newbie, and even I got burnt.

Sure, I can fix that, making alt-git.git a soft-link to git.git (or,
specifically, making refs/ and objects/ symlinks). Junio even might not
have to change his push scripts. ;-)

-- 
				Petr "Pasky" Baudis
The average, healthy, well-adjusted adult gets up at seven-thirty
in the morning feeling just terrible. -- Jean Kerr
