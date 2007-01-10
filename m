From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Wed, 10 Jan 2007 04:05:48 -0500
Message-ID: <20070110090548.GE30765@spearce.org>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net> <7vy7obj07k.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701091539050.3594@woody.osdl.org> <200701100904.32077.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 10:06:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4ZP9-0004RH-Bt
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 10:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932753AbXAJJFw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 04:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932754AbXAJJFw
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 04:05:52 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49197 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932753AbXAJJFv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 04:05:51 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H4ZP2-0007YR-Kw; Wed, 10 Jan 2007 04:05:48 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5EC6220FBAE; Wed, 10 Jan 2007 04:05:48 -0500 (EST)
To: Andy Parkins <andyparkins@gmail.com>
Content-Disposition: inline
In-Reply-To: <200701100904.32077.andyparkins@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36491>

Andy Parkins <andyparkins@gmail.com> wrote:
> On Tuesday 2007 January 09 23:46, Linus Torvalds wrote:
> 
> > I would suggest a solution:
> >
> >  - git checkout will refuse to switch AWAY from a detached head unless the
> >    SHA1 of the detached head exactly matches some other branch.
> 
> If the detached HEAD matches another branch what did we need a detached HEAD 
> for in the first place?

Tags.  Previously you could not checkout a tag without first making
a branch from it.  Now you can.

-- 
Shawn.
