From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: [PATCH] Makefile: Remove git-fsck and git-verify-pack from PROGRAMS
Date: Mon, 28 May 2007 22:05:43 -0400
Message-ID: <20070529020543.GC2552@localhost.myhome.westell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 29 04:05:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hsr5o-00044L-Q0
	for gcvg-git@gmane.org; Tue, 29 May 2007 04:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753459AbXE2CFk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 28 May 2007 22:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753599AbXE2CFk
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 22:05:40 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:36429 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459AbXE2CFj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 22:05:39 -0400
Received: by wx-out-0506.google.com with SMTP id t15so1374339wxc
        for <git@vger.kernel.org>; Mon, 28 May 2007 19:05:38 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        b=nmVaCnx67AB05oe7hECP++YpSmLSgkHaiwge/YS9jfaLPzASRv309UxZx0rIRTFC9di1FL5kKUpuYc6dk5MFrbgY6CHtw/rr+AWR4r/Tmolx3FQSKMBOAI6DtaTAyJlg6VAmm6UIvV8kCM3xNMBBvp9ErFpur1mlyzFISye7fqE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        b=p8GoL9POuq0hXZD6OuFdKSNJvCMTE2qXzJGXMd+dJ/VTWdAMC+eVfLsDFIlzvSZJeHBRs+yS+2j0h/FKgyHI16/kJPqxa9otCor3o9mXhyX0kLO74jtANfxqsjKDQUWwa+RpJzd+IjhzNqc9wGMik7g/xQlpwWIuThGhwP1bnOE=
Received: by 10.70.113.5 with SMTP id l5mr9364322wxc.1180404337965;
        Mon, 28 May 2007 19:05:37 -0700 (PDT)
Received: from pclouds@gmail.com ( [71.124.167.144])
        by mx.google.com with ESMTP id q34sm8129363wrq.2007.05.28.19.05.37;
        Mon, 28 May 2007 19:05:37 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2007 22:05:43 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48658>

Those are builtins. Remove them from PROGRAMS variable

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 29243c6..fb11fa1 100644
--- a/Makefile
+++ b/Makefile
@@ -235,7 +235,7 @@ endif
=20
 # ... and all the rest that could be moved out of bindir to gitexecdir
 PROGRAMS =3D \
-	git-convert-objects$X git-fetch-pack$X git-fsck$X \
+	git-convert-objects$X git-fetch-pack$X \
 	git-hash-object$X git-index-pack$X git-local-fetch$X \
 	git-fast-import$X \
 	git-merge-base$X \
@@ -246,7 +246,7 @@ PROGRAMS =3D \
 	git-show-index$X git-ssh-fetch$X \
 	git-ssh-upload$X git-unpack-file$X \
 	git-update-server-info$X \
-	git-upload-pack$X git-verify-pack$X \
+	git-upload-pack$X \
 	git-pack-redundant$X git-var$X \
 	git-merge-tree$X git-imap-send$X \
 	git-merge-recursive$X \
--=20
1.5.2
