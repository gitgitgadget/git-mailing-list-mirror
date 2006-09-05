From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] autoconf: Fix copy'n'paste error
Date: Tue, 5 Sep 2006 22:03:48 +0200
Message-ID: <200609052203.49060.jnareb@gmail.com>
References: <200609050054.24279.jnareb@gmail.com> <200609050055.52980.jnareb@gmail.com> <20060905162526.GA5547@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 05 22:03:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKh93-0001tX-6G
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 22:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161023AbWIEUDh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 16:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161024AbWIEUDh
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 16:03:37 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:38736 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161023AbWIEUDg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Sep 2006 16:03:36 -0400
Received: by nf-out-0910.google.com with SMTP id o25so54073nfa
        for <git@vger.kernel.org>; Tue, 05 Sep 2006 13:03:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=sukWjUyAMfgFjVaQsq0CooFkRJcJHqCw+uhHMbLS+1iJBj+ZFL/18oFEs34v5SmKgGKo17FXVoxP+p2+H8BSj3D0ZZfo3PxOw/R1LndWfelwr2vHFa+UTRf3CGihP69H/7c/ISUp3TUxOjcsul6h/lhmuLA/QclxuUFj8sbHDq0=
Received: by 10.49.43.2 with SMTP id v2mr8174760nfj;
        Tue, 05 Sep 2006 13:03:34 -0700 (PDT)
Received: from host-81-190-21-28.torun.mm.pl ( [81.190.21.28])
        by mx.gmail.com with ESMTP id r33sm7143813nfc.2006.09.05.13.03.33;
        Tue, 05 Sep 2006 13:03:34 -0700 (PDT)
To: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <20060905162526.GA5547@diku.dk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26485>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 configure.ac |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index 85317a3..482c849 100644
--- a/configure.ac
+++ b/configure.ac
@@ -147,7 +147,7 @@ AC_CHECK_LIB([c], [iconv],
 [NEEDS_LIBICONV=],
 [NEEDS_LIBICONV=YesPlease])
 AC_SUBST(NEEDS_LIBICONV)
-test -n "$NEEDS_SOCKET" && LIBS="$LIBS -liconv"
+test -n "$NEEDS_LIBICONV" && LIBS="$LIBS -liconv"
 #
 # Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
 # Patrick Mauritz).
-- 
1.4.2
