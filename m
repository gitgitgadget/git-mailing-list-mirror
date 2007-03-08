From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git push failure with update hook success
Date: Thu, 8 Mar 2007 05:06:55 -0500
Message-ID: <20070308100655.GG30289@spearce.org>
References: <17902.59497.831409.218529@lisa.zopyra.com> <200703080922.54978.andyparkins@gmail.com> <20070308092809.GE30289@spearce.org> <200703081004.32666.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Bill Lear <rael@zopyra.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 11:07:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPFWg-0000jg-BE
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 11:07:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbXCHKHA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 05:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932945AbXCHKHA
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 05:07:00 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42010 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932470AbXCHKG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 05:06:58 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HPFWQ-00070F-Jq; Thu, 08 Mar 2007 05:06:54 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9463620FBAE; Thu,  8 Mar 2007 05:06:55 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <200703081004.32666.andyparkins@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41732>

Andy Parkins <andyparkins@gmail.com> wrote:
> On Thursday 2007 March 08 09:28, Shawn O. Pearce wrote:
> > Andy Parkins <andyparkins@gmail.com> wrote:
> > > Without adding some nasty switches to git-rev-list
> > > (like --all-except-this-branch), I can't see how the post-update hook
> > > could ever send emails with the necessary amount of detail.
> >
> > Which is why `master` now has support for a post-receive hook,
> > that has the magic three parameters.  ;-)
> 
> It still won't work - what about the 
> 
>  git-rev-list --not --all
> 
> Problem?
> 
> By the time that hook runs the master ref (for example) has changed, 
> so "--not --all" includes the new revisions, and you get no output.

Dammit.  That's so obvious.  And I missed it.

I got nothing at this hour of the morning.

-- 
Shawn.
