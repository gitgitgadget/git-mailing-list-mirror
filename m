From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/17] fixup! pack-objects: add --version to specify written pack version
Date: Sat, 21 Sep 2013 20:57:55 +0700
Message-ID: <1379771883-10278-10-git-send-email-pclouds@gmail.com>
References: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Sep 21 15:55:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNNey-00015L-0m
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 15:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471Ab3IUNzh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Sep 2013 09:55:37 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:61228 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455Ab3IUNze (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 09:55:34 -0400
Received: by mail-pb0-f53.google.com with SMTP id up15so1457486pbc.40
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 06:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=zfE+EM5nG2vQ5IN65A0GSte+912Y9kWQlTGX3kLcz6Y=;
        b=aClgDUuloyk7Hi0Cop+lf2/cnsQ8D781AvK+ceqWfDH3d8Km69byNFetfW+LA4uVI2
         r2Ipa+XRnpdYh/VPreFNz0Sgq4sJPhhWh8pZRU3thKIqXfzFN1pDjtUjBWpNc41lm7MT
         w1IvE5UeMfG4jlcgU0VD05q8bNrYvWQ/Y7V6Oe8I81dCdk6pzwvdIxU0ljUlGm9czIiy
         UMa/XDUuhcPJAr14E6k7EPpMzHrUMTfepPvx0LIv+WRGRgXxquFNGv7n6MOF+JYdAOiP
         dG8YX1/5Eo9pnp299pciTCvmArTTAnv6azrmBpM1nFViAMA6SO1oE3qtYRQoo0IFji29
         8J2Q==
X-Received: by 10.68.220.1 with SMTP id ps1mr13683096pbc.30.1379771734002;
        Sat, 21 Sep 2013 06:55:34 -0700 (PDT)
Received: from lanh ([115.73.252.65])
        by mx.google.com with ESMTPSA id ab4sm22131281pbc.43.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 06:55:33 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 21 Sep 2013 20:58:56 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235111>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-pack-objects.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pac=
k-objects.txt
index d94edcd..bb27fac 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -220,6 +220,10 @@ So does `git bundle` (see linkgit:git-bundle[1]) w=
hen it creates a bundle.
 	to force the version for the generated pack index, and to force
 	64-bit index entries on objects located above the given offset.
=20
+--version=3D<version>::
+	Force the version for the generated pack, Valid values are 2,
+	3 and 4. Default is 2.
+
 --keep-true-parents::
 	With this option, parents that are hidden by grafts are packed
 	nevertheless.
--=20
1.8.2.83.gc99314b
