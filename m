From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 09:24:04 +0200
Message-ID: <20070524072404.GF942MdfPADPa@greensroom.kotnet.org>
References: <11799589913153-git-send-email-skimo@liacs.nl>
 <Pine.LNX.4.64.0705240039370.4113@racer.site>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 24 09:24:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hr7g8-00036F-Re
	for gcvg-git@gmane.org; Thu, 24 May 2007 09:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754913AbXEXHYI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 03:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756095AbXEXHYI
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 03:24:08 -0400
Received: from psmtp12.wxs.nl ([195.121.247.24]:43744 "EHLO psmtp12.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754913AbXEXHYF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 03:24:05 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp12.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JIJ00H33B84YQ@psmtp12.wxs.nl> for git@vger.kernel.org; Thu,
 24 May 2007 09:24:04 +0200 (MEST)
Received: (qmail 10081 invoked by uid 500); Thu, 24 May 2007 07:24:04 +0000
In-reply-to: <Pine.LNX.4.64.0705240039370.4113@racer.site>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48232>

On Thu, May 24, 2007 at 12:40:20AM +0100, Johannes Schindelin wrote:
> On Thu, 24 May 2007, skimo@liacs.nl wrote:
> > This patch series implements a mechanism for cloning submodules.
> > Each submodule is specified by a 'submodule.<submodule>.url'
> > configuration option, e.g.,
> > 
> > bash-3.00$ ./git-config --remote=http://www.liacs.nl/~sverdool/isa.git --get-regexp 'submodule\..*\.url' 
> > submodule.cloog.url /home/sverdool/public_html/cloog.git
> > submodule.cloog.url http://www.liacs.nl/~sverdool/cloog.git
> 
> I am sorry to complain so late in the game, but I am not really interested 
> in submodules. However, what you say here is not a task for git-config 
> IMHO, but rather for git-remote.

Hmmm... git-remote does only local configuration and never gets
any information from the other side.
What would be the interface and how would you get the information?

skimo
