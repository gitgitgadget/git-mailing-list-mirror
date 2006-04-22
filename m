From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Problem with Git in Cygwin on x86-64 platform
Date: Sat, 22 Apr 2006 23:17:33 +0200
Message-ID: <20060422211733.GB7676@steel.home>
References: <20060422023029.GC2444@Zangband>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Apr 22 23:17:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXPU3-0000kW-Dr
	for gcvg-git@gmane.org; Sat, 22 Apr 2006 23:17:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWDVVRg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Apr 2006 17:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWDVVRg
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Apr 2006 17:17:36 -0400
Received: from devrace.com ([198.63.210.113]:38155 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1751218AbWDVVRf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Apr 2006 17:17:35 -0400
Received: from tigra.home (p54A06533.dip.t-dialin.net [84.160.101.51])
	by devrace.com (Postfix) with ESMTP id CEAD2154;
	Sat, 22 Apr 2006 16:17:35 -0500 (CDT)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1FXPTx-00033l-00; Sat, 22 Apr 2006 23:17:33 +0200
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1FXPTx-0000qU-Dm; Sat, 22 Apr 2006 23:17:33 +0200
To: Tim O'Callaghan <timo@dspsrv.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060422023029.GC2444@Zangband>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19062>

Tim O'Callaghan, Sat, Apr 22, 2006 04:30:30 +0200:
> When running a 'make test' under cygwin on my 64bit machine, and got
> the output below. The reason i cite the 64bit cygwin platform being a
> difference is that i have run 'make test' on the exact same codebase
> on a 32 bit machine. The only difference in compile environment is
> that the cygwin install on the 64 bit machine is as of today, and the
> 32 bit machine was about three days ago.
> 
> *** t0000-basic.sh ***
...
> * FAIL 8: git-update-index with --remove should be able to remove.
...
> Any ideas on how to start tracking this one down?

Start by going into git/t and running "./t0000-basic.sh -d -v"
