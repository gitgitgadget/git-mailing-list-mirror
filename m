From: Nicolas Pitre <nico@cam.org>
Subject: Re: A look at some alternative PACK file encodings
Date: Wed, 06 Sep 2006 20:40:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0609062037560.18635@xanadu.home>
References: <44FF41F4.1090906@gmail.com>
 <9e4733910609061623k73086dbey4a600ecf2852c024@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: gitzilla@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 02:41:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL7wj-0008UI-96
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 02:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161030AbWIGAkm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 20:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161033AbWIGAkm
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 20:40:42 -0400
Received: from relais.videotron.ca ([24.201.245.36]:53143 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1161030AbWIGAkl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 20:40:41 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J5700C865VSV1A0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 06 Sep 2006 20:40:40 -0400 (EDT)
In-reply-to: <9e4733910609061623k73086dbey4a600ecf2852c024@mail.gmail.com>
X-X-Sender: nico@xanadu.home
To: Jon Smirl <jonsmirl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26579>

On Wed, 6 Sep 2006, Jon Smirl wrote:

> Shawn is doing some prototype work on true dictionary based
> compression. I don't know how far along he is but it has potential for
> taking 30% off the Mozilla pack.

BTW I'm half-way done with support for deltas which base object is 
referenced with an offset in the pack instead of a hash.  It is quite 
messy though since it touches pretty core code all over the place when 
it comes to fetching objects out of a pack.


Nicolas
