From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] send-pack: respect '+' on wildcard refspecs
Date: Sat, 20 Oct 2007 00:57:33 -0400
Message-ID: <20071020045733.GS14735@spearce.org>
References: <20071019090400.GA8944@coredump.intra.peff.net> <449c10960710190510y3af3ffa2ydb9ae4a01b5d480c@mail.gmail.com> <20071019122755.GA17002@coredump.intra.peff.net> <449c10960710190638j5823b19dl903ae369965e884e@mail.gmail.com> <20071019134339.GA21852@coredump.intra.peff.net> <449c10960710191800j3e61b80cma2c582080c1dd07c@mail.gmail.com> <20071020042257.GA26755@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dan McGee <dan@archlinux.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 20 06:57:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij6PH-0006Fj-0J
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 06:57:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276AbXJTE5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 00:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752235AbXJTE5i
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 00:57:38 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44553 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219AbXJTE5i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 00:57:38 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ij6P1-0007iz-EZ; Sat, 20 Oct 2007 00:57:35 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EF31E20FBAE; Sat, 20 Oct 2007 00:57:33 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071020042257.GA26755@coredump.intra.peff.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61783>

Jeff King <peff@peff.net> wrote:
> On Fri, Oct 19, 2007 at 08:00:37PM -0500, Dan McGee wrote:
> 
> > Turns out I didn't have GIT_EXEC_PATH set up right. Once I do that,
> > everything seems to work just fine.
> > 
> > Thanks for looking into this Jeff, and git-bisect just won me over. It
> > made easy work of finding the commit that broke this.
> 
> Huzzah, success! Shawn, this should probably go on 'maint'. Although it
> is probably not high priority (it has been broken since May; I think
> wildcard push refspecs must not be that common), it is a fairly trivial
> fix that shouldn't impact anyone else.

Yea, its already queued on maint.  Both the patch and the
tests are obviously correct.  Its broken without the patch.
Its documented/expected behavior fixed by the patch.  IMHO it
belongs in maint.

-- 
Shawn.
