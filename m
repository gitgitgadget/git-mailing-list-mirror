From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [RFC] Third round of support for cloning submodules
Date: Mon, 21 May 2007 14:19:29 +0200
Message-ID: <20070521121929.GM942MdfPADPa@greensroom.kotnet.org>
References: <11796842882917-git-send-email-skimo@liacs.nl>
 <20070520225252.GO5412@admingilde.org>
 <20070521085419.GG942MdfPADPa@greensroom.kotnet.org>
 <20070521100716.GX5412@admingilde.org>
 <20070521101455.GK942MdfPADPa@greensroom.kotnet.org>
 <20070521113415.GY5412@admingilde.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Mon May 21 14:19:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq6rR-0001pM-Ft
	for gcvg-git@gmane.org; Mon, 21 May 2007 14:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755938AbXEUMTb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 08:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756328AbXEUMTb
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 08:19:31 -0400
Received: from psmtp09.wxs.nl ([195.121.247.23]:61702 "EHLO psmtp09.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755721AbXEUMTa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 08:19:30 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp09.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JIE00JDW4WHG9@psmtp09.wxs.nl> for git@vger.kernel.org; Mon,
 21 May 2007 14:19:29 +0200 (MEST)
Received: (qmail 9405 invoked by uid 500); Mon, 21 May 2007 12:19:29 +0000
In-reply-to: <20070521113415.GY5412@admingilde.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48014>

On Mon, May 21, 2007 at 01:34:15PM +0200, Martin Waitz wrote:
> hoi :)
> 
> On Mon, May 21, 2007 at 12:14:55PM +0200, Sven Verdoolaege wrote:
> > How?  AFAICS, it's upload-pack of the *clonee* that determines
> > where the actual git dir is.  The cloner has no clue.
> 
> we can just store the link to the workdir-or-gitdir and then try
> it out every time we access it.  When clone stores the location
> of the parent repository it doesn't know what it points to, but
> fetch works, too.

clone is just init + fetch (well, almost).
The comment above applies to fetching as well.

skimo
