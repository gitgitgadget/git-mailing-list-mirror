From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] git-fetch - repack in the background after fetching
Date: Sun, 25 Jun 2006 11:25:02 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606251122260.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11511486003924-git-send-email-martin@catalyst.net.nz>
 <Pine.LNX.4.64.0606242049500.3747@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin@catalyst.net.nz>, git@vger.kernel.org,
	junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Jun 25 11:25:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuQri-0007e1-Ga
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 11:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWFYJZG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 05:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWFYJZG
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 05:25:06 -0400
Received: from mail.gmx.de ([213.165.64.21]:33429 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932159AbWFYJZF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jun 2006 05:25:05 -0400
Received: (qmail invoked by alias); 25 Jun 2006 09:25:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 25 Jun 2006 11:25:04 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606242049500.3747@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22594>

Hi,

On Sat, 24 Jun 2006, Linus Torvalds wrote:

> However, the more worrisome thing about background repacking is that while 
> it should be safe against normal users, if you have two _repacks_ at the 
> same time, they can decide to remove each others packs. Yeah, yeah, that's 
> pretty damn unlikely, but hey, "pretty damn unlikely" is not "impossible".

Why not introduce a lock file for repack?

Ciao,
Dscho
