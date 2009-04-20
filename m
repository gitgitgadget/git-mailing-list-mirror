From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Makefile: remove {fetch,send}-pack from PROGRAMS as they are builtins
Date: Mon, 20 Apr 2009 10:17:25 +1000
Message-ID: <1240186645-4635-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 20 02:18:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvhDs-0002mg-2q
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 02:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbZDTARX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Apr 2009 20:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbZDTARX
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 20:17:23 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:47563 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbZDTARW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 20:17:22 -0400
Received: by wa-out-1112.google.com with SMTP id j5so942483wah.21
        for <git@vger.kernel.org>; Sun, 19 Apr 2009 17:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=Bfb07xAfIk8iPxIU8c9LkKzUtwinPkkrnv8KOkxUFQ0=;
        b=nRIiV0GpkG/aD4c8HmHKWwmSqQOwBhJQ2CYvvaE6m+ux+x5HQurES+f88J+L/eOUFQ
         jt6RlEf/R3Fv+M7VdaCBlLZK3hdXGvvppCYNUK8zmclhc8JvckSlXZ/NeGiZim3jGw9B
         Nf4v1zAlMih7wHjePgDmDQUC+oxgofqyHitJc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=RbNrYlNb4Do5BQ4l8P83Qu0jlbFAOzLujIsaKbIQWm7SdXSbANLDWhaqjDGRGdwNDb
         coetG7DWaqVtZ7t610HKCE6gnzUbtBzPytbMqFG03SBq38j0FbGMWZ7hqJz/JSyVJNWK
         XRNIKuPipCsO56YkvtB1IC+SkMbWSYN+GnVCw=
Received: by 10.115.58.1 with SMTP id l1mr2965024wak.191.1240186640566;
        Sun, 19 Apr 2009 17:17:20 -0700 (PDT)
Received: from dektop (dektec.lnk.telstra.net [203.45.32.221])
        by mx.google.com with ESMTPS id j28sm6822020waf.4.2009.04.19.17.17.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Apr 2009 17:17:20 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon, 20 Apr 2009 10:17:27 +1000
X-Mailer: git-send-email 1.6.2.2.693.g5a1be
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116919>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 57f9f26..6e0838b 100644
--- a/Makefile
+++ b/Makefile
@@ -319,7 +319,6 @@ EXTRA_PROGRAMS =3D
 # ... and all the rest that could be moved out of bindir to gitexecdir
 PROGRAMS +=3D $(EXTRA_PROGRAMS)
 PROGRAMS +=3D git-fast-import$X
-PROGRAMS +=3D git-fetch-pack$X
 PROGRAMS +=3D git-hash-object$X
 PROGRAMS +=3D git-index-pack$X
 PROGRAMS +=3D git-merge-index$X
@@ -328,7 +327,6 @@ PROGRAMS +=3D git-mktag$X
 PROGRAMS +=3D git-mktree$X
 PROGRAMS +=3D git-pack-redundant$X
 PROGRAMS +=3D git-patch-id$X
-PROGRAMS +=3D git-send-pack$X
 PROGRAMS +=3D git-shell$X
 PROGRAMS +=3D git-show-index$X
 PROGRAMS +=3D git-unpack-file$X
--=20
1.6.2.2.693.g5a1be
