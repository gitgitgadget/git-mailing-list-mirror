From: Russell King <rmk@arm.linux.org.uk>
Subject: dangling trees
Date: Thu, 5 May 2005 14:12:25 +0100
Message-ID: <20050505141224.A8323@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu May 05 15:11:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTg3A-00038a-6b
	for gcvg-git@gmane.org; Thu, 05 May 2005 15:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbVEENMb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 09:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262096AbVEENMb
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 09:12:31 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24081 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262095AbVEENM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2005 09:12:29 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DTg9S-0001qO-Cp; Thu, 05 May 2005 14:12:26 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DTg9R-0002fL-7Y; Thu, 05 May 2005 14:12:25 +0100
To: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

In todays 2.6 git repo, I see the following:

$ fsck-cache
expect dangling commits - potential heads - due to lack of head information
dangling commit 897f5ab2cd733a77a2279268262919caa8154b9d
dangling tree c39ae07f393806ccf406ef966e9a15afc43cc36a

The dangling commit is the current head - that's fine.  However,
what's this dangling tree?

It appears to have come in from Linus' tree on kernel.org this morning.

(above from cogito 0.8)

-- 
Russell King

