From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Deltification library work by Nicolas Pitre.
Date: Thu, 19 May 2005 11:14:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0505191104410.20274@localhost.localdomain>
References: <7vwtpv1pd4.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.62.0505191019180.20274@localhost.localdomain>
 <Pine.LNX.4.58.0505190736020.2322@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 17:19:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYmlD-0003id-Lz
	for gcvg-git@gmane.org; Thu, 19 May 2005 17:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbVESPQV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 11:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbVESPQV
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 11:16:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:23595 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S262540AbVESPO0
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 11:14:26 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR010.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IGQ000NPSZHB1@VL-MO-MR010.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 19 May 2005 11:14:05 -0400 (EDT)
In-reply-to: <Pine.LNX.4.58.0505190736020.2322@ppc970.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 19 May 2005, Linus Torvalds wrote:

> Sure. I'll apply this one and merge in Junio's rename on top of it, but I 
> wanted to verify one thing first:
> 
> > + *  This file is free software; you can redistribute it and/or
> > + *  modify it under the terms of the GNU Lesser General Public
> > + *  License as published by the Free Software Foundation; either
> > + *  version 2.1 of the License, or (at your option) any later version.
> 
> I don't know the different LGPL versions, so can somebody verify that LGPL
> 2.1 is fully compatible with GPLv2...
> 
> In fact I'd prefer to have that notice in the code to make it obvious that 
> the LGPL becomes the GPLv2 when linked into the rest of git.

I don't mind switching it to GPL v2 if I'm allowed to.  I kept LGPL v2.1 
for that file since that's the license used for xdiff where significant 
portion of that file has been copied from.

In fact I think the code in that file might be simplified even further 
eventually, at which point there  might not be much of the original code 
left anymore and the license switched to GPL v2.  But in the mean time 
someone else with better knowledge of GPL vs LGPL interaction is needed 
to give advice.


Nicolas
