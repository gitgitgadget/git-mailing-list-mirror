From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 0/2] Avoid suggestions to "merge" remote changes
Date: Sun,  7 Jul 2013 20:02:13 +0100
Message-ID: <cover.1373223663.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>,
	Philip Oakley <philipoakley@iee.org>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 07 21:02:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvuET-0001Ci-Vh
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 21:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753013Ab3GGTCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 15:02:31 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:52553 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752886Ab3GGTCb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 15:02:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 503616064CE;
	Sun,  7 Jul 2013 20:02:30 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 35Sxnmg7wLNK; Sun,  7 Jul 2013 20:02:29 +0100 (BST)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id A9F466064D7;
	Sun,  7 Jul 2013 20:02:20 +0100 (BST)
X-Mailer: git-send-email 1.8.3.2.855.gbc9faed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229798>

As another aspect of the change to make git-pull die when remote changes
do not fast-forward, this series changes the advice messages in git-push to
avoid implying that the user wants to merge remote changes.

I've chosen the word "integrate" because it does not carry any special
meaning in Git (in terms of being a command) and seems to cover the
merge and rebase cases nicely.

John Keeping (2):
  push: avoid suggesting "merging" remote changes
  pull: change the description to "integrate" changes

 Documentation/git-pull.txt |  2 +-
 builtin/push.c             | 12 ++++++------
 git-pull.sh                |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

-- 
1.8.3.2.855.gbc9faed
