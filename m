From: Peter Vereshagin <peter@vereshagin.org>
Subject: delete deprecated refs to release disk space
Date: Sun, 13 Nov 2011 19:10:33 +0400
Organization: '
Message-ID: <20111113151033.GD16065@external.screwed.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 13 16:18:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPboj-0007FF-SR
	for gcvg-git-2@lo.gmane.org; Sun, 13 Nov 2011 16:17:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845Ab1KMPRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Nov 2011 10:17:53 -0500
Received: from ns1.skyriver.ru ([89.108.118.221]:49241 "EHLO mx1.skyriver.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752952Ab1KMPRw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2011 10:17:52 -0500
X-Greylist: delayed 384 seconds by postgrey-1.27 at vger.kernel.org; Sun, 13 Nov 2011 10:17:52 EST
Received: from localhost (exit-01b.noisetor.net [173.254.216.67])
	by mx1.skyriver.ru (Postfix) with ESMTPSA id E9F755A80
	for <git@vger.kernel.org>; Sun, 13 Nov 2011 18:36:40 +0400 (MSK)
Content-Disposition: inline
X-Face: 8T>{1owI$Byj]]a;^G]kRf*dkq>E-3':F>4ODP[#X4s"dr?^b&2G@'3lukno]A1wvJ_L(~u
 6>I2ra/<,j1%@C[LN=>p#_}RIV+#:KTszp-X$bQOj,K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185340>

Hello.

I use git for sql database backups:

    http://gitweb.vereshagin.org/endvance/blob_plain/HEAD:/endvance/README

Am wondering if there is a way to remove the expired revisions? Following that
scenario:

    https://gist.github.com/1362183

I think there should be the way to decrease the space that .git takes. Without
compression, of course.

No problem if this involves the overwriting of the history like  filter-branch
does.  But filter-branch doesn't seem to be able to remove the old  info  from
repository based on expiration time, does it?

Thank you.

--
Peter Vereshagin <peter@vereshagin.org> (http://vereshagin.org) pgp: A0E26627 
