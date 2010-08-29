From: AlexanderS <alexander@sulfrian.net>
Subject: Re: [PATCHv2 2/2] daemon: allow more than one host address given
 via --listen
Date: Sun, 29 Aug 2010 17:17:07 +0200
Message-ID: <20100829171707.2bb43a97@laptop.localhost>
References: <7v4oel14tl.fsf@alter.siamese.dyndns.org>
 <1283094462-5184-3-git-send-email-alexander@sulfrian.net>
 <AANLkTi==kDW7FbTZ7P6nF+k8_jGTJsFvwkcRijR=jex4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/4eDT0gPRFzec_Pp3OrxnlU="; protocol="application/pgp-signature"
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 29 17:17:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpjdO-0003mg-4e
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 17:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753529Ab0H2PRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 11:17:21 -0400
Received: from animux.de ([78.46.93.45]:33348 "EHLO mail.sulfrian.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752087Ab0H2PRV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 11:17:21 -0400
Received: from laptop.localhost (p5DD62732.dip.t-dialin.net [93.214.39.50])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.sulfrian.net (Postfix) with ESMTPSA id 0A85380DFFAF;
	Sun, 29 Aug 2010 17:17:31 +0200 (CEST)
In-Reply-To: <AANLkTi==kDW7FbTZ7P6nF+k8_jGTJsFvwkcRijR=jex4@mail.gmail.com>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154693>

--Sig_/4eDT0gPRFzec_Pp3OrxnlU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 29 Aug 2010 17:11:54 +0200
Erik Faye-Lund <kusmabite@gmail.com> wrote:

<snip>
> > @@ -1174,5 +1185,7 @@ int main(int argc, char **argv)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pid_file)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0store_pid(pid_fi=
le);
> >
> > - =C2=A0 =C2=A0 =C2=A0 return serve(listen_addr, listen_port, pass, gid=
);
> > + =C2=A0 =C2=A0 =C2=A0 return_value =3D serve(&listen_addr, listen_port=
, pass, gid);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 return return_value;
> > =C2=A0}
>=20
> Uhm, why? I can't find any other uses for "return_value"...

See v3, I missed string_list_clear this time...

--Sig_/4eDT0gPRFzec_Pp3OrxnlU=
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEARECAAYFAkx6efcACgkQ1SSUxvEq73w+iQCfQlAxkLlPex168q6JFpcVDmtW
ADUAoI6Yhi4+ZJZvTrQDDibK3A6cVgBW
=rxvM
-----END PGP SIGNATURE-----

--Sig_/4eDT0gPRFzec_Pp3OrxnlU=--
