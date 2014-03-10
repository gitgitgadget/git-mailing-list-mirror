From: TamerTas <tamertas@outlook.com>
Subject: [PATCH][GSOC2014]
Date: Mon, 10 Mar 2014 21:04:21 +0200
Message-ID: <BLU0-SMTP15143B8ABC984B63BB4F391D5740@phx.gbl>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain
Cc: TamerTas <tamertas@outlook.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 10 20:09:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN5a3-0000y9-67
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 20:09:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424AbaCJTJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 15:09:39 -0400
Received: from blu0-omc3-s35.blu0.hotmail.com ([65.55.116.110]:24459 "EHLO
	blu0-omc3-s35.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752901AbaCJTJi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 15:09:38 -0400
X-Greylist: delayed 306 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Mar 2014 15:09:38 EDT
Received: from BLU0-SMTP151 ([65.55.116.74]) by blu0-omc3-s35.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Mon, 10 Mar 2014 12:04:32 -0700
X-TMN: [SReI2xaVr9TkaYkiCj2sbmfKO4uhq+5O]
X-Originating-Email: [tamertas@outlook.com]
Received: from localhost.localdomain ([24.133.189.163]) by BLU0-SMTP151.phx.gbl over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Mon, 10 Mar 2014 12:04:30 -0700
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <y>
X-OriginalArrivalTime: 10 Mar 2014 19:04:30.0465 (UTC) FILETIME=[90D32710:01CF3C93]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243794>

I inspected branch.c:install_branch_config() and since
the conditionals cover all the possibilities, I decided
that making the code table-driven would be much cleaner
and shorter. I've ran the tests and they all passed. 
Reimplementation using "git am" also didn't have any problems.
Please let me know if there is any problems that I missed.
I would also love to learn if you think that the code was better
before and why it was better.

TamerTas (1):
  changed logical chain in branch.c to lookup tables

 branch.c |   31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

-- 
1.7.9.5
