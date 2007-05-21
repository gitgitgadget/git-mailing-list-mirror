From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [RFC] Third round of support for cloning submodules
Date: Mon, 21 May 2007 12:14:55 +0200
Message-ID: <20070521101455.GK942MdfPADPa@greensroom.kotnet.org>
References: <11796842882917-git-send-email-skimo@liacs.nl>
 <20070520225252.GO5412@admingilde.org>
 <20070521085419.GG942MdfPADPa@greensroom.kotnet.org>
 <20070521100716.GX5412@admingilde.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Mon May 21 12:15:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq4v4-0003p3-TJ
	for gcvg-git@gmane.org; Mon, 21 May 2007 12:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763070AbXEUKO7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 06:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762312AbXEUKO7
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 06:14:59 -0400
Received: from psmtp13.wxs.nl ([195.121.247.25]:51298 "EHLO psmtp13.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762720AbXEUKO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 06:14:57 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp13.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JID000KFZ4W9T@psmtp13.wxs.nl> for git@vger.kernel.org; Mon,
 21 May 2007 12:14:56 +0200 (MEST)
Received: (qmail 7136 invoked by uid 500); Mon, 21 May 2007 10:14:56 +0000
In-reply-to: <20070521100716.GX5412@admingilde.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48005>

On Mon, May 21, 2007 at 12:07:16PM +0200, Martin Waitz wrote:
> > The problem with relative paths is that you don't know if the
> > URL the user gave you points to the working directory or the
> > git directory of the project, but I guess I can let dump-config
> > tell you where it found the config file.
> 
> We have already solved that in clone & fetch so I don't think this is a
> real problem.

How?  AFAICS, it's upload-pack of the *clonee* that determines
where the actual git dir is.  The cloner has no clue.

skimo
