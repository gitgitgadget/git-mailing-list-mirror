From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a --user option to git-config
Date: Wed, 1 Aug 2007 19:13:35 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708011913070.14781@racer.site>
References: <46AB7041.8070605@ramsay1.demon.co.uk> <Pine.LNX.4.64.0707282103150.14781@racer.site>
 <46AFAF7D.7010306@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Aug 01 20:14:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGIiI-0005tz-FE
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 20:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877AbXHASOA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 14:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752748AbXHASOA
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 14:14:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:43206 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751620AbXHASN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 14:13:59 -0400
Received: (qmail invoked by alias); 01 Aug 2007 18:13:57 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp028) with SMTP; 01 Aug 2007 20:13:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18sZ6cPSIwsQ2NQWxeHdGhj/0JbP/qx670J3ufSrL
	19tuQIqmp2k8U7
X-X-Sender: gene099@racer.site
In-Reply-To: <46AFAF7D.7010306@ramsay1.demon.co.uk>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54460>

Hi,

On Tue, 31 Jul 2007, Ramsay Jones wrote:

> Johannes Schindelin wrote:
> > On Sat, 28 Jul 2007, Ramsay Jones wrote:
> > 
> >> At present, the --global option is something of a misnomer, so
> >> we introduce the --user option as a synonym, with the intention
> >> of removing the old option in the future.
> > 
> > Ack for the intention, except for "removing the old option in the future".  
> > We do not need to advertise it, but breaking existing functionality, which 
> > might be used by scripts and aliases is bad.
> > 
> 
> Yep, which is why I made it a synonym; git-gui uses the --global option, for
> example, and I'm confident that other (user) scripts use it too. The "future"
> I had in mind was something like 1 year down the road, but it could be longer
> (or forever) if necessary.

Please read my reply as "I vote against ever removing the --global 
option".

Ciao,
Dscho
