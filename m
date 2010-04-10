From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH v3 0/4] send-email: --smtp-domain improvements
Date: Sat, 10 Apr 2010 10:53:52 -0400
Message-ID: <1270911236-32476-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 10 16:54:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0c4v-0006h6-Vq
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 16:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888Ab0DJOyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 10:54:07 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:34389 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743Ab0DJOyF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 10:54:05 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id C773A1FFC06B; Sat, 10 Apr 2010 14:53:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from Hermes.local.net (unknown [64.134.103.20])
	by silverinsanity.com (Postfix) with ESMTPA id EEB641FFC056;
	Sat, 10 Apr 2010 14:53:55 +0000 (UTC)
X-Mailer: git-send-email 1.7.1.rc0.251.g42f41
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144555>

Next iteration of my small series of fixes to --smtp-domain.

Changes since v2:

1/4: Added a patch that standardizes on a single bracket style for subs.

2/4: Fixed the style of valid_fqdn() and calls to it.

4/4: Remove default variable and significantly improve commit message.

Many thanks to Jakub Narebski for his repeated suggestions.

Brian Gernhardt (4):
  send-email: Cleanup { style
  send-email: Don't use FQDNs without a '.'
  Document send-email --smtp-domain
  send-email: Cleanup smtp-domain and add config

 Documentation/config.txt         |    1 +
 Documentation/git-send-email.txt |    7 +++++
 git-send-email.perl              |   48 +++++++++++++++++--------------------
 3 files changed, 30 insertions(+), 26 deletions(-)
