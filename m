From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] diff-delta: produce optimal pack data
Date: Fri, 24 Feb 2006 14:03:29 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602241358070.31162@localhost.localdomain>
References: <Pine.LNX.4.64.0602212043260.5606@localhost.localdomain>
 <7v4q2pf8fq.fsf@assigned-by-dhcp.cox.net>
 <20060224174422.GA13367@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0602241252300.31162@localhost.localdomain>
 <20060224184934.GA387@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 20:03:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCiE1-000346-JS
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 20:03:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWBXTDa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 14:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWBXTDa
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 14:03:30 -0500
Received: from relais.videotron.ca ([24.201.245.36]:29877 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932258AbWBXTDa
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 14:03:30 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IV700J3LGXTN7G0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 24 Feb 2006 14:03:29 -0500 (EST)
In-reply-to: <20060224184934.GA387@hpsvcnb.fc.hp.com>
X-X-Sender: nico@localhost.localdomain
To: Carl Baldwin <cnb@fc.hp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16727>

On Fri, 24 Feb 2006, Carl Baldwin wrote:

> I've updated to a very current master branch.  This seems to include the
> pack data reuse stuff.  I've not made an attempt yet to apply your delta
> patches.
> 
> git-repack quickly gets up to 5% (2/36) and hangs there.  I'll let it
> run for a while just to see how far it claims to get.  I'm not hopeful.

It should complete sometimes, probably after the same amount of time 
needed by your previous clone attempt.  But after that any clone 
operation should be quick.  This is clearly unacceptable but at least 
with the pack data reuse you should suffer only once for the initial 
repack.

> Maybe your patches can help?

No.  They actually make things worse performance wise, much worse in 
some special cases.

Is it possible for me to have access to 2 consecutive versions of your 
big binary file?


Nicolas
