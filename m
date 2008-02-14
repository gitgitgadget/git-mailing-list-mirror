From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Thu, 14 Feb 2008 15:16:35 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802141512580.2732@xanadu.home>
References: <200802081828.43849.kendy@suse.cz>
 <m3ejbngtnn.fsf@localhost.localdomain> <200802091627.25913.kendy@suse.cz>
 <alpine.LFD.1.00.0802092200350.2732@xanadu.home>
 <alpine.LSU.1.00.0802101640570.11591@racer.site>
 <alpine.LSU.1.00.0802101845320.11591@racer.site>
 <alpine.LSU.1.00.0802122036150.3870@racer.site>
 <alpine.LSU.1.00.0802141917420.30505@racer.site>
 <m3y79nb8xk.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jan Holesovsky <kendy@suse.cz>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 21:17:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPkW8-0008IX-8s
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 21:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757362AbYBNUQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 15:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757215AbYBNUQi
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 15:16:38 -0500
Received: from relais.videotron.ca ([24.201.245.36]:18737 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754781AbYBNUQh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 15:16:37 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JW80010VWBN3F90@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 14 Feb 2008 15:16:36 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <m3y79nb8xk.fsf@localhost.localdomain>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73913>

On Thu, 14 Feb 2008, Jakub Narebski wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > The result is:
> > 
> > $ ls -la objects/pack/pack-e4dc6da0a10888ec4345490575efc587b7523b45.pack
> > -rwxrwxrwx 1 root root 1638490531 2008-02-14 17:51 
> > objects/pack/pack-e4dc6da0a10888ec4345490575efc587b7523b45.pack
> > 
> > 1.6G looks much better than 2.4G, wouldn't you say?  Jan, if you want it, 
> > please give me a place to upload it to.
> 
> Brandon Casey wrote:
> 
> > I have successfully repacked this repo a few times on a 2.1GHz
> > system with 16G.
> > 
> > The smallest attained pack was about 1.45G (1556569742B).
> 
> Hmmm... I wonder if packv4 would help...

No.  Well, it would help a bit, maybe in the 10-20% range, but nothing 
as significant as going from 2.6G to 1.5G, or like in the GCC case, from 
1.3G to 230M.


Nicolas
