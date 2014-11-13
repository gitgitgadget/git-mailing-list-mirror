From: slavomir vlcek <svlc@inventati.org>
Subject: [PATCH] SubmittingPatches: fix an inconsistency
Date: Thu, 13 Nov 2014 01:29:00 +0100
Message-ID: <5463FB4C.2060203@inventati.org>
References: <5463DA20.3080703@inventati.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 01:26:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoiEb-0002MO-BR
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 01:26:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834AbaKMAZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 19:25:57 -0500
Received: from latitanza.investici.org ([82.94.249.234]:33185 "EHLO
	latitanza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462AbaKMAZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 19:25:57 -0500
Received: from [82.94.249.234] (latitanza [82.94.249.234]) (Authenticated sender: svlc@inventati.org) by localhost (Postfix) with ESMTPSA id 96C2D120E66;
	Thu, 13 Nov 2014 00:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inventati.org;
	s=stigmate; t=1415838355;
	bh=C4J0tA79d5wSYHJdyV/mdfGYaAHXSFi5ZEmQbU7unrU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=ENkXtfaIjEkcDh1UzWKsTMyNO9Jp3dWLW5ivQbWQzq/hnHRmzDimiBOXi1jbyz50r
	 tCdPzhPohxFmgnL430hItvcQ/gasLnKgupO9FrT7pk2l5BloJ1za1+mlRNXLz09K+Q
	 nDjCyvjrC7Y/dYlOgOEKO+o8tHqU/MFixhiCgIog=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <5463DA20.3080703@inventati.org>
X-Forwarded-Message-Id: <5463DA20.3080703@inventati.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'SubmittingPatches' document contains a small inconsistency
 in a patch-email sending procedure.

Not a big thing,
but a newcomer could get confused.

Please,
also consider adding the definition/explanation for all the branches available
at the beginning of this document (and maybe even what their names stand for).
Thanks.

Signed-off-by: slavomir vlcek <svlc@inventati.org>
---

>From 74859712cf805663e3863686bdc09511c74b207b Mon Sep 17 00:00:00 2001
From: slavomir vlcek <svlc@inventati.org>
Date: Thu, 13 Nov 2014 00:18:39 +0100
Subject: [PATCH] SubmittingPatches: fix an inconsistency

At line 213 there was an instruction:
  "re-send it with "To:" set to the maintainer [*1*] and "cc:" the list [*2*]"

and this instruction got repeated once more in the document (line 340):
  "Send it to the list and cc the maintainer."

This inconsistency was solved by editing the second occurance.
---
 Documentation/SubmittingPatches | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index e6d46ed..fa71b5f 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -337,7 +337,7 @@ suggests to the contributors:
      spend their time to improve your patch.  Go back to step (2).
 
  (4) The list forms consensus that the last round of your patch is
-     good.  Send it to the list and cc the maintainer.
+     good.  Send it to the maintainer and cc the list.
 
  (5) A topic branch is created with the patch and is merged to 'next',
      and cooked further and eventually graduates to 'master'.
-- 
2.0.1
