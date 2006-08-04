From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/5] autoconf: typofix to detect SHA1_Init in -lcrypto
Date: Fri, 4 Aug 2006 23:29:28 +0200
Message-ID: <200608042329.29254.jnareb@gmail.com>
References: <200608042333.19011.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Aug 04 23:41:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G97PO-0005gS-Nq
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 23:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161499AbWHDVkh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 17:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161497AbWHDVkg
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 17:40:36 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:18352 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161496AbWHDVke convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 17:40:34 -0400
Received: by nf-out-0910.google.com with SMTP id k26so30469nfc
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 14:40:33 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=U4FOwlt7k9hpkC3Tgco9qwnjm2eg/5zOp2wMim5eqkpKs5wCGs6Vr/t7crl6mZ7TQyle1yca2lByPbTRm08zA3GBbpJChxO9BZMyjbIv44mHehR0iJaHVSJq9zXZTJ6UTzIRGLA/PPQHSzofPYdtLE2IiLOGFF36prqbrAWEztw=
Received: by 10.49.94.20 with SMTP id w20mr6010866nfl;
        Fri, 04 Aug 2006 14:40:33 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id r34sm1038674nfc.2006.08.04.14.40.33;
        Fri, 04 Aug 2006 14:40:33 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608042333.19011.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24845>

>From 15951e524df655d12b2bc42b1cf0a4be39fc3278 Mon Sep 17 00:00:00 2001
From: Junio C Hamano <junkio@cox.net>
Date: Fri, 4 Aug 2006 22:17:35 +0200
Subject: [PATCH 1/5] autoconf: typofix to detect SHA1_Init in -lcrypto

Signed-off-by: Junio C Hamano <junkio@cox.net>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 configure.ac |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index 76bfa9d..5926f3c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -155,7 +155,7 @@ #
 # Define NO_OPENSSL environment variable if you do not have OpenSSL.
 # Define NEEDS_SSL_WITH_CRYPTO if you need -lcrypto with -lssl 
(Darwin).
 AC_CHECK_LIB([ssl], [SHA1_Init],[],
-[AC_CHECK_LIB([crypto], [SHA1_INIT],
+[AC_CHECK_LIB([crypto], [SHA1_Init],
  [GIT_CONF_APPEND_LINE(NEEDS_SSL_WITH_CRYPTO=YesPlease)],
  [GIT_CONF_APPEND_LINE(NO_OPENSSL=YesPlease)])])
 #
-- 
1.4.1.1
