From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-fast-import
Date: Tue, 6 Feb 2007 00:48:08 -0500
Message-ID: <20070206054808.GA10508@spearce.org>
References: <20070206023111.GB9222@spearce.org> <Pine.LNX.4.64.0702052248070.19212@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Feb 06 06:48:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEJBr-0000ne-OO
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 06:48:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965273AbXBFFsN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 00:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965276AbXBFFsN
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 00:48:13 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:51116 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965273AbXBFFsM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 00:48:12 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HEJBa-0006cP-2J; Tue, 06 Feb 2007 00:48:10 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BBF8F20FBAE; Tue,  6 Feb 2007 00:48:08 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702052248070.19212@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38809>

Nicolas Pitre <nico@cam.org> wrote:
> On Mon, 5 Feb 2007, Shawn O. Pearce wrote:
> > The time of the change is specified by `<time>` as the number of
> > seconds since the UNIX epoc (midnight, Jan 1, 1970, UTC) and is
> > written in base-10 notation using US-ASCII digits.  The committer's
> > timezone is specified by `<tz>` as a positive or negative offset
> > from UTC, in minutes.  For example EST would be expressed in `<tz>`
> > by ``-0500''.
> 
> I think this is quite error prone, demonstrated by the fact that we 
> screwed that up ourselves on a few occasions.  I think that the frontend 
> should be relieved from this by letting it provide the time of change in 
> a more natural format amongst all possible ones(like RFC2822 for 
> example) and gfi should simply give it to parse_date().

This is a really good point.  Its a little bit of work to switch
to parse_date(); I'll try to get it done tomorrow night.

-- 
Shawn.
