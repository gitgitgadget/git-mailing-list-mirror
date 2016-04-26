From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] config doc: improve exit code listing
Date: Tue, 26 Apr 2016 11:10:58 -0700
Message-ID: <20160426181058.7901-1-sbeller@google.com>
Cc: john@keeping.me.uk, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Apr 26 20:11:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av7SR-0005gg-Re
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 20:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280AbcDZSLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 14:11:25 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33956 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260AbcDZSLY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 14:11:24 -0400
Received: by mail-pa0-f48.google.com with SMTP id r5so9471439pag.1
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 11:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=5XNqEEmDvQkXad5b3VjT+ttaAifX6RVPaWLqLZzyaWk=;
        b=aK6uVndSxUrTwO+8X6m+4en0Q5UJDLbSP8Pg8m3guGUhBT6OPG9fjTKRUFXe7zyFVd
         fl5K9vi+FFPbjMtU+5e3aVyRknrE9C70GdyScTPElRImRYI7qvd/Xuxz69ZwmiCmDum3
         b1HcYUviCOc1aCgYJf18fBbAmDWqvY78Lye8+5BV1Fveynqv8BZ1pmEek+x108AXmF+6
         toG8FCdJrnpHj3dO6qcGe4RbFmhWRpCGJytFvnSv4D/Ah/yOlxePJXa0FhVy3NWsD7ti
         YYrDM0aMdgfwCwxDxA5+EMUZpH+LkzR1+e7OfUgKy6MeMwMM+PiWYnh0ch1aaK5F8zB8
         QoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5XNqEEmDvQkXad5b3VjT+ttaAifX6RVPaWLqLZzyaWk=;
        b=coG/xCM0EdHRAPJOy35hmEwErgnBkjjcLjGYLsSCdlfY0OR+BuLqQva+4h1FcLfoJz
         RtOPh8SMoxpuCSUGd34VBioXfP4dGEiOES5IYaGgH6geD5A0tN1lYqFH4vc8MjW28FV+
         hx27NijBjmjzt16WciPxlHP9nnSeSroP8a2ebFWxbZGuoMYWqpEi6T9nMjMRBezK34uf
         SYWwthfEj5M/qQx0IvpYqDMVCLoqmRjniBTIfRvQTZGSYLLQ8B+/oWOTQ+YCQK3n6ktN
         ffs2jHfp7GOILv0gjuHAt0aWMg1IBAL4N5jYt6ZXKPRRrcdWdeDqLKFklCcqPAqbgiJz
         HgKg==
X-Gm-Message-State: AOPr4FXXlXKPWIBiJxoysQgqBPeq5ZGC4VrBGFEFM1PejWaafYLOT7DqpWURDQmrHT2wFf6hOShTH/ZJx7vFYTjRbc6G5YJk6KsRbmaWKtkwMBV/BymanlnJGGlhAw==
X-Received: by 10.66.160.7 with SMTP id xg7mr5600210pab.10.1461694283366;
        Tue, 26 Apr 2016 11:11:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:fcb4:82e7:2d29:45d6])
        by smtp.gmail.com with ESMTPSA id 194sm6918388pfv.8.2016.04.26.11.11.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Apr 2016 11:11:22 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.343.gb96d81e
X-ccpol: medium
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292634>

The possible reasons for exiting are now ordered by the exit code value.
While at it, rewrite the `can not write to the config file` to
`the config file cannot be written` to be grammatically correct and a
proper sentence.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-config.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 6fc08e3..6843114 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -58,10 +58,10 @@ that location (you can say '--local' but that is the default).
 This command will fail with non-zero status upon error.  Some exit
 codes are:
 
-- The config file is invalid (ret=3),
-- can not write to the config file (ret=4),
+- The section or key is invalid (ret=1),
 - no section or name was provided (ret=2),
-- the section or key is invalid (ret=1),
+- the config file is invalid (ret=3),
+- the config file cannot be written (ret=4),
 - you try to unset an option which does not exist (ret=5),
 - you try to unset/set an option for which multiple lines match (ret=5), or
 - you try to use an invalid regexp (ret=6).
-- 
2.8.1.343.gb96d81e

base-commit: 3ad15fd5e17bbb73fb1161ff4e9c3ed254d5b243
