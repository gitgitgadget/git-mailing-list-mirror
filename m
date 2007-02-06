From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-fast-import
Date: Tue, 6 Feb 2007 11:44:41 -0500
Message-ID: <20070206164441.GA4949@spearce.org>
References: <20070206023111.GB9222@spearce.org> <200702060928.54440.andyparkins@gmail.com> <Pine.LNX.4.64.0702060836180.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 06 17:44:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HETR3-0005lV-Cr
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 17:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965201AbXBFQoq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 11:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965220AbXBFQoq
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 11:44:46 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:41336 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965201AbXBFQop (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 11:44:45 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HETQq-0000Ns-L4; Tue, 06 Feb 2007 11:44:36 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 41A6320FBAE; Tue,  6 Feb 2007 11:44:41 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702060836180.8424@woody.linux-foundation.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38859>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Tue, 6 Feb 2007, Andy Parkins wrote:
> > 
> > Is <tz> /really/ expressed in minutes?  500 minutes is 8 hours 20 minutes.
> > 
> > I know what you mean, of course; and so would anyone reading it - so I suggest 
> > just dropping the ", in minutes" - as it's not true.
> 
> Agreed. It _is_ "in minutes", but it's in an oddish human-readable base-60 
> format. It's certainly *not* decimal, it's more like "two decimal digits 
> encode each base-60 digit in the obvious way".

What about this language?

	The time of the change is specified by `<time>` as the number of
	seconds since the UNIX epoc (midnight, Jan 1, 1970, UTC) and is
	written in base-10 notation using US-ASCII digits.  The committer's
	timezone is specified by `<tz>` as a positive or negative offset
	from UTC.  For example EST (which is typically 5 hours behind GMT)
	would be expressed in `<tz>` by ``-0500'' while GMT is ``+0000''.

-- 
Shawn.
