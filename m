From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] git-update-ref: add --no-deref option for
 overwriting/detaching ref
Date: Wed, 09 May 2007 14:53:06 +0200
Message-ID: <20070509125306.GV942MdfPADPa@greensroom.kotnet.org>
References: <20070509103320.GA7257MdfPADPa@greensroom.kotnet.org>
 <20070509123914.GO4489@pasky.or.cz>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed May 09 14:53:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hllfn-0005Q0-EJ
	for gcvg-git@gmane.org; Wed, 09 May 2007 14:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755836AbXEIMxK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 08:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756574AbXEIMxK
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 08:53:10 -0400
Received: from psmtp13.wxs.nl ([195.121.247.25]:47347 "EHLO psmtp13.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756091AbXEIMxI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 08:53:08 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp13.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JHR00IYSYGI2G@psmtp13.wxs.nl> for git@vger.kernel.org; Wed,
 09 May 2007 14:53:07 +0200 (MEST)
Received: (qmail 25814 invoked by uid 500); Wed, 09 May 2007 12:53:06 +0000
In-reply-to: <20070509123914.GO4489@pasky.or.cz>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46709>

On Wed, May 09, 2007 at 02:39:14PM +0200, Petr Baudis wrote:
> On Wed, May 09, 2007 at 12:33:20PM CEST, Sven Verdoolaege wrote:
> > git-checkout is also adapted to make use of this new option
> > instead of the handcrafted command sequence.
> > 
> > Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
> 
> Isn't this what git-symbolic-ref is about?

You certainly can't use git-symbolic-ref now to overwrite a symbolic
ref by a non-symbolic ref.  It allows you to do the equivalent
of symlink/readlink, while we want to _remove_ the link here.

skimo
