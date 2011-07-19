From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: Re: git-archive and tar options
Date: Tue, 19 Jul 2011 22:10:07 +0200
Message-ID: <1311106207.17539.12.camel@kheops>
References: <ivla29$liu$1@dough.gmane.org>
	 <20110714015656.GA20136@sigill.intra.peff.net>  <m239i8vjlk.fsf@igel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-EKb1VgtKGWIukU+UdIjt"
Cc: Jeff King <peff@peff.net>, Neal Kreitzinger <neal@rsss.com>,
	git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Jul 19 22:10:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjGcW-0003Hl-Jj
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 22:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092Ab1GSUKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 16:10:12 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64620 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001Ab1GSUKL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 16:10:11 -0400
Received: by wyg8 with SMTP id 8so3042273wyg.19
        for <git@vger.kernel.org>; Tue, 19 Jul 2011 13:10:10 -0700 (PDT)
Received: by 10.216.145.149 with SMTP id p21mr6610730wej.91.1311106209996;
        Tue, 19 Jul 2011 13:10:09 -0700 (PDT)
Received: from [192.168.0.7] ([85.69.155.32])
        by mx.google.com with ESMTPS id m46sm2801860weq.5.2011.07.19.13.10.08
        (version=SSLv3 cipher=OTHER);
        Tue, 19 Jul 2011 13:10:08 -0700 (PDT)
In-Reply-To: <m239i8vjlk.fsf@igel.home>
X-Mailer: Evolution 2.32.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177500>


--=-EKb1VgtKGWIukU+UdIjt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2011-07-14 at 19:48 +0200, Andreas Schwab wrote:
> Jeff King <peff@peff.net> writes:
>=20
> > So you're probably stuck with extracting the results of "git archive" t=
o
> > a temporary directory and then using GNU tar to re-archive them (or if
> > you have a checkout, you can just tar that up directly, feeding the lis=
t
> > from "git ls-files" into tar).
>=20
> That would lose the embedded commit-id, though.
>=20
> Andreas.
>=20

You can pass the commit id this way.

$ tar --pax-option "comment=3D$COMMIT" ...

--=20
Sylvain Rabot <sylvain@abstraction.fr>

--=-EKb1VgtKGWIukU+UdIjt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOJeSfAAoJECLlHVUnhaoW/hIIAJWy8DbbNBBbRPkTq47Klifj
2XqNBsAFxpV1BvknsQxednLb5bLRuSx9mBbbByvvBU8OP3KfXWFMkBwFUFWcEY9t
jOGxPqxmWfKdRqXYgx0fd3l9cyko0x+UTADQOMBEWUl17sfEGjwZc8juNh+IWLnc
byMz2g09EWb0yOMEBbSWXnNsOhFA3WXXRKm10skkRmzmRmM4aNquVc9BTFRwol3t
bw1jFlaiRNxwtg+JzvtL42x5Pkie+0tcznVPCBXatDPgj8XtGLfLB611lKFf0v/V
cTuMLSjlC9mHcezM1iN1MUp8TaW7Bi/RFPNoZnnX9/bXpIvIFQX7v1ujnpyciv0=
=I9ZE
-----END PGP SIGNATURE-----

--=-EKb1VgtKGWIukU+UdIjt--
