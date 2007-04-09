From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 11/10] allow forcing index v2 and 64-bit offset treshold
Date: Mon, 09 Apr 2007 19:04:52 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704091901290.28181@xanadu.home>
References: <alpine.LFD.0.98.0704091727300.28181@xanadu.home>
 <7vps6dxjvb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 10 04:24:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hb2uu-00012x-0y
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 01:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753640AbXDIXEy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 19:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753616AbXDIXEy
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 19:04:54 -0400
Received: from relais.videotron.ca ([24.201.245.36]:37010 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753607AbXDIXEx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 19:04:53 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG900GJX6S4OCW0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 09 Apr 2007 19:04:52 -0400 (EDT)
In-reply-to: <7vps6dxjvb.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44096>

On Mon, 9 Apr 2007, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > This is necessary for testing the new capabilities in some automated 
> > way without having an actual 4GB+ pack.
> >
> > Signed-off-by: Nicolas Pitre <nico@cam.org>
> > ---
> >
> > I should write some tests... when I have more time.
> 
> It appears everybody is short of time.  I am having two
> troubles.  Nobody seems to have positive nor negative reports or
> comments on what are cooking in 'next' so nothing can graduate,
> and I am behind list discussions on certain areas myself.

At least my latest patch series received two positive reviews.  ;-)

> > ddiff --git a/t/Makefile b/t/Makefile
> 
> ???

Remnant of a change to that file which was later reverted but mtime 
doesn't match the index.


Nicolas
