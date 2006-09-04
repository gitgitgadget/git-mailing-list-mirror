From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/5] autoconf: Add some commented out variables to config.mak.in
Date: Tue, 5 Sep 2006 00:55:12 +0200
Message-ID: <200609050055.12666.jnareb@gmail.com>
References: <200609050054.24279.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 05 00:58:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKNOl-0007dB-HF
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 00:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWIDW6d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 18:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWIDW6d
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 18:58:33 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:36119 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751308AbWIDW6b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 18:58:31 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1112904nfa
        for <git@vger.kernel.org>; Mon, 04 Sep 2006 15:58:30 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pAgUqR/GH7SYxOXRFZaB60OvnnxBsP/6s2KQ0yWhGveIsMKoEHjCBxW5cKxtiUONSCKTVmifZHWws18FalS5EB2QdmNchwy2+xzMU9tpQpL8lgm8ESzz3fd25ONMGfsgfMp38ABQ3QDXvMzWM6UAKCQRc+b0YuK6AmvTgoZSow0=
Received: by 10.48.254.10 with SMTP id b10mr7098626nfi;
        Mon, 04 Sep 2006 15:58:29 -0700 (PDT)
Received: from host-81-190-21-28.torun.mm.pl ( [81.190.21.28])
        by mx.gmail.com with ESMTP id l38sm10135925nfc.2006.09.04.15.58.29;
        Mon, 04 Sep 2006 15:58:29 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200609050054.24279.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26444>

Add commented out variables for the features which can be detected by
autoconf, but are not implemented yet, to config.mak.in file.

This way we can easily see which tests are not implemented yet.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 config.mak.in |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index 369e611..2947560 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -37,4 +37,6 @@ NO_C99_FORMAT=@NO_C99_FORMAT@
 NO_STRCASESTR=@NO_STRCASESTR@
 NO_STRLCPY=@NO_STRLCPY@
 NO_SETENV=@NO_SETENV@
+#NO_MMAP=@NO_MMAP@
+#NO_ICONV=@NO_ICONV@
 
-- 
1.4.1.1
