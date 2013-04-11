From: Benoit Bourbie <benoit.bourbie@gmail.com>
Subject: Fixing typos
Date: Wed, 10 Apr 2013 22:08:12 -0500
Message-ID: <5166291C.8070709@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030906070708030605030104"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 11 05:16:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ7zx-0002vM-Vd
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 05:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933036Ab3DKDQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 23:16:25 -0400
Received: from mail-yh0-f50.google.com ([209.85.213.50]:39797 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762678Ab3DKDQX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 23:16:23 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Apr 2013 23:16:23 EDT
Received: by mail-yh0-f50.google.com with SMTP id 25so188067yhr.9
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 20:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:subject
         :content-type;
        bh=2LgNx0hBPnBmydSLrPvIWve+YiyROJkV+htvA3iO3nc=;
        b=W7r1L+tkGaXhDvMIUY+W7QLdwmpkK7kpkW4avP9JPj8EECxk7Mq0vonMJ158/78Wep
         KTsfOYxAvEP1VOS7QsMmVLx8GowRBxB+Ar9PwjgEu2hZv4pT+7ORTj4jZZBTuGTQJuxh
         oMTOiND8dkjDHUsLomb1r5k6EXaPYWqQyx5YUnku/i2xLrFrXlp+BcCHCqJLxLZshuoe
         Ms4E10fKC8qvUU06BQJ1X05lleZbXNgEz6kXIN2wGdf4ySfGKGfmdpetNP+LQaoTvCPD
         QS1xpkP7vtAk9aeVX9XX2Bw0K66XUFrMttUZkb+jQPP08We9vaeISR+ip/e47R6ztOlv
         0OJQ==
X-Received: by 10.236.84.195 with SMTP id s43mr2972127yhe.105.1365649694879;
        Wed, 10 Apr 2013 20:08:14 -0700 (PDT)
Received: from [192.168.0.16] (c-98-201-171-34.hsd1.tx.comcast.net. [98.201.171.34])
        by mx.google.com with ESMTPS id h6sm3810679yhf.19.2013.04.10.20.08.13
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 10 Apr 2013 20:08:14 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220808>

This is a multi-part message in MIME format.
--------------030906070708030605030104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I apologize for being picky but that patch fixes 3 typos.



--------------030906070708030605030104
Content-Type: text/x-patch;
 name="fix_typo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fix_typo.patch"

>From 59f60e37b6d684963e2408b85a636b04c753f74f Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Beno=C3=AEt=20Bourbi=C3=A9?= <benoit.bourbie@gmail.com>
Date: Wed, 10 Apr 2013 22:00:25 -0500
Subject: [PATCH] fix it's -> its typo

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


--------------030906070708030605030104--
