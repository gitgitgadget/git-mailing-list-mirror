From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Alternate revno proposal (Was: Re: VCS comparison table)
Date: Thu, 19 Oct 2006 07:45:56 +0200
Message-ID: <20061019054556.GB9403@artax.karlin.mff.cuni.cz>
References: <45346290.6050300@utoronto.ca> <200610171120.09747.jnareb@gmail.com> <1161078035.9020.73.camel@localhost.localdomain> <Pine.LNX.4.64.0610170921540.3962@g5.osdl.org> <1161124078.9020.88.camel@localhost.localdomain> <20061017191838.1c36499b.seanlkml@sympatico.ca> <20061017233305.GG20017@pasky.or.cz> <1161149200.3423.34.camel@localhost.localdomain> <20061018214623.GA32725@artax.karlin.mff.cuni.cz> <eh68va$7er$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 07:46:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaQjC-0000JD-3D
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 07:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbWJSFpv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 01:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030303AbWJSFpv
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 01:45:51 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:62394 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030270AbWJSFpu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 01:45:50 -0400
Received: by artax.karlin.mff.cuni.cz (Postfix, from userid 17196)
	id A42B54A86; Thu, 19 Oct 2006 07:45:56 +0200 (CEST)
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <eh68va$7er$1@sea.gmane.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29324>

On Thu, Oct 19, 2006 at 12:14:02AM +0200, Jakub Narebski wrote:
> Jan Hudec wrote:
> > Comments?
> 
> What about fetching from repository? For revnos you have to assign revno for
> all commit you have downloaded; now you need only to unpack received pack
> (or not, if you used --keep option). More work.

I don't know git internals, so I can't tell for git. For bzr:
1) You have to add the data to the knits, since the knits are one for
   each versioned file plus one for inventory and one for revision
   metadata, so this is just a small addition to that work. In fact the
   revnos in repository-wide case would be just the indices into the
   revisions knit (while in the branch-wide there would have to be a
   special list).
2) Bzr already generates a special list, revision-history, where it
   stores a list of mainline branches (in fact it used to store a list
   of local commits, but now lists the path over leftmost parents).
   So it already does the work.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
