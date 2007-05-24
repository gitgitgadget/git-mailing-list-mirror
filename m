From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Documentation: fix git-config.xml generation
Date: Thu, 24 May 2007 00:47:36 -0400
Message-ID: <20070524044736.GH28023@spearce.org>
References: <3f80363f0705231516x7c6fa2daua33a708deaa7a10c@mail.gmail.com> <1179979802.3682.12.camel@lt21223.campus.dmacc.edu> <7vhcq2zw7y.fsf@assigned-by-dhcp.cox.net> <1179981812.3682.16.camel@lt21223.campus.dmacc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Jeffrey C. Ollie" <jeff@ocjtech.us>
X-From: git-owner@vger.kernel.org Thu May 24 06:47:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hr5El-0004gE-5E
	for gcvg-git@gmane.org; Thu, 24 May 2007 06:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757213AbXEXErk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 00:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758147AbXEXErk
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 00:47:40 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55498 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757213AbXEXErj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 00:47:39 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hr5Eg-0007cO-FR; Thu, 24 May 2007 00:47:38 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8644520FBAE; Thu, 24 May 2007 00:47:36 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1179981812.3682.16.camel@lt21223.campus.dmacc.edu>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48219>

"Jeffrey C. Ollie" <jeff@ocjtech.us> wrote:
> On Wed, 2007-05-23 at 21:22 -0700, Junio C Hamano wrote:
> > "Jeffrey C. Ollie" <jeff@ocjtech.us> writes:
> > 
> > > On Wed, 2007-05-23 at 18:16 -0400, James Bowes wrote:
> > >>
> > >> With asciidoc 8.1.0 and xmlto 0.0.18, git-config.xml failed to
> > >> validate. This patch just makes the asciidoc formatting for
> > >> branch.autosetupmerge the same as the other config options.
> > >
> > > I can confirm that this patch fixes the validation errors...
> > 
> > Yup, already pushed out about 7 hours ago.
> 
> I do not see it in any of the public git repos.  Is there some
> synchronization interval I need to wait for?

kernel.org has mirroring lags.  When Junio pushes to kernel.org
he also pushes to repo.or.cz/alt-git.git.  That's usually where
I fetch from, as there's no mirroring lag at all.

Note that repo.or.cz also has a git.git, which is a mirror of
kernel.org's mirrors, so its uh, way way behind sometimes.  ;-)

-- 
Shawn.
