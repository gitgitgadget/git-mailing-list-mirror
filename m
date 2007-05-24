From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 19:42:52 +0200
Message-ID: <20070524174252.GT942MdfPADPa@greensroom.kotnet.org>
References: <20070524105112.GI942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241201270.4648@racer.site>
 <20070524111645.GK942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241230410.4648@racer.site>
 <20070524114354.GN942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241315290.4648@racer.site>
 <20070524123936.GO942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241415050.4648@racer.site>
 <20070524132434.GQ942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241446070.4648@racer.site>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 24 19:42:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrHL0-0004Zs-1V
	for gcvg-git@gmane.org; Thu, 24 May 2007 19:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbXEXRmz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 13:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbXEXRmz
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 13:42:55 -0400
Received: from smtp17.wxs.nl ([195.121.247.8]:52754 "EHLO smtp17.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702AbXEXRmy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 13:42:54 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp17.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JIK00BQ83VGE7@smtp17.wxs.nl> for git@vger.kernel.org; Thu,
 24 May 2007 19:42:53 +0200 (CEST)
Received: (qmail 6303 invoked by uid 500); Thu, 24 May 2007 17:42:52 +0000
In-reply-to: <Pine.LNX.4.64.0705241446070.4648@racer.site>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48281>

On Thu, May 24, 2007 at 02:52:25PM +0100, Johannes Schindelin wrote:
> It is not that expensive to just give the SHA-1 with the URL, and to 
> introduce a new namespace, say
> 
> 3f... submodule/path^{URL:blablub}
> 
> to say that the submodule which is connected in "HEAD:path" is available 
> with the URL "blablub" and just so happens to be at commit "3f..." at the 
> moment. Heck, you can even use this instead of expensive fetches to verify 
> up-to-date, and even more, you can make sure that you are as up-to-date as 
> the remote supermodule.

What about all the other branches?
Also, the submodule may not even be in any of the tips of the branches.

> Without some very intrusive surgery into the transport code of Git, in 22 
> patches, which I am not at all comfortable with.

You're not comfortable with the number or with the patches?
There's only about four or five that deal with this git-config stuff
and any other mechanism would have to implemented as well.

skimo
