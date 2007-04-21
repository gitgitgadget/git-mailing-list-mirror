From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Fri, 20 Apr 2007 22:06:56 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704202203200.4504@xanadu.home>
References: <200704171041.46176.andyparkins@gmail.com>
 <"200704171803.58940.an dyparkins"@gmail.com>
 <200704172012.31280.andyparkins@gmail.com>
 <"alpine.LFD.0.98.0704171530220.45 04"@xanadu.home>
 <Pine.LNX.4.63.0704171244450.1696@qynat.qvtvafvgr.pbz>
 <"alpin e.LFD.0.98.0704171624190.4504"@xanadu.home>
 <Pine.LNX.4.63.0704171302200.1696@qynat.qvtvafvgr.pbz>
 <alpine.LFD.0.98.0704171708360.4504@xanadu.home>
 <7vy7kqlj5r.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0704201605580.4634@qynat.qvtvafvgr.pbz>
 <7vbqhiwky4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: David Lang <david.lang@digitalinsight.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 21 04:07:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hf50c-0003Hx-QH
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 04:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048AbXDUCG6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 22:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754060AbXDUCG6
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 22:06:58 -0400
Received: from relais.videotron.ca ([24.201.245.36]:57050 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754048AbXDUCG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 22:06:57 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGT00B5KSJKKL21@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 20 Apr 2007 22:06:56 -0400 (EDT)
In-reply-to: <7vbqhiwky4.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45147>

On Fri, 20 Apr 2007, Junio C Hamano wrote:

> The point of my comment was that with Andy's definition of when
> the "external tools" should trigger, that CPU serial number
> embedder would _NOT_ trigger for a path when you switch branches
> that have the same contents at that path.  External tools can do
> stupid things and that is what you are calling the rope.  But
> the case I am talking about is that we deliberately do _not_
> call external tools, so even if external tools can do sensible
> things if given a chance to, they are not given a chance to do
> so, and deciding not to call them in some cases is made by us.

And that's a fairly acceptable limitation IMHO, which doesn't make the 
thing any less useful for many cases.  We just need to document it 
appropriately.


Nicolas
