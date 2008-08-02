From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] diff: chapter and part in funcname for tex
Date: Sat,  2 Aug 2008 13:55:45 +0200
Message-ID: <1217678145-2630-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <1217658945-29908-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 02 13:56:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPFip-0003vN-6E
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 13:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811AbYHBLza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 07:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752806AbYHBLza
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 07:55:30 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:36447 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752798AbYHBLz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 07:55:29 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1207578fkq.5
        for <git@vger.kernel.org>; Sat, 02 Aug 2008 04:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=RwjPLJOR1v1W/ZNz4kHlhcguHqdZOgKBdBixwRFHCeg=;
        b=CqifDOTAObWLnB9qWBq2w32KgV0TFnGGaCF9lj6ZKHTa02ZCuPUYUGbQpc3lIA1rgg
         nVK4Gfmg/mr5AYFXrcOWRalhyw/OQhUvaqdS2UmAHxCQkBMveT2FYBO10f9PYwbBOq2/
         ZUAuxH2nu7qTNtERrO74MUsWvFdGv7diC5bak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qoTokW1yh6ZmxxWNb0gDcDCpl5uhvSZW3wlpr2leRBdgfLH2Qt2jmA7ntwR+dpc2A2
         EhiJS0E75bE+Z4No8J5KON2fQCCt7+rEYeelc8kT34Buz2ucw+VE22S8x/9P8th/eXcf
         34GuU2WPxk+StTxDnaScRZAzWLq0O8O3nDP8Q=
Received: by 10.181.21.6 with SMTP id y6mr4405396bki.86.1217678127406;
        Sat, 02 Aug 2008 04:55:27 -0700 (PDT)
Received: from localhost ( [94.37.6.145])
        by mx.google.com with ESMTPS id b17sm1956285fka.19.2008.08.02.04.55.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 02 Aug 2008 04:55:26 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1217658945-29908-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91144>

This patch enhances the tex funcname by adding support for
chapter and part sectioning commands. It also matches
the starred version of the sectioning commands.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

---

Resend, with Signed-off-by: line

 diff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index c253015..776bce1 100644
--- a/diff.c
+++ b/diff.c
@@ -1380,7 +1380,7 @@ static struct builtin_funcname_pattern {
 			"^[ 	]*\\(\\([ 	]*"
 			"[A-Za-z_][A-Za-z_0-9]*\\)\\{2,\\}"
 			"[ 	]*([^;]*\\)$" },
-	{ "tex", "^\\(\\\\\\(sub\\)*section{.*\\)$" },
+	{ "tex", "^\\(\\\\\\(\\(sub\\)*section\\|chapter\\|part\\)\\*\\?{.*\\)$" },
 	{ "ruby", "^\\s*\\(\\(class\\|module\\|def\\)\\s.*\\)$" },
 };
 
-- 
1.5.6.3
