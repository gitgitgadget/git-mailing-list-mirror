From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: [PATCH] diff,difftool: Don't use the {0,2} notation in usage strings
Date: Thu, 04 Nov 2010 18:18:17 +0100
Message-ID: <87hbfxgg86.fsf_-_@gmail.com>
References: <20101021222129.GA13262@burratino> <20101024155121.GA9503@headley>
	<AANLkTimpJbuZAPfvVOedstV7=UiLiDMnDaYWQLVNQ+Yc@mail.gmail.com>
	<87wrp12p00.fsf@gmail.com>
	<AANLkTinyPkGmsgbGM9qpXMNcZRzOXvtjDDEkJ-i3nWXz@mail.gmail.com>
	<87fwvl2d4d.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Mark Lodato <lodatom@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 18:19:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE3Td-0004zj-2I
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 18:19:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287Ab0KDRTs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Nov 2010 13:19:48 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63043 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967Ab0KDRTr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Nov 2010 13:19:47 -0400
Received: by bwz11 with SMTP id 11so1868265bwz.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 10:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject
         :in-reply-to:references:user-agent:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=j9lWoYl8yAKpOtY7onVJQ2t0k+t3TxdUK/toOyI9fGo=;
        b=Me/Xg0hUdBl29gWbvkdQshUXcnqM9Qp5tEapqib+ytLggKYueoVLNRt6BcEwKm5s2C
         e0sblbY/b+/FNAiobwgZ0YGqy4+Nx3O9+cUVfNJD3tMYJkGPwu4J2Kub+4tPgMPDi56B
         DK7T0SQk4GZOWX0yINrSQNNDjGSUWcwBDcwLc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        b=OGf8t2GOUCrfm3x1Ldn0u29k2wfDpnSkcOGXmjpNQhO5SWhrgnfgQLu6OYxuMiuyLl
         9+xPGhs1XhFpjgbwZM/deHttPUDVBfigk+pnO3qlPWAW2k6pSECe98Tr5MFv7I63/P5x
         ej3NZZ7sz9K79s+/4542uBYZq1CkpsOxO7sV0=
Received: by 10.204.61.16 with SMTP id r16mr908672bkh.4.1288891185665;
        Thu, 04 Nov 2010 10:19:45 -0700 (PDT)
Received: from localhost (176.119.broadband10.iol.cz [90.177.119.176])
        by mx.google.com with ESMTPS id p34sm166707bkf.3.2010.11.04.10.19.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Nov 2010 10:19:44 -0700 (PDT)
In-Reply-To: <87fwvl2d4d.fsf@gmail.com> (=?utf-8?B?IsWgdMSbcMOhbiBOxJtt?=
 =?utf-8?B?ZWMiJ3M=?= message of "Mon, 01
	Nov 2010 18:00:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160735>

This was the only occurence of that usage, and square brackets are
sufficient and already well-established for that purpose.

Signed-off-by: =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com>
---

As per discussion upthread, this notation is not worth keeping; hence
not mentioning it in the v2 of the CodingGuidlines patch and this
removal.

 Documentation/git-diff.txt     |    2 +-
 Documentation/git-difftool.txt |    2 +-
 builtin/diff.c                 |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index dd1fb32..61728f6 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -8,7 +8,7 @@ git-diff - Show changes between commits, commit and wor=
king tree, etc
=20
 SYNOPSIS
 --------
-'git diff' [<common diff options>] <commit>{0,2} [--] [<path>...]
+'git diff' [<common diff options>] [<commit> [<commit>]] [--] [<path>.=
=2E.]
=20
 DESCRIPTION
 -----------
diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftoo=
l.txt
index 8250bad..a02e3b5 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -7,7 +7,7 @@ git-difftool - Show changes using common diff tools
=20
 SYNOPSIS
 --------
-'git difftool' [<options>] <commit>{0,2} [--] [<path>...]
+'git difftool' [<options>] [<commit> [<commit>]] [--] [<path>...]
=20
 DESCRIPTION
 -----------
diff --git a/builtin/diff.c b/builtin/diff.c
index a43d326..945e758 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -22,7 +22,7 @@ struct blobinfo {
 };
=20
 static const char builtin_diff_usage[] =3D
-"git diff <options> <rev>{0,2} -- <path>*";
+"git diff [<options>] [<commit> [<commit>]] [--] [<path>...]";
=20
 static void stuff_change(struct diff_options *opt,
 			 unsigned old_mode, unsigned new_mode,
--=20
1.7.3.rc2.221.gbf93f.dirty
