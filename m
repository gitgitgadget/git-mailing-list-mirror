From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH v5 1/4] merge: update the usage information to be more modern
Date: Thu, 10 Feb 2011 18:52:41 -0500
Message-ID: <1297381964-7137-2-git-send-email-jaredhance@gmail.com>
References: <1297381964-7137-1-git-send-email-jaredhance@gmail.com>
Cc: Jared Hance <jaredhance@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 11 00:53:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PngKO-0006BZ-Ja
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 00:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757395Ab1BJXxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 18:53:00 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:53185 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757291Ab1BJXw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 18:52:58 -0500
Received: by qwa26 with SMTP id 26so1176611qwa.19
        for <git@vger.kernel.org>; Thu, 10 Feb 2011 15:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=OX8BKaucr1meAhevhQONFB3eCQWxTAAU7IF/GVENj4A=;
        b=ZdGJeozE8/XFXS0rVS+84VESFts9s3QbG2gxC+1SdqUpUBcfnCmxl44/9b4bOoO3XL
         NI9BW/RZpF7klEvbYirCbeQ9Czll7C6YzhoCW+IR04xblMd1OoXJioGprfxSuZeJ7PRJ
         WGq4xenE9zaFSamMtNCChdHG6BXQo13s7v7UA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oYV8Z1pRkTagVwYqpY2/zbv9B6IDxLtLF4Ed5/R1/8NcLWMFYw/QV7Ul+/xdJCFWsi
         QsFvfxfp8i8T72xmVnb9jMcLjgxLb5SsPr7g8L35RSi4EokKm8r5nfLXBJgBEVmzcLFI
         +eyQtsWr+W6SRehPceGzb/Lhk+w402uV/byCA=
Received: by 10.224.60.132 with SMTP id p4mr17984312qah.267.1297381977026;
        Thu, 10 Feb 2011 15:52:57 -0800 (PST)
Received: from localhost.localdomain (cpe-75-186-7-248.cinci.res.rr.com [75.186.7.248])
        by mx.google.com with ESMTPS id t7sm123028qcs.4.2011.02.10.15.52.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Feb 2011 15:52:56 -0800 (PST)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1297381964-7137-1-git-send-email-jaredhance@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166527>

Apparantly, merge's usage information was outdated and used old terminology.
Fix it.

Signed-off-by: Jared Hance <jaredhance@gmail.com>
---
 builtin/merge.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 42fff38..439d2c7 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -37,8 +37,8 @@ struct strategy {
 };
 
 static const char * const builtin_merge_usage[] = {
-	"git merge [options] <remote>...",
-	"git merge [options] <msg> HEAD <remote>",
+	"git merge [options] <branch>...",
+	"git merge [options] <msg> HEAD <branch>",
 	NULL
 };
 
-- 
1.7.4
