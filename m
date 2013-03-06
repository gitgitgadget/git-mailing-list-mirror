From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH 0/2] Improve P4Merge mergetool invocation
Date: Wed,  6 Mar 2013 22:32:56 +0200
Message-ID: <1362601978-16911-1-git-send-email-kevin@bracey.fi>
Cc: David Aguilar <davvid@gmail.com>,
	Ciaran Jessup <ciaranj@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 07 00:37:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDNu5-0007bV-1e
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 00:37:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757529Ab3CFXhN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 18:37:13 -0500
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:49385 "EHLO
	mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757425Ab3CFXhE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 18:37:04 -0500
Received: from mail406.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id 13CFBDC1519
	for <git@vger.kernel.org>; Wed,  6 Mar 2013 21:44:04 +0100 (CET)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 6 Mar 2013 22:33:45 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 6 Mar 2013 22:33:45 +0200
X-Ovh-Mailout: 178.32.228.2 (mo2.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.2.rc2.5.g1a80410.dirty
X-Ovh-Tracer-Id: 12116934798748717278
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -48
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrvdehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlhedvmd
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -48
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrvdehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlhedvmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217559>

Two changes to the same piece of code that have greatly improved the behaviour
of P4Merge for me. Some of it may also be applicable to other mergetools.

I've put probably overly-long-winded explanations in the commit messages.

Comments welcome. In particular, I know almost nothing of sh, so I may have
made some blunder there.

Kevin Bracey (2):
  p4merge: swap LOCAL and REMOTE for mergetool
  p4merge: create a virtual base if none available

 git-mergetool--lib.sh | 14 ++++++++++++++
 mergetools/p4merge    |  4 ++--
 2 files changed, 16 insertions(+), 2 deletions(-)

-- 
1.8.2.rc2.5.g1a80410.dirty
