From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] git-for-each-ref.txt: 'raw' is a supported date format
Date: Mon, 21 Jan 2013 13:53:40 +0000
Message-ID: <d3a288a67867d7a60c9217a78bda42301392c3da.1358776352.git.john@keeping.me.uk>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 14:54:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxHpL-0005r9-Nz
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 14:54:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753956Ab3AUNyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 08:54:00 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:41623 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753730Ab3AUNx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 08:53:58 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 09398CDA5DA;
	Mon, 21 Jan 2013 13:53:58 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bil6csGJCMIk; Mon, 21 Jan 2013 13:53:56 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 8A894CDA5EB;
	Mon, 21 Jan 2013 13:53:56 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 79730161E25D;
	Mon, 21 Jan 2013 13:53:56 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZVa7METKsrq2; Mon, 21 Jan 2013 13:53:56 +0000 (GMT)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id CF251161E3E9;
	Mon, 21 Jan 2013 13:53:51 +0000 (GMT)
X-Mailer: git-send-email 1.8.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214119>

Commit 7dff9b3 (Support 'raw' date format) added a raw date format.
Update the git-for-each-ref documentation to include this.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 Documentation/git-for-each-ref.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index db55a4e..d3e1df7 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -117,7 +117,7 @@ returns an empty string instead.
 
 As a special case for the date-type fields, you may specify a format for
 the date by adding one of `:default`, `:relative`, `:short`, `:local`,
-`:iso8601` or `:rfc2822` to the end of the fieldname; e.g.
+`:iso8601`, `:rfc2822` or `raw` to the end of the fieldname; e.g.
 `%(taggerdate:relative)`.
 
 
-- 
1.8.1
