From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] nicer eye candies for pack-objects
Date: Wed, 22 Feb 2006 17:37:06 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602221733030.5606@localhost.localdomain>
References: <Pine.LNX.4.64.0602221549250.5606@localhost.localdomain>
 <7vy803kp1n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 23:38:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FC2c6-0002Ld-6N
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 23:37:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbWBVWhc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Feb 2006 17:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751582AbWBVWhb
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Feb 2006 17:37:31 -0500
Received: from relais.videotron.ca ([24.201.245.36]:43412 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751575AbWBVWhH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2006 17:37:07 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IV400NNZ1HU34G0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 22 Feb 2006 17:37:06 -0500 (EST)
In-reply-to: <7vy803kp1n.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16620>

On Wed, 22 Feb 2006, Junio C Hamano wrote:

> I like this, but like the "every second or every percent
> whichever comes first" unpack-objects does even better.  How
> about something like this on top of your patch?

Well... my concern is (if I'm right) that this status is generated 
remotely and sent over the network when performing a fetch.  The "every 
percent" might in this case generate quite some significant overhead if 
the pack is small.

Also (personal opinion) such progress numbers are harder to read when 
they change too fast.


Nicolas
