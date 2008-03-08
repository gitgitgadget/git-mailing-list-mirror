From: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH] ident.c: Removes geekspeak comment when the user name cannot be determined
Date: Sat,  8 Mar 2008 12:30:04 +0100
Message-ID: <1204975804-8511-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 12:31:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXxHC-0004M0-Q4
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 12:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279AbYCHLaj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Mar 2008 06:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752511AbYCHLaj
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 06:30:39 -0500
Received: from fk-out-0910.google.com ([209.85.128.186]:46727 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752279AbYCHLai (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 06:30:38 -0500
Received: by fk-out-0910.google.com with SMTP id z23so736603fkz.5
        for <git@vger.kernel.org>; Sat, 08 Mar 2008 03:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=ybChG7vE5AqFzCgGBTK8ZkeWNFkARAmWzGr5mehuUSQ=;
        b=Np6cr74HLatsD4TnHz0cx6NAhZ55HgjOCpYfXUUY143vdUiO8sKXZJ8YzJMhh/bmAQrjX38f3V4teoAaEVb8A+uC5g+LiXKjZdzNQkF46sXA6DaGTz+SPWfDYacC/C3rH88OocevVUgNAFb/HbDTnLbPMRXh1aM7p504C7UM4tQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=FRpyFSgfJkYtp/AaOYbj2Lfdyn/3N9XZRKFz36sxLjejLs+ghpif/sP4BpH67lCd0vkgt1o+HnzmoHLkPBV5C3fx4R3ddES/uZhLGlOsBXfBBX8nJ7MR9VY2Z4ZDMxeC1gztrKgbNgiOyl0/hPSTztyxjanDlC+N6OBBV/jRy0A=
Received: by 10.78.179.12 with SMTP id b12mr6738600huf.61.1204975832340;
        Sat, 08 Mar 2008 03:30:32 -0800 (PST)
Received: from localhost ( [91.13.83.130])
        by mx.google.com with ESMTPS id j10sm7061714muh.16.2008.03.08.03.30.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 08 Mar 2008 03:30:31 -0800 (PST)
X-Mailer: git-send-email 1.5.4.3.589.g6816
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76557>

The "config --global" suggested in the message is a valid one-shot fix,
and hopefully one-shot across machines that NFS mounts the home directo=
ries.

This knowledge can hopefully be reused when you are forced to use git o=
n
Windows, but the fix based on GECOS would probably not.

[sb: commit message taken from a Junio's comment]

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 ident.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/ident.c b/ident.c
index b839dcf..4007c5a 100644
--- a/ident.c
+++ b/ident.c
@@ -171,7 +171,7 @@ static const char au_env[] =3D "GIT_AUTHOR_NAME";
 static const char co_env[] =3D "GIT_COMMITTER_NAME";
 static const char *env_hint =3D
 "\n"
-"*** Your name cannot be determined from your system services (gecos).=
\n"
+"*** Your name cannot be determined.\n"
 "\n"
 "Run\n"
 "\n"
--=20
1.5.4.3.589.g6816

