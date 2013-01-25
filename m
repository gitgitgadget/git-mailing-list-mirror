From: Jiang Xin <worldhello.net@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20Update=20renamed=20file=20merge-file=2Eh=20in=20Makefile?=
Date: Fri, 25 Jan 2013 11:06:28 +0800
Message-ID: <1359083188-31866-1-git-send-email-worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 04:07:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyZdJ-0003nF-Pc
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 04:07:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380Ab3AYDGw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2013 22:06:52 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:42600 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406Ab3AYDGv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 22:06:51 -0500
Received: by mail-pa0-f49.google.com with SMTP id bi1so5883301pad.8
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 19:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=hJ46s0x2auUVuobt3SYQJCw0dVSdD1I7ssbrd/7WB28=;
        b=lHlkJR9sqDh6FwRn9gGCswm77DSLx78mEu0JaWz5Mu8AhB5AX36yt1jdRjCUiNAtQY
         Wx2AFypJxqA+yo16VlGUp1LONqvs5FKNqHu1oxhYcjYibY71+Xpt9jWM9qGqVAdbTBbh
         JfNfiuaPGRnn/jagBADjo6mb6ywmJf3gMt0QxlzcCmn9ZagnJvGXocpp4rGO3+pj8rB1
         VYNHpR78LMfARqhqw7wYXlLsQi6dHFpX51wTy+2YYPZ1wpyeY42fc+w/Ks3T7a9MPCPw
         XCqnWHVINmJSnQzr9UKOPetoV4TQZBksocZ/7cmCvqMsU5LcH+zN3bcRqbdQO10foQep
         p83Q==
X-Received: by 10.66.86.71 with SMTP id n7mr9932969paz.77.1359083211312;
        Thu, 24 Jan 2013 19:06:51 -0800 (PST)
Received: from localhost.localdomain ([124.207.10.6])
        by mx.google.com with ESMTPS id oc8sm14807044pbb.39.2013.01.24.19.06.46
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 24 Jan 2013 19:06:49 -0800 (PST)
X-Mailer: git-send-email 1.8.0-rc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214482>

Commit v1.8.1-rc0-3-gfa2364e renamed merge-file.h to merge-blobs.h, but
forgot to update the reference of merge-file.h in Makefile. This would
break the build of "po/git.pot", which depends on $(LOCALIZED_C), then
fallback to the missing file "merge-file.h".

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 Makefile |    2 +-
 1 =E4=B8=AA=E6=96=87=E4=BB=B6=E8=A2=AB=E4=BF=AE=E6=94=B9=EF=BC=8C=E6=8F=
=92=E5=85=A5 1 =E8=A1=8C(+)=EF=BC=8C=E5=88=A0=E9=99=A4 1 =E8=A1=8C(-)

diff --git a/Makefile b/Makefile
index 1b30d7b..a786d4c 100644
--- a/Makefile
+++ b/Makefile
@@ -649,7 +649,7 @@ LIB_H +=3D list-objects.h
 LIB_H +=3D ll-merge.h
 LIB_H +=3D log-tree.h
 LIB_H +=3D mailmap.h
-LIB_H +=3D merge-file.h
+LIB_H +=3D merge-blobs.h
 LIB_H +=3D merge-recursive.h
 LIB_H +=3D mergesort.h
 LIB_H +=3D notes-cache.h
--=20
1.8.1.1
