From: Marcus Griep <neoeinstein@gmail.com>
Subject: Re: [PATCH] Git.pm: Use File::Temp->tempfile instead of ->new
Date: Sun, 07 Sep 2008 12:50:56 -0400
Message-ID: <48C40670.6090106@gmail.com>
References: <48BBB59F.9080204@statsbiblioteket.dk> <vpqvdxggpw6.fsf@bauges.imag.fr> <20080901100435.GC6555@toroid.org> <48BBC20E.20808@statsbiblioteket.dk> <20080901104222.GA10026@toroid.org> <48BBCBEA.8000301@statsbiblioteket.dk> <7vskscplsz.fsf@gitster.siamese.dyndns.org> <20080907092624.GA8470@toroid.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2CAB539DECABDCAEFCF5CFA4"
Cc: Junio C Hamano <gitster@pobox.com>,
	"Tom G. Christensen" <tgc@statsbiblioteket.dk>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Petr Baudis <pasky@suse.cz>
To: Abhijit Menon-Sen <ams@toroid.org>
X-From: git-owner@vger.kernel.org Sun Sep 07 18:52:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcNUt-00035T-95
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 18:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952AbYIGQvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 12:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753941AbYIGQvR
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 12:51:17 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:32858 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753906AbYIGQvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 12:51:16 -0400
Received: by yx-out-2324.google.com with SMTP id 8so609819yxm.1
        for <git@vger.kernel.org>; Sun, 07 Sep 2008 09:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type;
        bh=kLjPtJaqB/d5M/v+B3cyuqHmbhMwJ4o2Hup+VG1tgP8=;
        b=g+HsJInuoZ8yjj8ZR/3nQEI0Bei9ee4ZbPFCT7qYT/x+ouSfVTkGg9BOsTKT9Szc8Z
         skPHTB+iFVQmRBHazpwYtFk95/1CqaM5wmJtlkF4XeZXh+vl9DStOWm0Ca6q3QmFGFIw
         Ab5MgTTwYy2FJKCNF3YCYpK6JqNKNGiusFaYw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type;
        b=uik45N1xbjLoxWRqnvE5Vn4ZdRGM2tsdyEK8IETc/6wZbcSaBrauZcO0jfttUlTW/H
         xRY6R26CS7z4v5k1Z2gLOgp6crIgwH7Za/9kAitUyQKffBF190TKTlabfn5K7rF857IV
         2lV980VbNqaWyzmMGi2SUB7Is9YRlUEATLqn8=
Received: by 10.151.144.4 with SMTP id w4mr19837562ybn.234.1220806275224;
        Sun, 07 Sep 2008 09:51:15 -0700 (PDT)
Received: from ?192.168.1.152? ( [71.174.65.37])
        by mx.google.com with ESMTPS id m55sm3016792rnd.8.2008.09.07.09.51.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Sep 2008 09:51:14 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <20080907092624.GA8470@toroid.org>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95148>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2CAB539DECABDCAEFCF5CFA4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Abhijit Menon-Sen wrote:
> My patch is broken. I sent Tom an update, but he encountered an error
> with that too. I'm trying to figure out what's wrong, and will post a
> new patch to the list when I have it working.

As I was the one who brought File::Temp->new over from git-svn, I can
take a look at reducing the dependency to ->tempfile.  If you don't patch=

in first, I'll get one in as well.

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4


--------------enig2CAB539DECABDCAEFCF5CFA4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIVAwUBSMQGcQPFruyc22R/AQJyIA/+Myh1EIzT5axXtpZDIcwsYFDogJQeaXPC
dPRVnB6H9wtUjC5I+b2fFnJlitaxQCRxqXk++EqQ4iRpAC7I/P/VcfwY45Flu5rs
njntr+fUQmZvj+/f8snaazH9evhZ71AHH4pW66oorudc7TQYTJw4yMvz8eZ267on
OsVnn6nVpMsoKrXbbju94XCnWOb0Pr949hTGNErV0TBWJXJYVQy+pmMlR/ynrORP
42QpMI1V1+o/nHtg8SeFRsjbfHRoKIw5NxPlu/OxlWKyYxJzlisJP0w9Jj2mlqG4
l/rtX2IvUql6zo8yhy2Fv0k/6qf0nTC9atNZvcdLtVLvYmyf2eK13jFs7eQBV3Kq
sxjgWU0549LdUrKdyPgzweo6GEvU+zyl39pYBhuS4fTBXAidwiN+8K1k7j5gqx1I
QjyDpgmZ2GgvXNcrxCmbSbo3fQcPJJuWEpSYxF6xCVXmE0NNGvdOhfr++xTudWJR
aL5m7e8NIBNQqlLIjeE50ejBcUIKqnsdXGEF0dMswcb1eWvXDYpM+xC8RuHCIm/T
QNtB7C6v0uhAOQ/7d3cHsaRZMAzHHBXgAANNi6dt2uI9It/vO9Gu458eGTsYNGRv
zUbz+0p3PCMdKiKuxBf68rT0hXFB6o7a7U0XMu84P+KAlt+cI7Oz3XUO9Z0eMMQX
PtAKoGr0Pas=
=FdkB
-----END PGP SIGNATURE-----

--------------enig2CAB539DECABDCAEFCF5CFA4--
