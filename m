From: Alexander Litvinov <lan@ac-sw.com>
Subject: [PATCH] fix cvsexportcommit syntax error
Date: Wed, 9 Nov 2005 13:02:58 +0600
Organization: AcademSoft Ltd.
Message-ID: <200511091302.58805.lan@ac-sw.com>
References: <7vy83zhyu4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 08:02:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZjyS-0003r4-Q4
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 08:02:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030407AbVKIHCW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 02:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030424AbVKIHCW
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 02:02:22 -0500
Received: from gw.ac-sw.com ([81.1.223.2]:45021 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id S1030407AbVKIHCV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 02:02:21 -0500
Received: from lan.ac-sw.lcl (unknown [192.168.0.69])
	by gw.ac-sw.com (Postfix) with ESMTP
	id B48A5BD67; Wed,  9 Nov 2005 13:02:12 +0600 (NOVT)
Received: by lan.ac-sw.lcl (Postfix, from userid 65534)
	id AAF5ECC867; Wed,  9 Nov 2005 13:03:01 +0600 (NOVT)
Received: from localhost (localhost [127.0.0.1])
	by lan.ac-sw.lcl (Postfix) with ESMTP id C4111A6D9E;
	Wed,  9 Nov 2005 13:03:00 +0600 (NOVT)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.8
In-Reply-To: <7vy83zhyu4.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on lan.ac-sw.lcl
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=5.0 tests=ALL_TRUSTED,AWL 
	autolearn=ham version=3.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11388>

There is a syntax error in cvsexport script:

--- git-cvsexportcommit.perl.orig       2005-11-09 13:00:51.000000000 +0600
+++ git-cvsexportcommit.perl    2005-11-09 13:00:57.000000000 +0600
@@ -64,7 +64,7 @@
            last;
        }; # found it
        die "Did not find $parent in the parents for this commit!";
-s    }
+    }
 } else { # we don't have a parent from the cmdline...
     if (@parents == 1) { # it's safe to get it from the commit
        $parent = $parents[0];
