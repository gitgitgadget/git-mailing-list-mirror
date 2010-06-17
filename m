From: Zhang Le <r0bertz@gentoo.org>
Subject: Re: [PATCH v3 1/2] add --recode-patch option to git-mailinfo
Date: Thu, 17 Jun 2010 09:39:18 +0800
Message-ID: <20100617013915.GA20339@adriano>
References: <1276664983-5693-1-git-send-email-r0bertz@gentoo.org>
 <7vhbl2eq1g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 17 03:39:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OP44y-0000A1-QX
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 03:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758463Ab0FQBjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jun 2010 21:39:33 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37833 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756308Ab0FQBjc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jun 2010 21:39:32 -0400
Received: by pva4 with SMTP id 4so961399pva.19
        for <git@vger.kernel.org>; Wed, 16 Jun 2010 18:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=/RI+SM/F6MkZPHRSLmvNKhgpYkSCst5m1Chhcpb5dLY=;
        b=eCtKTG/p3l6LFiOw0doI8c7Z4uiDbzGFSquvuVlmtVdr607Gyyn1iPqkhyyU0nBXyS
         b2d9KY+U46RVtusWzZvY2YfjvCYXZ9T8czIuYuCW5+x6oMKRTSGRLf+pLMP/XHGo6gLj
         yzZTsfazEKaa8k8L/J1MXzcOpLTJUgw7taMCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TouPTKXIjYwekE1bMHUC+cGlspzZQJLLSW7ON0qjRaA8C/AMAuHI2xQaaPnt4EBaV/
         CW9g1N85bljVgkOrv6cv287fv07tFSZ3OHTf4Z26hf19qsJtM1Kv/Em/ec8SNxlZ9Skr
         0yWYJEAILz6dyKCQEJS4tOwwNO9ir2ifARQAY=
Received: by 10.142.249.2 with SMTP id w2mr6862441wfh.25.1276738765843;
        Wed, 16 Jun 2010 18:39:25 -0700 (PDT)
Received: from localhost ([119.122.48.97])
        by mx.google.com with ESMTPS id f11sm88692594wai.11.2010.06.16.18.39.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 16 Jun 2010 18:39:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vhbl2eq1g.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149282>


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12:27 Wed 16 Jun     , Junio C Hamano wrote:
> Zhang Le <r0bertz@gentoo.org> writes:
>=20
> > diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinf=
o.txt
> > index 3ea5aad..24d5bd7 100644
> > --- a/Documentation/git-mailinfo.txt
> > +++ b/Documentation/git-mailinfo.txt
> > @@ -45,7 +45,7 @@ OPTIONS
> >  	them.  This used to be optional but now it is the default.
> >  +
> >  Note that the patch is always used as-is without charset
> > -conversion, even with this flag.
> > +conversion, even with this flag.  Unless --recode-patch is used.
>=20
> Somehow this doesn't rhyme well.  Perhaps
>=20
>     Note that the patch is used as-with without charset conversion; use
>     `--recode-patch` for that.
>=20
> would be better?

OK

>=20
> > @@ -54,6 +54,10 @@ conversion, even with this flag.
> >  -n::
> >  	Disable all charset re-coding of the metadata.
> > =20
> > +--recode-patch::
> > +	Similar to -u.  But what is re-coded is the patch instead of the
> > +	metainfo.  The default is off.
>=20
> Ditto.
>=20
> 	Convert the patch from the e-mail to UTF-8 (or the value of the
> 	configuration variable `i18n.commitencoding`, if it is set).
>=20

OK

> By the way, what happens when somebody runs the following command?
>=20
> 	git mailinfo -n --recode-patch
>=20
> Is it desirable?  If not, what _should_ happen instead?

This is not desirable. If -n is used, no recoding will happen.
Maybe we should warn users.
Maybe we use a separate variable like patch_charset, instead of reusing
metainfo_charset?

>=20
> > diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
> > index 4a9729b..bb87b32 100644
> > --- a/builtin/mailinfo.c
> > +++ b/builtin/mailinfo.c
> > @@ -12,6 +12,7 @@ static FILE *cmitmsg, *patchfile, *fin, *fout;
> >  static int keep_subject;
> >  static int keep_non_patch_brackets_in_subject;
> >  static const char *metainfo_charset;
> > +static int recode_patch;
> >  static struct strbuf line =3D STRBUF_INIT;
> >  static struct strbuf name =3D STRBUF_INIT;
> >  static struct strbuf email =3D STRBUF_INIT;
> > @@ -828,8 +829,10 @@ static int handle_commit_msg(struct strbuf *line)
> >  	return 0;
> >  }
> > =20
> > -static void handle_patch(const struct strbuf *line)
> > +static void handle_patch(struct strbuf *line)
> >  {
> > +	if (recode_patch)
> > +		convert_to_utf8(line, charset.buf);
> >  	fwrite(line->buf, 1, line->len, patchfile);
> >  	patch_lines++;
> >  }
> > @@ -1021,7 +1024,7 @@ static int git_mailinfo_config(const char *var, c=
onst char *value, void *unused)
> >  }
> > =20
> >  static const char mailinfo_usage[] =3D
> > -	"git mailinfo [-k|-b] [-u | --encoding=3D<encoding> | -n] [--scissors=
 | --no-scissors] msg patch < mail >info";
> > +	"git mailinfo [-k|-b] [-u | --encoding=3D<encoding> | -n] [--recode-p=
atch] [--scissors | --no-scissors] msg patch < mail >info";
> > =20
> >  int cmd_mailinfo(int argc, const char **argv, const char *prefix)
> >  {
> > @@ -1034,6 +1037,7 @@ int cmd_mailinfo(int argc, const char **argv, con=
st char *prefix)
> > =20
> >  	def_charset =3D (git_commit_encoding ? git_commit_encoding : "UTF-8");
> >  	metainfo_charset =3D def_charset;
> > +	recode_patch =3D 0;
>=20
> Do you need this assignment?

Of course, It is not required. Since variable in bss secton will be initial=
ized
to 0. I just thought maybe it is better to initialized it explicitly, to ma=
ke
it clear. Of course, this is only personal taste.

I will remove it, if that will suit git's coding style well. :)

--=20
Zhang, Le
Gentoo/Loongson Developer
http://zhangle.is-a-geek.org
0260 C902 B8F8 6506 6586 2B90 BC51 C808 1E4E 2973

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iEYEARECAAYFAkwZfMMACgkQvFHICB5OKXOQJwCeK78BZxIWm4nC6sPnmQ9TuGFR
o5cAn1qMNLxroSt5cP4q7jXe1MpwQSrQ
=1lbF
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
