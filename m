From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: Re: bisect gives strange answer
Date: Fri, 05 Aug 2005 16:38:59 +0100
Message-ID: <E1E14Hj-0001Nt-00@skye.ra.phy.cam.ac.uk>
References: <20050804192838.GB26714@mars.ravnborg.org>
Cc: Greg KH <greg@kroah.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 05 17:51:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E14SF-0005WR-H1
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 17:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263064AbVHEPmj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Aug 2005 11:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbVHEPj3
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Aug 2005 11:39:29 -0400
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:8142 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261809AbVHEPjW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2005 11:39:22 -0400
Received: from skye.ra.phy.cam.ac.uk ([131.111.48.158] ident=mail)
	by mraos.ra.phy.cam.ac.uk with esmtp (Exim 4.43)
	id 1E14Hj-0002nm-Sl; Fri, 05 Aug 2005 16:38:59 +0100
Received: from sanjoy by skye.ra.phy.cam.ac.uk with local (Exim 3.35 #1)
	id 1E14Hj-0001Nt-00; Fri, 05 Aug 2005 16:38:59 +0100
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: Your message of "Thu, 04 Aug 2005 21:28:38 +0200."
             <20050804192838.GB26714@mars.ravnborg.org> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> If you see any sort of evidence that this would hold true I really like
> to know.

I haven't found any evidence.  When I rebuilt the kernels from scratch
(exporting them into an empty directory using cg-export), I got
reliable data and bisected down to a patch that probably was a problem.

I will redo those tests but rebuilding in place after each bisection
(with -f added to all the git checkout uses in git-bisect-script) and
see whether I get the same results.  If I don't, it could be due to
git or git-bisect (but not so likely with the -f switch) or to the
build system.  Will keep you and Junio posted.

-Sanjoy
