From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH/RFC 1/9] mention --date=raw in rev-list and blame help
Date: Tue, 29 Mar 2011 00:17:23 +0100
Message-ID: <1301354251-23380-2-git-send-email-wmpalmer@gmail.com>
References: <1301354251-23380-1-git-send-email-wmpalmer@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Will Palmer <wmpalmer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 01:18:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4LhJ-0000rH-Fn
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 01:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755515Ab1C1XR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 19:17:56 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56503 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755418Ab1C1XRy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 19:17:54 -0400
Received: by wya21 with SMTP id 21so3294020wya.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 16:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=zJe9W+o7kT8R4bYDuRnYdvcvR9KuJfpOAQuy6u0hB/k=;
        b=nvdPKSBZdpWsoKc9sV7vhYs/eY67azIOEzCKbNhteYF53sH+y21yWKnxohA8rzGT68
         bEFRQXox36JUATQsjClg8pC/yUNIy1xTyjN+YgpgzHN39eS8DvlMHzpI1pJAUhi2NTQX
         TP50OerL0nU9enT7w+exwQiMC90c5R+//RxiU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BHwBOKbZ1OHXXYzaIgjtz3TjSrMZV+1Zau8fxbP8DYdFUbM9ClGRXtSYEpsuN8t60r
         isYDxrdgKV94uWLkQrgtPmFBxwrsxzyno8aFAr2JY/bFv1rBaiT0bTX8vmF2PpAEfSnZ
         cWHy6m3hNdbRSucOrxIsF5Phux0mJSMVQMfkQ=
Received: by 10.216.240.3 with SMTP id d3mr3372072wer.51.1301354273531;
        Mon, 28 Mar 2011 16:17:53 -0700 (PDT)
Received: from localhost.localdomain (5acc3aad.bb.sky.com [90.204.58.173])
        by mx.google.com with ESMTPS id b54sm1678272wer.45.2011.03.28.16.17.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 16:17:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.2
In-Reply-To: <1301354251-23380-1-git-send-email-wmpalmer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170200>

Very trivial: the documentation for "blame" and "rev-list" failed to
mention the --date=raw option in the summary of the --date option.
Here we correct that.

Signed-off-by: Will Palmer <wmpalmer@gmail.com>
---
 Documentation/blame-options.txt |    4 ++--
 Documentation/git-rev-list.txt  |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 16e3c68..e11a3da 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -72,8 +72,8 @@ of lines before or after the line given by <start>.
 
 --date <format>::
 	The value is one of the following alternatives:
-	{relative,local,default,iso,rfc,short}. If --date is not
-	provided, the value of the blame.date config variable is
+	{relative,local,default,iso,rfc,short,raw}. If --date is
+	not provided, the value of the blame.date config variable is
 	used. If the blame.date config variable is also not set, the
 	iso format is used. For more information, See the discussion
 	of the --date option at linkgit:git-log[1].
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 8e1e329..ce3692c 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -37,7 +37,7 @@ SYNOPSIS
 	     [ \--regexp-ignore-case | -i ]
 	     [ \--extended-regexp | -E ]
 	     [ \--fixed-strings | -F ]
-	     [ \--date=(local|relative|default|iso|rfc|short) ]
+	     [ \--date=(local|relative|default|iso|rfc|short|raw) ]
 	     [ [\--objects | \--objects-edge] [ \--unpacked ] ]
 	     [ \--pretty | \--header ]
 	     [ \--bisect ]
-- 
1.7.4.2
