From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH 10/10] Docs: git tag: Rewrite discussion of GIT_COMMITTER_DATE
Date: Mon, 28 Mar 2011 15:11:49 +0000
Message-ID: <1301327622-8595-11-git-send-email-mfwitten@gmail.com>
References: <1301327622-8595-1-git-send-email-mfwitten@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 17:55:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Emr-0004h7-Hh
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 17:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754744Ab1C1PzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 11:55:12 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:45043 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754207Ab1C1PzL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 11:55:11 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1221676ewy.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 08:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:message-id:x-mailer
         :in-reply-to:references:date;
        bh=9meaS6O5eN1jZSbppM3zXYhaxWvpmE7fQv9hLfqXGTk=;
        b=AQdnzsWfVFM6k7gVMrijpQEGha3YLsdyW1OcCb9/QxK2WPMMHPBeqS4/g7pMG3ZOPT
         mF1872rLAFDivmKqhABExUV0UzkhxwMCGz10L7rLSQNk8l7/5iFc+sVzhOxIpWogDA7W
         7bKNj+yCCTklzFBNnB9RxyX0s9FeGPJSYC/U8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:message-id:x-mailer:in-reply-to:references:date;
        b=gO9gI1/nHvdpFq57zESTb8GCdLbXEzoe6Wj3d3Joe0H5nTASyPA2t2BbBFU5Au8BBb
         UgYPjHsClxo/9c0i4xOYZdciy9A/mUqCg1ZeEsVow3qpixCMU0aOqfOZYy+CrXLSAQDq
         7VwU0u0fVsDKbvFH0s/hYii4n8QKYjBvrU80w=
Received: by 10.14.11.1 with SMTP id 1mr1853288eew.138.1301327710470;
        Mon, 28 Mar 2011 08:55:10 -0700 (PDT)
Received: from localhost.localdomain ([174.143.243.243])
        by mx.google.com with ESMTPS id v1sm2878807eeh.6.2011.03.28.08.55.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 08:55:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.18.g68fe8
In-Reply-To: <1301327622-8595-1-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170148>

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-tag.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 3dd78a0..21dc06f 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -248,16 +248,16 @@ the tag object affects, for example, the ordering of tags in the
 gitweb interface.
 
 To set the date used in future tag objects, set the environment
-variable GIT_COMMITTER_DATE to one or more of the date and time.  The
-date and time can be specified in a number of ways; the most common
-is "YYYY-MM-DD HH:MM".
+variable GIT_COMMITTER_DATE (see the later discussion of possible
+values; the most common form is "YYYY-MM-DD HH:MM").
 
-An example follows.
+For example:
 
 ------------
 $ GIT_COMMITTER_DATE="2006-10-02 10:31" git tag -s v1.0.1
 ------------
 
+include::date-formats.txt[]
 
 SEE ALSO
 --------
-- 
1.7.4.18.g68fe8
