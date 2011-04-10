From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 4/7] i18n: mark merge CHERRY_PICK_HEAD messages for translation
Date: Sun, 10 Apr 2011 19:34:05 +0000
Message-ID: <1302464048-21806-5-git-send-email-avarab@gmail.com>
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
	id 1Q90P4-00036n-Kj
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 21:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757742Ab1DJTe1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Apr 2011 15:34:27 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37883 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754874Ab1DJTeY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 15:34:24 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1532438ewy.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 12:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=TxW5uUPprK8NiQrlk8q8kI6pHYkEzHlHqxa2j+2Vc9I=;
        b=SQYcrJArbcTeKzopiy0BaUPhAZe780DEOUn8iIiWbZQY5djTNGys3yZ/zIsSUklm3A
         sV/pyoKILctxbaX/KMSV2qYPolYkWlMJT3nO9wvRrxpOi2/cbDEgA93GtnuuDIJjKk8X
         Scoti2Hd/bPYtaSCqYZxg/tc8U/7OV//nhLD4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=rjHzfa514AdHIvkT+pArXelh+JYvuf50Ej3E/UPOt83fjw5cMl0eg6TBsUZscWpPJB
         D1oxWDYMFCOPk3y9USt8XgTo5lN1z1KHhbjcntsv6VhO0suJ8LFz+H9+irZJD9bk61jj
         F7EppVLuYQdnVf3XnwDSHUM2uF4FatadwNdVY=
Received: by 10.213.32.137 with SMTP id c9mr1931687ebd.114.1302464063685;
        Sun, 10 Apr 2011 12:34:23 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id m55sm1147236eei.8.2011.04.10.12.34.21
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 12:34:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1302464048-21806-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171277>

Mark CHERRY_PICK_HEAD related messages in builtin/merge.c that were
added in v1.7.5-rc0~88^2~2 (Introduce CHERRY_PICK_HEAD) by Jay Soffian
for translation.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/merge.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 6e63c08..08245b6 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1043,10 +1043,10 @@ int cmd_merge(int argc, const char **argv, cons=
t char *prefix)
 	}
 	if (file_exists(git_path("CHERRY_PICK_HEAD"))) {
 		if (advice_resolve_conflict)
-			die("You have not concluded your cherry-pick (CHERRY_PICK_HEAD exis=
ts).\n"
-			    "Please, commit your changes before you can merge.");
+			die(_("You have not concluded your cherry-pick (CHERRY_PICK_HEAD ex=
ists).\n"
+			    "Please, commit your changes before you can merge."));
 		else
-			die("You have not concluded your cherry-pick (CHERRY_PICK_HEAD exis=
ts).");
+			die(_("You have not concluded your cherry-pick (CHERRY_PICK_HEAD ex=
ists)."));
 	}
 	resolve_undo_clear();
=20
--=20
1.7.4.1
