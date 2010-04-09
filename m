From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH 0/3] send-email: --smtp-domain improvements
Date: Fri,  9 Apr 2010 01:11:43 -0400
Message-ID: <1270789906-23735-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 09 07:12:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O06VZ-0003on-1U
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 07:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753452Ab0DIFLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 01:11:51 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:55638 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752597Ab0DIFLu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 01:11:50 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 170491FFC06B; Fri,  9 Apr 2010 05:11:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	by silverinsanity.com (Postfix) with ESMTPA id 083B91FFC056;
	Fri,  9 Apr 2010 05:11:35 +0000 (UTC)
X-Mailer: git-send-email 1.7.1.rc0.243.g2ce66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144399>

The first patch keeps send-email from using a bogus FQDN for my laptop.
Oddly enough, my MTA doesn't mind "localhost.localdomain" but complains
about "My-Computer".

The second adds documentation for --smtp-domain to the git-send-email man
page.  The only documentation for it was in the code and the usage message.

The last is just an enhancement, but I was honestly surprised that
--smtp-domain didn't have a configuration.

Brian Gernhardt (3):
  send-email: Don't use FQDNs without a '.'
  Document send-email --smtp-domain
  send-email: Add sendemail.smtpdomain

 Documentation/git-send-email.txt |    7 +++++++
 git-send-email.perl              |   26 ++++++++++++++------------
 2 files changed, 21 insertions(+), 12 deletions(-)
