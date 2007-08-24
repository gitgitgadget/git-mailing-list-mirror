From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-daemon on NSLU2
Date: Fri, 24 Aug 2007 16:23:10 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0708241618070.16727@xanadu.home>
References: <9e4733910708232254w4e74ca72o917c7cadae4ee0f4@mail.gmail.com>
 <20070824062106.GV27913@spearce.org>
 <9e4733910708241238n1899f332j4fafbd6d7ccc48b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 22:23:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOfgb-0000ir-BT
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 22:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921AbXHXUXM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 16:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752883AbXHXUXM
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 16:23:12 -0400
Received: from relais.videotron.ca ([24.201.245.36]:61998 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589AbXHXUXM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 16:23:12 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JNA00F6NOMMBC50@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 24 Aug 2007 16:23:10 -0400 (EDT)
In-reply-to: <9e4733910708241238n1899f332j4fafbd6d7ccc48b9@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56597>

On Fri, 24 Aug 2007, Jon Smirl wrote:

> I'm still trying to debug git-daemon
> 
> I do find it surprising that git-index-pack can't be happy with in
> 20MB of RAM and it has to continuously swap it's 30MB of virtual. My
> disk is chattering itself to death. It stayed that way for 40 minutes.
> 
> I'm practicing on the kernel tree.

You hope for miracles, do you?  ;-)

Please stop hammering that poor little NSLU2 with such a workset, or 
hack some additional 224MB of RAM into it.  There is no magical 
solution.


Nicolas
