From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 0/2] send-email config path expansion
Date: Tue, 17 Nov 2015 22:01:04 +0000
Message-ID: <cover.1447797487.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 17 23:10:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyoST-0001vq-0e
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 23:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbbKQWKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 17:10:30 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:54479 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932355AbbKQWK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 17:10:28 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 5FFE09621FC;
	Tue, 17 Nov 2015 22:04:48 +0000 (GMT)
X-Quarantine-ID: <16bQHjRz0wd9>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 16bQHjRz0wd9; Tue, 17 Nov 2015 22:04:47 +0000 (GMT)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 22BC58E2731;
	Tue, 17 Nov 2015 22:01:11 +0000 (GMT)
X-Mailer: git-send-email 2.6.3.462.gbe2c914
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281422>

These two patches enable tilde-expansion for a few more config variables
in git-send-email.

The first case is the one that surprised me when it didn't work, the
second two are the other ones that look like they should be handled as
paths.

John Keeping (2):
  send-email: expand path in sendemail.smtpsslcertpath config
  send-email: expand paths in sendemail.{to,cc}cmd config

 git-send-email.perl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.6.3.462.gbe2c914
