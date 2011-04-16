From: "ZHANG, Le" <r0bertz@gentoo.org>
Subject: Re: [PATCH v4 1/4] mailinfo.c: convert_to_utf8(): added a
 target_charset parameter
Date: Fri, 15 Apr 2011 23:22:58 -0700
Message-ID: <20110416062255.GC18591@adriano.hsd1.ca.comcast.net>
References: <1290971417-4474-1-git-send-email-r0bertz@gentoo.org>
 <1290971417-4474-2-git-send-email-r0bertz@gentoo.org>
 <7vsjyj3mmr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CblX+4bnyfN0pR09"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 08:23:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAyuZ-0003Z3-SF
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 08:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329Ab1DPGXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 02:23:11 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47521 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285Ab1DPGXK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 02:23:10 -0400
Received: by pzk9 with SMTP id 9so1283053pzk.19
        for <git@vger.kernel.org>; Fri, 15 Apr 2011 23:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=S1Ji1zh+RMyC7qlTwZ/XSx/yi4KEVZyAgTUW9IQAO6M=;
        b=UgAgc8SA4L4kKZi7tJqaVvN8tz4v6CwhYBVfJqmPoEBNzLTKE2gE4qVEyP+v4n+cEl
         SQ7QcMOedm6bc4Qw7sdWD8gEFo/wJL9/783sjbsck695jDHkVI5hGxvhnpM6oQ+BVsHr
         PjXJAjLzQFvffTLS8n4gWy6ChqJfX2CS/Mmvw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=JYiRWqTUSc9kShaRQGXZqFOx3sEL32655EwkK9SNZLUElanOV2khjFoD1eYN3v4B7u
         6vb/A4aS9RgGSOgLa+w1mPmnxepg0fJN1YZK4AbuihckWNmGiwqjGYsyNihhyLA1N1JF
         fX7Is1Xhsr0eiPae/LcCaCqUyDaY9fD4Nttww=
Received: by 10.68.39.105 with SMTP id o9mr3285411pbk.45.1302934989721;
        Fri, 15 Apr 2011 23:23:09 -0700 (PDT)
Received: from localhost (c-67-180-129-150.hsd1.ca.comcast.net [67.180.129.150])
        by mx.google.com with ESMTPS id x6sm904102pbs.1.2011.04.15.23.23.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Apr 2011 23:23:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vsjyj3mmr.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171662>


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12:23 Mon 29 Nov     , Junio C Hamano wrote:
> "ZHANG, Le" <r0bertz@gentoo.org> writes:
>=20
> > This is required for my recode-patch patch which needs a seperate patch=
_charset variable.
> >
> > Signed-off-by: ZHANG, Le <r0bertz@gentoo.org>
> > ---
>=20
> Thanks.
>=20
> Please describe what the new parameter means.  Is it used to convert the
> contents in "line" from "charset" to "target_charset"?  Perhaps it is a
> good time to rename the function to "convert_to()", its "charset"
> parameter to "from_charset", and name the new parameter "to_charset", in
> order to reduce confusion?
>=20
> It is not just _your_ patch but will help other/later patches, so you may
> want to phrase the proposed commit log message a bit differently (and with
> a narrower page width, like 68-74 chars per line).  Perhaps like...
>=20
>     mailinfo.c: Allow convert_to_utf8() to specify both src/dst charset
>=20
>     The convert_to_utf8() function actually converts to whatever charset
>     "metainfo_charset" variable contains, which is not necessarily UTF-8.
>     Rename it to convert_to(), and give an extra parameter "to_charset" to
>     specify what charset to re-encode to.  Also rename its "charset"
>     parameter to "from_charset" to clarify which is which.

Thank you for reviewing! And sorry for late response.

For this problem only, I'd like to propose a slightly better approach based=
 on
your suggestion.

