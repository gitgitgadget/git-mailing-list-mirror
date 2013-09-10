From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 11/14] be clearer in place of 'remote repository' phrase
Date: Wed, 11 Sep 2013 01:07:55 +0800
Message-ID: <1378832878-12811-12-git-send-email-rctay89@gmail.com>
References: <1255065768-10428-2-git-send-email-spearce@spearce.org>
 <1378832878-12811-1-git-send-email-rctay89@gmail.com>
 <1378832878-12811-2-git-send-email-rctay89@gmail.com>
 <1378832878-12811-3-git-send-email-rctay89@gmail.com>
 <1378832878-12811-4-git-send-email-rctay89@gmail.com>
 <1378832878-12811-5-git-send-email-rctay89@gmail.com>
 <1378832878-12811-6-git-send-email-rctay89@gmail.com>
 <1378832878-12811-7-git-send-email-rctay89@gmail.com>
 <1378832878-12811-8-git-send-email-rctay89@gmail.com>
 <1378832878-12811-9-git-send-email-rctay89@gmail.com>
 <1378832878-12811-10-git-send-email-rctay89@gmail.com>
 <1378832878-12811-11-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 10 19:09:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJRQq-0003Wj-Fr
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 19:08:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079Ab3IJRIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 13:08:45 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:48453 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754045Ab3IJRIm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 13:08:42 -0400
Received: by mail-pd0-f173.google.com with SMTP id p10so7891861pdj.18
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 10:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X2z2j2dquXe2j5/mPiOAXtUyg6dnmM/oMuI6KbLGSls=;
        b=oAXclxd5xSAW8dpYJy16ivv8vVVhUzXP6IkM52TBIqPZ/iVu8ezubdgSJaieJLLqih
         11YWOdeDju6p8ZvUx/K2okWqv9N/PYT4DHIel66iHVtGNLdpn6c5DJnXPp0EIobEdMfA
         /9om+J1y4tuX7C4JMCuCRyseB3zKu0hpHZnrYJX0R1zzlJ7i+qoBgPS2IDfXelgrlD/t
         z0g5jzGUIh+GpIljov9ILuN7h5ado2FCgJVDYamTqojYRxfueXpP7YoYINPYPFw5PcqO
         VjY98dBVtf1Hn1QB/88qou/d/SpUjZDn+gLzmgEjIjniAhcVSYvoZ/AyLhdO7inpAVz4
         ibUg==
X-Received: by 10.66.144.102 with SMTP id sl6mr27255057pab.96.1378832922361;
        Tue, 10 Sep 2013 10:08:42 -0700 (PDT)
Received: from ubu-01-asus.nus.edu.sg (bb42-60-75-197.singnet.com.sg. [42.60.75.197])
        by mx.google.com with ESMTPSA id tg7sm24173138pbc.36.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 10:08:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc4.527.g303b16c
In-Reply-To: <1378832878-12811-11-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234455>

Based on:

  From:   Junio C Hamano <gitster@pobox.com>
  Message-ID: <7vskdss3ei.fsf@alter.siamese.dyndns.org>

  > +Smart Service git-upload-pack
  > +------------------------------
  > +This service reads from the remote repository.

  The wording "remote repository" felt confusing.  I know it is "from the
  repository served by the server", but if it were named without
  "upload-pack", I might have mistaken that you are allowing to proxy a
  request to access a third-party repository by this server.  The same
  comment applies to the git-receive-pack service.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 Documentation/technical/http-protocol.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
index dbfff36..4bb1614 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -279,7 +279,7 @@ declarations behind a NUL on the first ref.
 
 Smart Service git-upload-pack
 ------------------------------
-This service reads from the remote repository.
+This service reads from the repository pointed to by $GIT_URL.
 
 Clients MUST first perform ref discovery with
 '$GIT_URL/info/refs?service=git-upload-pack'.
@@ -440,7 +440,7 @@ TODO: Document parsing response
 
 Smart Service git-receive-pack
 ------------------------------
-This service modifies the remote repository.
+This service modifies the repository pointed to by $GIT_URL.
 
 Clients MUST first perform ref discovery with
 '$GIT_URL/info/refs?service=git-receive-pack'.
-- 
1.8.4.rc4.527.g303b16c
