From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 09:22:16 +0200
Message-ID: <20070524072216.GE942MdfPADPa@greensroom.kotnet.org>
References: <11799589913153-git-send-email-skimo@liacs.nl>
 <Pine.LNX.4.64.0705240039370.4113@racer.site>
 <7vtzu3yrh9.fsf@assigned-by-dhcp.cox.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 24 09:22:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hr7eP-0002pu-JO
	for gcvg-git@gmane.org; Thu, 24 May 2007 09:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755148AbXEXHWS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 03:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756132AbXEXHWS
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 03:22:18 -0400
Received: from psmtp04.wxs.nl ([195.121.247.13]:36017 "EHLO psmtp04.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755148AbXEXHWR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 03:22:17 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp04.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JIJ004NCB54WM@psmtp04.wxs.nl> for git@vger.kernel.org; Thu,
 24 May 2007 09:22:16 +0200 (MEST)
Received: (qmail 10059 invoked by uid 500); Thu, 24 May 2007 07:22:16 +0000
In-reply-to: <7vtzu3yrh9.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48231>

On Wed, May 23, 2007 at 05:50:42PM -0700, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > On Thu, 24 May 2007, skimo@liacs.nl wrote:
> >> bash-3.00$ ./git-config --remote=http://www.liacs.nl/~sverdool/isa.git --get-regexp 'submodule\..*\.url' 
> >> submodule.cloog.url /home/sverdool/public_html/cloog.git
> >> submodule.cloog.url http://www.liacs.nl/~sverdool/cloog.git
> >
> > I am sorry to complain so late in the game, but I am not really interested 
> > in submodules. However, what you say here is not a task for git-config 
> > IMHO, but rather for git-remote.
> 
> Honestly speaking, I do not think people have no business
> peeking into configuratoin remote repository has, and it would
> be preferrable that supermodule Porcelain stuff does not rely on
> that.

Maybe there are too many negations in that sentence, but are you
saying it is ok to look into the remote configuration or not?

skimo
