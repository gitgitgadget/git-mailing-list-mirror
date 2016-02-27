From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/22] ref-filter.c: mark strings for translation
Date: Sat, 27 Feb 2016 13:42:04 +0700
Message-ID: <1456555333-5853-14-git-send-email-pclouds@gmail.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 07:43:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZYbA-0003Xa-Rh
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 07:43:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756082AbcB0GnZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2016 01:43:25 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33173 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408AbcB0GnY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 01:43:24 -0500
Received: by mail-pa0-f50.google.com with SMTP id fl4so62540936pad.0
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 22:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cM1sUxRVnoztuMt9gPTUnZuB2741ROAb7zqD16hYebo=;
        b=DXH85c8UNTPPqL3IocdtJ/sY7B2UaLqJ3lA2pVzkxt5flwV4sxFv2n84EoOpCOWNOI
         KbSxxtMHIOXI6TRaqx30UiVPjKguHiy41TTP6LgMD9u5TIn+Zs5t7Pa4XAsCEE+eIGvf
         jpFnzoWhPdh51dpX9zb8SYjzdWUY/oohTfyD8AbOAPimo+wiy6nb/8ia6jfhN5s4/AZY
         p+/vb61h5mnGDm+UMBFLuWlFI4GArvMt7492V5WpYpzPKkLOzgoy/A6e/bpoKkZLsOJ9
         f1R1wk9fQgQL+62hApJ/suI8RGa2hS5hlpjkkPXshqkMc63yKX/wePF4Og5nc4QPjAL1
         +UnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cM1sUxRVnoztuMt9gPTUnZuB2741ROAb7zqD16hYebo=;
        b=Ke3orS/FCeEDZaq1T0u+BnlKonJpfCsTIyRuKgnQlcbya6ytqXjkhIw9Bm43UvDkoY
         pxCtGJb3vFtUW28ZUT9mjQbIL+Y1gHD6rdIYwKpwnxrpcuKCtw+nvCsJlffK+ejb+hvI
         Je0OpLmEhDFCPTQbyx44Xnm1HZ9YNWGp1hij4xPiq3NmGqFu/bPYK/xznsaf8+h79Ps4
         5xuBQstgTzfnMBIAFssRnnsK8kndy7J78YluAmA3ut7Lzi3/IXh3chRuE6eOVbEdECEV
         40uQXDHHITIOgHeAJeTDcMU7z2pQ8glAXUoAJ6AkmKuxMPiuf7vaj5P4soldDZpb28+p
         WgyA==
X-Gm-Message-State: AD7BkJKNqTN2CG60tMY8TUtOWrjnXyCVl0v3afoF1xNwUNcZICunbIbk7Cnt9yY32AvcdA==
X-Received: by 10.66.124.170 with SMTP id mj10mr7571435pab.92.1456555403919;
        Fri, 26 Feb 2016 22:43:23 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id o66sm1609731pfi.14.2016.02.26.22.43.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Feb 2016 22:43:22 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 27 Feb 2016 13:43:56 +0700
X-Mailer: git-send-email 2.8.0.rc0.205.g7ec8cf1
In-Reply-To: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287674>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 ref-filter.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index bb79d6b..bc551a7 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -74,14 +74,14 @@ static void remote_ref_atom_parser(struct used_atom=
 *atom, const char *arg)
 static void body_atom_parser(struct used_atom *atom, const char *arg)
 {
 	if (arg)
-		die("%%(body) does not take arguments");
+		die(_("%%(body) does not take arguments"));
 	atom->u.contents.option =3D C_BODY_DEP;
 }
=20
 static void subject_atom_parser(struct used_atom *atom, const char *ar=
g)
 {
 	if (arg)
-		die("%%(subject) does not take arguments");
+		die(_("%%(subject) does not take arguments"));
 	atom->u.contents.option =3D C_SUB;
 }
=20
@@ -241,7 +241,7 @@ int parse_ref_filter_atom(const char *atom, const c=
har *ep)
 	if (*sp =3D=3D '*' && sp < ep)
 		sp++; /* deref */
 	if (ep <=3D sp)
