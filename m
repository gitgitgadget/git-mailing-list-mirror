From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH v3 3/3] Documentation/git-pull: document --[no-]autostash option
Date: Thu,  3 Mar 2016 21:43:21 +0530
Message-ID: <1457021601-9099-3-git-send-email-mehul.jain2029@gmail.com>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
 <1457021601-9099-1-git-send-email-mehul.jain2029@gmail.com>
Cc: pyokagan@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 03 17:15:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abVu3-0004kg-AC
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 17:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756788AbcCCQO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 11:14:59 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35161 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754801AbcCCQO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 11:14:58 -0500
Received: by mail-pf0-f196.google.com with SMTP id w128so1511243pfb.2
        for <git@vger.kernel.org>; Thu, 03 Mar 2016 08:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OBUrJshRKdHCIELytwMgwl0eYU8yhpe9u6VmUXUcNvo=;
        b=rGsubvXIow95Ufx23HRo3uxWphlEx2wxoP2kmlVj0XRfzzwEsgQUQvQsa+JfQ7g026
         xJPEGfVdOIzgvyN99d7IbquPbQc6ATAO0APsvL1iXuQ6oda0V/p2lmy7SwmaqcolxO9O
         wB1zCdltPKaJplJp/ERML0NOuzjB4mge6vsjUeLQom8EHNnsL3C4RswYe4wRaa6r2HT0
         dGXi+z37neNEC6lnEWdI2idbGja+fI9iZoRPVQ3ZcLhnOSg1GTd3/xKCzPYjmBHDWRbS
         HwpYA5HYpL2/JFsboxX95FhKv5eqinAGXUJcFA0HUTJ1FmlkfkkFF5jiFQTGN4Z2CV1K
         bhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OBUrJshRKdHCIELytwMgwl0eYU8yhpe9u6VmUXUcNvo=;
        b=DRvLd2O46DBRkPDDVYI0kDzih8RVnuPO7en+k/RQKx99ZMiBSisvY3BO2olCIBaJmk
         5cp5JSgKG8U930813jdWbHV2E5HGshrJ3IOrUHBkyZunPC7Jnhn/yHQvoT/rlGXxp3u3
         BbSzqOTtrDhdYan07WIzCrCGy38CVOgk1xSJtLKC5A3PNx+p3bIh4dfTJPMc/bDbkkQU
         i2S2eteuLEITA6ozNeVUR2TL1yJZAsU/MH72wQRMNS52nfdn2Qjn7Bz3V5iCNYv99bY8
         Eryf9OEDG9bQaSCwlp4sUCyzA1jm8SqhEBApW2I6+xC2VQ8dizOz8wwvNiG86z2Pgmiw
         gIsw==
X-Gm-Message-State: AD7BkJLlp5RqsDKZP1+wMBfTMCtiqE9b+TXmVm8CP9vZ4wBxEtCfIuY/s5zOQsX8RNRtxw==
X-Received: by 10.98.14.67 with SMTP id w64mr4847975pfi.154.1457021698141;
        Thu, 03 Mar 2016 08:14:58 -0800 (PST)
Received: from localhost.localdomain ([1.39.36.239])
        by smtp.gmail.com with ESMTPSA id z5sm30337230par.21.2016.03.03.08.14.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Mar 2016 08:14:57 -0800 (PST)
X-Mailer: git-send-email 2.7.1.340.g69eb491.dirty
In-Reply-To: <1457021601-9099-1-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288188>

Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
---
 Documentation/git-pull.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index a62a2a6..a593972 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -128,6 +128,21 @@ unless you have read linkgit:git-rebase[1] carefully.
 --no-rebase::
 	Override earlier --rebase.
 
+--autostash::
+--no-autostash::
+	Automatically create a temporary stash before the operation
+	begins, and apply it after the operation ends. This means
+	that you can run rebase on a dirty worktree.
++
+This option is only valid when '--rebase' option is used.
++
+The default is --no-autostash, unless rebase.autoStash configuration 
+is set.
++
+[NOTE]
+Use with care: the final stash application after a successful
+rebase might result in non-trivial conflicts.
+
 Options related to fetching
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.7.1.340.g69eb491.dirty
