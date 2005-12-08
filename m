From: linux@horizon.com
Subject: Re: Wine + GIT
Date: 8 Dec 2005 02:30:00 -0500
Message-ID: <20051208073000.7097.qmail@science.horizon.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 08:31:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkGEV-0007tY-BW
	for gcvg-git@gmane.org; Thu, 08 Dec 2005 08:30:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbVLHHaF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 02:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbVLHHaF
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 02:30:05 -0500
Received: from science.horizon.com ([192.35.100.1]:43306 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750710AbVLHHaC
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 8 Dec 2005 02:30:02 -0500
Received: (qmail 7098 invoked by uid 1000); 8 Dec 2005 02:30:00 -0500
To: git@vger.kernel.org, junkio@cox.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13361>

> The paragraph "Once you have finished editting [sic]..." needs
> to be followed by:
> 
>	git-update-index those paths you hand corrected
>        git-commit

This is what happens when you have people too used to using the
pre-porcelain plumbing.

How about just
git-commit <the paths you hand corrected>

If you forget any, the commit will fail, but they will have been
updated in the index, and you don't need to mention them again in the
next attempt.


(Grump... I just noticed that the "recursive" merge stratgy *doesn't*
generate a merged file containing conflict markers, at least not in
the case I tried.  Instead I get "a~HEAD" and "a~branch" files.
Time to fix the docs...)
