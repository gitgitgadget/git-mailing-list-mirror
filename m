From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 15/72] gettextize: git-branch "remote branch '%s' not found" message
Date: Sat, 19 Feb 2011 19:23:58 +0000
Message-ID: <1298143495-3681-16-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:27:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsSu-0002nl-1w
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:27:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755889Ab1BST1c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:27:32 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40522 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755873Ab1BST13 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:27:29 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so2347071eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=GHfuFBp2eRjFqWLoko6OGyLAS+ZgVtRLLWzrF52lQUA=;
        b=aTiVnxIfJw4GPJQsabnBaqmb0PZM5Ya9TsXMQm8xLEJozQOnnkdAlEw0+iNc8Q07t1
         iKQsPnIsYGUx8jlOtgBR/JQMI5ebNT7BEOvXk+Z/7muy7L0RgeLRrnK0EpwAnEvXkSbY
         myDSHTp0slVec4LOrRqOWIXagTBrkJfHF3dXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=PRo1HMF89dC2lDzzvXDklVTGjm8ei69l3SL+pQSUvfwZ2s67ZKfItObkSD6iCuyniy
         iXEbr896C+OyFIwEZ5je+vE9r0NH+1cC73A1+wBZ14TRbOjrxU8EG1RV4XnULNHplzy4
         CJGaeAcyK6tiv8268Dz7VKPJB9ZO0zXvSsmxQ=
Received: by 10.213.16.140 with SMTP id o12mr2361725eba.29.1298143648967;
        Sat, 19 Feb 2011 11:27:28 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.27.28
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:27:28 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167322>

This could be done better by splitting it up, but it would change too
much code, which I'm trying to avoid at this point. Instead add a
TRANSLATORS comment to explain what "remote " does.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/branch.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 6695db4..e9d8a5a 100644
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
1.7.2.3
