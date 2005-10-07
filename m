From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] If NO_MMAP is defined, fake mmap() and munmap()
Date: Sat, 8 Oct 2005 01:57:35 +0200
Message-ID: <20051007235735.GB14827@steel.home>
References: <Pine.LNX.4.63.0510080050550.20922@wbgn013.biozentrum.uni-wuerzburg.de> <7vwtkoyjs9.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 08 02:00:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EO26q-0001pv-Ib
	for gcvg-git@gmane.org; Sat, 08 Oct 2005 01:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161008AbVJGX5p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 19:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161014AbVJGX5p
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 19:57:45 -0400
Received: from devrace.com ([198.63.210.113]:47365 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1161008AbVJGX5n (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Oct 2005 19:57:43 -0400
Received: from tigra.home (p54A0E160.dip.t-dialin.net [84.160.225.96])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id j980A2lk081617;
	Fri, 7 Oct 2005 19:10:02 -0500 (CDT)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EO25n-0006hM-00; Sat, 08 Oct 2005 01:57:35 +0200
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EO25n-00029L-GI; Sat, 08 Oct 2005 01:57:35 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwtkoyjs9.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.4 required=4.5 tests=AWL,BAYES_50,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9832>

Junio C Hamano, Sat, Oct 08, 2005 01:44:22 +0200:
> > Since some platforms do not support mmap() at all, and others do only just 
> > so, this patch introduces the option to fake mmap() and munmap() by 
> > malloc()ing and read()ing explicitely.
> 
> I guess I can just drop Alex Riesen patch and any other recent
> patches that try to work around mmap().  Happy!
> 

Me too. I was just about to make a read_cache read the whole index in
(absolutely the same as Johannes, but not that elegant).

The platform(s) deserve such a treatment :)
