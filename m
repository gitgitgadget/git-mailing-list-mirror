From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 13/72] gettextize: git-add refresh_index message
Date: Sat, 19 Feb 2011 19:23:56 +0000
Message-ID: <1298143495-3681-14-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:27:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsSs-0002nl-TH
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:27:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755868Ab1BST11 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:27:27 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56673 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755823Ab1BST1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:27:25 -0500
Received: by ewy5 with SMTP id 5so1970368ewy.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=V7fWgiWI+oIjuWrto49keZsh3/Q3qIqOa6kkVmVY430=;
        b=m6zexYD6fES7goIIWtzliDqDYTwCJU5YiTukVI/CO3dnnpRCyR4qpdZftJqc12IxF5
         d7repa9JyOsSZUfaz28k6LNXYUyMblIZTRST1tyQLHbaywZD7GlKObyzpmYR9bds9JhZ
         hVMN0BUKyM9EwpbjxbWdusmF8ODSt1xRh8Hp4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=u/hVfmtBfr1eVveGb7hkYYo1gZCZZE78QS0/jls1xprXJaQas7VahT6MOKlnbgA/mC
         P8jiC6fBrA0oXICuWJ1pN9OADomOB7AbQDgwwp8/SVsOraLCjADbAU+DqtFOBQiSFKoZ
         VorupFORcsAaq0i25Ez45noaGsWvd6lK27u4o=
Received: by 10.14.119.16 with SMTP id m16mr2510230eeh.8.1298143643972;
        Sat, 19 Feb 2011 11:27:23 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.27.23
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:27:23 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167321>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/add.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index e399d19..3e75460 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -188,7 +188,7 @@ static void refresh(int verbose, const char **paths=
pec)
 		/* nothing */;
 	seen =3D xcalloc(specs, 1);
 	refresh_index(&the_index, verbose ? REFRESH_IN_PORCELAIN : REFRESH_QU=
IET,
-		      pathspec, seen, "Unstaged changes after refreshing the index:"=
);
+		      pathspec, seen, _("Unstaged changes after refreshing the index=
:"));
 	for (i =3D 0; i < specs; i++) {
 		if (!seen[i])
 			die(_("pathspec '%s' did not match any files"), pathspec[i]);
--=20
1.7.2.3
