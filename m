From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: merge-recursive: include heapq?
Date: Fri, 11 Nov 2005 19:52:46 +0100
Message-ID: <20051111185246.GB13524@steel.home>
References: <Pine.LNX.4.63.0511111520260.7575@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 19:54:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eae1D-0001zM-8W
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 19:52:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbVKKSw5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 13:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbVKKSw4
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 13:52:56 -0500
Received: from devrace.com ([198.63.210.113]:21522 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1751031AbVKKSw4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 13:52:56 -0500
Received: from tigra.home (p54A0D6F6.dip.t-dialin.net [84.160.214.246])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id jABIqlCj028970;
	Fri, 11 Nov 2005 12:52:48 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1Eae10-0000EC-00; Fri, 11 Nov 2005 19:52:46 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1Eae10-0006Jt-27; Fri, 11 Nov 2005 19:52:46 +0100
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511111520260.7575@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.6 required=4.5 tests=AWL,BAYES_50,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11628>

Johannes Schindelin, Fri, Nov 11, 2005 15:23:04 +0100:
> I get this when pulling:
> 
> -- snip --
> Traceback (most recent call last):
>   File "./git-merge-recursive", line 4, in ?
>     from heapq import heappush, heappop
> ImportError: No module named heapq
> -- snap --
> 
> Okay, my python is *old*:
> 
> $ python -V
> Python 2.2.1
> 
> Is it worthwhile to include heapq as we did with subprocess? Or should I 
> upgrade...

Trying really trivial in-index merge...
fatal: Merge requires file-level merging
Nope.
Traceback (most recent call last):
  File "/home/raa/bin/git-merge-recursive", line 8, in ?
    from gitMergeCommon import *
  File "/home/raa/share/git-core/python/gitMergeCommon.py", line 14, in ?
    import subprocess
ImportError: No module named subprocess
Automatic merge failed/prevented; fix up by hand

That said, I thought an upgrade was worth it and upgraded my 2.3 to 2.4 :)
