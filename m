From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git push failure with update hook success
Date: Thu, 8 Mar 2007 04:28:09 -0500
Message-ID: <20070308092809.GE30289@spearce.org>
References: <17902.59497.831409.218529@lisa.zopyra.com> <20070307170904.GB27922@spearce.org> <17902.62836.920473.810183@lisa.zopyra.com> <200703080922.54978.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Bill Lear <rael@zopyra.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 10:28:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPEv7-0008S9-7d
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 10:28:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030407AbXCHJ2R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 04:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030347AbXCHJ2R
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 04:28:17 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:41388 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030407AbXCHJ2P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 04:28:15 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HPEuw-0005r3-2t; Thu, 08 Mar 2007 04:28:10 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2585D20FBAE; Thu,  8 Mar 2007 04:28:09 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <200703080922.54978.andyparkins@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41724>

Andy Parkins <andyparkins@gmail.com> wrote:
> Without adding some nasty switches to git-rev-list 
> (like --all-except-this-branch), I can't see how the post-update hook could 
> ever send emails with the necessary amount of detail.

Which is why `master` now has support for a post-receive hook,
that has the magic three parameters.  ;-)

-- 
Shawn.
