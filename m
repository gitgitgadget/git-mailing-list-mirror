From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] TopGit v0.3
Date: Mon, 22 Sep 2008 17:27:12 +0200
Message-ID: <20080922152712.GN10360@machine.or.cz>
References: <20080909231009.GD10544@machine.or.cz> <1221120192.8962.7.camel@heerbeest> <20080912110017.GW10360@machine.or.cz> <1221222433.29747.8.camel@heerbeest> <20080912131530.GZ10360@machine.or.cz> <20080912181442.GA5407@lapse.rw.madduck.net> <1221648520.30402.12.camel@heerbeest> <20080921142445.GJ10360@machine.or.cz> <1222074825.6698.13.camel@heerbeest>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: martin f krafft <madduck@madduck.net>, git@vger.kernel.org
To: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
X-From: git-owner@vger.kernel.org Mon Sep 22 17:28:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhnKs-0000OO-Ah
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 17:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645AbYIVP1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 11:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752638AbYIVP1Q
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 11:27:16 -0400
Received: from w241.dkm.cz ([62.24.88.241]:46358 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752635AbYIVP1P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 11:27:15 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 7C868393A370; Mon, 22 Sep 2008 17:27:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1222074825.6698.13.camel@heerbeest>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96481>

On Mon, Sep 22, 2008 at 11:13:45AM +0200, Jan Nieuwenhuizen wrote:
> On zo, 2008-09-21 at 16:24 +0200, Petr Baudis wrote:
> 
> > The problem is that you can undo the merge content, but not the history
> > information. So this revert can e.g. propagate even into branches which
> > still *should* depend on the other branch, you get into trouble when you
> > want to make your branch depend on the other one anyway, etc.
> 
> Ah, yes.  I see.  Does this mean that functionality for easy adding and
> removing dependencies/patches from a branch can only be provided through
> some sort of [unpublishable] patch based mechanism like stgit?
> 
> Possibly we'd need a kind of setup where stgit-like patch branches
> can be "finalized" into topgit branches.  Hmm.

Do you really expect you will need this kind of functionality often,
though? Adding dependencies is easy, and note that removing whole topic
branches or deleting dependencies that were merged upstream _is_ doable.

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
