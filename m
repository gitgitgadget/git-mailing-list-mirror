From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Libification project (SoC)
Date: Mon, 19 Mar 2007 14:55:21 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703191453040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vps79wueu.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703161251200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070316130958.GD1783@peter.daprodeges.fqdn.th-h.de>
 <Pine.LNX.4.63.0703161509560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070318140816.GG4489@pasky.or.cz> <Pine.LNX.4.63.0703190045520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070319012111.GS18276@pasky.or.cz> <Pine.LNX.4.63.0703190235330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <e5bfff550703190001k761541c7v2c259ef3f7695b10@mail.gmail.com>
 <Pine.LNX.4.63.0703191329220.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070319125233.GT18276@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marco Costalba <mcostalba@gmail.com>, Rocco Rutte <pdmef@gmx.net>,
	git@vger.kernel.org, tytso@mit.edu, spearce@spearce.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Mar 19 14:55:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTIKa-0003Tm-Mp
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 14:55:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933895AbXCSNzY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 09:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933913AbXCSNzY
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 09:55:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:50329 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933895AbXCSNzX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 09:55:23 -0400
Received: (qmail invoked by alias); 19 Mar 2007 13:55:22 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 19 Mar 2007 14:55:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+EEMpmMcKEfDGlr1xnfbgPI8yAV3GdrD9stK1Dsb
	D6PA08MkDwwDs3
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070319125233.GT18276@pasky.or.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42619>

Hi,

On Mon, 19 Mar 2007, Petr Baudis wrote:

> On Mon, Mar 19, 2007 at 01:37:18PM CET, Johannes Schindelin wrote:
> > Yes, you could write a program which can compare objects from several 
> > repos, but that is easy in fact: just set GIT_ALTERNATE_OBJECT_DIRECTORIES 
> > and you're done. Without changing the core of Git at all!
> 
> But you'll also need to access refs.

Yes, and you want it to bake some fine pizza, too.

> And the key point here is reentrance - handling multiple repositories at 
> once is only part of this, actually probably the much bigger customer 
> would be multi-threaded programs. And easier creation of reusable 
> components and other libraries, and so on...
> 
> I believe the performance impact will be most likely absolutely 
> negligible. Of course we have no hard data, but I doubt it's this where 
> most of the CPU crunching is.

My time is very limited, and I see this thread going nowhere since 
everybody says "I like this, I like that", and nobody shows some hard data 
(me included). It almost feels like a Windows user community. Or Slashdot.

Anyway, I refuse to comment on these issues until somebody proves me wrong 
or right in my assumption that the impact on core Git (in terms of time 
_or_ lines of code) would be huge.

Ciao,
Dscho
