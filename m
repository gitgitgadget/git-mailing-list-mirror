From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] clarify need for init in git-submodules documentation
Date: Fri, 17 Aug 2007 11:31:16 +0200
Message-ID: <20070817093116.GH1070MdfPADPa@greensroom.kotnet.org>
References: <200708161553.10991.Josef.Weidendorfer@gmx.de>
 <11872878021267-git-send-email-madduck@madduck.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "martin f. krafft" <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Fri Aug 17 11:31:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILyAy-0002Nk-El
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 11:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257AbXHQJbV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 05:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752130AbXHQJbV
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 05:31:21 -0400
Received: from psmtp08.wxs.nl ([195.121.247.22]:43298 "EHLO psmtp08.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751120AbXHQJbS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 05:31:18 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp08.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JMW00BE1VS5OD@psmtp08.wxs.nl> for git@vger.kernel.org; Fri,
 17 Aug 2007 11:31:17 +0200 (MEST)
Received: (qmail 21483 invoked by uid 500); Fri, 17 Aug 2007 09:31:16 +0000
In-reply-to: <11872878021267-git-send-email-madduck@madduck.net>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56056>

On Thu, Aug 16, 2007 at 08:10:02PM +0200, martin f. krafft wrote:
> +The file .gitmodules serves default configuration data to users who cloned the
> +repository. In order to work with submodules, these data need to be copied to
> +$GIT_DIR/config with `git-submodule init`. Only the data in $GIT_DIR/config
> +are used for `git-submodule update`.
> +

This is not true.  The url (which is local information) is taken from .git/config,
the name/path relation (which is shared information) is taken from .gitmodules.

skimo

PS, please don't prune (me from) the CC list when replying.
