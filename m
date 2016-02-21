From: "=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?=" 
	<felipeg.assis@gmail.com>
Subject: [PATCH v2 1/5] merge-strategies.txt: fix typo
Date: Sun, 21 Feb 2016 19:59:01 -0300
Message-ID: <1456095545-20201-2-git-send-email-felipegassis@gmail.com>
References: <1456095545-20201-1-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	sunshine@sunshineco.com,
	=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= 
	<felipegassis@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 00:00:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXczp-0001wN-CT
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 00:00:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356AbcBUXAo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Feb 2016 18:00:44 -0500
Received: from mail-qg0-f41.google.com ([209.85.192.41]:33193 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109AbcBUXAl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 18:00:41 -0500
Received: by mail-qg0-f41.google.com with SMTP id b35so99735143qge.0
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 15:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=QhoWixWZGDmybZ7TQXPUyAEzerJgQxH8uq8c3kV18iQ=;
        b=WUbFJhFPnKClulbNTLVJCDmEeuzxjLvDKdmMlg3/9PSmzJj2hWqzKnhWX3yJlSETwi
         TTAl9EtZIXf6FRC4XkVaJP4ahkOI9RhCSajDY5uWAG2YuLEdPPmkdPHdVDVFsD6HdXgQ
         3znAOgD4bJLBRbdrbSyf+O9jj7BlwkQuBKfH18GD5LGroZM4MPWLa56iC4izAcbFRS21
         qwrcDApzrlu3PQyUOZVy+WLKY6ab0bNLotl5Qt8N8Gwp3fAGwLIRjpW+fyBsLc7cNC0B
         cpv/L1RSLtAE+48FpllqCQ5+ALvyRWuC6bUBusKND5IgT4y/E5j46VNqtQKCLGvCiyXT
         eyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=QhoWixWZGDmybZ7TQXPUyAEzerJgQxH8uq8c3kV18iQ=;
        b=WWvlzY/ZFMWyLAHX07ex7juhZTALLTP9XU0x1S0hZVPibnqBDX2e4FQRoRqlODXa17
         otbuQHzhOVG7RO20+Jcsu+nQD3G0kDonTieqV+FtHhi8Mx1YH6qzObsOuq1+5Z1J8z9U
         G7BEXwJAAs03tTxtPnP0KOmdGSep41f+gXPjxW3hxhpizZoOJXxkGXJ/h1BL/HzYhhwy
         CJXtsOiQwyD/ASJb80fBZ1wHVn5bMtF6JgL6l+bol2oDyac6JCkiE2K93c64JCm6QHU/
         MTUluZk5JJNxZOQ6uwXOKFqyuwZWLSFh1cVDclCxjoJU4lIwc7OloW05iBgOTbsXWnt/
         7uRA==
X-Gm-Message-State: AG10YOQaHBWgGzKz0zZlJO4wACqv6jryzgnL/d1H0Xaw5WPHeJ9Eaiit+hVBpZaCycafoA==
X-Received: by 10.140.251.70 with SMTP id w67mr31037509qhc.99.1456095640592;
        Sun, 21 Feb 2016 15:00:40 -0800 (PST)
Received: from traveller.moon ([177.94.146.172])
        by smtp.gmail.com with ESMTPSA id f83sm9177201qkb.25.2016.02.21.15.00.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Feb 2016 15:00:39 -0800 (PST)
X-Google-Original-From: =?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= <felipegassis@gmail.com>
X-Mailer: git-send-email 2.7.1.492.gd821b20
In-Reply-To: <1456095545-20201-1-git-send-email-felipegassis@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286836>

Signed-off-by: Felipe Gon=C3=A7alves Assis <felipegassis@gmail.com>
---
 Documentation/merge-strategies.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-s=
trategies.txt
index ff359b6..2eb92b9 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -86,8 +86,8 @@ no-renames;;
 	See also linkgit:git-diff[1] `--no-renames`.
=20
 find-renames[=3D<n>];;
-	Turn on rename detection, optionally setting the the similarity
-	threshold. This is the default.
+	Turn on rename detection, optionally setting the similarity
+	threshold.  This is the default.
 	See also linkgit:git-diff[1] `--find-renames`.
=20
 rename-threshold=3D<n>;;
--=20
2.7.1.492.gd821b20
