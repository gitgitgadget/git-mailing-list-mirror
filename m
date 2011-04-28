From: Johan Herland <johan@herland.net>
Subject: [PATCHv5 0/7]  --dirstat fixes, part 2
Date: Thu, 28 Apr 2011 03:17:15 +0200
Message-ID: <1303953442-26536-1-git-send-email-johan@herland.net>
References: <1303892653-3958-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 03:17:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFFrL-00051R-3X
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 03:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757754Ab1D1BR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 21:17:28 -0400
Received: from smtp.getmail.no ([84.208.15.66]:46644 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421Ab1D1BR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 21:17:27 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LKC00GMU8X1P940@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 28 Apr 2011 03:17:25 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 9A4961EA58BB_DB8C025B	for <git@vger.kernel.org>; Thu,
 28 Apr 2011 01:17:25 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id CAC4F1EA3836_DB8C024F	for <git@vger.kernel.org>; Thu,
 28 Apr 2011 01:17:24 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LKC0058L8X0LO10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 28 Apr 2011 03:17:24 +0200 (MEST)
X-Mailer: git-send-email 1.7.5.rc1.3.g4d7b
In-reply-to: <1303892653-3958-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172301>

Hi,

Here's version 5 incorporating Junio's feedback and patch from elsewhere
in this thread.

Have fun! :)

...Johan


Johan Herland (7):
  Add several testcases for --dirstat and friends
  Make --dirstat=0 output directories that contribute < 0.1% of changes
  Refactor --dirstat parsing; deprecate --cumulative and --dirstat-by-file
  Add config variable for specifying default --dirstat behavior
  Allow specifying --dirstat cut-off percentage as a floating point number
  New --dirstat=lines mode, doing dirstat analysis based on diffstat
  Improve error handling when parsing dirstat parameters

 Documentation/config.txt       |   44 ++
 Documentation/diff-options.txt |   54 ++-
 diff.c                         |  158 ++++++-
 diff.h                         |    3 +-
 t/t4047-diff-dirstat.sh        |  965 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 1192 insertions(+), 32 deletions(-)
 create mode 100755 t/t4047-diff-dirstat.sh

-- 
1.7.5.rc1.3.g4d7b
