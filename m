From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v3] Remove --allow-empty from the git-commit synopsis
Date: Wed,  7 Apr 2010 18:48:52 +0000
Message-ID: <1270666132-29430-1-git-send-email-avarab@gmail.com>
References: <v2ybe6fef0d1004071121gcdd530dcvaaed78c0b989fc99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 07 20:49:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzaJR-0002HA-IJ
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 20:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754186Ab0DGStJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Apr 2010 14:49:09 -0400
Received: from mail-fx0-f223.google.com ([209.85.220.223]:35323 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753645Ab0DGStI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 14:49:08 -0400
Received: by fxm23 with SMTP id 23so1357073fxm.21
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 11:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=2IcVHT+JczF9xWtRNuAZIjYJ+L7M3VWJANwRj0FrHZs=;
        b=XbJO7+93LJSzgZt4CvNHo+OQjts35RHecUlA2EstN8i8s0KCdLGarawBiNXZ+ap0Rl
         gAuXR05jr8Ue87CvgdeS2kz1X8DYS7B/DWX+78uuPoGA7vEfXC9gWPtvI3BkaR467eWS
         p4Ay8U8MVIz/NAru3sqhFZQj9uYuHkNiRt+bI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=r6albKN31VJXSLjS273rMtJmkpA3NwaesPZvsury3jOvuntgprS8pPk/126aDpKS7v
         VXOSCeOGn4CJPlwQvf2Zy9bCP1Aq8KSQY6SE5+3zB/YxMmWmeu1S7Lh8tE8UUErvPF/y
         /lIYnemZrpvtodOHo0NDSV5/CHgFmWUNalkfw=
Received: by 10.87.50.37 with SMTP id c37mr14552591fgk.68.1270666145726;
        Wed, 07 Apr 2010 11:49:05 -0700 (PDT)
Received: from localhost.localdomain ([188.104.23.89])
        by mx.google.com with ESMTPS id d8sm15320529fga.16.2010.04.07.11.49.02
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 11:49:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4.298.gc81d
In-Reply-To: <v2ybe6fef0d1004071121gcdd530dcvaaed78c0b989fc99@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144267>

The --allow-empty option is too rarely used to warrant being displayed
in the SYNOPSIS. It should only be mentioned in the main body of the
documentation like --porcelain.

The issue was raised in the thread discussing the new
--allow-empty-message option by Jeff King <peff@peff.net>:

    http://marc.info/?l=3Dgit&m=3D127039258902941
    http://marc.info/?l=3Dgit&m=3D127054334121604

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
Thanks for catching that. Here's the commit without the tyop :)

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
