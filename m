From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Fri, 25 May 2007 16:38:15 +0200
Message-ID: <20070525143815.GF942MdfPADPa@greensroom.kotnet.org>
References: <Pine.LNX.4.64.0705240039370.4113@racer.site>
 <200705251427.46903.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.64.0705251343550.4648@racer.site>
 <200705251559.53846.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.64.0705251514220.4648@racer.site>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	Lars Hjemli <hjemli@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 25 16:38:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hravz-0007Zv-HA
	for gcvg-git@gmane.org; Fri, 25 May 2007 16:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752758AbXEYOiS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 10:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753284AbXEYOiS
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 10:38:18 -0400
Received: from psmtp04.wxs.nl ([195.121.247.13]:57654 "EHLO psmtp04.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752758AbXEYOiR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 10:38:17 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp04.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JIL003P9PZR0I@psmtp04.wxs.nl> for git@vger.kernel.org; Fri,
 25 May 2007 16:38:16 +0200 (MEST)
Received: (qmail 17822 invoked by uid 500); Fri, 25 May 2007 14:38:15 +0000
In-reply-to: <Pine.LNX.4.64.0705251514220.4648@racer.site>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48381>

On Fri, May 25, 2007 at 03:16:56PM +0100, Johannes Schindelin wrote:
> And the point about my config being private still stands. You have no 
> business looking into my config.

Put your private configuration in config and your public configuration
in submodulesconfig.
A public repo typically wouldn't have any submodules configuration
in config (or any other private information for that matter), but
we wouldn't read it anyway.

skimo
