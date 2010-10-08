From: "=?UTF-8?q?=C5=A0t=C4=9Bp=C3=A1n=20N=C4=9Bmec?=" 
	<stepan.nemec@gmail.com>
Subject: [PATCH 5/6] Put a space between `<' and argument in pack-objects usage string
Date: Fri,  8 Oct 2010 19:31:19 +0200
Message-ID: <1286559080-27257-6-git-send-email-stepnem@gmail.com>
References: <87fwwhszsf.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jrnieder@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 08 19:35:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4Gqj-0000hg-8F
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 19:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475Ab0JHReL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Oct 2010 13:34:11 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56324 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932428Ab0JHReI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 13:34:08 -0400
Received: by fxm14 with SMTP id 14so629374fxm.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 10:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=JXgj9gBXJ82yhJ7chEdbK3bNFz6ErhliyP+AnaTSol8=;
        b=F9fWSPp9XUJ+nmEykI7XOk3998SPV6ttGkcebJmWE93FuGBwTmNCQ9kEzArNx++Vr3
         qbw+eM6ReC0JuBOg42YNprxlI3xlBpxa3QG3k+35kvV4t9SeexgpZ2OghagJa+/nXdFe
         76my+WsDP23alPzO1sFg9zdAClOR9pUANqMSk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ZPHNNzkjLu17yJTgoU5RgjcuUayaV4XUHQYWX+KcuptzHp+aNSGDAdPVqqALomthbE
         eGIISExwx0dZ5DKO7N/K77R9BRehoxMl05fYYAj34FcOgqUrQvJC55AC1EGSiODPDNUy
         Nl1DA6AN90sjtWUlAEWEJoqrxNldf0Xd4e6/k=
Received: by 10.223.120.66 with SMTP id c2mr3533027far.85.1286559247376;
        Fri, 08 Oct 2010 10:34:07 -0700 (PDT)
Received: from localhost (176.119.broadband10.iol.cz [90.177.119.176])
        by mx.google.com with ESMTPS id s20sm1746251faa.4.2010.10.08.10.34.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 10:34:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc2.221.gbf93f.dirty
In-Reply-To: <87fwwhszsf.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158510>

This makes it cosistent with other places (including the
git-pack-objects(1) manpage itself) and avoids possible confusion (I,
for one, mistook `<object-list' for a `<object-list>' typo at first whe=
n
preparing this series).

Signed-off-by: =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com>
---
 builtin/pack-objects.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 26f2304..f8eba53 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -31,7 +31,7 @@ static const char pack_usage[] =3D
   "        [--threads=3D<n>] [--non-empty] [--revs [--unpacked | --all=
]]\n"
   "        [--reflog] [--stdout | base-name] [--include-tag]\n"
   "        [--keep-unreachable | --unpack-unreachable]\n"
-  "        [<ref-list | <object-list]";
+  "        [< ref-list | < object-list]";
=20
 struct object_entry {
 	struct pack_idx_entry idx;
--=20
1.7.3.rc2.221.gbf93f.dirty
