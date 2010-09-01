From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 07/13] gettextize: git-branch "remote branch '%s' not found" message
Date: Wed,  1 Sep 2010 20:43:59 +0000
Message-ID: <1283373845-2022-8-git-send-email-avarab@gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 01 22:45:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OquBS-000790-Pa
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 22:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754731Ab0IAUok convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 16:44:40 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34335 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753964Ab0IAUoj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 16:44:39 -0400
Received: by mail-wy0-f174.google.com with SMTP id 35so9681721wyb.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 13:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=wPOLunTNx68xS+le7MAgwPeHEZonmClB97HNcVgjdtk=;
        b=QWOdCpqgYxRrqT9HVhp+hj1/kNRHGyADXwJ2k0QCl+5LrT/KRY+EfJmPPHxdUdJ8Mm
         Ec2AFS1vDUhY9coMO6uxbbF4s/S2IDOCglxJri4P03eYHDvqroUQ7KiQCN6QHuT3r1ka
         X7oMu/JFhXBJPobLjoa6/L1W9BrCeYEmYWofI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=m5cDEpud3wBwyqebi5DLq4oTQZYXrj1xNtiSY7Wh2LmwtPfWUdB5Jga1BwjTFSVb0N
         M0L8m+pCIDxwy1r7JcLX1UnDRDX/dECZ+nxlRYEu1JeiMA9oERyEQpCoTFvGFwVqapEI
         CNKUw+ZC0rWpi4ukqMLhclnCanymVmTG8Hy3E=
Received: by 10.216.86.16 with SMTP id v16mr8424017wee.11.1283373878550;
        Wed, 01 Sep 2010 13:44:38 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id v11sm6461150weq.16.2010.09.01.13.44.37
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Sep 2010 13:44:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.579.g2183d
In-Reply-To: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155089>

This could be done better by splitting it up, but it would change too
much code, which I'm trying to avoid at this point. Instead add a
TRANSLATORS comment to explain what "remote " does.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/branch.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 50c15c1..8802033 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -157,7 +157,8 @@ static int delete_branches(int argc, const char **a=
rgv, int force, int kinds)
 	switch (kinds) {
 	case REF_REMOTE_BRANCH:
 		fmt =3D "refs/remotes/%s";
-		remote =3D "remote ";
+		/* TRANSLATORS: This is "remote " in "remote branch '%s' not found" =
*/
+		remote =3D _("remote ");
 		force =3D 1;
 		break;
 	case REF_LOCAL_BRANCH:
--=20
1.7.2.2.579.g2183d
