From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] fix display overlap between remote and local progress
Date: Sun, 04 Nov 2007 16:19:52 -0500 (EST)
Message-ID: <alpine.LFD.0.9999.0711041610520.21255@xanadu.home>
References: <alpine.LFD.0.9999.0711032328490.21255@xanadu.home>
 <Pine.LNX.4.64.0711041331520.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 04 22:20:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IomtH-0003bB-9T
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 22:20:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752975AbXKDVTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 16:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752974AbXKDVTy
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 16:19:54 -0500
Received: from relais.videotron.ca ([24.201.245.36]:49639 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953AbXKDVTx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 16:19:53 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JR000AD2394H180@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 04 Nov 2007 16:19:52 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <Pine.LNX.4.64.0711041331520.4362@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63443>

On Sun, 4 Nov 2007, Johannes Schindelin wrote:

> Hi,
> 
> On Sun, 4 Nov 2007, Nicolas Pitre wrote:
> 
> > +#define SUFFIX "\e[K"  /* change to "        " if ANSI sequences don't work */ 
> 
> I am almost certain (without even testing) that cmd.exe has problems with 
> that.  It does not even understand colorisation.

That's what I was expecting.  This is why I suggested an alternative in 
the comment.


Nicolas
