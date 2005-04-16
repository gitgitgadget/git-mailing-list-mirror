From: Martin Mares <mj@ucw.cz>
Subject: Storing permissions
Date: Sun, 17 Apr 2005 01:00:58 +0200
Message-ID: <20050416230058.GA10983@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Apr 17 00:57:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMwE6-0001hA-6Z
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 00:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVDPXBB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 19:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbVDPXBB
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 19:01:01 -0400
Received: from albireo.ucw.cz ([84.242.65.67]:21132 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S261184AbVDPXA4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 19:00:56 -0400
Received: by albireo.ucw.cz (Postfix, from userid 1000)
	id 7138A7BD17; Sun, 17 Apr 2005 01:00:58 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Linus et al.,

I'm trying to use git, but I frequenty run into problems with file permissions
-- some archives (including the master git archive) contain group-writable
files, but when I check them out, the permissions get trimmed by my umask
(quite sensibly) and update-cache complains that they need update.

Does it really make sense to store full permissions in the trees? I think
that remembering the x-bit should be good enough for almost all purposes
and the other permissions should be left to the local environment.

Another possibility is to keep the permissions in the trees, but just make
update-cache ignore differences in write permissions.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Man is the highest animal. Man does the classifying.
