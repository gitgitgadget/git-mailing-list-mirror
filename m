From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH] CVSps fixed; git-cvsimport works, too
Date: Sat, 17 Jun 2006 14:21:58 +0200
Message-ID: <20060617122158.GQ7766@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>, cvsps@dm.cobite.com
X-From: git-owner@vger.kernel.org Sat Jun 17 14:21:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrZo5-0002d1-Or
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 14:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWFQMVc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 08:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbWFQMVc
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 08:21:32 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:52138 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751252AbWFQMVc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Jun 2006 08:21:32 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 98FBF2268C;
	Sat, 17 Jun 2006 14:21:30 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1FrZoN-0002RG-9m; Sat, 17 Jun 2006 14:21:59 +0200
To: Chris Shoemaker <c.shoemaker@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22013>

[for original thread see
http://www.gelato.unsw.edu.au/archives/git/0511/11812.html]

Hi Chris,

I was looking at your patch and test script to decide whether to
include it in my cvsps patch collection, but it seems there are still
problems:

* when run with "-x" it gives the expected result, even with "-A"

* when run without "-x" and without "-A", the patchset introducing
file "b" and branch "stable" does not appear, without even a warning

* when run with "-A" cvsps notices the inconsistency:

invalid initial_branch for file a, probably from old cache, run with -x.


I have included the current version of your patch in branch "to-check"
in http://ydirson.free.fr/soft/git/cvsps.git/.  I did not tak time to
look at it closely yet - do you plan to work on this issue ?

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
