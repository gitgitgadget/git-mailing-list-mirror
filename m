From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-daemon and hook output
Date: Fri, 24 Oct 2008 13:42:44 -0700
Message-ID: <20081024204243.GE14786@spearce.org>
References: <20081024050713.GA21548@kodama.kitenet.net> <20081024203943.GV26961@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Oct 24 22:44:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtTVm-0007fX-1M
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 22:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753673AbYJXUmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 16:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753623AbYJXUmp
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 16:42:45 -0400
Received: from george.spearce.org ([209.20.77.23]:54373 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845AbYJXUmo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 16:42:44 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 261B43835F; Fri, 24 Oct 2008 20:42:44 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081024203943.GV26961@genesis.frugalware.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99065>

Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Fri, Oct 24, 2008 at 01:07:13AM -0400, Joey Hess <joey@kitenet.net> wrote:
> > I ran into this in a real-world application -- I'm implementing
> > anonymous pushes into ikiwiki, which are checked pre-receive to limit
> > them to changes that could be done via the web interface. So all my nice
> > error messages about why a commit is refused are not available, which is
> > a pity.
> 
> I think the recommended protocol even for anonymous push is ssh, at
> least that's what repo.or.cz uses for the 'mob' user, which is
> equivalent to anonymous, AFAIK.

Nah.  git:// supports anonymous push.  For some applications its
just what people want.  I say the original change is worthwhile;
expose the remote address and let a hook do logging and/or denials
based on its own logic.

-- 
Shawn.
