From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Tue, 9 Jan 2007 19:18:22 -0500
Message-ID: <20070110001822.GG30023@spearce.org>
References: <87odphgfzz.wl%cworth@cworth.org> <7vbql9ydd7.fsf@assigned-by-dhcp.cox.net> <20070108131735.GA2647@coredump.intra.peff.net> <7vzm8tt5kf.fsf@assigned-by-dhcp.cox.net> <20070109142130.GA10633@coredump.intra.peff.net> <7virffkick.fsf@assigned-by-dhcp.cox.net> <20070109213117.GB25012@fieldses.org> <7vy7obj07k.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701091539050.3594@woody.osdl.org> <7vd55nivx7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 01:18:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4RAp-0006Ka-0I
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 01:18:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932577AbXAJASb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 19:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbXAJASb
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 19:18:31 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:36250 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932577AbXAJASa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 19:18:30 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H4RAU-0000uk-EU; Tue, 09 Jan 2007 19:18:14 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E700B20FBAE; Tue,  9 Jan 2007 19:18:22 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd55nivx7.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36436>

Junio C Hamano <junkio@cox.net> wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> >  - git checkout will refuse to switch AWAY from a detached head unless the 
> >    SHA1 of the detached head exactly matches some other branch.
> 
> ... or an existing "ref^{commit}".

I think that was implied.  ;-)
 
> > I'd love to see the detached HEAD series move into "master", but I do 
> > think we should make sure that people can't drop their work easily by 
> > mistake, and I think the above suggestion is both simple and workable.
> >
> > Comments?
> 
> I agree with the "reachability is wrong -- you would lose the
> point in the middle" reasoning.

I have no problem with that.  Forget the reachability thing entirely.

My point about reset --hard/--soft probably also needing this check
still stands however.

-- 
Shawn.
