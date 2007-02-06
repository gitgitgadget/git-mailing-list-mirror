From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-fast-import
Date: Tue, 6 Feb 2007 04:40:48 -0500
Message-ID: <20070206094048.GE10508@spearce.org>
References: <20070206023111.GB9222@spearce.org> <200702060928.54440.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 06 10:40:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEMos-0008Ka-B3
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 10:40:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbXBFJkx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 04:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751927AbXBFJkx
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 04:40:53 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:55731 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914AbXBFJkw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 04:40:52 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HEMoi-0006dI-1P; Tue, 06 Feb 2007 04:40:48 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E653D20FBAE; Tue,  6 Feb 2007 04:40:48 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <200702060928.54440.andyparkins@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38827>

Andy Parkins <andyparkins@gmail.com> wrote:
> On Tuesday 2007 February 06 02:31, Shawn O. Pearce wrote:
> 
> > The time of the change is specified by `<time>` as the number of
> > seconds since the UNIX epoc (midnight, Jan 1, 1970, UTC) and is
> > written in base-10 notation using US-ASCII digits.  The committer's
> > timezone is specified by `<tz>` as a positive or negative offset
> > from UTC, in minutes.  For example EST would be expressed in `<tz>`
> > by ``-0500''.
> 
> Is <tz> /really/ expressed in minutes?  500 minutes is 8 hours 20 minutes.
> 
> I know what you mean, of course; and so would anyone reading it - so I suggest 
> just dropping the ", in minutes" - as it's not true.

Heh, right you are!

Nico's point about using parse_date() here is a really good one.
I'm going to modify that section of gfi to use parse_date(), which
would change the language here anyway.  I'll try to not to make a
silly mistake such as the above in the updated docs.  :)

-- 
Shawn.
