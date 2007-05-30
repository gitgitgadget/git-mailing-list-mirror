From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] diff-delta: use realloc instead of xrealloc
Date: Tue, 29 May 2007 22:57:06 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705292252220.11491@xanadu.home>
References: <1180465715346-git-send-email-mkoegler@auto.tuwien.ac.at>
 <7v1wgz5gus.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 30 04:57:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtENC-0007QM-Ro
	for gcvg-git@gmane.org; Wed, 30 May 2007 04:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbXE3C5K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 22:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbXE3C5K
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 22:57:10 -0400
Received: from relais.videotron.ca ([24.201.245.36]:27833 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbXE3C5J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 22:57:09 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JIU001TZ2V6Y0G0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 29 May 2007 22:57:07 -0400 (EDT)
In-reply-to: <7v1wgz5gus.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48726>

On Tue, 29 May 2007, Junio C Hamano wrote:

> Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:
> 
> > Commit 83572c1a914d3f7a8dd66d954c11bbc665b7b923 changed many
> > realloc to xrealloc. This change was made in diff-delta.c too,
> > although the code can handle an out of memory failure.
> >
> > This patch reverts this change in diff-delta.c.
> 
> Wasn't there a discussion around this exact issue when the
> original patch was applied?

Maybe, but I cannot remember it, not can I justify that xrealloc now.


Nicolas
