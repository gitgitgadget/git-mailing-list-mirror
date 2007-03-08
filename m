From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Split sample update hook into post-receive hook
Date: Thu, 8 Mar 2007 03:33:17 -0500
Message-ID: <20070308083317.GB30289@spearce.org>
References: <20070308041618.GA29744@spearce.org> <81b0412b0703080026v6f3990c3x2cefca661b64e00d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>,
	Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 09:33:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPE42-0007s3-DT
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 09:33:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbXCHId1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 03:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030284AbXCHId0
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 03:33:26 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:40630 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030291AbXCHIdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 03:33:25 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HPE3s-00046q-Op; Thu, 08 Mar 2007 03:33:20 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BD49120FBAE; Thu,  8 Mar 2007 03:33:17 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <81b0412b0703080026v6f3990c3x2cefca661b64e00d@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41718>

Alex Riesen <raa.lkml@gmail.com> wrote:
> On 3/8/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> >+# Called by git-receive-pack with arguments:
> >+#    (refname sha1-old sha1-new)+
> > #
> 
> What do you do if this breaks because of too many refs passed?

Die a horrible horrible death?

That's certainly a problem in receive-pack.  It should (somehow)
break long invocations up, much like what xargs winds up doing.
Problem is that limit is OS dependent... so uh, yea...

-- 
Shawn.
