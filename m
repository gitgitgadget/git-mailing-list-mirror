From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: New shiny gitk
Date: Sun, 19 Feb 2006 19:30:52 +0100
Message-ID: <20060219183051.GA10010@steel.home>
References: <17400.23434.724188.649656@cargo.ozlabs.ibm.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 19 19:31:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAtL9-0002bO-7S
	for gcvg-git@gmane.org; Sun, 19 Feb 2006 19:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWBSSbT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Feb 2006 13:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWBSSbT
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Feb 2006 13:31:19 -0500
Received: from devrace.com ([198.63.210.113]:35597 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S932188AbWBSSbS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Feb 2006 13:31:18 -0500
Received: from tigra.home (p54A07517.dip.t-dialin.net [84.160.117.23])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k1JIUt3t096429;
	Sun, 19 Feb 2006 12:30:56 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1FAtKg-0001Sp-00; Sun, 19 Feb 2006 19:30:54 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1FAtKf-0004DU-4D; Sun, 19 Feb 2006 19:30:53 +0100
To: Paul Mackerras <paulus@samba.org>
Content-Disposition: inline
In-Reply-To: <17400.23434.724188.649656@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16441>

Paul Mackerras, Sun, Feb 19, 2006 12:50:34 +0100:
> I just created a branch called "new" in my gitk repository at
> 
> git://git.kernel.org/pub/scm/gitk/gitk.git
> 
> which has a new improved version of gitk which is much faster than the
> old one and has a better graph layout algorithm.  I'd like people to
> try it out and tell me how they like it and if I broke anything (I'm
> pretty sure I broke the "Update" function, for instance).

aside from speedup and broken Update (both of which I didn't really
notice yet in the linux tree), I really like the new layout. I suggest
to try it on ACPI monster merge and gits "next" branch. It's simplier
to understand now (because of how the lines are highlighted when you
click on them).  Well the latter is a hopeless maze anyway, but you
often can see more of the patch description now.

Thanks!
