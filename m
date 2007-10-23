From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Let git-add--interactive read "git colors" from git-config
Date: Tue, 23 Oct 2007 00:40:55 -0400
Message-ID: <20071023044055.GB14735@spearce.org>
References: <19271E58-5C4F-41AF-8F9D-F114F36A34AC@wincent.com> <20071013172745.GA2624@coredump.intra.peff.net> <20071013175127.GA3183@coredump.intra.peff.net> <47112491.8070309@gmail.com> <20071015034338.GA4844@coredump.intra.peff.net> <20071016194709.3c1cb3a8@danzwell.com> <20071017015152.GN13801@spearce.org> <20071022163244.4af72973@danzwell.com> <20071022211958.045895ac@danzwell.com> <20071023042956.GC28312@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dan Zwell <dzwell@zwell.net>, Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 23 06:42:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkBb3-000341-UG
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 06:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341AbXJWElJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 00:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753677AbXJWElI
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 00:41:08 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39547 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753651AbXJWElG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 00:41:06 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IkBZZ-0001rM-H9; Tue, 23 Oct 2007 00:40:57 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E75E820FBAE; Tue, 23 Oct 2007 00:40:55 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071023042956.GC28312@coredump.intra.peff.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62088>

Jeff King <peff@peff.net> wrote:
> On Mon, Oct 22, 2007 at 09:19:58PM -0500, Dan Zwell wrote:
> 
> > This patch is againts Shawn Pearce's "pu" branch.
> 
> Don't do that. The code in 'pu' is a mess of half-working features. If
> your patch is accepted, then it has to be picked apart from those
> half-working features that aren't being accepted (which hopefully isn't
> hard if nobody has been working in the same area, but can be quite
> ugly).  Base your work on 'master' if possible, or 'next' if it relies
> on features only in next. If it relies on some topic branch that is
> _only_ in pu, then mention explicitly which topic.

And even when you base work on things in next, don't base it on the
tip of next.  Base it on a specific topic that is merged into next.
Next is also a mess of features, but they are more likely to be in
a working state than the features in pu.

Topics in next will merge to master at different times.  If your
changes depend on more than one topic that may make it more difficult
for the maintainer to merge your topic to master.

Fortunately In Dan's case the only topic in pu that impacted
git-add--interactive was his dz/color-addi topic, so this probably
applies to the tip of it just as well as it does to the tip of pu.

-- 
Shawn.
