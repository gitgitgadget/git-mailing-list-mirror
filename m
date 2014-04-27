From: Marius Ungureanu <marius.ungureanu@xamarin.com>
Subject: Re: [PATCH 1/2] update C# userdiff patterns
Date: Sun, 27 Apr 2014 16:45:46 +0300
Message-ID: <31BBCA60-8EC8-43B1-B82F-071324036AC8@xamarin.com>
References: <29F78086-81B4-481F-9051-FF3EEBA9BB08@xamarin.com> <535B5BFF.40002@kdbg.org> <97789B23-A375-46B1-99FD-A851A15C2D85@xamarin.com> <535BF1C0.7080204@kdbg.org> <1EA6F663-54DC-4665-A88C-8627F38B356E@xamarin.com> <535BFFEB.8040103@kdbg.org>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Apr 27 15:44:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WePNz-0007BC-Kk
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 15:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbaD0Nos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2014 09:44:48 -0400
Received: from mail-ee0-f42.google.com ([74.125.83.42]:53653 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbaD0Nor convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Apr 2014 09:44:47 -0400
Received: by mail-ee0-f42.google.com with SMTP id d17so4080050eek.29
        for <git@vger.kernel.org>; Sun, 27 Apr 2014 06:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xamarin.com; s=google;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GvvLUItoP7NWb0zQlvnTEUcFtARTxpkTd5Lk18OvCQo=;
        b=mU2+rTX2WjrKUN3q5GivKk4On6nYneYRisvWYNP8U4eFziyTAgg8z8Aejcov8Hb8k1
         RQQ+iPB+s11S+82VGvNUO7q/6Ui2GBDTEamtFPBhRYbhM0Mhgm8Z9bR36zfThckgygSm
         L8zurIDHMZQnyLTi1QR1CWgs9eC2Wmi5BoGDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=GvvLUItoP7NWb0zQlvnTEUcFtARTxpkTd5Lk18OvCQo=;
        b=JiFfPqIUz1wUC0QCNAjRs4bsMEf+OdJqDIcfgiTNMc9qygZH0afnq4xmmCfUkg7sV3
         DCiGPJ9vP4geLNoN+scYSKsMKTXLuaZTf7M9le9Gc3crrFjqhizRCf7NenSOEBhpxe0w
         pQZKfJ9ndOCVMk8+Zh8Zv7h6i+OA68t4kucVvE8wXYElgmyO7wpPvTKhqAoqznlwoa0O
         9mkTYvEAPwwZrUYpzLJGt6zA/otPAw0+uHoQ2Q31XyQM5Fqu2vcHWEUGVI3xV/U/fx0I
         4O4vkwsFqWNapihDMKwZp1O2RmWbTpk9PjdA9+1cBNQ23IaNkekYYBCbAz8kPglo7GIm
         Yc1w==
X-Gm-Message-State: ALoCoQnpzVd8O2UdziV9hxYLM4GAZ1WVCKNL2kWd3VuTkfsSGIPQA4Fyx6c3/zJvFi2T02zXyx7T
X-Received: by 10.14.224.6 with SMTP id w6mr656927eep.60.1398606285753;
        Sun, 27 Apr 2014 06:44:45 -0700 (PDT)
Received: from [192.168.1.101] ([188.26.30.123])
        by mx.google.com with ESMTPSA id u1sm41811467eex.31.2014.04.27.06.44.44
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Apr 2014 06:44:45 -0700 (PDT)
In-Reply-To: <535BFFEB.8040103@kdbg.org>
X-Mailer: Apple Mail (2.1874)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247201>

Remove all keywords since they don't cause conflicts.

Add method modifiers: abstract, async, explicit, extern, implicit,
partial, operator.

Add properties modifiers: abstract, readonly.

Add type modifiers: abstract.

Parse C# operator functions.

Fix constructor parsing.

Signed-off-by: Marius Ungureanu <marius.ungureanu@xamarin.com>
---
 userdiff.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index fad52d6..e7ba5e3 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -133,14 +133,12 @@ PATTERNS("cpp",
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lLuU]*"
 	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->\\*?|\\.\\*"),
 PATTERNS("csharp",
-	 /* Keywords */
-	 "!^[ \t]*(do|while|for|if|else|instanceof|new|return|switch|case|throw|catch|using)\n"
 	 /* Methods and constructors */
-	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[<>@._[:alnum:]]+[ \t]*\\(.*\\))[ \t]*$\n"
+	 "^[ \t]*(((abstract|async|explicit|extern|implicit|internal|new|operator|override|partial|private|protected|public|sealed|static|unsafe|virtual)[ \t]+)*[][<>@._[:alnum:]]*[ \t]*[-<>@.~=+!*%&|^_[:alnum:]]+[ \t]*\\(.*\\))[ \t]*$\n"
 	 /* Properties */
-	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[@._[:alnum:]]+)[ \t]*$\n"
+	 "^[ \t]*(((abstract|internal|new|override|private|protected|public|readonly|sealed|static|unsafe|virtual)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[@._[:alnum:]]+)[ \t]*$\n"
 	 /* Type definitions */
-	 "^[ \t]*(((static|public|internal|private|protected|new|unsafe|sealed|abstract|partial)[ \t]+)*(class|enum|interface|struct)[ \t]+.*)$\n"
+	 "^[ \t]*(((abstract|internal|new|override|partial|private|protected|public|sealed|static|unsafe)[ \t]+)*(class|enum|interface|struct)[ \t]+.*)$\n"
 	 /* Namespace */
 	 "^[ \t]*(namespace[ \t]+.*)$",
 	 /* -- */
-- 
1.8.4
