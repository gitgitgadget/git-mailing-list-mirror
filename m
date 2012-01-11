From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 0/5] git-p4: view spec review fixes
Date: Wed, 11 Jan 2012 18:31:05 -0500
Message-ID: <1326324670-15967-1-git-send-email-pw@padd.com>
Cc: Gary Gibbons <ggibbons@perforce.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 00:31:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl7dY-0005ri-QT
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 00:31:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334Ab2AKXbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 18:31:16 -0500
Received: from honk.padd.com ([74.3.171.149]:34111 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133Ab2AKXbP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 18:31:15 -0500
Received: from arf.padd.com (unknown [50.55.142.76])
	by honk.padd.com (Postfix) with ESMTPSA id C76BB20D2;
	Wed, 11 Jan 2012 15:31:14 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 12B1531442; Wed, 11 Jan 2012 18:31:10 -0500 (EST)
X-Mailer: git-send-email 1.7.9.rc0.47.gc9457
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188398>

I received some helpful review comments offline regarding the
series recently merged into master (8cbfc11
(Merge branch 'pw/p4-view-updates', 2012-01-06)).

It would be nice to see these go into 1.7.9 as well.
Even though they belong there logically, they are
minor fixes, and not critical.

I added a bunch of new tests documenting further problems,
but will not fix those here as the changes will be more
invasive.

Thanks,

Pete Wyckoff (5):
  git-p4: only a single ... wildcard is supported
  git-p4: fix verbose comment typo
  git-p4: clarify comment
  git-p4: adjust test to adhere to stricter useClientSpec
  git-p4: add tests demonstrating spec overlay ambiguities

 Documentation/git-p4.txt      |    5 +
 contrib/fast-import/git-p4    |    9 +-
 t/t9806-git-p4-options.sh     |    4 +-
 t/t9809-git-p4-client-view.sh |  395 ++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 406 insertions(+), 7 deletions(-)

-- 
1.7.8.1.409.g3e338.dirty
