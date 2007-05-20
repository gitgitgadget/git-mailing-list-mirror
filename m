From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH 02/15] git-config: add --remote option for reading config from remote repo
Date: Mon, 21 May 2007 00:03:38 +0200
Message-ID: <20070520220337.GJ4085@planck.djpig.de>
References: <11796842882917-git-send-email-skimo@liacs.nl> <11796842881646-git-send-email-skimo@liacs.nl> <20070520181155.GH4085@planck.djpig.de> <20070520194448.GW942MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Mon May 21 00:03:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HptVJ-0003JA-14
	for gcvg-git@gmane.org; Mon, 21 May 2007 00:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757272AbXETWDr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 18:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757292AbXETWDq
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 18:03:46 -0400
Received: from planck.djpig.de ([85.10.192.180]:2856 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757272AbXETWDq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 18:03:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id D974888060;
	Mon, 21 May 2007 00:03:41 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WqVK3ODq8YTj; Mon, 21 May 2007 00:03:38 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 14ED988105; Mon, 21 May 2007 00:03:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070520194448.GW942MdfPADPa@greensroom.kotnet.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47932>

On Sun, May 20, 2007 at 09:44:48PM +0200, Sven Verdoolaege wrote:
> On Sun, May 20, 2007 at 08:11:55PM +0200, Frank Lichtenheld wrote:
> > On Sun, May 20, 2007 at 08:04:35PM +0200, skimo@liacs.nl wrote:
> > > From: Sven Verdoolaege <skimo@kotnet.org>
> > > 
> > > Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
> > > ---
> > >  Documentation/git-config.txt |   33 +++++++++++++++++++++---------
> > 
> > All my old suggestions and corrections for the documentation
> > part still apply... should I repeat them?
> 
> I did the [scope] thing, but it seems I inadvertedly threw it out.
> I guess I'll have to do it again.
> 
> Was there anything else?

You list --remote for all variants while it is not really supported for
them. Although this problem probably implicetly goes away if you use
scope and later explain what that means.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
