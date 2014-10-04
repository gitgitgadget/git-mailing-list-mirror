From: Wieland Hoffmann <themineo@gmail.com>
Subject: [PATCH] git-tag.txt: Add a missing hyphen to `-s`
Date: Sat,  4 Oct 2014 18:27:16 +0200
Message-ID: <1412440036-20067-1-git-send-email-themineo@gmail.com>
Cc: Wieland Hoffmann <themineo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 04 18:28:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XaSC5-00030Z-Qb
	for gcvg-git-2@plane.gmane.org; Sat, 04 Oct 2014 18:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbaJDQ2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2014 12:28:24 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:34505 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbaJDQ2G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Oct 2014 12:28:06 -0400
Received: by mail-wg0-f47.google.com with SMTP id x13so3591315wgg.6
        for <git@vger.kernel.org>; Sat, 04 Oct 2014 09:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=eEdrlaXzrDXkd6I6dPCNHyfRNpYaLrCHZADwzZeiIkA=;
        b=OpA61TonvYm9Amv49zXahuEXc06z6CeYlTipPJRpxDk8ar7aZEZ98ZBjw0Mc/bH21L
         DWCgeDiqnd0GyhFBbIjNy0RfjfRm6P4XD4eunF8k989/WSMPD7WMWHm8ubCq5me8184p
         cHcDtmNcvME/VvQV0jkF0Ry2VBmOE5n8WBi1Q2QyO8uzFy+CCuFwkOKMY+7UhscjB88y
         tbyEfYBjkDlerltg/bwko2ciUrpnW24JVPcP6NjiHVfwqeRQ+59yA5WyfwJbOM+foOwR
         OrK+W8KJv82AUHDO3wpgYLFxJLe4bMd4qo9GrQxce5DPUIG8rsTE3022OkkmX66ezLjQ
         OO6Q==
X-Received: by 10.181.9.73 with SMTP id dq9mr6827316wid.40.1412440084504;
        Sat, 04 Oct 2014 09:28:04 -0700 (PDT)
Received: from localhost.localdomain (pD9FDCAF4.dip0.t-ipconnect.de. [217.253.202.244])
        by mx.google.com with ESMTPSA id u8sm5410802wia.24.2014.10.04.09.28.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 04 Oct 2014 09:28:04 -0700 (PDT)
X-Mailer: git-send-email 2.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257889>

Signed-off-by: Wieland Hoffmann <themineo@gmail.com>
---
 Documentation/git-tag.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 3209083..e953ba4 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -42,7 +42,7 @@ committer identity for the current user is used to find the
 GnuPG key for signing. 	The configuration variable `gpg.program`
 is used to specify custom GnuPG binary.
 
-Tag objects (created with `-a`, `s`, or `-u`) are called "annotated"
+Tag objects (created with `-a`, `-s`, or `-u`) are called "annotated"
 tags; they contain a creation date, the tagger name and e-mail, a
 tagging message, and an optional GnuPG signature. Whereas a
 "lightweight" tag is simply a name for an object (usually a commit
-- 
2.1.2
