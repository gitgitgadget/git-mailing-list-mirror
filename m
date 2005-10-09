From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Seeing various mode changes on cygwin
Date: Sun, 9 Oct 2005 15:02:53 +0200
Message-ID: <20051009130253.GA14237@steel.home>
References: <20051008180023.GC28875@diku.dk> <7vfyrbrgdw.fsf@assigned-by-dhcp.cox.net> <20051008213612.GA5794@steel.home> <7vzmpjoa32.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 09 15:05:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOapj-0004UK-Sh
	for gcvg-git@gmane.org; Sun, 09 Oct 2005 15:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbVJINDH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Oct 2005 09:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbVJINDH
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Oct 2005 09:03:07 -0400
Received: from devrace.com ([198.63.210.113]:38151 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1750700AbVJINDG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Oct 2005 09:03:06 -0400
Received: from tigra.home (p54A0D8F4.dip.t-dialin.net [84.160.216.244])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id j99DFU52000147;
	Sun, 9 Oct 2005 08:15:32 -0500 (CDT)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EOapL-0003dA-00; Sun, 09 Oct 2005 15:02:55 +0200
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EOapK-0006jo-JB; Sun, 09 Oct 2005 15:02:54 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzmpjoa32.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.0 required=4.5 tests=AWL,BAYES_40,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9864>

Junio C Hamano, Sun, Oct 09, 2005 01:36:17 +0200:
> > These are not real attributes, cygwin emulates them from the names,
> > like .exe will always be 0755, for example.
> 
> Ouch.  Is this true in general, or only on FAT-derived
> filesystems?
> 

Before they are chmod'ed by cygwin (with chmod): probably everywhere
on windows (I'm sure about vfat, were chmod wont help at all).  Even
if you can save user (unix) attributes somewhere, initial clone will
still always have this problem.
