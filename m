From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH 0/3] Submodule filtering for filter-branch
Date: Fri, 31 Dec 2010 16:29:21 +0100
Message-ID: <cover.1293809100.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: <jeffrey.freeman@syncleus.com>
X-From: git-owner@vger.kernel.org Fri Dec 31 16:29:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYgv8-0005F6-La
	for gcvg-git-2@lo.gmane.org; Fri, 31 Dec 2010 16:29:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032Ab0LaP32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Dec 2010 10:29:28 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:4268 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751680Ab0LaP31 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Dec 2010 10:29:27 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Fri, 31 Dec
 2010 16:29:14 +0100
Received: from localhost.localdomain (217.162.250.31) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.218.12; Fri, 31 Dec
 2010 16:29:24 +0100
X-Mailer: git-send-email 1.7.4.rc0.240.g44e61
X-Originating-IP: [217.162.250.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164386>

Jeffrey Phillips Freeman aka tty1 asked on IRC about a way to fix the
super-project after rewriting submodules.  This quick series provides
some extra tricks in the filter-branch toolbox that can be plumbed
together to achieve this (see the last commit's message), and should
hopefully be general enough to be of other use too.

Comes without docs and tests at this point, hence RFC.  It's also only
lightly tested, but since Jeffrey has a use-case, I'll leave it up to
him to bend it a bit and see if anything breaks.


Thomas Rast (3):
  filter-branch: optionally dump all mappings at the end
  filter-branch: optionally load existing mappings prior to filtering
  filter-branch: support --submodule-filter

 git-filter-branch.sh |   64 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 64 insertions(+), 0 deletions(-)

-- 
1.7.4.rc0.240.g44e61
