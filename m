From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [RFC/PATCH 3/5] gettextize: git-init: !fixup "basic messages"
Date: Sun, 31 Oct 2010 11:34:18 +0000
Message-ID: <1288524860-538-4-git-send-email-avarab@gmail.com>
References: <AANLkTikOgMGqw5fc95c2VGwXxKu9rmsA+=z5_jykD92=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 31 12:35:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCWBc-0002ko-Ub
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 12:34:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755395Ab0JaLeg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Oct 2010 07:34:36 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49431 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755389Ab0JaLee (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 07:34:34 -0400
Received: by mail-ww0-f44.google.com with SMTP id 15so5080015wwe.1
        for <git@vger.kernel.org>; Sun, 31 Oct 2010 04:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=zRNsIq7EmYJONrWuXgTRAYZZg1MlKtOCgI9NdoSaMjk=;
        b=JQ6KJ6ojT1dgHhVxyBZuD2pZ47QeNCew+JVt8x7hI5vzCqhPL3NrsD5C5o1T5XsjJn
         MSfJtDj+7npR3X0Rh9MzI95AglkAKj1t0ow9llEFElRY29rlwI6vOR76t7kYhOEt+432
         Z6GfzoieQSbYssRCTqRvvwWyyFTf5fq9BMdfU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=uWtR7megcLB95B3qHnY9W9L9dbdFXrJPJe0LcvT4JS/S1m4NcOyvTwDsU94+MlAFqQ
         k00/cSKZlXDj6enid1z/XRo1oeSVdhkxOPzqW2QQPbfrYu7Mh2dpSFLfTWOLulWKMfrI
         79crayILMI7MT3ld02bk4MN8GtP0H7pAAxSao=
Received: by 10.216.28.204 with SMTP id g54mr1427657wea.73.1288524873457;
        Sun, 31 Oct 2010 04:34:33 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id x12sm3009770weq.18.2010.10.31.04.34.32
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 31 Oct 2010 04:34:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.2.312.ge13a7
In-Reply-To: <AANLkTikOgMGqw5fc95c2VGwXxKu9rmsA+=z5_jykD92=@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160439>

Gettextize the "oops" die message in builtin/init-db.c

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/init-db.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 28e20f9..2d6132a 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -346,7 +346,7 @@ int init_db(const char *template_dir, unsigned int =
flags)
 		else if (shared_repository =3D=3D PERM_EVERYBODY)
 			sprintf(buf, "%d", OLD_PERM_EVERYBODY);
 		else
-			die("oops");
+			die(_("oops"));
 		git_config_set("core.sharedrepository", buf);
 		git_config_set("receive.denyNonFastforwards", "true");
 	}
--=20
1.7.3.2.312.ge13a7
