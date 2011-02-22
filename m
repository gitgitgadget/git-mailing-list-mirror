From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 60/73] gettextize: git-archive basic messages
Date: Tue, 22 Feb 2011 23:42:19 +0000
Message-ID: <1298418152-27789-61-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:45:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1vE-0000K1-8V
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:45:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755599Ab1BVXol convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:44:41 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:51284 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755228Ab1BVXod (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:33 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3867040bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=iqbxuuzRkHHMU3OeW/48yiVflh/ruRGUuVPLDy8snik=;
        b=ETzrn6ppPUTTyP0UeVB75D8opDyC2XzeRnua8+26d716ODrjS/kZrSqoNCsheQf3R9
         ZFmKgumeyp19iqAeBke9t0B8q0ZBJ6lEX6dPH7fOZycYyHg0GFlUK3btNK+ChCKd9ho/
         O5/NMOFhdhb34E19elRGwQlG3n9lUBn2Qt/9U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=hEwj4YkOd0aea8uZlxtKmzk+4dO6hSa8aJyV/yibiD2uucQ2lXXm7lE3HUW/X8ZtbJ
         vI3KFxT+tw3QNLvUB1l491umMx1QHkR/uhSnABlsSsScyL1ufzIFQfsytZSa9ikQAdCt
         Tv45n1sdnIliHdQ/P7P9FbAqlcVxuysCt5QQY=
Received: by 10.204.49.87 with SMTP id u23mr3063848bkf.50.1298418272332;
        Tue, 22 Feb 2011 15:44:32 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.30
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:31 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167610>

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
1.7.2.3
