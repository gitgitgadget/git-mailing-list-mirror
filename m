From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/7] Fix 'git var' usage synopsis
Date: Fri, 19 Feb 2010 00:51:57 -0600
Message-ID: <20100219065156.GA29916@progeny.tock>
References: <20100219065010.GA22258@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Celis <sebastian@sebastiancelis.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 19 07:51:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiMiR-0002AG-2F
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 07:51:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484Ab0BSGvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 01:51:51 -0500
Received: from mail-gx0-f227.google.com ([209.85.217.227]:32841 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752287Ab0BSGvu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 01:51:50 -0500
Received: by gxk27 with SMTP id 27so3751899gxk.1
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 22:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=8o/iAWKwYrfwHYYB2evWHA4HCyjNEEH9tWkAZ8jThsE=;
        b=VG7a1rG3VRP51LTyE4Ufms+UcqaiATmgabgODzLKsDpKhvk6W32HITJ0a+6GJVWvMe
         be3KMDuo9lSq2K3cAfDt3nB5wZi4nPJ3GqhVhmoiiXEPVcQ3tbSzK1Px364P80wF4Jv5
         o980N51NAX4265jucYLuR29bgMAnn2Jx6+rKk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OvEQQA9q6vzqoL5APmN79z197VuvDDvWnDFEh7jqHYngg5kOnDIGnh+yVmxnThNQ5J
         Hfm8+cag+fhqNUZ9NXrvhDeGEB3Qj5gLcXnVjnoUvG0I+uqGic7Z+GaLC2x5l4fXfPdo
         c9ymx8Uq+wfZ2Y1U47Rw12qMCrOEImLF4BUTs=
Received: by 10.91.160.30 with SMTP id m30mr6743611ago.1.1266562309177;
        Thu, 18 Feb 2010 22:51:49 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 15sm1259735gxk.2.2010.02.18.22.51.48
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 18 Feb 2010 22:51:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100219065010.GA22258@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140417>

The parameter to 'git var' is not optional.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Same as v1, probably should be ejected from the series.  I am
including it for reference anyway.

 Documentation/git-var.txt |    2 +-
 builtin-var.c             |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index bb98182..458f3e2 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -8,7 +8,7 @@ git-var - Show a git logical variable
 
 SYNOPSIS
 --------
-'git var' [ -l | <variable> ]
+'git var' ( -l | <variable> )
 
 DESCRIPTION
 -----------
diff --git a/builtin-var.c b/builtin-var.c
index 2280518..e6ee7bc 100644
--- a/builtin-var.c
+++ b/builtin-var.c
@@ -6,7 +6,7 @@
 #include "cache.h"
 #include "exec_cmd.h"
 
-static const char var_usage[] = "git var [-l | <variable>]";
+static const char var_usage[] = "git var (-l | <variable>)";
 
 static const char *editor(int flag)
 {
-- 
1.7.0
