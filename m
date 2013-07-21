From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 0/2] Improvements to rev-parse option handling
Date: Sun, 21 Jul 2013 13:49:25 +0100
Message-ID: <cover.1374410829.git.john@keeping.me.uk>
References: <7v4nbquw3l.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 21 14:50:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0t5M-0003ei-Ah
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jul 2013 14:50:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755480Ab3GUMtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jul 2013 08:49:47 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:39392 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754945Ab3GUMtl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jul 2013 08:49:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id AE510CDA580;
	Sun, 21 Jul 2013 13:49:40 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pJYI9W6EaTWD; Sun, 21 Jul 2013 13:49:39 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id CBDF5CDA57D;
	Sun, 21 Jul 2013 13:49:39 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 9A0E0161E332;
	Sun, 21 Jul 2013 13:49:39 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rR19bMQ7Ls3d; Sun, 21 Jul 2013 13:49:37 +0100 (BST)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 56394161E16E;
	Sun, 21 Jul 2013 13:49:32 +0100 (BST)
X-Mailer: git-send-email 1.8.3.3.972.gc83849e.dirty
In-Reply-To: <7v4nbquw3l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230928>

This adds a new patch to remove the restrictions on --local-env-var and
--resolve-git-dir so that they do not need to appear first on the
command line.

The other patch is update to reflect this as well as to split up the
catch-all "Options for Input" subsection a bit.

John Keeping (2):
  rev-parse: remove restrictions on some options
  rev-parse(1): logically group options

 Documentation/git-rev-parse.txt | 104 ++++++++++++++++++++++++----------------
 builtin/rev-parse.c             |  28 +++++------
 2 files changed, 77 insertions(+), 55 deletions(-)

-- 
1.8.3.3.972.gc83849e.dirty
