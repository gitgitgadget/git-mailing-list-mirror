From: =?UTF-8?q?Beno=C3=AEt=20Bourbi=C3=A9?= <benoit.bourbie@gmail.com>
Subject: [PATCH] Typo fix: replacing it's -> its
Date: Fri, 12 Apr 2013 00:05:41 -0500
Message-ID: <1365743141-2513-2-git-send-email-benoit.bourbie@gmail.com>
References: <1365743141-2513-1-git-send-email-benoit.bourbie@gmail.com>
Cc: =?UTF-8?q?Beno=C3=AEt=20Bourbi=C3=A9?= <benoit.bourbie@gmail.com>,
	git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Apr 12 07:06:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQWC1-0002Ku-86
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 07:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731Ab3DLFG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 01:06:29 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:53158 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523Ab3DLFG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 01:06:28 -0400
Received: by mail-ob0-f172.google.com with SMTP id eh20so2060559obb.3
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 22:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Kx2HvdxUEhwhC0hpxfCoP0R98FR7IieF/FTeD23Si4A=;
        b=QT31BBC1c4hqjOwczTSJGV5FhR+Z8m3iR52Rs4l5mg8Mw8diPzVJXRjt9ezewGMT2s
         mOD3VsiMDHPdblTa5onx0heqJ7oLkSB5uZWAp3TJk1m+lj1TYQQU0c9WHJ418WYoqh7X
         XdC+kjjMyUzoCN+883YXRg1Sgtzb6JP2XNoarjWF4NEXoJgrVjThi0v2ObFypdCrnXLb
         5+8ZSVL0GjkTqyGLwdj+S2VRek+9dWQOau97mo380rNdvlHfcLRD9goAHgw5AJYaFVc/
         P+q6Mas2nGVgbOQDWpzRlj+2fEmhRiJ3o3ZKa+EYKjXBfCgCbbsAy4TyiGhAXfW/pZqY
         wlIg==
X-Received: by 10.182.102.106 with SMTP id fn10mr3266866obb.85.1365743188295;
        Thu, 11 Apr 2013 22:06:28 -0700 (PDT)
Received: from localhost.localdomain (c-98-201-171-34.hsd1.tx.comcast.net. [98.201.171.34])
        by mx.google.com with ESMTPS id x10sm1495193oes.6.2013.04.11.22.06.27
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 22:06:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.470.g21ccebe.dirty
In-Reply-To: <1365743141-2513-1-git-send-email-benoit.bourbie@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220954>

Signed-off-by: Benoit Bourbie <benoit.bourbie@gmail.com>
---
 INSTALL               | 2 +-
 perl/private-Error.pm | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/INSTALL b/INSTALL
index 2dc3b61..ba01e74 100644
--- a/INSTALL
+++ b/INSTALL
@@ -101,7 +101,7 @@ Issues of note:
 	- "openssl" library is used by git-imap-send to use IMAP over SSL.
 	  If you don't need it, use NO_OPENSSL.
 
-	  By default, git uses OpenSSL for SHA1 but it will use it's own
+	  By default, git uses OpenSSL for SHA1 but it will use its own
 	  library (inspired by Mozilla's) with either NO_OPENSSL or
 	  BLK_SHA1.  Also included is a version optimized for PowerPC
 	  (PPC_SHA1).
diff --git a/perl/private-Error.pm b/perl/private-Error.pm
index 11e9cd9..ea14ab2 100644
--- a/perl/private-Error.pm
+++ b/perl/private-Error.pm
@@ -630,7 +630,7 @@ Only one finally block may be specified per try block
 =head2 CONSTRUCTORS
 
 The C<Error> object is implemented as a HASH. This HASH is initialized
-with the arguments that are passed to it's constructor. The elements
+with the arguments that are passed to its constructor. The elements
 that are used by, or are retrievable by the C<Error> class are listed
 below, other classes may add to these.
 
@@ -763,7 +763,7 @@ to the constructor.
 
 =item Error::Simple
 
-This class can be used to hold simple error strings and values. It's
+This class can be used to hold simple error strings and values. Its
 constructor takes two arguments. The first is a text value, the second
 is a numeric value. These values are what will be returned by the
 overload methods.
-- 
1.8.2.470.g21ccebe.dirty
