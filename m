From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Edit user manual for grammar
Date: Tue, 12 Jun 2007 16:43:19 +0100
Message-ID: <200706121643.19837.andyparkins@gmail.com>
References: <588192970706120518p201b52fdi9ed48896278b9f3e@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 12 17:43:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy8Wp-0008NS-NO
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 17:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755298AbXFLPn1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 11:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755216AbXFLPn0
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 11:43:26 -0400
Received: from mu-out-0910.google.com ([209.85.134.190]:56436 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755215AbXFLPn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 11:43:26 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1549779mue
        for <git@vger.kernel.org>; Tue, 12 Jun 2007 08:43:24 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=A714L4MhGT5p+jPdJ2SmMUtkyApsk/Nv3rWIlYZUyWO0iVwmbE69qUe350tJzXzm3Jw+NKnZzPV59qfDk2uTdo610jsvd3pH5yJi/wwRkoxBKRg4wF2QDbUzba/d6CEk80p8IxyYAtu3xAwREzfBknRuUA4dER7RxVIdD3OYBoE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=Bs+hAfVg1gnxXq4l+RPZuY30Oeq1xYRpr/IgqzPUNN/vSQpoDTOYDrPQX5f0IBy3LajPnMlJ4oIrpwTEFCvaaqJ4Sw2SDI/vT3YLcl1zu+fEfIa2UVrMKP4U9xqjK003sIpMFzB1GvSEcP1PvlW74jX3KBcNqsdXg43MrktSYwQ=
Received: by 10.82.112.3 with SMTP id k3mr13545307buc.1181663003403;
        Tue, 12 Jun 2007 08:43:23 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id z40sm16858024ikz.2007.06.12.08.43.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Jun 2007 08:43:22 -0700 (PDT)
In-Reply-To: <588192970706120518p201b52fdi9ed48896278b9f3e@mail.gmail.com>
X-TUID: cefe01bfc2891692
X-UID: 317
X-Length: 1827
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49968>

 - "last-resort" is two words, not a conjoined word, it doesn't require
   the hyphen
 - "method of" is vulgar, "method for" is nicer
 - "recovery" becomes "recovering" from Steve Hoelzer's original version
   of this patch
 - "if you want" is nicer as "if you wish"
 - "you may" should be "you can"; "you may" is "you have permission to"
   rather than "you can"'s "it is possible to"

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---

My apologies for jumping on your patch, but when I read the context of your
change, I couldn't resist fixing some things around it too.

 Documentation/user-manual.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 7eaafa8..d62ccd0 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1527,9 +1527,9 @@ dangling tree b24c2473f1fd3d91352a624795be026d64c8841f
 -------------------------------------------------
 
 Dangling objects are not a problem.  At worst they may take up a little
-extra disk space.  They can sometimes provide a last-resort method of
-recovery lost work--see <<dangling-objects>> for details.  However, if
-you want, you may remove them with gitlink:git-prune[1] or the --prune
+extra disk space.  They can sometimes provide a last resort method for
+recovering lost work--see <<dangling-objects>> for details.  However, if
+you wish, you can remove them with gitlink:git-prune[1] or the --prune
 option to gitlink:git-gc[1]:
 
 -------------------------------------------------
-- 
1.5.2.1.134.gd166e
