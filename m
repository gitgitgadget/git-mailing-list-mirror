From: Johan Herland <johan@herland.net>
Subject: [PATCH 0/5] revision: --ancestry-path, take 2
Date: Fri, 04 Jun 2010 01:17:32 +0200
Message-ID: <1275607057-26645-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 04 01:18:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKJfo-0007BM-0o
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 01:18:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754907Ab0FCXRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 19:17:52 -0400
Received: from smtp.getmail.no ([84.208.15.66]:40860 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752675Ab0FCXRv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 19:17:51 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L3G00DB8OPPCWC0@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 04 Jun 2010 01:17:49 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 255621EA57B8_C08381DB	for <git@vger.kernel.org>; Thu,
 03 Jun 2010 23:17:49 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 0FE341EA3037_C08381DF	for <git@vger.kernel.org>; Thu,
 03 Jun 2010 23:17:49 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L3G007W6OPOV330@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 04 Jun 2010 01:17:49 +0200 (MEST)
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148369>

Hi,

This is an attempt to resurrect the --ancestry-path patch that Junio
provided on 2010-04-21. In addition to his original patch, I've added
a fix for the interaction between --ancestry-path and history
simplification, plus documentation and a couple of other small fixes.

I'm unsure if there are more bugs/problems in the interaction between
--ancestry-path and other rev-list options that I'm not yet aware of.


Have fun! :)

...Johan


Johan Herland (4):
  Documentation/rev-list-options.txt: Fix missing line in example history graph
  Documentation/rev-list-options.txt: Explain --ancestry-path
  revision: Fix typo in --ancestry-path error message
  revision: Turn off history simplification in --ancestry-path mode

Junio C Hamano (1):
  revision: --ancestry-path

 Documentation/rev-list-options.txt |   52 ++++++++++++++++-
 revision.c                         |  107 ++++++++++++++++++++++++++++++++++++
 revision.h                         |    1 +
 t/t6019-rev-list-ancestry-path.sh  |   73 ++++++++++++++++++++++++
 4 files changed, 230 insertions(+), 3 deletions(-)
 create mode 100755 t/t6019-rev-list-ancestry-path.sh
