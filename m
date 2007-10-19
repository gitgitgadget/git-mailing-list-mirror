From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Change 'Deltifying objects' to 'Delta compressing objects'
Date: Thu, 18 Oct 2007 22:21:54 -0400
Message-ID: <20071019022154.GY14735@spearce.org>
References: <20071019004527.GA12930@spearce.org> <20071019021255.GD3290@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 04:22:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IihVC-00005p-2F
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 04:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759939AbXJSCWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 22:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759226AbXJSCWF
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 22:22:05 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43213 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759882AbXJSCWE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 22:22:04 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IihUb-0008Ge-85; Thu, 18 Oct 2007 22:21:41 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EF08E20FBAE; Thu, 18 Oct 2007 22:21:54 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071019021255.GD3290@coredump.intra.peff.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61605>

Jeff King <peff@peff.net> wrote:
> On Thu, Oct 18, 2007 at 08:45:27PM -0400, Shawn O. Pearce wrote:
> 
> > Recently I was referred to the Grammar Police as the git-pack-objects
> > progress message 'Deltifying %u objects' is considered to be not
> > proper English to at least some small but vocal segment of the
> > English speaking population.  Techncially we are applying delta
> > compression to these objects at this stage, so the new term is
> > slightly more acceptable to the Grammar Police but is also just
> > as correct.
> 
> Boo. I _like_ "deltifying". Sure, it's probably not in the dictionary,
> but that's how languages change: saying "delta compressing" all the time
> will get awkward, so people invent a new word using existing rules to
> explain a common phenomenon.

My eyes have gotten used to "Deltifying" but I have to admit that
in my early Git days I thought it looked damn odd.  Today I'm far
too familiar with Git to really notice this as a problem now.

I really don't have an opinion either way.  Actually I think the
entire progress system of git-pack-objects should be reduced even
further so that users aren't exposed to the internal phases we
are going through.  Most of them just don't care.  They just
want to know when its going to be done[*1*].

> Anyway, if you want to please the Grammar Police, should it not be
> "Delta-compressing"?  "Delta" is not an adverb here, but rather the
> phrase acts as a compound verb (i.e., the two words work in place of a
> single verb). Although "Delta-compressing objects" just looks stupid.

Yea, that is just stupid.  And is why I didn't use a - in my patch.


*1*: Yes, yes, I know that's hard to predict and impossible in
the really important cases (like network transfer of not yet
compressed data).  So just telling them that we are working and
have recently done something useful towards finishing our goal is
more than enough.  Its like putting mirrors on the wall in a lobby;
folks won't notice how long it takes for the elevator to arrive as
they are too busy preening themselves.

-- 
Shawn.
