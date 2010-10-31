From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [RFC/PATCH 2/5] gettextize: git-clone: !fixup "basic messages"
Date: Sun, 31 Oct 2010 11:34:17 +0000
Message-ID: <1288524860-538-3-git-send-email-avarab@gmail.com>
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
	id 1PCWBd-0002ko-G9
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 12:34:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755406Ab0JaLei convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Oct 2010 07:34:38 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46450 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755349Ab0JaLed (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 07:34:33 -0400
Received: by wwe15 with SMTP id 15so5080025wwe.1
        for <git@vger.kernel.org>; Sun, 31 Oct 2010 04:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=sig64UzwOnDk/evR5KfwiumvMZLgGiQ/jDLmCwSDFGo=;
        b=k7SLPcCQY9v7HEnOLXk+PPefBJMS/3NwuZJ3mPT0L0L4S6iYbCUee2jtiK5LyRJZEs
         ZbyrPIAM4uR7+M7NLhNDFZ+cQ0oPvk3G0KUcmGMXR55sTStHs2YB4cxfVCBFnKyTS6kw
         a2kxM+/oBQ3YabnvMBH/AxJVK4UNxWATL2Yew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=A9rRrACSj4P2mgQmAV4mznFv79Z6UK/7ZNfrX0fKC+y5oabrIJs4U0F/J7R92R7qY2
         9fgswy+ruE3nSiocCM/M/aP80B4rkMbhZ34/6HfwsNGCDQSP6U4cazrTp8FbcNfqRN6A
         Ddfyn347inLRQRKxR/tuxdFkyHHEUSA1tsOJA=
Received: by 10.216.10.77 with SMTP id 55mr8649952weu.17.1288524871799;
        Sun, 31 Oct 2010 04:34:31 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id x12sm3009770weq.18.2010.10.31.04.34.31
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 31 Oct 2010 04:34:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.2.312.ge13a7
In-Reply-To: <AANLkTikOgMGqw5fc95c2VGwXxKu9rmsA+=z5_jykD92=@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160437>

Gettextize the "--depth is ignored in local clones" message added in
v1.7.3-rc0~8^2 by Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/clone.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index de23ba3..2c5d492 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -415,7 +415,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 		repo =3D repo_name;
 	is_local =3D path && !is_bundle;
 	if (is_local && option_depth)
-		warning("--depth is ignored in local clones; use file:// instead.");
+		warning(_("--depth is ignored in local clones; use file:// instead."=
));
=20
 	if (argc =3D=3D 2)
 		dir =3D xstrdup(argv[1]);
--=20
1.7.3.2.312.ge13a7
