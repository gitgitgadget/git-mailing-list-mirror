From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 24/24] git-status.txt: advertisement for untracked cache
Date: Tue, 20 Jan 2015 20:03:33 +0700
Message-ID: <1421759013-8494-25-git-send-email-pclouds@gmail.com>
References: <1421759013-8494-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 20 14:06:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDYVh-0004Di-9l
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 14:06:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755063AbbATNGR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2015 08:06:17 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:61562 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754326AbbATNGP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 08:06:15 -0500
Received: by mail-pa0-f53.google.com with SMTP id kx10so1270803pab.12
        for <git@vger.kernel.org>; Tue, 20 Jan 2015 05:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Bv2EYcmkPzsDAqekghVMwWx0P8hBOeZ8cIPbnYeazRQ=;
        b=DLbiwe7W2KoV8V2ZGvR6RAGi900IcLlkW66MkbbQblAaykr29sPF9bJ7sPfMwCs8hW
         SprObTpmMIJHEn9OzyiT/773iHzqd0BikzS6uhpIOmRt+9fpKOmGSsTskreP5DvUAwW/
         bEMiEqbxa3GOkQREdRKrXiwXxqYWVy3aCY52FXBqAEp5DRfB51mowQAwfE0tBsTEMvET
         TT4VG0ilJ4brztK6JcdvSDFNsbj5MmMFjjyhH18dJYp0HeRPrOxQmPftG5nbbQELe9lx
         GTyzQrSVACowUNbw7c98P4xV9EuEayMCnzR2kw49RimglBXoHj/5MsYNXbF+TpeeutbA
         56ew==
X-Received: by 10.66.117.199 with SMTP id kg7mr52985327pab.92.1421759175115;
        Tue, 20 Jan 2015 05:06:15 -0800 (PST)
Received: from lanh ([115.73.212.1])
        by mx.google.com with ESMTPSA id r1sm77843pdb.24.2015.01.20.05.06.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jan 2015 05:06:14 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 20 Jan 2015 20:06:25 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1421759013-8494-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262676>

When a good user sees the "too long, consider -uno" advice when
running `git status`, they should check out the man page to find out
more. This change suggests they try untracked cache before -uno.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-status.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.tx=
t
index def635f..7850f53 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -58,7 +58,10 @@ When `-u` option is not used, untracked files and di=
rectories are
 shown (i.e. the same as specifying `normal`), to help you avoid
 forgetting to add newly created files.  Because it takes extra work
 to find untracked files in the filesystem, this mode may take some
-time in a large working tree.  You can use `no` to have `git status`
+time in a large working tree.
+Consider to enable untracked cache and split index if supported (see
+`git update-index --untracked-cache` and `git update-index
+--split-index`), Otherwise you can use `no` to have `git status`
 return more quickly without showing untracked files.
 +
 The default can be changed using the status.showUntrackedFiles
--=20
2.2.0.84.ge9c7a8a
