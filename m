From: Paul Menzel <pm.debian@googlemail.com>
Subject: status of libgit.a
Date: Sun, 07 Mar 2010 11:27:35 +0100
Message-ID: <1267957655.3759.29.camel@mattotaupa>
References: <499B3F65.8010109@synapse.com>
	 <20090218091617.7805.qmail@2684cdd72f0ee9.315fe32.mid.smarden.org>
	 <499C40EA.6050108@synapse.com>
	 <20090219092446.23272.qmail@3b5a9fa637f270.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-ER66iWJu/aNNN/Q0JE6w"
Cc: Marc Oscar Singer <elf@synapse.com>, 407722@bugs.debian.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 11:27:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoDi7-0003ZD-1g
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 11:27:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753706Ab0CGK1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 05:27:41 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:33340 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216Ab0CGK1j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 05:27:39 -0500
Received: by fxm19 with SMTP id 19so5472706fxm.21
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 02:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer;
        bh=woxhoyNLqYsGEsIyYrF4o+c2dZd/MTQfk/gAsCT8xAs=;
        b=FARD9AvVVOI0F8M42E2AhXeV32b/EEE5a8QcDczwIr/CLeKqLpqExnE171vXZ3z4QQ
         kl6s5nmfq44MWLHZ+fr/pNtJ7DcZCAE/igDElBui4+8csyrg6PHSfwArP9IYWk01UPac
         2SRohXaOabLGRCx8fY5cdEugS8Xvmuo2xS4Go=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer;
        b=e4JZhQWKnT0w8Xpb/mIxrjOBAjwGF/5CS2hYmsFY+x8s2Pxo9wMwIw2XdJYlsXv5TP
         nTdXkVyJd7tDVptbyRE7KVon5SEZFjxO0I1UhTC89vBUeHQZnjjuHO7lLbDgWm5FXKT2
         o+gLmra6GrLho1NVlA9yZJW9zsavZYOcaH6kU=
Received: by 10.223.15.133 with SMTP id k5mr3965363faa.39.1267957657879;
        Sun, 07 Mar 2010 02:27:37 -0800 (PST)
Received: from [192.168.178.21] (f053035214.adsl.alicedsl.de [78.53.35.214])
        by mx.google.com with ESMTPS id 14sm2298709fxm.9.2010.03.07.02.27.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 02:27:37 -0800 (PST)
In-Reply-To: <20090219092446.23272.qmail@3b5a9fa637f270.315fe32.mid.smarden.org>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141628>


--=-ER66iWJu/aNNN/Q0JE6w
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Git folks,


Am Donnerstag, den 19.02.2009, 09:24 +0000 schrieb Gerrit Pape:
> On Wed, Feb 18, 2009 at 09:10:02AM -0800, Marc Oscar Singer wrote:
> > Gerrit Pape wrote:

[=E2=80=A6]

> > >It depends on upstream.  Back then, Junio asked to not provide such a
> > >library package in Debian, and I respect that.  There've been some pla=
ns
> > >and effort to stabilize the lib in the past, but I'm not sure about th=
e
> > >status.
> > > =20
> > Would it be a compromise to provide libgit.a as a static library for=20
> > until it stabilizes?
>=20
> That's not the compromise, that's the option, I don't know any plans
> about a shared library.  The git-core-dev package that was available for
> short included such a static library.
>=20
> You really need to talk to upstream if you want this libgit.a.

could you please give an update on the status of libgit.a. For example
cgit still could not be packaged yet for Debian [1] because of this bug
[2].

cgit is used by a lot of projects out there, so I am wondering if the
current libgit.a can be released in its current state.

By the way, is there a web site/page for libgit.a?


Thanks and sorry if I got something wrong,

Paul


[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D515793
[2] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D407722

--=-ER66iWJu/aNNN/Q0JE6w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkuTf4oACgkQPX1aK2wOHVj/cgCfXhH1Cwvp0hf/KnPWhThBc9Mh
SawAmwYbDM9dCktPpNZ3IKVMw8VaqZWo
=ddAr
-----END PGP SIGNATURE-----

--=-ER66iWJu/aNNN/Q0JE6w--
