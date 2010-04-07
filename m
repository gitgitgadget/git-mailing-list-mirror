From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] Remove --allow-empty from the git-commit synopsis
Date: Wed,  7 Apr 2010 15:09:39 +0000
Message-ID: <1270652979-23572-1-git-send-email-avarab@gmail.com>
References: <h2h51dd1af81004060142p25194aaai58492f617419d0f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 07 17:10:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzWu6-00047q-V0
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 17:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932697Ab0DGPKs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Apr 2010 11:10:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:11905 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932581Ab0DGPKr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 11:10:47 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1555503fgg.1
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 08:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=LN1RbKb5rbahtuYy5srMkkDY9DBnMJfasGse+tZ9d2k=;
        b=ExE/GR780mJUvcf5NwUREnJ46TjeMoWc+gUNPbgTPTu3kPdnuGOOgaWCmVpLPYnmK2
         x03JhuEkSv0CWdliq9nBxanizRrUwvHkXKlDwvhyChp+BOU6+ir3JulFJs3mwNBxi5To
         FYXk+992EW3Xlq+why5DUfES9nO3k7vaBFdc0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Hp4qgYSPglpP0PS4LMNeCAv8XJfQDWMc04ULk25jZ568GyriVs2G9ma56mva788Jft
         FkzWHrdafYmt3opdLWhfBTiIDa+RgtSBQuJY7/QsTMpstAW+KtB4nkxEQAVPuL0i7UP1
         dMPnAeyyHW7YQHHrk4fNPBFBDJrb215fgPNR0=
Received: by 10.87.61.22 with SMTP id o22mr14185784fgk.50.1270653044891;
        Wed, 07 Apr 2010 08:10:44 -0700 (PDT)
Received: from localhost.localdomain ([188.104.23.89])
        by mx.google.com with ESMTPS id 12sm69487fgg.19.2010.04.07.08.10.43
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 08:10:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4.298.gc81d
In-Reply-To: <h2h51dd1af81004060142p25194aaai58492f617419d0f8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144235>

The --allow-empty option is too rarley used to warrant being displayed
in the SYNOPSIS. It should only be mentioned in the main body of the
documentation like --porcelain.

The issue was raised in the thread discussing the new
--allow-empty-message option (see 1aadbfad) by Jeff King
<peff@peff.net>:

    http://marc.info/?l=3Dgit&m=3D127054334121604

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Documentation/git-commit.txt |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.tx=
t
index 64fb458..ed2cd95 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -10,9 +10,8 @@ SYNOPSIS
 [verse]
 'git commit' [-a | --interactive] [-s] [-v] [-u<mode>] [--amend] [--dr=
y-run]
 	   [(-c | -C) <commit>] [-F <file> | -m <msg>] [--reset-author]
-	   [--allow-empty] [--no-verify] [-e] [--author=3D<author>]
-	   [--date=3D<date>] [--cleanup=3D<mode>] [--status | --no-status] [-=
-]
-	   [[-i | -o ]<file>...]
+	   [--no-verify] [-e] [--author=3D<author>] [--date=3D<date>]
+	   [--cleanup=3D<mode>] [--status | --no-status] [--] [[-i | -o ]<fil=
e>...]
=20
 DESCRIPTION
 -----------
--=20
1.7.0.4.298.gc81d
