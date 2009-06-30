From: Joe Perches <joe@perches.com>
Subject: [PATCH 0/2] format-patch and send-email
Date: Tue, 30 Jun 2009 16:40:37 -0700
Message-ID: <cover.1246404999.git.joe@perches.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 01 01:41:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLmxB-0006TN-2b
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 01:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756007AbZF3Xki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 19:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756267AbZF3Xkh
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 19:40:37 -0400
Received: from 136-022.dsl.LABridge.com ([206.117.136.22]:4951 "EHLO
	mail.perches.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754156AbZF3Xkg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 19:40:36 -0400
Received: from localhost.localdomain ([192.168.1.158])
	by mail.perches.com (8.9.3/8.9.3) with ESMTP id QAA23712
	for <git@vger.kernel.org>; Tue, 30 Jun 2009 16:40:22 -0700
X-Mailer: git-send-email 1.6.3.1.10.g659a0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122554>

A couple of patches that have previously been sent to the list

Joe Perches (2):
  git-send-email.perl: Don't add header "In-Reply-To:" when --no-chain-reply-to set
  format-patch: Add --cover-letter-wrap

 Documentation/git-format-patch.txt     |   13 +++++++++
 builtin-log.c                          |   46 +++++++++++++++++++++++++++++---
 contrib/completion/git-completion.bash |    1 +
 git-send-email.perl                    |    3 +-
 4 files changed, 58 insertions(+), 5 deletions(-)
