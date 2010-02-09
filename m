From: Chris Packham <judge.packham@gmail.com>
Subject: [PATCH 3/3] t2200-add-update.sh: change expected fail to success
Date: Tue,  9 Feb 2010 17:30:50 -0500
Message-ID: <1265754650-25438-4-git-send-email-judge.packham@gmail.com>
References: <a038bef51002091417o1048c098x898517596115ed90@mail.gmail.com>
 <1265754650-25438-1-git-send-email-judge.packham@gmail.com>
 <1265754650-25438-2-git-send-email-judge.packham@gmail.com>
 <1265754650-25438-3-git-send-email-judge.packham@gmail.com>
Cc: peff@peff.net, szeder@ira.uka.de, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 09 23:33:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeyeC-0002A3-KI
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 23:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212Ab0BIWdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 17:33:15 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54288 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689Ab0BIWdG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 17:33:06 -0500
Received: by mail-vw0-f46.google.com with SMTP id 12so445537vws.19
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 14:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=m66linXvpDdyGFoJ6ygxnE0J12arifmMvOQNgw9dBxg=;
        b=mrABl7PKuQK+yWnb49pAKtCdXWxV9m0iMuMyWBmEF4ZFID+Yh16Lb6M/PUFm/PJF3W
         9U0JByfvd4PcTQzg4+OPXzkNLPgBSxAkBcuCzs2Wg5VYrNx9F4jLsdC22VhmoPnlsy4L
         rrEdybh5dCs5n5Hrq6MdUYNhozjomb/AJndEo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MWRJwUZbEbRBADR2I2JxLrQRTg3l6HMCWNiqZpZS8LKG9450amak0QR+SUvGRqyk/m
         i7WlLE2ajO5kvkARJBn6eFr4ZTDdkomYiD7XHqI+k6iVir2KbNLbRVgZzjjf8nXDpLkE
         dW+abVjlBYcJ2g4Agb/cNZoa95vXmdFkhC628=
Received: by 10.220.89.94 with SMTP id d30mr1006801vcm.141.1265754785795;
        Tue, 09 Feb 2010 14:33:05 -0800 (PST)
Received: from localhost.localdomain ([66.193.66.34])
        by mx.google.com with ESMTPS id 26sm4516876vws.21.2010.02.09.14.33.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Feb 2010 14:33:05 -0800 (PST)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <1265754650-25438-3-git-send-email-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139454>

This changes the test added in bb73e5c to an expected success now that
Junio has supplied a fix.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
 t/t2200-add-update.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index dbabc3c..6302137 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -176,7 +176,7 @@ test_expect_success 'add -u resolves unmerged paths' '
 
 '
 
-test_expect_failure 'error out when attempting to add -u non-existent pathspec' '
+test_expect_success 'error out when attempting to add -u non-existent pathspec' '
 	test_must_fail git add -u non-existent &&
 	! (git ls-files | grep "non-existent")
 '
-- 
1.6.4.2
