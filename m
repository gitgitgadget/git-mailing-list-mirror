From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v2 1/3] t/lib-cvs.sh: allow cvsps version 3.x.
Date: Sat, 12 Jan 2013 00:21:41 -0600
Message-ID: <1357971703-28513-2-git-send-email-chris@rorvick.com>
References: <1357971703-28513-1-git-send-email-chris@rorvick.com>
Cc: "Eric S. Raymond" <esr@thyrsus.com>,
	Junio C Hamano <gitster@pobox.com>,
	Chris Rorvick <chris@rorvick.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 12 07:24:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtuVm-0004UI-JS
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 07:24:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760Ab3ALGXn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 01:23:43 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:61688 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485Ab3ALGXm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 01:23:42 -0500
Received: by mail-ie0-f181.google.com with SMTP id 16so3208260iea.26
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 22:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=JsAKlU2dKhQmgulAAiaDnb2sstDyLnDwU+1UfIO/Whs=;
        b=g0Qi/OHtYrn2eOQGELMA2r07RzOto7uNPt257cM/FwETedxZa/gVDMof7b52QfE7WF
         YtwMRpyn/MF4AIHFCrRwBIgota4DzasQg7LqyVjKZmyhO4mmRb7XIVxyHdpcegWg/Fim
         4p06WQyO81jwWv28y6JfE0N/4yLCScNDFQg0cMP+p4jeWkp3vNI4yvdjdpl1VHl0GB8z
         RCSCLCc4WuBUiUYQ5MYgw0gSr/mdODwZJTHal7X1fqHR0wQAnWvOhTNDpA87M8nEYPbL
         anz4OLcILTqo7+W9jWCZKIfY023R+7R7i0Hc0Nkn4QOKAQ+lkgsT4rWBh3xJXL8ui8/4
         fslw==
X-Received: by 10.50.187.230 with SMTP id fv6mr1359882igc.48.1357971821973;
        Fri, 11 Jan 2013 22:23:41 -0800 (PST)
Received: from marlin.localdomain (adsl-70-131-98-170.dsl.emhril.sbcglobal.net. [70.131.98.170])
        by mx.google.com with ESMTPS id ww6sm1426280igb.2.2013.01.11.22.23.40
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 11 Jan 2013 22:23:41 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.335.g88a67d6
In-Reply-To: <1357971703-28513-1-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213271>

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 t/lib-cvs.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-cvs.sh b/t/lib-cvs.sh
index 44263ad..b55e861 100644
--- a/t/lib-cvs.sh
+++ b/t/lib-cvs.sh
@@ -15,7 +15,7 @@ export CVS
 
 cvsps_version=`cvsps -h 2>&1 | sed -ne 's/cvsps version //p'`
 case "$cvsps_version" in
-2.1 | 2.2*)
+2.1 | 2.2* | 3.*)
 	;;
 '')
 	skip_all='skipping cvsimport tests, cvsps not found'
-- 
1.8.1.rc3.335.g88a67d6
