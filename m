From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 16:29:49 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704171624190.4504@xanadu.home>
References: <200704171041.46176.andyparkins@gmail.com>
 <"200704171803.58940.an dyparkins"@gmail.com>
 <200704172012.31280.andyparkins@gmail.com>
 <alpine.LFD.0.98.0704171530220.4504@xanadu.home>
 <Pine.LNX.4.63.0704171244450.1696@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
To: David Lang <david.lang@digitalinsight.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 22:29:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HduJG-0007tB-MM
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 22:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161331AbXDQU3v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 16:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161334AbXDQU3v
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 16:29:51 -0400
Received: from relais.videotron.ca ([24.201.245.36]:61115 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161331AbXDQU3u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 16:29:50 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGN00BA3SXPG930@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 17 Apr 2007 16:29:50 -0400 (EDT)
In-reply-to: <Pine.LNX.4.63.0704171244450.1696@qynat.qvtvafvgr.pbz>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44818>

On Tue, 17 Apr 2007, David Lang wrote:

> On Tue, 17 Apr 2007, Nicolas Pitre wrote:
> 
> > I cannot do otherwise than ask at this point in the debate: why isn't
> > the makefile rule sufficient for your needs?  Why going through a
> > complicated path that no one else will support due to its numerous
> > pitfalls?
> 
> not all uses of VCS's involve useing make

Use perl then.  Or a shell script.  Or even a command.com batch script.  
Or your own tool.

> > > That's just being obtuse - no other tool cares in the slightest about
> > > the keywords, there are more "tools" in the world than just the VCS.
> > 
> > ... which reinforces my question: why force a task on the VCS if it
> > doesn't fit well with its fundamental design?
> 
> becouse the VCS can do the job better then anything else?

On what basis?

> even if there are
> limits to what the VCS can do.

In the context of keyword expansion I don't agree at all with this 
statement.  Git can *not* do better than an external tool and it has 
been demonstrated a few times already.


Nicolas
