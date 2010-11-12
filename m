From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH] Documentation/git-rebase: clarify -s option
Date: Fri, 12 Nov 2010 19:57:49 +0100
Message-ID: <1289588269-6920-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Sat Nov 13 01:58:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PH4RX-0001xW-C2
	for gcvg-git-2@lo.gmane.org; Sat, 13 Nov 2010 01:58:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933233Ab0KMA6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 19:58:06 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47430 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933218Ab0KMA6E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 19:58:04 -0500
Received: by vws13 with SMTP id 13so1197869vws.19
        for <git@vger.kernel.org>; Fri, 12 Nov 2010 16:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=QkFhVuwYKhhCXhTOHcKSKqk6CCfCJ5PifE/T6yRk8kc=;
        b=LB8FiACdoaOKPlzQ2btchF4p26Z3a9PP5I8ZearIXuDixI8pF+iffH5RuPKV3yKwa6
         kCn4TvHkD4Uf1BuyErrLG89pyTA/2VK/9QT4k7qSNiMgXbSs/nG5alXxhmv+dNhcckDP
         VyGKhGNZwyX1pIxBHSd/Y1BH2T3Ke3lPB0eNo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=G4pnJisc3c76aYkiS9b7SLvYOVxW3JtEV6W8ezsOPNoKV5pOfPPQ4UT1NfSdh/y84Y
         Vvs8rNkJXTJ8gFEp0A1lhpaqc9wnw6jlRS47+tTDAErRTDFEbMmGAw2LgbVmBM0jWquE
         ceJb7A5Ql+cCKg/Oc7ocJnaP2tCHjGXYi5PJg=
Received: by 10.220.189.136 with SMTP id de8mr668953vcb.30.1289609883331;
        Fri, 12 Nov 2010 16:58:03 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id m10sm1105255vcf.21.2010.11.12.16.58.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Nov 2010 16:58:02 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.167.ga361b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161375>

Clarify that it is '-s' itself that implies '--merge'. Currently it may
seem like '--merge' is implied "If there is no `-s` option".

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 Documentation/git-rebase.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 30e5c0e..f3753a8 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -244,9 +244,9 @@ other words, the sides are swapped.
 
 -s <strategy>::
 --strategy=<strategy>::
-	Use the given merge strategy.
+	Use the given merge strategy.  This implies --merge.
 	If there is no `-s` option 'git merge-recursive' is used
-	instead.  This implies --merge.
+	instead.
 +
 Because 'git rebase' replays each commit from the working branch
 on top of the <upstream> branch using the given strategy, using
-- 
1.7.3.2.167.ga361b
