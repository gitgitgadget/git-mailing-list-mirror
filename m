From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] strbuf: style fix -- top opening bracket on a separate line
Date: Sat,  1 Mar 2014 09:50:55 +0700
Message-ID: <1393642255-2551-1-git-send-email-pclouds@gmail.com>
References: <xmqqppmi97s3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 03:50:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJa0c-0000Ms-A0
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 03:50:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781AbaCACue convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Feb 2014 21:50:34 -0500
Received: from mail-pb0-f45.google.com ([209.85.160.45]:35432 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040AbaCACud (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 21:50:33 -0500
Received: by mail-pb0-f45.google.com with SMTP id uo5so827187pbc.4
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 18:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=gGFFcVLMBuanUfuu9doFVbpliOvmCds+VL6HhcC8dmo=;
        b=lfh1tZm9xlZ+6k0rXmjWo/0sou9iQJDf5lC6JVlu1ZP7tv/0HOvE6lLQttu5+kUuRN
         6bvbKrIQa/Jj6xQFlNQ5NzXg6osjm96v2geo5ArKUTEQQ81MP9d7vxqeVnwOCPPhBtdl
         JNlDynFsPI6/Dmi6vEBAIyoHgG60q+g7B5geXX9zVEHW7MzKZXzI54ut8J9626Q4ApSV
         B0aTJfrEmKTUtvn+lgC8IMlNCv1hxTrfnRj6GB2tpSS0N3tI3wIJ2JFXlnaZx2v6DmXx
         Ux5HyTPp7oczZ16AE2Kf6xKIGCpEZfAzXHmlPkf9dXHJFP3l+zQvO4E0Uzdeo7CV+YOD
         455g==
X-Received: by 10.67.5.131 with SMTP id cm3mr7312919pad.92.1393642233157;
        Fri, 28 Feb 2014 18:50:33 -0800 (PST)
Received: from lanh ([115.73.192.203])
        by mx.google.com with ESMTPSA id xs1sm26648182pac.7.2014.02.28.18.50.28
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 28 Feb 2014 18:50:32 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 01 Mar 2014 09:50:56 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <xmqqppmi97s3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243038>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Thu, Feb 20, 2014 at 3:17 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
 >> --- a/strbuf.h
 >> +++ b/strbuf.h
 >> @@ -116,6 +116,10 @@ extern void strbuf_add(struct strbuf *, const =
void *, size_t);
 >> =C2=A0static inline void strbuf_addstr(struct strbuf *sb, const cha=
r *s) {
 >> =C2=A0 =C2=A0 =C2=A0 strbuf_add(sb, s, strlen(s));
 >> =C2=A0}
 >> +static inline void strbuf_addstr_at(struct strbuf *sb, size_t len,=
 const char *s) {
 >
 > Please have the opening "{" on its own line.
 >
 > Surrounding existing functions are all offenders, but that is not an
 > excuse to make it worse (cleaning them up will need to be done in a
 > separate patch).

 Let's fix the surrounding code then.

 strbuf.h | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/strbuf.h b/strbuf.h
index 73e80ce..39c14cf 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -17,20 +17,23 @@ extern void strbuf_init(struct strbuf *, size_t);
 extern void strbuf_release(struct strbuf *);
 extern char *strbuf_detach(struct strbuf *, size_t *);
 extern void strbuf_attach(struct strbuf *, void *, size_t, size_t);
-static inline void strbuf_swap(struct strbuf *a, struct strbuf *b) {
+static inline void strbuf_swap(struct strbuf *a, struct strbuf *b)
+{
 	struct strbuf tmp =3D *a;
 	*a =3D *b;
 	*b =3D tmp;
 }
=20
 /*----- strbuf size related -----*/
-static inline size_t strbuf_avail(const struct strbuf *sb) {
+static inline size_t strbuf_avail(const struct strbuf *sb)
+{
 	return sb->alloc ? sb->alloc - sb->len - 1 : 0;
 }
=20
 extern void strbuf_grow(struct strbuf *, size_t);
=20
-static inline void strbuf_setlen(struct strbuf *sb, size_t len) {
+static inline void strbuf_setlen(struct strbuf *sb, size_t len)
+{
 	if (len > (sb->alloc ? sb->alloc - 1 : 0))
 		die("BUG: strbuf_setlen() beyond buffer");
 	sb->len =3D len;
@@ -97,7 +100,8 @@ static inline struct strbuf **strbuf_split(const str=
uct strbuf *sb,
 extern void strbuf_list_free(struct strbuf **);
=20
 /*----- add data in your buffer -----*/
-static inline void strbuf_addch(struct strbuf *sb, int c) {
+static inline void strbuf_addch(struct strbuf *sb, int c)
+{
 	strbuf_grow(sb, 1);
 	sb->buf[sb->len++] =3D c;
 	sb->buf[sb->len] =3D '\0';
@@ -113,10 +117,12 @@ extern void strbuf_splice(struct strbuf *, size_t=
 pos, size_t len,
 extern void strbuf_add_commented_lines(struct strbuf *out, const char =
*buf, size_t size);
=20
 extern void strbuf_add(struct strbuf *, const void *, size_t);
-static inline void strbuf_addstr(struct strbuf *sb, const char *s) {
+static inline void strbuf_addstr(struct strbuf *sb, const char *s)
+{
 	strbuf_add(sb, s, strlen(s));
 }
-static inline void strbuf_addbuf(struct strbuf *sb, const struct strbu=
f *sb2) {
+static inline void strbuf_addbuf(struct strbuf *sb, const struct strbu=
f *sb2)
+{
 	strbuf_grow(sb, sb2->len);
 	strbuf_add(sb, sb2->buf, sb2->len);
 }
--=20
1.9.0.40.gaa8c3ea
