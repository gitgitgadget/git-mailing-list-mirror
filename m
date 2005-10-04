From: Mitchell Blank Jr <mitch@sfgoth.com>
Subject: [ANNOUNCE] gitfs pre-release 0.02
Date: Tue, 4 Oct 2005 03:51:54 -0700
Message-ID: <20051004105154.GH32664@gaz.sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Oct 04 12:42:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMkDs-0005hS-2p
	for gcvg-git@gmane.org; Tue, 04 Oct 2005 12:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbVJDKkb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Oct 2005 06:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbVJDKkb
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Oct 2005 06:40:31 -0400
Received: from gaz.sfgoth.com ([69.36.241.230]:20730 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S932245AbVJDKka (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2005 06:40:30 -0400
Received: from gaz.sfgoth.com (localhost.sfgoth.com [127.0.0.1])
	by gaz.sfgoth.com (8.12.10/8.12.10) with ESMTP id j94Apsi0003779
	for <git@vger.kernel.org>; Tue, 4 Oct 2005 03:51:54 -0700 (PDT)
	(envelope-from mitch@gaz.sfgoth.com)
Received: (from mitch@localhost)
	by gaz.sfgoth.com (8.12.10/8.12.6/Submit) id j94ApsFE003778
	for git@vger.kernel.org; Tue, 4 Oct 2005 03:51:54 -0700 (PDT)
	(envelope-from mitch)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Tue, 04 Oct 2005 03:51:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9673>

When I announced the first pre-release of my little gitfs tool back in
June[1] I didn't get much response.  (Actually, that's not quite true -- I
got zero response :-)  I've been very busy and haven't had the chance to
implement any of the big missing functionality yet, nor will I have time
for at least awhile.  Hopefully I'll have some time over the holidays to
hack on it.

However, two things HAVE changed:
  1. FUSE is now in the latest mainline kernels, so the barrier-to-entry for
     toying with it is lower now
  2. The introduction of git packs a couple months ago broke it; this is now
     fixed

Other than rebasing against git-core-0.99.8 the only major changes are:
  * now runs in non-debugging mode by default (use '-d' to enable debugging
    mode)
  * some efficiency improvements in the directory-handling code
All the limitations and caveats in the original announcement still apply.

As always --  http://www.sfgoth.com/~mitch/linux/gitfs/

-Mitch

[1] -- http://marc.theaimsgroup.com/?l=git&m=111975978111303&w=2
