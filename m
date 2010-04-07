From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2] Remove --allow-empty from the git-commit synopsis
Date: Wed,  7 Apr 2010 17:28:47 +0000
Message-ID: <1270661327-28078-1-git-send-email-avarab@gmail.com>
References: <w2zfabb9a1e1004070829ob9da47e6oacf2703129be9107@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 07 19:29:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzZ3v-0005Hv-2d
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 19:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754339Ab0DGR3E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Apr 2010 13:29:04 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:19117 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758217Ab0DGR3C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 13:29:02 -0400
Received: by fg-out-1718.google.com with SMTP id d23so558202fga.1
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 10:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=XCdPy12jxdfCTvzWPIymaiWCG6VHzsw/mPLOc/oe9tM=;
        b=RGCtZTM/oxKrRdjx49ZpwGiosD11sEdwr2sOdbipsBrp11pVxWFIkX6dEV50XkTbJ5
         Z/h7w8EQBp6dwRvm7dyIjgYKgurxvATSE3ptYAh2rylvPb8bTM/Ko65BiNToqvkrssQS
         3wMjYvsB4BXpDyRO5Eb0m4gP8iRZ9KGYMpewI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=DOhPWbsob/hHMSInqhDIBltUUJV4L4ms3S8Y1GoVRUDBC3tSRjCm+PGg4PUJz+ABSy
         M21P5YnUDzyxAgoi069+3OqjHbxwukN5NxJEOelfgKc9xPcjvcBa7XP8tD9BlbdiRdyh
         XmDZu4ctDbENkfV7TDPZOgEAs9bbnmR7iHcLg=
Received: by 10.87.17.34 with SMTP id u34mr2217323fgi.10.1270661341021;
        Wed, 07 Apr 2010 10:29:01 -0700 (PDT)
Received: from localhost.localdomain ([188.104.23.89])
        by mx.google.com with ESMTPS id d4sm19259365fga.25.2010.04.07.10.28.59
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 10:29:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4.298.gc81d
In-Reply-To: <w2zfabb9a1e1004070829ob9da47e6oacf2703129be9107@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144254>

The --allow-empty option is too rarley used to warrant being displayed
in the SYNOPSIS. It should only be mentioned in the main body of the
documentation like --porcelain.

The issue was raised in the thread discussing the new
--allow-empty-message option by Jeff King <peff@peff.net>:

    http://marc.info/?l=3Dgit&m=3D127039258902941
    http://marc.info/?l=3Dgit&m=3D127054334121604

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
I'd forgotten how the Git project likes rebasing :)

Here's a better patch that just cites the two relevant mailing list
posts instead of the commit sha1.

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
