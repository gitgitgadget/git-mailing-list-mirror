From: Yann Dirson <ydirson@altern.org>
Subject: cvsps patches
Date: Sat, 12 May 2007 00:39:19 +0200
Message-ID: <20070511223919.GJ19253@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 12 00:40:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hmdmn-0003xK-P1
	for gcvg-git@gmane.org; Sat, 12 May 2007 00:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753932AbXEKWkY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 18:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754492AbXEKWkY
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 18:40:24 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:50188 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753932AbXEKWkX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 18:40:23 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id AE9A981DB
	for <git@vger.kernel.org>; Sat, 12 May 2007 00:40:22 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 3C28A1F161; Sat, 12 May 2007 00:39:19 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46993>

Here is an update on cvsps patches.

* The repository has just been moved to repo.or.cz, since uploading to
  the old one was a PITA

  Gitweb and pull instructions at http://repo.or.cz/w/cvsps-yd.git

* A handful of new patches have been sent to me since the last update.
  Since I don't have much time to allocate to this, I have added those
  to the to-check branch.  I'd be glad to have feedback on them :)

  - Fix buffer overflow in cvsps if a log message line is longer than BUFSIZ
  - Fix parsing of pserver URL in open_ctx_pserver()
  - Initial support for CVS branch aliases.

  OTOH, I probably missed some posted to this list, I may find some
  time to dig for them - but if you'd like to see them in the repo,
  better send them directly to me.

* I also noticed some time ago another cvsps repo at freedesktop, but
  did not look at it too close for now.

  http://gitweb.freedesktop.org/?p=freedesktop/cvsps.git;a=summary

Best regards,
-- 
Yann.
