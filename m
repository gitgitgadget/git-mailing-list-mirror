From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/4] Make git-fetch follow tags we already have objects for sooner
Date: Sun, 2 Mar 2008 09:13:16 -0500
Message-ID: <20080302141316.GB8410@spearce.org>
References: <20080228084257.GC16870@spearce.org> <7v3arcduil.fsf@gitster.siamese.dyndns.org> <20080229223431.GT8410@spearce.org> <alpine.LNX.1.00.0802291736580.19665@iabervon.org> <20080301042510.GW8410@spearce.org> <alpine.LNX.1.00.0803011127490.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Mar 02 15:14:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVowx-0003Dd-Cy
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 15:13:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753362AbYCBONW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 09:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753452AbYCBONW
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 09:13:22 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45620 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943AbYCBONW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 09:13:22 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JVowC-0005P0-UA; Sun, 02 Mar 2008 09:13:12 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6BE9B20FBAE; Sun,  2 Mar 2008 09:13:16 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0803011127490.19665@iabervon.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75781>

Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Fri, 29 Feb 2008, Shawn O. Pearce wrote:
> > 
> > Is this "horribly intrusive" ?
> > 
> > We can test it with something like this:
> 
> That looks suitable to me (although maybe the environment variable should 
> contain the fd to write to?). I also want to know the "have" info, so I 
> can verify that the client is listing things appropriately, but that's an 
> obvious addition.

Yea, I was thinking about that last night myself.  I think the patch
is still in `pu` so I will work up something for Junio to squash into
it that uses the variable to specify the fd, rather than assume 3.

-- 
Shawn.
