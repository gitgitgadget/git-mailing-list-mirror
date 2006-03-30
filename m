From: Paul Mackerras <paulus@samba.org>
Subject: Re: Gitk strangeness..
Date: Fri, 31 Mar 2006 09:33:11 +1100
Message-ID: <17452.23719.400996.78248@cargo.ozlabs.ibm.com>
References: <7v64lzo1j7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603271802030.15714@g5.osdl.org>
	<17448.40941.256361.866229@cargo.ozlabs.ibm.com>
	<7vr74nmg7e.fsf@assigned-by-dhcp.cox.net>
	<17448.48143.764989.649462@cargo.ozlabs.ibm.com>
	<7vmzfbm8m0.fsf@assigned-by-dhcp.cox.net>
	<17448.54558.865097.519248@cargo.ozlabs.ibm.com>
	<7vzmjbj9a1.fsf@assigned-by-dhcp.cox.net>
	<17449.48630.370867.10251@cargo.ozlabs.ibm.com>
	<20060330205759.GA27131@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Mar 31 00:57:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FP63L-0001ph-6e
	for gcvg-git@gmane.org; Fri, 31 Mar 2006 00:55:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWC3Wzk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Mar 2006 17:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbWC3Wzk
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Mar 2006 17:55:40 -0500
Received: from ozlabs.org ([203.10.76.45]:31908 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750929AbWC3Wzk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Mar 2006 17:55:40 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 2D8E6679EF; Fri, 31 Mar 2006 09:55:39 +1100 (EST)
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20060330205759.GA27131@steel.home>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18208>

Alex Riesen writes:

> Well... Could you take a look at these screenshots, please?
> http://home.arcor.de/fork0/bug/gitk1.jpg (this one is BIG, 400k, 2456x949)
> http://home.arcor.de/fork0/bug/gitk2.jpg
> http://home.arcor.de/fork0/bug/gitk3.jpg

Yes, I was just looking last night at the part of the git.git graph
that you have there in gitk1.jpg.  That's an artifact of some changes
I made to make sure there was a vertical line segment just before an
arrow.  The reason for doing that is that Tk 8.4 seems to just punt on
drawing an arrow on the end of a diagonal line segment.  The old gitk
just removed trailing diagonal segments of the line, but I thought I
could do better than that.

I'll try another approach.

Paul.
