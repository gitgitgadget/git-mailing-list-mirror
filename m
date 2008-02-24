From: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH 1/3] urls.txt: Add bundles to the list of local urls.
Date: Sun, 24 Feb 2008 14:42:01 +0100
Message-ID: <1203860521-12333-1-git-send-email-sbejar@gmail.com>
References: <1203860474-12291-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 24 14:42:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTH7y-0004ju-Po
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 14:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927AbYBXNmP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Feb 2008 08:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752883AbYBXNmP
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 08:42:15 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:13718 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830AbYBXNmO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 08:42:14 -0500
Received: by fg-out-1718.google.com with SMTP id e21so928218fga.17
        for <git@vger.kernel.org>; Sun, 24 Feb 2008 05:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        bh=Qj7wQnuzp+W/jYfrU1yuDd2woi4OOVoeiHZWz+Xx7Yk=;
        b=td4ffO5LhwFA0FOOYm6b4A5f1xuwhRzVTcHYIQnEfJM/1c/XLWXkR8RmMnvNzOLgIOQWdmZsl5/5WkN8WHKFmwHGtRs2damVkWcs3npufdFG4ztBFLjK1fgAmMR2wXxf45CmoW/uBEwgnbkiOLqWyb16oX0IGZW0e8RaHDc6TBY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        b=sjiDCymuY4MtYxrMirhmEbxoeGW5jCk2miuZ1ohSnewM2P5MvJMXeXQ6c+g0ggPWRw7i9Yx+C12Bc2+vJfuTjpAmrHC6CMzm6BQCGKaavZCdadsm+FPYONKmFZO8ZjMMpNptDJXF02Ow6SZJyHrv0Lc5KHXjEW2e2QVGhy31Q/o=
Received: by 10.86.30.9 with SMTP id d9mr1636663fgd.77.1203860533634;
        Sun, 24 Feb 2008 05:42:13 -0800 (PST)
Received: from localhost ( [91.13.69.136])
        by mx.google.com with ESMTPS id e20sm4750883fga.1.2008.02.24.05.42.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Feb 2008 05:42:12 -0800 (PST)
X-Mailer: git-send-email 1.5.4.3.293.gac81
In-Reply-To: <1203860474-12291-1-git-send-email-sbejar@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74930>


Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 Documentation/urls.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 81ac17f..894bb46 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -34,13 +34,14 @@ To sync with a local directory, you can use:
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 - /path/to/repo.git/
 - file:///path/to/repo.git/
+- /path/to/bundle
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 ifndef::git-clone[]
-They are mostly equivalent, except when cloning.  See
+The first two are mostly equivalent, except when cloning.  See
 linkgit:git-clone[1] for details.
 endif::git-clone[]
=20
 ifdef::git-clone[]
-They are equivalent, except the former implies --local option.
+The first two are equivalent, except the former implies --local option=
=2E
 endif::git-clone[]
--=20
1.5.4.3.293.gac81
