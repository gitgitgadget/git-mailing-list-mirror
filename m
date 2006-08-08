From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 5/4] autoconf: Mention "make configure" instead of "autoconf" in INSTALL
Date: Tue, 8 Aug 2006 18:48:47 +0200
Message-ID: <200608081848.48181.jnareb@gmail.com>
References: <200608081834.09271.jnareb@gmail.com> <200608081835.23448.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Aug 08 18:48:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAUl6-0005Xx-96
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 18:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbWHHQsp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 12:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbWHHQsp
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 12:48:45 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:32950 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964984AbWHHQso (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Aug 2006 12:48:44 -0400
Received: by nf-out-0910.google.com with SMTP id q29so227664nfc
        for <git@vger.kernel.org>; Tue, 08 Aug 2006 09:48:43 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=GEc7lb1tyZ9sis8Nk3tUe+9iVO7EXXLviBICc3GBfl8uQ1QHzq1hgPLV1oOq7nKks3iAIR7j1ty4a4aSuJR2XbQneip94tk0fJ9wX6pWD05OPMVaQxGR7uJ3Kz5Z8iUQkpDRKGlOAoA3UAKrimrRa8wY1kdwHIj/EfJ/xE67+j0=
Received: by 10.49.8.1 with SMTP id l1mr580713nfi;
        Tue, 08 Aug 2006 09:48:42 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id c10sm1009901nfb.2006.08.08.09.48.42;
        Tue, 08 Aug 2006 09:48:42 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608081835.23448.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25077>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Should be part of [PATCH 1/4] in this series (replied-to patch)

 INSTALL |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/INSTALL b/INSTALL
index f8dfa19..0d432d7 100644
--- a/INSTALL
+++ b/INSTALL
@@ -16,7 +16,7 @@ install" would not work.
 Alternatively you can use autoconf generated ./configure script to
 set up install paths (via config.mak.autogen), so you can write instead
 
-	$ autoconf ;# as yourself if ./configure doesn't exist yet
+	$ make configure ;# as yourself
 	$ ./configure --prefix=/usr ;# as yourself
 	$ make all doc ;# as yourself
 	# make install install-doc ;# as root
-- 
1.4.1.1
