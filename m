From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Prevent using bold text in entire gui for some fonts sometimes
Date: Thu, 20 Sep 2007 13:01:24 -0400
Message-ID: <20070920170124.GS3099@spearce.org>
References: <981e6de60709181533o24ef0e45w7925070b5e78ef56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Simon Sasburg <simon.sasburg@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 19:01:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYPPE-0000um-F5
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 19:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753235AbXITRB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 13:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753311AbXITRB3
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 13:01:29 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49198 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063AbXITRB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 13:01:28 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IYPOx-0006il-RC; Thu, 20 Sep 2007 13:01:20 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 16A3120FBAE; Thu, 20 Sep 2007 13:01:25 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <981e6de60709181533o24ef0e45w7925070b5e78ef56@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58786>

Simon Sasburg <simon.sasburg@gmail.com> wrote:
> When I first saw git-gui on windows, I noticed it wasn't using ugly
> bold fonts for it's entire gui like it was in linux. I came up with
> the following patch to fix this there.
> 
> And it worked, trange thing was, even git-gui without this patch
> applied was using normal fonts now. The patch didn't seem to make any
> difference for me anymore. So I chalked this up to weirdness of my
> system.
> 
> Yesterday though a saw that a friends git-gui was showing the same
> problem with the entire gui being in bold text. And this patch fixed
> it.
> 
> So its a bit weird that this patch seemed to have 'permanent' effects
> for me, even after it was reverted.... but on the other hand it's
> really trivial.

Yea, I can't explain that either.  But this patch is really trivial
so I'm applying it anyway.  Doesn't break anyone who was already
using a normal weight on their font and it should prevent others
from picking up bold everywhere.  Thanks.

-- 
Shawn.
