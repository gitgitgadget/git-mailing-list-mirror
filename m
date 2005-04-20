From: David Roundy <droundy@abridgegame.org>
Subject: Re: [darcs-devel] Darcs and git: plan of action
Date: Wed, 20 Apr 2005 07:18:51 -0400
Message-ID: <20050420111847.GF29945@abridgegame.org>
References: <7ivf6lm594.fsf@lanthane.pps.jussieu.fr> <20050418122011.GA13769@abridgegame.org> <7iy8bf7fh2.fsf@lanthane.pps.jussieu.fr> <20050419110407.GB28269@abridgegame.org> <7i4qe3x8ig.fsf@lanthane.pps.jussieu.fr> <20050419122518.GD12757@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>,
	darcs-devel@darcs.net, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 20 13:20:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DODF3-00011a-5b
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 13:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVDTLXw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 07:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVDTLXw
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 07:23:52 -0400
Received: from user-10mt71s.cable.mindspring.com ([65.110.156.60]:60992 "EHLO
	localhost") by vger.kernel.org with ESMTP id S261338AbVDTLXu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 07:23:50 -0400
Received: from droundy by localhost with local (Exim 4.50)
	id 1DODEJ-0000Zv-MU; Wed, 20 Apr 2005 07:18:51 -0400
To: Petr Baudis <pasky@ucw.cz>
Mail-Followup-To: Petr Baudis <pasky@ucw.cz>,
	Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>,
	darcs-devel@darcs.net, Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050419122518.GD12757@pasky.ji.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 19, 2005 at 02:25:18PM +0200, Petr Baudis wrote:
> Dear diary, on Tue, Apr 19, 2005 at 02:20:55PM CEST, I got a letter
> where Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr> told me that...
> > > The problem is that there is no sequence of alien versions that one
> > > can differentiate.  Git has a branched history, with each version
> > > that follows a merge having multiple parents.
> > 
> > Yep.  I've just realised that this morning.  Is there some notion of
> > ``primary parent'' as in Arch?  Can a changeset have 0 parents?
> 
> Yes, the root commit. Usually, there is only one, but there may be
> multiple of them theoretically.

Incidentally (and completely off-topic for this thread), wouldn't there be
a sha1 tree hash corresponding to a completely empty directory, and
couldn't one use that as the parent for the root? Would there be any reason
to do so? Just a silly thought...
-- 
David Roundy
http://www.darcs.net
