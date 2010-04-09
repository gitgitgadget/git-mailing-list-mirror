From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH v2 0/3] *** SUBJECT HERE ***
Date: Fri,  9 Apr 2010 11:34:02 -0400
Message-ID: <1270827245-28958-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 09 17:34:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0GDw-0000BY-SM
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 17:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754198Ab0DIPeP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 11:34:15 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:56937 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937Ab0DIPeO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 11:34:14 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id E07981FFC056; Fri,  9 Apr 2010 15:34:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from Hermes.local.net (unknown [64.134.102.129])
	by silverinsanity.com (Postfix) with ESMTPA id 22F391FFC056;
	Fri,  9 Apr 2010 15:34:07 +0000 (UTC)
X-Mailer: git-send-email 1.7.1.rc0.243.g2ce66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144439>

Changes from v1:
  - Moves valid FQDN conditions from line-ending conditions to a new
    function
  - Adds sendemail.smtpdomain to the list in config.txt

Patch 2/3 is unchanged.

Brian Gernhardt (3):
  send-email: Don't use FQDNs without a '.'
  Document send-email --smtp-domain
  send-email: Add sendemail.smtpdomain

 Documentation/config.txt         |    1 +
 Documentation/git-send-email.txt |    7 +++++++
 git-send-email.perl              |   32 ++++++++++++++++++--------------
 3 files changed, 26 insertions(+), 14 deletions(-)
