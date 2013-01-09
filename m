From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] git-shortlog(1): document behaviour of zero-width wrap
Date: Wed, 9 Jan 2013 20:16:45 +0000
Message-ID: <20130109201645.GB4574@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 21:17:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt25I-0005Te-Qf
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 21:17:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528Ab3AIUQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 15:16:52 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:33041 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932488Ab3AIUQw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 15:16:52 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 9B8776064E0;
	Wed,  9 Jan 2013 20:16:51 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -11
X-Spam-Level: 
X-Spam-Status: No, score=-11 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eo7R6bflZWN5; Wed,  9 Jan 2013 20:16:51 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 471356064D3;
	Wed,  9 Jan 2013 20:16:51 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 222A1161E556;
	Wed,  9 Jan 2013 20:16:51 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TuF6EEkF2gyT; Wed,  9 Jan 2013 20:16:51 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 232CC161E554;
	Wed,  9 Jan 2013 20:16:47 +0000 (GMT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213097>

Commit 00d3947 (Teach --wrap to only indent without wrapping) added
special behaviour for a width of zero in the '-w' argument to
'git-shortlog' but this was not documented.  Fix this.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 Documentation/git-shortlog.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index afeb4cd..c308e91 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -56,6 +56,9 @@ OPTIONS
 	line of each entry is indented by `indent1` spaces, and the second
 	and subsequent lines are indented by `indent2` spaces. `width`,
 	`indent1`, and `indent2` default to 76, 6 and 9 respectively.
++
+If width is `0` (zero) then indent the lines of the output without wrapping
+them.
 
 
 MAPPING AUTHORS
-- 
1.8.0.2
