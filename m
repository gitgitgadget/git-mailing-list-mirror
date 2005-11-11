From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Getting rid of symlinks in .git?
Date: Fri, 11 Nov 2005 16:40:43 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511111636400.16210@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051110204543.GZ30496@pasky.or.cz> <43746118.30404@hogyros.de>
 <Pine.LNX.4.63.0511111511050.7575@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051111150530.GT30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Simon Richter <Simon.Richter@hogyros.de>,
	Pavel Roskin <proski@gnu.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 11 16:42:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eab1E-0006To-Hc
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 16:40:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbVKKPkp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 10:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbVKKPkp
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 10:40:45 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:47796 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750822AbVKKPkp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 10:40:45 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2447B13F343; Fri, 11 Nov 2005 16:40:44 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 03B66B514F; Fri, 11 Nov 2005 16:40:44 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D7E295973F; Fri, 11 Nov 2005 16:40:43 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B76D013F343; Fri, 11 Nov 2005 16:40:43 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051111150530.GT30496@pasky.or.cz>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11608>

Hi,

On Fri, 11 Nov 2005, Petr Baudis wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> > 
> > Please note that symlinks are much more performant than symrefs. Working a 
> > lot with switching branches, this matters.
> 
> What operations get slowed down noticeably in particular?

Well, if you have to read two files instead of one, it is 100% slower ;-)

> Do you have any timing testcases and data at hand?

No and no.

Note that the only symlink/symref you usually have is .git/HEAD. But it 
feels wrong to take the worse approach in *all* cases, just because 
*one* brain-fscked file system/operating system does not support the 
superior approach.

Conclusion: I can live with the symref support in git "AS IS".

Ciao,
Dscho
