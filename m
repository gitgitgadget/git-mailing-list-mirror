From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: sprintf security holes?
Date: Mon, 19 Sep 2005 14:42:22 +0200
Message-ID: <20050919124222.GD15165MdfPADPa@greensroom.kotnet.org>
References: <86zmqd5aey.fsf@blue.stonehenge.com>
 <7voe6pv6zz.fsf@assigned-by-dhcp.cox.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 14:44:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHKyh-0004Y1-Er
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 14:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbVISMm0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 08:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbVISMm0
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 08:42:26 -0400
Received: from smtp19.wxs.nl ([195.121.6.15]:54765 "EHLO smtp19.wxs.nl")
	by vger.kernel.org with ESMTP id S932264AbVISMm0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 08:42:26 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp19.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with SMTP id <0IN200911DYMDI@smtp19.wxs.nl> for git@vger.kernel.org; Mon,
 19 Sep 2005 14:42:22 +0200 (CEST)
Received: (qmail 13709 invoked by uid 500); Mon, 19 Sep 2005 12:42:22 +0000
In-reply-to: <7voe6pv6zz.fsf@assigned-by-dhcp.cox.net>
To: Junio C Hamano <junkio@cox.net>
Mail-followup-to: Junio C Hamano <junkio@cox.net>,
 "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8856>

On Mon, Sep 19, 2005 at 12:42:08AM -0700, Junio C Hamano wrote:
> We _might_ be protected from buffer overrun errors [*1*], but we
> would then end up operating on a truncated data -- which would
> lead to an equally unexpected behaviour.  I do not think there
> is any guarantee that working with unexpectedly truncated data
> leads to less severe security problems than buffer overruns with
> careless sprintf().

But you can _check_ whether the data has been truncated.
Just look at the return value of snprintf.

skimo
