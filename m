From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: t1001-read-tree-m-2way.sh failed
Date: Thu, 20 Apr 2006 15:53:58 +0200
Message-ID: <20060420135358.GQ11428MdfPADPa@greensroom.kotnet.org>
References: <20060420130121.GO11428MdfPADPa@greensroom.kotnet.org>
 <4447882F.8080304@op5.se>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 20 15:54:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWZbi-0001ng-Ov
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 15:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWDTNyD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 09:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWDTNyD
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 09:54:03 -0400
Received: from smtp15.wxs.nl ([195.121.247.6]:49574 "EHLO smtp15.wxs.nl")
	by vger.kernel.org with ESMTP id S1750741AbWDTNyC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Apr 2006 09:54:02 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp15.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with SMTP id <0IY00071MX9X35@smtp15.wxs.nl> for git@vger.kernel.org; Thu,
 20 Apr 2006 15:53:58 +0200 (CEST)
Received: (qmail 10725 invoked by uid 500); Thu, 20 Apr 2006 13:53:58 +0000
In-reply-to: <4447882F.8080304@op5.se>
To: Andreas Ericsson <ae@op5.se>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18970>

On Thu, Apr 20, 2006 at 03:10:07PM +0200, Andreas Ericsson wrote:
> Keyboard color?

I think "beige" comes closest.

In any case, it turns out that apparently make was confused
by the rename from diff.c to diff-lib.c.
After a make clean, everything was ok.

skimo
