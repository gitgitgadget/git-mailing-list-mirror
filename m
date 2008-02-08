From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Fri, 08 Feb 2008 15:09:56 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802081457170.2732@xanadu.home>
References: <200802081828.43849.kendy@suse.cz>
 <m3ejbngtnn.fsf@localhost.localdomain>
 <9e4733910802081126r5bf19c95rec817a1b6648ee4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>, Jan Holesovsky <kendy@suse.cz>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 21:10:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNZYP-0002iV-3S
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 21:10:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932717AbYBHUJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 15:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932670AbYBHUJ6
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 15:09:58 -0500
Received: from relais.videotron.ca ([24.201.245.36]:38556 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932587AbYBHUJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 15:09:57 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JVX001MAS0KYZ50@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 08 Feb 2008 15:09:56 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <9e4733910802081126r5bf19c95rec817a1b6648ee4d@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73129>

On Fri, 8 Feb 2008, Jon Smirl wrote:

> There are some patches for making repack work multi-core. Not sure if
> they made it into the main git tree yet.

Yes, they are.  You need to compile with"make THREADED_DELTA_SEARCH=yes" 
or add THREADED_DELTA_SEARCH=yes into config.mak for it to be enabled 
though.  Then you have to set the pack.threads configuration variable 
appropriately to use it.


Nicolas
