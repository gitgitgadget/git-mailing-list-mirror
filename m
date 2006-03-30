From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Gitk strangeness..
Date: Thu, 30 Mar 2006 22:57:59 +0200
Message-ID: <20060330205759.GA27131@steel.home>
References: <7v64lzo1j7.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0603271802030.15714@g5.osdl.org> <17448.40941.256361.866229@cargo.ozlabs.ibm.com> <7vr74nmg7e.fsf@assigned-by-dhcp.cox.net> <17448.48143.764989.649462@cargo.ozlabs.ibm.com> <7vmzfbm8m0.fsf@assigned-by-dhcp.cox.net> <17448.54558.865097.519248@cargo.ozlabs.ibm.com> <7vzmjbj9a1.fsf@assigned-by-dhcp.cox.net> <17449.48630.370867.10251@cargo.ozlabs.ibm.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Mar 30 22:58:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FP4E5-0007L5-Ow
	for gcvg-git@gmane.org; Thu, 30 Mar 2006 22:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbWC3U6j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Mar 2006 15:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbWC3U6i
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Mar 2006 15:58:38 -0500
Received: from devrace.com ([198.63.210.113]:22283 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1750894AbWC3U6i (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Mar 2006 15:58:38 -0500
Received: from tigra.home (p54A0538A.dip.t-dialin.net [84.160.83.138])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k2UKw8Ej030821;
	Thu, 30 Mar 2006 14:58:20 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1FP4DQ-00066t-00; Thu, 30 Mar 2006 22:58:00 +0200
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1FP4DP-0007ZW-Rd; Thu, 30 Mar 2006 22:57:59 +0200
To: Paul Mackerras <paulus@samba.org>
Content-Disposition: inline
In-Reply-To: <17449.48630.370867.10251@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,BAYES_50,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18206>

Paul Mackerras, Wed, Mar 29, 2006 00:51:34 +0200:
> Junio C Hamano writes:
> 
> > How about this alternative patch, then?  It turned out to be
> > quite convoluted as I feared.
> 
> That's brilliant.  Thank you!  With the patch to gitk below, the
> graph display on Linus' example looks much saner.
> 

Well... Could you take a look at these screenshots, please?
http://home.arcor.de/fork0/bug/gitk1.jpg (this one is BIG, 400k, 2456x949)
http://home.arcor.de/fork0/bug/gitk2.jpg
http://home.arcor.de/fork0/bug/gitk3.jpg

The compressed repository is being uploaded there:

http://home.arcor.de/fork0/bug/ggg.tar.bz2 (~6Mb)

The old gitk produced a denser graph, which wasn't perfect too, but
had a higher count of visible commit titles (and this is two-monitor
setup, too).
