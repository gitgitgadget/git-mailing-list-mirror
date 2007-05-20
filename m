From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 06/15] git-read-tree: take --submodules option
Date: Sun, 20 May 2007 23:50:24 +0200
Message-ID: <20070520215024.GD942MdfPADPa@greensroom.kotnet.org>
References: <11796842882917-git-send-email-skimo@liacs.nl>
 <11796842893584-git-send-email-skimo@liacs.nl>
 <20070520212404.GK5412@admingilde.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Sun May 20 23:50:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HptIN-0001EQ-0v
	for gcvg-git@gmane.org; Sun, 20 May 2007 23:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756648AbXETVu0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 17:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756876AbXETVu0
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 17:50:26 -0400
Received: from psmtp08.wxs.nl ([195.121.247.22]:57452 "EHLO psmtp08.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756648AbXETVuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 17:50:25 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp08.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JID00DF70O0XQ@psmtp08.wxs.nl> for git@vger.kernel.org; Sun,
 20 May 2007 23:50:24 +0200 (MEST)
Received: (qmail 2107 invoked by uid 500); Sun, 20 May 2007 21:50:24 +0000
In-reply-to: <20070520212404.GK5412@admingilde.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47930>

On Sun, May 20, 2007 at 11:24:04PM +0200, Martin Waitz wrote:
> hoi :)
> 
> what really is the motivation to suppress submodule checkout at this
> level?  I can see that we need some per-submodule option for checkout,
> but this should influence the actual checkout process and not
> read-tree.

It's only used with update is set.

> At least we really want to always update the index correctly and a
> read-tree --no-submodules  which updates the index for submodules but
> doesn't go into existing submodules just feels wrong.

It doesn't do that.

skimo
