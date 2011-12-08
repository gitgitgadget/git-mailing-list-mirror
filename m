From: pclouds@gmail.com
Subject: [PATCH 1/2] index_pack: indent find_unresolved_detals one level
Date: Thu,  8 Dec 2011 20:40:37 +0700
Message-ID: <4ee0be67.05c1e70a.1956.ffff800b@mx.google.com>
References: <CAJo=hJvrk3Jzg3dQhQnfbmKAFovLuEtJAP4rakHPFeuZ0T5R7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 08 14:41:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYeDf-00072p-8k
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 14:41:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068Ab1LHNk5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Dec 2011 08:40:57 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59419 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877Ab1LHNk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 08:40:57 -0500
Received: by iakc1 with SMTP id c1so2605408iak.19
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 05:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=84vr+pp3bdjvOG/mUBHJM4JEpLdgWFWPCbPcFqSrTPk=;
        b=NecB09uyN1lJkk4eXrxj9LtCA6Ir5cVZHmUKNONLWvJ0qwl/WabeEytcTmW5odICZQ
         1oOmVMj1Lrdiwz31Kjex8ZNcPRMGCInU+k2stgHiTtqno+Lf+FGXoVkr6UTBHb9CQ0jR
         0t5PfjGxQ9aLYtxTaD6cWM1kRN7tYn1e+Ohj0=
Received: by 10.42.176.8 with SMTP id bc8mr3541317icb.12.1323351656655;
        Thu, 08 Dec 2011 05:40:56 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.54.147])
        by mx.google.com with ESMTPS id ds5sm19865955ibb.5.2011.12.08.05.40.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Dec 2011 05:40:55 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 08 Dec 2011 20:40:40 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <CAJo=hJvrk3Jzg3dQhQnfbmKAFovLuEtJAP4rakHPFeuZ0T5R7g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186563>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

The next patch puts most of the code in one level deeper. By indenting
separately, it'd be easier to see the actual changes.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c |   47 +++++++++++++++++++++++-------------------=
-----
 1 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 103e19c..9855ada 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -585,37 +585,36 @@ static void find_unresolved_deltas(struct base_da=
ta *base,
 		base_spec.offset =3D base->obj->idx.offset;
 		find_delta_children(&base_spec,
 				    &ofs_first, &ofs_last, OBJ_OFS_DELTA);
-	}
=20
-	if (ref_last =3D=3D -1 && ofs_last =3D=3D -1) {
-		free(base->data);
-		return;
-	}
+		if (ref_last =3D=3D -1 && ofs_last =3D=3D -1) {
+			free(base->data);
+			return;
+		}
=20
-	link_base_data(prev_base, base);
+		link_base_data(prev_base, base);
=20
-	for (i =3D ref_first; i <=3D ref_last; i++) {
-		struct object_entry *child =3D objects + deltas[i].obj_no;
-		struct base_data result;
+		for (i =3D ref_first; i <=3D ref_last; i++) {
+			struct object_entry *child =3D objects + deltas[i].obj_no;
+			struct base_data result;
=20
-		assert(child->real_type =3D=3D OBJ_REF_DELTA);
-		resolve_delta(child, base, &result);
-		if (i =3D=3D ref_last && ofs_last =3D=3D -1)
-			free_base_data(base);
-		find_unresolved_deltas(&result, base);
-	}
+			assert(child->real_type =3D=3D OBJ_REF_DELTA);
+			resolve_delta(child, base, &result);
+			if (i =3D=3D ref_last && ofs_last =3D=3D -1)
+				free_base_data(base);
+			find_unresolved_deltas(&result, base);
+		}
=20
-	for (i =3D ofs_first; i <=3D ofs_last; i++) {
-		struct object_entry *child =3D objects + deltas[i].obj_no;
-		struct base_data result;
+		for (i =3D ofs_first; i <=3D ofs_last; i++) {
+			struct object_entry *child =3D objects + deltas[i].obj_no;
+			struct base_data result;
=20
-		assert(child->real_type =3D=3D OBJ_OFS_DELTA);
-		resolve_delta(child, base, &result);
-		if (i =3D=3D ofs_last)
-			free_base_data(base);
-		find_unresolved_deltas(&result, base);
+			assert(child->real_type =3D=3D OBJ_OFS_DELTA);
+			resolve_delta(child, base, &result);
+			if (i =3D=3D ofs_last)
+				free_base_data(base);
+			find_unresolved_deltas(&result, base);
+		}
 	}
-
 	unlink_base_data(base);
 }
=20
--=20
1.7.8.36.g69ee2
