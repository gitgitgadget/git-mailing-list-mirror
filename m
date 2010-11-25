From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v3 1/9] t5550-http-fetch: add missing '&&'
Date: Thu, 25 Nov 2010 16:21:02 +0800
Message-ID: <1290673270-4284-2-git-send-email-rctay89@gmail.com>
References: <1290433298-6000-1-git-send-email-rctay89@gmail.com>
 <1290673270-4284-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 25 09:28:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLXBT-0002Kt-8q
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 09:28:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663Ab0KYI16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 03:27:58 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40060 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483Ab0KYI16 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 03:27:58 -0500
Received: by iwn5 with SMTP id 5so7074iwn.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 00:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=uC11roZJfEbFb9mAsZFL2e4oeKx6o3+m3iG1TiRVY50=;
        b=CYzs3LKY5bVDhJEfp/d42FqGtOEo1JB6o+vspYUaZa1exR1VKr6P4KEgKCCcTkT9Ur
         IobP+B4TGWyy5yoLsFO0F/3prSou8qo/MyeNB0KfFHTGK7LLjhZIedrKK7zG6rivc78X
         hUO6bxTzh5J4rSUoeetc2KHoIxdF16Jy4cFow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kCR27Hz7Yy9le/yn04euU1lbXGHFn4S9vP+Wr6IeBk1BSc+llZZqexFwwoePZiROOR
         fbFgusu/Eyrc8nX/OfiAmBJ65I/sWapF+hPaheb0l3GcAH37sNdN62Z+42Uy5QgxDFAE
         8mXOPizCAO+Ozedtl4fRfbfKF2+liWbkSD2FI=
Received: by 10.231.40.10 with SMTP id i10mr340147ibe.55.1290673333844;
        Thu, 25 Nov 2010 00:22:13 -0800 (PST)
Received: from localhost.localdomain (cm60.zeta152.maxonline.com.sg [116.87.152.60])
        by mx.google.com with ESMTPS id i16sm513271ibl.12.2010.11.25.00.22.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 00:22:12 -0800 (PST)
X-Mailer: git-send-email 1.7.2.2.513.ge1ef3
In-Reply-To: <1290673270-4284-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162115>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t5550-http-fetch.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index 2fb48d0..39f7b7c 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -37,7 +37,7 @@ test_expect_success 'clone http repository' '
 test_expect_success 'fetch changes via http' '
 	echo content >>file &&
 	git commit -a -m two &&
-	git push public
+	git push public &&
 	(cd clone && git pull) &&
 	test_cmp file clone/file
 '
-- 
1.7.3.2.495.gc7b3f
