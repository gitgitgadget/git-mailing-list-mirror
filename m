From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: Re: [ANNOUNCE] qgit-2.0rc1
Date: Sun, 10 Jun 2007 16:45:26 +0300
Organization: TUBITAK/UEKAE
Message-ID: <200706101645.27090.ismail@pardus.org.tr>
References: <e5bfff550706100447g5d34adf2j92389cd193658738@mail.gmail.com> <e5bfff550706100626t2d5721a6r7beb0cfeb19dff4@mail.gmail.com> <e5bfff550706100640w3bbc01foa84263bb0a751376@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3830178.XZ71Mt7zaO";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Pavel Roskin" <proski@gnu.org>,
	"Andy Parkins" <andyparkins@gmail.com>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 15:45:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxNjr-0003EW-Tc
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 15:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755086AbXFJNpt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 09:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754855AbXFJNps
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 09:45:48 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:48441 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754821AbXFJNpp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 09:45:45 -0400
Received: from southpark.local (unknown [85.96.17.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 49DDA604C8E5;
	Sun, 10 Jun 2007 16:45:38 +0300 (EEST)
User-Agent: KMail/1.9.7
In-Reply-To: <e5bfff550706100640w3bbc01foa84263bb0a751376@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49732>

--nextPart3830178.XZ71Mt7zaO
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 10 June 2007 16:40:35 Marco Costalba wrote:
> On 6/10/07, Marco Costalba <mcostalba@gmail.com> wrote:
> > I will try an update to src/src.pro file to let Qt pass this library
> > to the linker.
>
> Please apply the following patch to your src/src.pro file and try to
> rebuild.
>
> Please, let me know if this fixes the build for you.
>
>
> --- a/src/src.pro
> +++ b/src/src.pro
> @@ -25,6 +25,9 @@ QMAKE_CXXFLAGS_RELEASE +=3D -g3 -O2
> -Wno-non-virtual-dtor -frepo -Wno-long-long -p
>  QMAKE_CXXFLAGS_DEBUG +=3D -g3 -O0 -Wno-non-virtual-dtor -Wno-long-long
> -pedantic -Wconversion
>  INSTALLS +=3D target
>
> +# Qt doesn't seem to link all needed libraries
> +unix:LIBS +=3D -L$$QMAKE_LIBDIR_QT -lQtUiTools
> +
>  # Directories
>  DESTDIR =3D ../bin
>  BUILD_DIR =3D ../build

Still no go. Though the final linker line have a -lQtUiTools

Regards,
ismail

=2D-=20
Perfect is the enemy of good

--nextPart3830178.XZ71Mt7zaO
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (GNU/Linux)

iQIVAwUARmwAdke9qviWcMsnAQKHIhAAn+K+CzrfGp3xrdOM3eUhpjSwjUgQb5zu
ORpcdo7BozjsorLKu3od9x2iWmsDLTcXoedYdlE8lBjI8aDhhWuxMh0Q5AVvFzux
i3EIlQzR16l1AH/LFVuSyinskfH/RTPZa6yTmUWW9TpKi7Yj2HPI9lZBbAGLTGq5
wj9CQ9y1eH/cjWD0L7soeJJXOLlZ4H8mOYxvZpESPn2gvz1/5w5HpYVhuHhD10IT
7d9B7rwrT8SChG00XqN5M/TtRkdMmVlmp+InHKyfeYCukMeRbAk/TeglWWKYXf3s
s8PE2uPk8KE0sV8UTvLBBfC58Ijg5UZ9gdDd2bk9RMDUZSVDsUmMbItFJ2vaFcC9
axvQfiVYulDeF8CGfz+g8psDD+XmGYg8bA1vsO4zl+zwBwSv9ZydNUnsBtsgoE9k
YPsk4H/TziyRF6JDv7sDwFz/nb7ihk5vrqGZ0RCO9WHifIlkXNIgTMFkfSxraONa
EcHQuVBnlH4TA40GzZQYY32TDJsjNzCaEuZUlPYlPnoY3rTk2iwmGP61AYV+Z35G
v5RBMckXCMUzfw8DloDghkUc+Zgo0yFF2+QT6ctXqG1IkxiYd3N+wM75IuYZjpm1
jlRlcZBQD/gqM/06oxANwNSouU7BZTLgpNvX7dm/PMJiiMulDiGPSjP7M5EfB8AF
2u428cfi15Y=
=lsxZ
-----END PGP SIGNATURE-----

--nextPart3830178.XZ71Mt7zaO--
