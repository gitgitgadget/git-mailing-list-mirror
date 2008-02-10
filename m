From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Sun, 10 Feb 2008 14:50:49 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802101445430.2732@xanadu.home>
References: <200802081828.43849.kendy@suse.cz>
 <m3ejbngtnn.fsf@localhost.localdomain> <200802091627.25913.kendy@suse.cz>
 <alpine.LFD.1.00.0802092200350.2732@xanadu.home>
 <alpine.LSU.1.00.0802101640570.11591@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jan Holesovsky <kendy@suse.cz>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 10 20:51:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOID4-0005Jb-6n
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 20:51:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830AbYBJTu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 14:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752813AbYBJTu4
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 14:50:56 -0500
Received: from relais.videotron.ca ([24.201.245.36]:9800 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458AbYBJTuz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 14:50:55 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JW100KZAGGI5280@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 10 Feb 2008 14:50:47 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LSU.1.00.0802101640570.11591@racer.site>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73394>

On Sun, 10 Feb 2008, Johannes Schindelin wrote:

> I tried that:
> 
> $ git config pack.deltaCacheLimit 1
> $ git config pack.deltaCacheSize 1
> $ git config pack.windowMemory 2g

This has nothing to do with repacking memory usage, but even tighter 
packs can be obtained with:

	git config repack.usedeltabaseoffset true

This is not the default yet.


Nicolas
