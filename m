X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: [PATCH] Teach SubmittingPatches about git-commit -s
Date: Tue, 21 Nov 2006 19:55:20 +0100
Message-ID: <20061121195520.66c22559@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 21 Nov 2006 18:55:28 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=qDkCTL4bQqXGjaqf5nAyv5+GD7S60XbDSSHEUrHvfbM/h0S+9teiNXIMdTZHoMSW9ob5sYwP4CJ1jg89iPLwtdJCuCPAbkBtw8YFbLu2KIJpTfT/HwN416NTMfex9X8J19dUDC7fgnPPi3sJ84cYBohjn9BBU8eYGnqr6vxtU5w=
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32022>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gmalw-0005rv-4Y for gcvg-git@gmane.org; Tue, 21 Nov
 2006 19:55:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031312AbWKUSzE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 13:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966969AbWKUSzE
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 13:55:04 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:36965 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1031315AbWKUSzB
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 13:55:01 -0500
Received: by nf-out-0910.google.com with SMTP id o25so265803nfa for
 <git@vger.kernel.org>; Tue, 21 Nov 2006 10:55:00 -0800 (PST)
Received: by 10.48.202.11 with SMTP id z11mr1286911nff.1164135300153; Tue, 21
 Nov 2006 10:55:00 -0800 (PST)
Received: from paolo-desktop ( [82.50.5.251]) by mx.google.com with ESMTP id
 n23sm26840657nfc.2006.11.21.10.54.59; Tue, 21 Nov 2006 10:54:59 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

[PATCH] Teach SubmittingPatches about git-commit -s

As discussed on git mailing list let's teach the reader about
the possiblity to have automatically signed off the commit running
the git-commit -s command

Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
---
 Documentation/SubmittingPatches |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 8a3d316..20193cc 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -149,6 +149,7 @@ then you just add a line saying
 
 	Signed-off-by: Random J Developer <random@developer.example.org>
 
+This line can be automatically added by git if you run the git-commit command with the -s option
 Some people also put extra tags at the end.  They'll just be ignored for
 now, but you can do this to mark internal company procedures or just
 point out some special detail about the sign-off.
-- 
1.4.4.gef06


