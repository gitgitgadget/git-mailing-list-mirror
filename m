From: Alexander Potashev <aspotashev@gmail.com>
Subject: [PATCH (resend)] Fix typo in comment in builtin-add.c
Date: Thu, 11 Dec 2008 01:27:44 +0300
Message-ID: <1228948064-4006-1-git-send-email-aspotashev@gmail.com>
References: <200812101910.mBAJAsF04710@localhost.localdomain>
Cc: Alexander Potashev <aspotashev@gmail.com>,
	"Boyd Stephen Smith Jr." <bss03@volumehost.net>,
	Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: A S Potashev <aspotashev@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 23:28:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAXXm-0002yr-J1
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 23:28:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409AbYLJW1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 17:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753617AbYLJW1R
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 17:27:17 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:30817 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbYLJW1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 17:27:16 -0500
Received: by fg-out-1718.google.com with SMTP id 19so343109fgg.17
        for <git@vger.kernel.org>; Wed, 10 Dec 2008 14:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=kFALlKTnyheefuOnraApxxZVhNh8pXtJDkGEhrWbCSE=;
        b=OWz7KWgR1RTrzCdif8CT580KLPP2m6GCEQ+dJosEqELeAV3ljhJw8QuLxHaQxk2O5i
         K9qfM22Ka+DP+j4kwEIZvECgDz2+NkjxmWjftdFlL2kXW3D7oM4PgJYCwBhQFAwzXT5y
         41loJDPPVfuPkDid/wQeG414ByCzYlNtDInmE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mlJ0rHOsc+/IbdjZTEqIOA1DlZ0WK1ahWVR+BMME5kvlKGB+tFnwL1zio/uU7Qh14/
         Vg6UeCVv0CGRzNM2C4MZe+jLaLckt4FJU+KdYmq9lgSbdstr4HWlwEyav3JA+c+1fFwr
         bg2/6f5K+/yTInrE2UP2SGLqP/5EgXlpMLwrM=
Received: by 10.86.50.6 with SMTP id x6mr910526fgx.71.1228948034808;
        Wed, 10 Dec 2008 14:27:14 -0800 (PST)
Received: from localhost.localdomain ([91.78.206.93])
        by mx.google.com with ESMTPS id 4sm104416fge.45.2008.12.10.14.27.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Dec 2008 14:27:13 -0800 (PST)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <200812101910.mBAJAsF04710@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102732>

Reported-by: Tim Daly <daly@axiom-developer.org>
Cc: Boyd Stephen Smith Jr. <bss03@volumehost.net>
Cc: Junio C Hamano <gitster@pobox.com>
Cc: <git@vger.kernel.org>
Signed-off-by: Alexander Potashev <aspotashev@gmail.com>
---
 builtin-add.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index ea4e771..719de8b 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -23,7 +23,7 @@ static void fill_pathspec_matches(const char **pathspec, char *seen, int specs)
 	int num_unmatched = 0, i;
 
 	/*
-	 * Since we are walking the index as if we are warlking the directory,
+	 * Since we are walking the index as if we were walking the directory,
 	 * we have to mark the matched pathspec as seen; otherwise we will
 	 * mistakenly think that the user gave a pathspec that did not match
 	 * anything.
-- 
1.6.0.4
