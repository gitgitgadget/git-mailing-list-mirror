From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] doc: move rev-list option -<n> from git-log.txt to rev-list-options.txt
Date: Thu,  6 Sep 2012 21:28:03 +0700
Message-ID: <1346941683-24832-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 16:34:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9dAS-0004z8-HB
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 16:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756238Ab2IFOep convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Sep 2012 10:34:45 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50203 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756193Ab2IFOeo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 10:34:44 -0400
Received: by pbbrr13 with SMTP id rr13so2587895pbb.19
        for <git@vger.kernel.org>; Thu, 06 Sep 2012 07:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=mZwLjaQ8w0q/E5Xd5+whEsztu6Qm6Bzi0QvE3Kg4kbM=;
        b=V6a6eOkJgVxqWMP3xK4/IONFS3zuf/i7y5JGR5GL+DrOkFhyaREqVbeuT5H8QF5nas
         5NxaKS9YrB+SybYEt2uscvVutc5PeKxFJkBAYZ3Cxx+7YNEV0Zebz3yYR9ajmih/nYwB
         Alk8A3wyMPfDqhi53JSGTobMarWszHkHCQdWM8wn81oKWAI9gg7R7lHCihlTWx0mBhBp
         W/aM2XKYvJJCe1D2rF2c5fKHBrsrdpUGmu0FQgFts90CSQ4I7T7QjmZC8DP6kOl8n/LM
         V5DIgcrLCUWGGm659c8WaLNx85zCCOq2MbDRjp2Ji68nwOQW2g4FirsEnwtaTadkSGg2
         vmjQ==
Received: by 10.68.138.163 with SMTP id qr3mr4743963pbb.161.1346942084113;
        Thu, 06 Sep 2012 07:34:44 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.40.250])
        by mx.google.com with ESMTPS id qp6sm1429523pbc.55.2012.09.06.07.34.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Sep 2012 07:34:43 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 06 Sep 2012 21:28:04 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204891>

rev-list-options.txt is included in git-rev-list.txt. This makes sure
rev-list man page also shows that, and at one place, together with
equivalent options -n and --max-count.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-log.txt          | 6 ++----
 Documentation/rev-list-options.txt | 3 ++-
 2 t=E1=BA=ADp tin =C4=91=C3=A3 b=E1=BB=8B thay =C4=91=E1=BB=95i, 4 =C4=
=91=C6=B0=E1=BB=A3c th=C3=AAm v=C3=A0o(+), 5 b=E1=BB=8B x=C3=B3a(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 1f90620..585dac4 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -24,10 +24,6 @@ each commit introduces are shown.
 OPTIONS
 -------
=20
--<n>::
-	Limits the number of commits to show.
-	Note that this is a commit limiting option, see below.
-
 <since>..<until>::
 	Show only commits between the named two commits.  When
 	either <since> or <until> is omitted, it defaults to
@@ -137,6 +133,8 @@ Examples
 	This makes sense only when following a strict policy of merging all
 	topic branches when staying on a single integration branch.
=20
+`git log -3`::
+	Limits the number of commits to show to 3.
=20
 Discussion
 ----------
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-lis=
t-options.txt
index def1340..1b15ea9 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -8,7 +8,8 @@ ordering and formatting options, such as '--reverse'.
=20
 --
=20
--n 'number'::
+-<number>::
+-n <number>::
 --max-count=3D<number>::
=20
 	Limit the number of commits to output.
--=20
1.7.12.rc2.18.g61b472e
