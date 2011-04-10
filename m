From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 3/7] i18n: mark merge "upstream" messages for translation
Date: Sun, 10 Apr 2011 19:34:04 +0000
Message-ID: <1302464048-21806-4-git-send-email-avarab@gmail.com>
References: <1302464048-21806-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 21:34:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q90P4-00036n-3o
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 21:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757666Ab1DJTe0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Apr 2011 15:34:26 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:44719 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755149Ab1DJTeX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 15:34:23 -0400
Received: by ewy4 with SMTP id 4so1532450ewy.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 12:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=aFMvMncwnYQXYMVMYG7osjs8gQBp4UNVlBZ8dE+AsxA=;
        b=mcsEWTnxjZmD3PfR45jN+hGIQkZOBXOhtOW3VgHdklpOxcmpyoZuHxk3FPS68Me6rU
         N2Mtr+gS17u2le1ROw2LPIW9iAGrE49m8dXO+LEfiXaNKtNUaTxQh472AnAjj2oUE8D+
         wuaotlpJjbVzVKTVhGpWTCoH0TzS5o/XY++3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=DACc3T8gn+QJDSMkgkCzTM3NI7GCRSI7xFJdFXi5XCpMP8oRFsP7vBglfI7chElGIH
         tvQfzrr113DfFbV5SULR00ryBLWMzuPUuvdagLU0LSuexMBIR82nlH5278ZajuP2Ga1k
         05vR1yz7dj2e6jcxW4XmKeZe27k5sowHEfjSY=
Received: by 10.213.110.198 with SMTP id o6mr1819802ebp.1.1302464061802;
        Sun, 10 Apr 2011 12:34:21 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id m55sm1147236eei.8.2011.04.10.12.34.20
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 12:34:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1302464048-21806-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171276>

Mark the merge messages that were added in v1.7.5-rc1~17^2 (merge:
merge with the default upstream branch without argument) by Junio C
Hamano for translation.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/merge.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 7eda05d..6e63c08 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -962,16 +962,16 @@ static int setup_with_upstream(const char ***argv=
)
 	const char **args;
=20
 	if (!branch)
-		die("No current branch.");
+		die(_("No current branch."));
 	if (!branch->remote)
-		die("No remote for the current branch.");
+		die(_("No remote for the current branch."));
 	if (!branch->merge_nr)
-		die("No default upstream defined for the current branch.");
+		die(_("No default upstream defined for the current branch."));
=20
 	args =3D xcalloc(branch->merge_nr + 1, sizeof(char *));
 	for (i =3D 0; i < branch->merge_nr; i++) {
 		if (!branch->merge[i]->dst)
-			die("No remote tracking branch for %s from %s",
+			die(_("No remote tracking branch for %s from %s"),
 			    branch->merge[i]->src, branch->remote_name);
 		args[i] =3D branch->merge[i]->dst;
 	}
--=20
1.7.4.1
