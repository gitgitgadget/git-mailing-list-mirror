From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] correct a few doubled-word nits in comments and
 documentation
Date: Wed, 28 Mar 2012 12:41:33 -0500
Message-ID: <20120328174133.GA8732@burratino>
References: <87d37xun9r.fsf@rho.meyering.net>
 <7vty18wweh.fsf@alter.siamese.dyndns.org>
 <878viku26e.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 19:41:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCwsW-000426-NX
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 19:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208Ab2C1Rlo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Mar 2012 13:41:44 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:57872 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753377Ab2C1Rln convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Mar 2012 13:41:43 -0400
Received: by yenl12 with SMTP id l12so916758yen.19
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 10:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ArSL+lP6AkqoBdN18NXxX9qyor9o+Cdy31ki/RdYlOc=;
        b=aauXrdRdtYfdAsDQuihPj21DD10jvm/ANLgW37qI5WU1cuYKynRNUonqfJzH9iZmA+
         RuNDNw8Hr3Bk7d1i4q1rnh8NsJgZI1neWIHY2BQVqiuRbCAkRmoXGHobJGySEC6rwmge
         s0l9/yfdvm9/DvZXpaLy54Ts96MJjKYcSjWSD6am2AcikgX4SIwukUeLdMBCYR/nuT9j
         GqeGgFxXegFSCawQ2WRotoR59AD4AxDFyDrMl9KZRc7CaY9GInJexyt4cQkIJ0BLJkP3
         N90AJ3YxdhY51FnsOX/AyzcPCvh1WG6YZSjOelfvBPl2mwiK59rOZZYIdcHFNmc+0BFI
         R8mA==
Received: by 10.50.40.233 with SMTP id a9mr40784igl.24.1332956502391;
        Wed, 28 Mar 2012 10:41:42 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id en3sm3611128igc.2.2012.03.28.10.41.39
        (version=SSLv3 cipher=OTHER);
        Wed, 28 Mar 2012 10:41:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <878viku26e.fsf@rho.meyering.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194147>

(+cc: =C3=86var for a side note marked with (*) below)
Hi,

Jim Meyering wrote:

> Found by running this command:
> $ git ls-files -z|xargs -0 perl -0777 -n \
>  -e 'while (/\b(then?|[iao]n|i[fst]|but|f?or|at|and|[dt]o)\s+\1\b/gim=
s)' \
>  -e '  {' \
>  -e '    $n =3D ($` =3D~ tr/\n/\n/ + 1);' \
>  -e '    ($v =3D $&) =3D~ s/\n/\\n/g;' \
>  -e '    print "$ARGV:$n:$v\n";' \
>  -e '  }'

Yeah, this often happens when a person returns to writing after being
interrupted in the middle of a train of thought.

[...]
> +++ b/Documentation/git-sh-i18n--envsubst.txt
> @@ -25,7 +25,7 @@ plumbing scripts and/or are writing new ones.
[...]
>  used internally by linkgit:git-sh-i18n[1] to interpolate the variabl=
es
> -passed to the the `eval_gettext` function.
> +passed to the `eval_gettext` function.

Good catch.

[...]
> +++ b/attr.h
> @@ -40,7 +40,7 @@ int git_check_attr(const char *path, int, struct gi=
t_attr_check *);
>=20
>  /*
>   * Retrieve all attributes that apply to the specified path.  *num
> - * will be set the the number of attributes on the path; **check wil=
l
> + * will be set the number of attributes on the path; **check will

Shouldn't this say "to the"?

[...]
> +++ b/gitweb/static/js/lib/cookies.js
> @@ -30,7 +30,7 @@
>   *                            If set to null or omitted, the cookie =
will be a session cookie
> - *                            and will not be retained when the the =
browser exits.
> + *                            and will not be retained when the brow=
ser exits.

Looks good.

[...]
> +++ b/po/README
> @@ -178,7 +178,7 @@ used:
>=20
>  C:
>=20
> - - Include builtin.h at the top, it'll pull in in gettext.h, which
> + - Include builtin.h at the top, it'll pull in gettext.h, which
>     defines the gettext interface. Consult with the list if you need =
to
>     use gettext.h directly.

Not related to this patch, but the sentence is a comma splice.  I'm
also not convinced that #include-ing builtin.h is actually a good idea
when you are not defining or using functions declared in that header. (=
*)

But that's all orthogonal to your patch, so looks good.

Patch for squashing in follows.

Thanks,
Jonathan

diff --git i/attr.h w/attr.h
index dea590a7..8b08d33a 100644
--- i/attr.h
+++ w/attr.h
@@ -40,7 +40,7 @@ int git_check_attr(const char *path, int, struct git_=
attr_check *);
=20
 /*
  * Retrieve all attributes that apply to the specified path.  *num
- * will be set the number of attributes on the path; **check will
+ * will be set to the number of attributes on the path; **check will
  * be set to point at a newly-allocated array of git_attr_check
  * objects describing the attributes and their values.  *check must be
  * free()ed by the caller.
