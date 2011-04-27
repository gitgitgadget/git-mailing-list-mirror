From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 0/6] --dirstat fixes, part 2
Date: Wed, 27 Apr 2011 04:12:33 +0200
Message-ID: <1303870359-26083-1-git-send-email-johan@herland.net>
References: <1303776102-9085-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 04:12:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEuFG-0001hO-Sb
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 04:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756514Ab1D0CMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 22:12:45 -0400
Received: from smtp.getmail.no ([84.208.15.66]:46164 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756138Ab1D0CMo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 22:12:44 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LKA0014CGT7JN30@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Apr 2011 04:12:43 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 480FB1EA5529_DB77B9BB	for <git@vger.kernel.org>; Wed,
 27 Apr 2011 02:12:43 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id DDF9F1EA2854_DB77B9AF	for <git@vger.kernel.org>; Wed,
 27 Apr 2011 02:12:42 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LKA00ENJGT6U700@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Apr 2011 04:12:42 +0200 (MEST)
X-Mailer: git-send-email 1.7.5.rc1.3.g4d7b
In-reply-to: <1303776102-9085-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172150>

Hi,

Here's version 2 with a lot of improvements suggested by Junio.
Especially patches #3, #4 and #6 have been updated. The other
patches are unchanged, or have only received minor/trivial updates.


Have fun! :)

...Johan

Johan Herland (6):
  Add several testcases for --dirstat and friends
  Make --dirstat=0 output directories that contribute < 0.1% of changes
  Refactor --dirstat parsing; deprecate --cumulative and --dirstat-by-file
  Add config variable for specifying default --dirstat behavior
  Use floating point for --dirstat percentages
  New --dirstat=lines mode, doing dirstat analysis based on diffstat

 Documentation/config.txt       |   44 ++
 Documentation/diff-options.txt |   54 ++-
 diff.c                         |  183 ++++++++-
 diff.h                         |    3 +-
 t/t4046-diff-dirstat.sh        |  908 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 1160 insertions(+), 32 deletions(-)
 create mode 100755 t/t4046-diff-dirstat.sh

-- 
1.7.5.rc1.3.g4d7b
