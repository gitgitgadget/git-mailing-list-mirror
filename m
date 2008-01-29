From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] Authenticate push via PGP signature, not SSH
Date: Mon, 28 Jan 2008 21:57:43 -0500
Message-ID: <20080129025743.GH24004@spearce.org>
References: <479D5611.4010205@vilain.net> <20080128081258.GE24004@spearce.org> <479E5021.7010404@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Tue Jan 29 03:58:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJggL-0002zb-7h
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 03:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755944AbYA2C5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 21:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754019AbYA2C5s
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 21:57:48 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49552 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754188AbYA2C5r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 21:57:47 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JJgfF-0002CT-HU; Mon, 28 Jan 2008 21:57:33 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8A14C20FBAE; Mon, 28 Jan 2008 21:57:43 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <479E5021.7010404@vilain.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71923>

Sam Vilain <sam@vilain.net> wrote:
> Shawn O. Pearce wrote:
> > But in a smaller business type setting, where there's under 100
> > employees working, odds are you've already created the user account
> > on systems, and physically passed the initial password via a sticky
> > note after checking the person's government issued IDs.  In such a
> > setting having yet another authentication system (PGP keys) is just
> > yet more work for the already over worked/under appreciated IT staff.
> 
> Agreed - again I'd personally consider allowing receive-pack with
> reflogs in those environments if setting up PGP or SSH keys was a hassle.

Yea, I already have reflogs enabled for all stored branches on the
central server.  And since some branches have a no-delete policy
(based upon the rules offered by contrib/hooks/update-paranoid) the
reflogs are also effectively no-delete, even if the branch rewinds.

I also never run `git reflog expire`.  I might in another year or
so consider it, but most of my no-delete branches also don't rewind
very often (if ever) so there's very little disk to be gained by
reflog expiry.

-- 
Shawn.
