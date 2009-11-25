From: Jed Brown <jed@59A2.org>
Subject: [PATCH 2/2] Documentation for format-patch --notmuch.
Date: Wed, 25 Nov 2009 03:50:47 +0100
Message-ID: <1259117447-23052-2-git-send-email-jed@59A2.org>
References: <87d4375ne0.fsf@59A2.org>
 <1259117447-23052-1-git-send-email-jed@59A2.org>
Cc: madcoder@debian.org, Jed Brown <jed@59A2.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 03:50:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ND7xx-0002Lu-IO
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 03:50:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934238AbZKYCue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 21:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934230AbZKYCud
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 21:50:33 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:48075 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934184AbZKYCuc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 21:50:32 -0500
Received: by mail-bw0-f227.google.com with SMTP id 27so6585968bwz.21
        for <git@vger.kernel.org>; Tue, 24 Nov 2009 18:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=vf6gG9jKI4+2xu7NfYA0w0qhGE6jxidYaCSeFC5ZFl4=;
        b=QTlN55yYnFg5zGiICsLnGQVMfwfC9UMGjhLS/DEdoIUSk7mCAfj9kVJGCCnuXsllfv
         /xqwrXPsB3MqCQDrNG3XnL+9hbxFbHPJBYWbjvqDpJ/kQxelxIwYV57ilL7x3att/3vq
         gp7ED+0UbFvW4s01WKCq+xfxHROTvPEuLQ7RM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=xxX0mB91arPLmTcOvnZOEg1FNXSZ1xMx1vncdhts5ZMsQ/jfTGDl1XWZD778fJ6KMb
         el8HBV9la7Y+VA8cQLzII1M5qcidQTJ8pTyHQo+0mZTFPvSSiaIA0XVBPcCr9e9uXhvi
         OCQGUaOUcyrqQSCgNw/miq5rIyCea3zDxFpkY=
Received: by 10.204.20.143 with SMTP id f15mr1076664bkb.49.1259117438237;
        Tue, 24 Nov 2009 18:50:38 -0800 (PST)
Received: from localhost.localdomain (vawpc43.ethz.ch [129.132.59.11])
        by mx.google.com with ESMTPS id 12sm410890fks.39.2009.11.24.18.50.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Nov 2009 18:50:37 -0800 (PST)
X-Mailer: git-send-email 1.6.5.3
In-Reply-To: <1259117447-23052-1-git-send-email-jed@59A2.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133610>

---
 Documentation/git-format-patch.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index f1fd0df..aaa472d 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -171,6 +171,13 @@ will want to ensure that threading is disabled for `git send-email`.
 	to any configured headers, and may be used multiple times.
 	For example, `--add-header="Organization: git-foo"`
 
+--notmuch=<expr>::
+	Generate headers appropriate for a reply to a notmuch search for the
+	given expression.  Usually an expression of the form id:<Message-ID>
+	will be used to match an exact message.  The reply will set
+	In-Reply-To, References, To, Cc, Bcc, and possibly other headers
+	(depending on notmuch configuration).
+
 --cover-letter::
 	In addition to the patches, generate a cover letter file
 	containing the shortlog and the overall diffstat.  You can
-- 
1.6.5.3
