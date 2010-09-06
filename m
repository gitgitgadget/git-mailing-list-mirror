From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 01/15] gettextize: git-archive basic messages
Date: Mon,  6 Sep 2010 12:21:30 +0000
Message-ID: <1283775704-29440-2-git-send-email-avarab@gmail.com>
References: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 14:22:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsaiH-0000Dp-Lb
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 14:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898Ab0IFMWH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 08:22:07 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:50377 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554Ab0IFMWF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 08:22:05 -0400
Received: by mail-ww0-f42.google.com with SMTP id 40so2310943wwj.1
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 05:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=sd/0XhTFj6W0xcHbVgglEjdK8doLD5ULTIL/UA6K1l4=;
        b=Kj13Y+rxXlvz4eDWNXnXeo+hefwslMme/uwZO6PVuqog2qqgFK4kZ/YSHMKsU7msLM
         c52BM4VH0f7a55qG8IaYOhLzS9o9Cu4+mMcN+ns+HHSyk9Cq4Ioif7AMTwQ2SQv+CnaA
         XtQoqzRpoupziVMKE/nqhyjmi//EEMJNGVj7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=U75JTiGzP52+lLr7ByWkRyrSYzqZMXzA2gWpdn7fzE4eyygOdwawr3I8dnwdEeB+jR
         6k312kgCl5JxovupZ16UiXf2WdeG6oLs5SXbeSY8lXn8eldVZVJMo7UOnzXPX8Nw9nqa
         6n4W1teNzLhS2MFP6V9Jic9LFWqiDx378eqk8=
Received: by 10.216.70.10 with SMTP id o10mr1200088wed.83.1283775724231;
        Mon, 06 Sep 2010 05:22:04 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id p82sm3297372weq.3.2010.09.06.05.22.02
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 05:22:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155552>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/archive.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index 6a887f5..b14eaba 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -14,10 +14,10 @@ static void create_output_file(const char *output_f=
ile)
 {
 	int output_fd =3D open(output_file, O_CREAT | O_WRONLY | O_TRUNC, 066=
6);
 	if (output_fd < 0)
-		die_errno("could not create archive file '%s'", output_file);
+		die_errno(_("could not create archive file '%s'"), output_file);
 	if (output_fd !=3D 1) {
 		if (dup2(output_fd, 1) < 0)
-			die_errno("could not redirect output");
+			die_errno(_("could not redirect output"));
 		else
 			close(output_fd);
 	}
@@ -33,7 +33,7 @@ static int run_remote_archiver(int argc, const char *=
*argv,
=20
 	_remote =3D remote_get(remote);
 	if (!_remote->url[0])
-		die("git archive: Remote with no URL");
+		die(_("git archive: Remote with no URL"));
 	transport =3D transport_get(_remote, _remote->url[0]);
 	transport_connect(transport, "git-upload-archive", exec, fd);
=20
@@ -43,18 +43,18 @@ static int run_remote_archiver(int argc, const char=
 **argv,
=20
 	len =3D packet_read_line(fd[0], buf, sizeof(buf));
 	if (!len)
-		die("git archive: expected ACK/NAK, got EOF");
+		die(_("git archive: expected ACK/NAK, got EOF"));
 	if (buf[len-1] =3D=3D '\n')
 		buf[--len] =3D 0;
 	if (strcmp(buf, "ACK")) {
 		if (len > 5 && !prefixcmp(buf, "NACK "))
-			die("git archive: NACK %s", buf + 5);
-		die("git archive: protocol error");
+			die(_("git archive: NACK %s"), buf + 5);
+		die(_("git archive: protocol error"));
 	}
=20
 	len =3D packet_read_line(fd[0], buf, sizeof(buf));
 	if (len)
-		die("git archive: expected a flush");
+		die(_("git archive: expected a flush"));
=20
 	/* Now, start reading from fd[0] and spit it out to stdout */
 	rv =3D recv_sideband("archive", fd[0], 1);
--=20
1.7.2.3.313.gcd15
