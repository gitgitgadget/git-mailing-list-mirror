From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 5/5] git-commit: remove lego in i18n messages
Date: Mon, 30 Apr 2012 15:33:14 +0000
Message-ID: <1335799995-7667-6-git-send-email-avarab@gmail.com>
References: <1335799995-7667-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 30 17:33:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOsbg-0001J5-5A
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 17:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755043Ab2D3Pdh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 11:33:37 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39599 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753940Ab2D3Pdg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 11:33:36 -0400
Received: by mail-bk0-f46.google.com with SMTP id ji2so383655bkc.19
        for <git@vger.kernel.org>; Mon, 30 Apr 2012 08:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3o1FjT82L0Ew5wYprVQEwckN8C2iRa09inuhUifW+Cc=;
        b=H6GPz7j119ykm/FuIMjRky8UF8cFIOkBlZIPlaz5gB8g/eeiKEfCim93JohQIOTle9
         gs6yvKVr9J8cmnnHmqbr7q5mNh3Elg0V2lmuvq0pX4taqRh0aazc6QGUQJMaxF471XKx
         Rs+UhAOotmJmZQrmkc7UzSgpM1ApiADb4Tu7BYsO0rcW7BeNy9Qtnf3dgDfwAMarww/g
         SY1blDJF7ajkNAyQVWoBHcx0gTlV1BzcZTp8WNGvJvUAGlhu92i2ebjeSb2WXBz/7siI
         sGAjiaS8HM5O58qdt5Jyc33K0fp2l93nNYUHgmmDcD5ZdJwDIdWINH7O0ZonQ7XQ+kko
         q8NQ==
Received: by 10.204.132.77 with SMTP id a13mr3333249bkt.76.1335800015625;
        Mon, 30 Apr 2012 08:33:35 -0700 (PDT)
Received: from w.nix.is (w.nix.is. [188.40.98.140])
        by mx.google.com with ESMTPS id jr13sm27636569bkb.14.2012.04.30.08.33.34
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Apr 2012 08:33:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.546.gbaa1a.dirty
In-Reply-To: <1335799995-7667-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196569>

Change the "Please enter the commit message for your changes." and the
subsequent blurb of text not to be split up. This makes translating it
much easier.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/commit.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index c7c491e..438f257 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -798,17 +798,15 @@ static int prepare_to_commit(const char *index_fi=
le, const char *prefix,
 					 : "CHERRY_PICK_HEAD"));
=20
 		fprintf(s->fp, "\n");
-		status_printf(s, GIT_COLOR_NORMAL,
-			_("Please enter the commit message for your changes."));
 		if (cleanup_mode =3D=3D CLEANUP_ALL)
-			status_printf_more(s, GIT_COLOR_NORMAL,
-				_(" Lines starting\n"
-				"with '#' will be ignored, and an empty"
+			status_printf(s, GIT_COLOR_NORMAL,
+				_("Please enter the commit message for your changes."
+				" Lines starting\nwith '#' will be ignored, and an empty"
 				" message aborts the commit.\n"));
 		else /* CLEANUP_SPACE, that is. */
-			status_printf_more(s, GIT_COLOR_NORMAL,
-				_(" Lines starting\n"
-				"with '#' will be kept; you may remove them"
+			status_printf(s, GIT_COLOR_NORMAL,
+				_("Please enter the commit message for your changes."
+				" Lines starting\nwith '#' will be kept; you may remove them"
 				" yourself if you want to.\n"
 				"An empty message aborts the commit.\n"));
 		if (only_include_assumed)
--=20
1.7.10.546.gbaa1a.dirty