Currently, in mailinfo.c, there are 3 calls to convert_to_utf8(). Two of ca=
lls
specifies from_charset, the third doesn't. For those two calls which already
specifies from_charset, there is no need to guess from_charset. So I make t=
wo
convert functions. One is guess_and_convert_to(), the other is convert_to().
The next version of repository_encoding patch[1] will use convert_to().

[1] http://thread.gmane.org/gmane.comp.version-control.git/162345/focus=3D1=
62424

Here is the patch:

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 71e6262..0f42ff1 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -472,6 +472,20 @@ static struct strbuf *decode_b_segment(const struct st=
rbuf *b_seg)
 	return out;
 }
=20
+static void convert_to(struct strbuf *line, const char *to_charset, const =
char *from_charset)
+{
+	char *out;
+
+	if (!strcasecmp(to_charset, from_charset))
+		return;
+
+	out =3D reencode_string(line->buf, to_charset, from_charset);
+	if (!out)
+		die("cannot convert from %s to %s",
+		    from_charset, to_charset);
+	strbuf_attach(line, out, strlen(out), strlen(out));
+}
+
 /*
  * When there is no known charset, guess.
  *
@@ -483,32 +497,14 @@ static struct strbuf *decode_b_segment(const struct s=
trbuf *b_seg)
  * Otherwise, we default to assuming it is Latin1 for historical
  * reasons.
  */
-static const char *guess_charset(const struct strbuf *line, const char *ta=
rget_charset)
+static void guess_and_convert_to(struct strbuf *line, const char *to_chars=
et)
 {
-	if (is_encoding_utf8(target_charset)) {
+	if (is_encoding_utf8(to_charset)) {
 		if (is_utf8(line->buf))
-			return NULL;
-	}
-	return "ISO8859-1";
-}
-
-static void convert_to_utf8(struct strbuf *line, const char *charset)
-{
-	char *out;
-
-	if (!charset || !*charset) {
-		charset =3D guess_charset(line, metainfo_charset);
-		if (!charset)
 			return;
 	}
=20
-	if (!strcasecmp(metainfo_charset, charset))
-		return;
-	out =3D reencode_string(line->buf, metainfo_charset, charset);
-	if (!out)
-		die("cannot convert from %s to %s",
-		    charset, metainfo_charset);
-	strbuf_attach(line, out, strlen(out), strlen(out));
+    convert_to(line, to_charset, "ISO8859-1");
 }
=20
 static int decode_header_bq(struct strbuf *it)
@@ -577,7 +573,7 @@ static int decode_header_bq(struct strbuf *it)
 			break;
 		}
 		if (metainfo_charset)
-			convert_to_utf8(dec, charset_q.buf);
+			convert_to(dec, metainfo_charset, charset_q.buf);
=20
 		strbuf_addbuf(&outbuf, dec);
 		strbuf_release(dec);
@@ -602,7 +598,7 @@ static void decode_header(struct strbuf *it)
 	 * This can be binary guck but there is no charset specified.
 	 */
 	if (metainfo_charset)
-		convert_to_utf8(it, "");
+		guess_and_convert_to(it, metainfo_charset);
 }
=20
 static void decode_transfer_encoding(struct strbuf *line)
@@ -796,7 +792,7 @@ static int handle_commit_msg(struct strbuf *line)
=20
 	/* normalize the log message to UTF-8. */
 	if (metainfo_charset)
-		convert_to_utf8(line, charset.buf);
+		convert_to(line, metainfo_charset, charset.buf);
=20
 	if (use_scissors && is_scissors_line(line)) {
 		int i;


--=20
ZHANG, Le
http://zhangle.co
0260 C902 B8F8 6506 6586 2B90 BC51 C808 1E4E 2973

--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iEYEARECAAYFAk2pNb8ACgkQvFHICB5OKXNhzgCeO4H95+QJSe2+q1/Wqk+IXQPM
HkcAoJOuyzhM83tkBIkxGLKCVA0d1nfR
=cyb6
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--
