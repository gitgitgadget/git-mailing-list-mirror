From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Summer of Code 2008 project application draft: Pack v4
Date: Mon, 31 Mar 2008 00:12:17 -0400
Message-ID: <20080331041217.GE10274@spearce.org>
References: <20080329205046.GA27926@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Peter Eriksen <s022018@student.dtu.dk>
X-From: git-owner@vger.kernel.org Mon Mar 31 06:13:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgBOW-0007ZW-99
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 06:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbYCaEMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 00:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbYCaEMW
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 00:12:22 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38659 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbYCaEMV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 00:12:21 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JgBNc-0007lF-KQ; Mon, 31 Mar 2008 00:12:20 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7003020FBAE; Mon, 31 Mar 2008 00:12:18 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080329205046.GA27926@bohr.gbar.dtu.dk>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78550>

Peter Eriksen <s022018@student.dtu.dk> wrote:
> Here is a draft of my application for the Google Summer of Code 2008.
...
> The project goal is to rebase the code and ideas developed for the
> version 4 of the git pack format, which showed good promise of making
> packs smaller, and faster.
> 
> The ideas of a new even more optimized pack format has been floating
> around the git world for almost two years, and because of the rapid pace
> of development the code implementing those ideas has become less, and
> less ready for inclusion in mainline.
> 
> Since those patches touch so many of the core functions in git, it will
> be a good chunk of work getting them mergeable, and nobody has gotten
> around to doing that yet. This will be a good oppertunity for laying the
> ground work, and getting the ball rolling again.

Have you had a chance to look at those patches yet?  Or the code
that they touch, but which has been heavily modified since then
(like say builtin-pack-objects.c)?

I would hope that forward-porting those patches would only take
us through to about the mid-term, and then finishing out the bulk
of the series (like commit dict encoding, maybe dict of object ids
used in trees) would be the remainder of the summer.  But that may
be aggressive.  To be successful I think the student working on
this project needs to spend some time during the bonding period to
understand the current pack v2 format and how the pack v4 format
was going to address some of the shortcomings of v2.

To some extent I have left the design details about pack v4 off
the ideas page hoping to draw students into explaining their own
ideas for how to improve upon Git's pack data storage.  Even if the
student's ideas provide less compression than pack v4 was hinting
it can give us, it shows the student's ability to think through
the problem and their desire to work on the project.  Its also why
I called it "v4/v5"... some of the students own ideas may be novel
to us and better than v4, hence creating a v5...
 
-- 
Shawn.