-		die("malformed field name: %.*s", (int)(ep-atom), atom);
+		die(_("malformed field name: %.*s"), (int)(ep-atom), atom);
=20
 	/* Do we have the atom already used elsewhere? */
 	for (i =3D 0; i < used_atom_cnt; i++) {
@@ -267,7 +267,7 @@ int parse_ref_filter_atom(const char *atom, const c=
har *ep)
 	}
=20
 	if (ARRAY_SIZE(valid_atom) <=3D i)
-		die("unknown field name: %.*s", (int)(ep-atom), atom);
+		die(_("unknown field name: %.*s"), (int)(ep-atom), atom);
=20
 	/* Add it in, including the deref prefix */
 	at =3D used_atom_cnt;
@@ -421,7 +421,7 @@ int verify_ref_format(const char *format)
 		int at;
=20
 		if (!ep)
-			return error("malformed format string %s", sp);
+			return error(_("malformed format string %s"), sp);
 		/* sp points at "%(" and ep points at the closing ")" */
 		at =3D parse_ref_filter_atom(sp + 2, ep);
 		cp =3D ep + 1;
@@ -875,12 +875,12 @@ static const char *strip_ref_components(const cha=
r *refname, const char *nr_arg)
 	const char *start =3D refname;
=20
 	if (nr < 1 || *end !=3D '\0')
-		die(":strip=3D requires a positive integer argument");
+		die(_(":strip=3D requires a positive integer argument"));
=20
 	while (remaining) {
 		switch (*start++) {
 		case '\0':
-			die("ref '%s' does not have %ld components to :strip",
+			die(_("ref '%s' does not have %ld components to :strip"),
 			    refname, nr);
 		case '/':
 			remaining--;
@@ -1043,7 +1043,7 @@ static void populate_value(struct ref_array_item =
*ref)
 			else if (skip_prefix(formatp, "strip=3D", &arg))
 				refname =3D strip_ref_components(refname, arg);
 			else
-				die("unknown %.*s format %s",
+				die(_("unknown %.*s format %s"),
 				    (int)(formatp - name), name, formatp);
 		}
=20
@@ -1063,10 +1063,10 @@ static void populate_value(struct ref_array_ite=
m *ref)
  need_obj:
 	buf =3D get_obj(ref->objectname, &obj, &size, &eaten);
 	if (!buf)
-		die("missing object %s for %s",
+		die(_("missing object %s for %s"),
 		    sha1_to_hex(ref->objectname), ref->refname);
 	if (!obj)
-		die("parse_object_buffer failed on %s for %s",
+		die(_("parse_object_buffer failed on %s for %s"),
 		    sha1_to_hex(ref->objectname), ref->refname);
=20
 	grab_values(ref->value, 0, obj, buf, size);
@@ -1094,10 +1094,10 @@ static void populate_value(struct ref_array_ite=
m *ref)
 	 */
 	buf =3D get_obj(tagged, &obj, &size, &eaten);
 	if (!buf)
-		die("missing object %s for %s",
+		die(_("missing object %s for %s"),
 		    sha1_to_hex(tagged), ref->refname);
 	if (!obj)
-		die("parse_object_buffer failed on %s for %s",
+		die(_("parse_object_buffer failed on %s for %s"),
 		    sha1_to_hex(tagged), ref->refname);
 	grab_values(ref->value, 1, obj, buf, size);
 	if (!eaten)
@@ -1370,12 +1370,12 @@ static int ref_filter_handler(const char *refna=
me, const struct object_id *oid,
 	unsigned int kind;
=20
 	if (flag & REF_BAD_NAME) {
-		warning("ignoring ref with broken name %s", refname);
+		warning(_("ignoring ref with broken name %s"), refname);
 		return 0;
 	}
=20
 	if (flag & REF_ISBROKEN) {
-		warning("ignoring broken ref %s", refname);
+		warning(_("ignoring broken ref %s"), refname);
 		return 0;
 	}
=20
--=20
2.8.0.rc0.205.g7ec8cf1
