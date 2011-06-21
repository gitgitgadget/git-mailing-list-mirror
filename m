From: Matteo Cypriani <mcy@lm7.fr>
Subject: Re: Preserve merge changes with rebase -p
Date: Tue, 21 Jun 2011 17:07:49 +0200
Message-ID: <201106211707.53486.mcy@lm7.fr>
References: <201106211411.31739.mcy@lm7.fr> <4E00AE60.5000801@sohovfx.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3404954.kcZ4PPFeDI";
  protocol="application/pgp-signature";
  micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 21 17:08:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ2Yc-0006LJ-5A
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 17:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753210Ab1FUPH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 11:07:56 -0400
Received: from adagio.lm7.fr ([91.121.68.23]:38632 "EHLO adagio.lm7.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750811Ab1FUPH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 11:07:56 -0400
Received: from silence.localnet (lifc08.pu-pm.univ-fcomte.fr [194.57.85.147])
	by adagio.lm7.fr (Postfix) with ESMTPSA id 291A330192
	for <git@vger.kernel.org>; Tue, 21 Jun 2011 17:07:55 +0200 (CEST)
User-Agent: KMail/1.13.7 (Linux/2.6.39-2-amd64; KDE/4.6.3; x86_64; ; )
In-Reply-To: <4E00AE60.5000801@sohovfx.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176161>

--nextPart3404954.kcZ4PPFeDI
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Le mardi 21 juin 2011 16:44:48, Andrew Wong a =C3=A9crit :
> Unfortunately, I don't think there's any nice way to do it right now. I
> think what you could do for now is make the "pick <M>" into a "edit
> <M>", together with other changes you want to make. And then when you
> get to "edit M", do a "git cherry-pick -n -m 1 <M>", or "-m 2" depending
> on how your merge was done. That should bring your changes over. Then
> you just need resolve and add any conflicts, and do a "rebase --continue".

Thank you, I'll try that the next time.


> I imagine this is pretty useful feature to have too. I could look into
> adding this support when I got a chance.

That would be great, many thanks in advance!

Cheers,

  Matteo

=2D-=20
Ma clef GPG est disponible sur keyserver.veridis.com
My GPG key is available on keyserver.veridis.com

--nextPart3404954.kcZ4PPFeDI
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCAAGBQJOALPFAAoJEE6QGOCjKRJrqpgQAJRr/oTxf6uUH3lML5a6NZkd
6qPCL7gtYwzZrHv6W30kzwqOtAVupyECTe/XcTRgjwtRaVWMnzuCkb7bC5Jx+zLA
LUyfVwQI+/gciG/PmIPC225f1dQTuQCIpDOKC/pEHgBJ430nTBUKVP1AA0TfzajH
4ylnH+1ImYecq8W4vrV0bhx7hzMBYxSF0qVcCm5SxljMD9Jv/S5frD7bikwxGCPM
/rEOKkgdddq72zJHGHpodpMRPSTdOnrw5Fj+F1JXYzeNEaGNew6o0Qwkco233tAv
5MT8YdsMy9/nXtkG1LeS7kpCvNGLPgc9jMYT+PM9tNLyxjn+QfD9DP5l6afrVgC/
yFdYmGnbhHip+1lUHhoGmnD+jpnrsWfTjGqSPMYSuaYCXEhgmAPXkQIG3k/Tp0/y
a4QrYhgKQLHG6MoLCyZWQNOwlWsFKs8rXaqVpN6HA75vcRSVkSmmMHvhLAsxphNf
HfO1K4ZJGMRbFs/UNqHAyl2rVO1KKHQ9utIZvnwnDbO53EllFc31Eu6PAH3UzvC4
wUTxVbnScI1FKVAmB6PmkZM2Q9nwqj622dqFl4kd8LiVl/QwGmhFlDGfFNuoM9FJ
uDXfSbKgo5q7KQrHJxyBUvXq3dv25eqTufoZy2g8I03X5t2pIVycC4e/HwnXXO1M
FkYE9qaMydr7Ue6j0GUC
=t1QG
-----END PGP SIGNATURE-----

--nextPart3404954.kcZ4PPFeDI--
