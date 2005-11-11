From: Andrew Vasquez <andrew.vasquez@qlogic.com>
Subject: Re: merge-recursive: include heapq?
Date: Fri, 11 Nov 2005 11:09:26 -0800
Organization: QLogic Corporation
Message-ID: <20051111190926.GD458@andrew-vasquezs-powerbook-g4-15.local>
References: <Pine.LNX.4.63.0511111520260.7575@wbgn013.biozentrum.uni-wuerzburg.de> <20051111185246.GB13524@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 20:11:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaeHH-00078u-V9
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 20:09:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbVKKTJd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 14:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbVKKTJd
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 14:09:33 -0500
Received: from pat.qlogic.com ([198.70.193.2]:7422 "EHLO avexch01.qlogic.com")
	by vger.kernel.org with ESMTP id S1751050AbVKKTJd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 14:09:33 -0500
Received: from avexch02.qlogic.com ([10.1.4.82]) by avexch01.qlogic.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 11 Nov 2005 11:09:28 -0800
Received: from plap.qlogic.com ([172.17.141.170]) by avexch02.qlogic.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 11 Nov 2005 11:09:28 -0800
Received: by plap.qlogic.com (Postfix, from userid 501)
	id E8B1F144F8B; Fri, 11 Nov 2005 11:09:26 -0800 (PST)
To: Alex Riesen <raa.lkml@gmail.com>
Content-Disposition: inline
In-Reply-To: <20051111185246.GB13524@steel.home>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 11 Nov 2005 19:09:28.0392 (UTC) FILETIME=[70357480:01C5E6F3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11629>

On Fri, 11 Nov 2005, Alex Riesen wrote:
> Johannes Schindelin, Fri, Nov 11, 2005 15:23:04 +0100:
> > I get this when pulling:
> > 
> > -- snip --
> > Traceback (most recent call last):
> >   File "./git-merge-recursive", line 4, in ?
> >     from heapq import heappush, heappop
> > ImportError: No module named heapq
> > -- snap --
> > 
> > Okay, my python is *old*:
> > 
> > $ python -V
> > Python 2.2.1
> > 
> > Is it worthwhile to include heapq as we did with subprocess? Or should I 
> > upgrade...
> 
> Trying really trivial in-index merge...
> fatal: Merge requires file-level merging
> Nope.
> Traceback (most recent call last):
>   File "/home/raa/bin/git-merge-recursive", line 8, in ?
>     from gitMergeCommon import *
>   File "/home/raa/share/git-core/python/gitMergeCommon.py", line 14, in ?
>     import subprocess
> ImportError: No module named subprocess
> Automatic merge failed/prevented; fix up by hand

Had the same problem earlier today, building with
WITH_OWN_SUBPROCESS_PY fixed things up...

--
av
