From: Alexander Sulfrian <alexander@sulfrian.net>
Subject: Re: What's cooking in git.git (Sep 2010, #05; Wed, 15)
Date: Sat, 25 Sep 2010 14:30:08 +0200
Message-ID: <20100925143008.14dfbfa6@laptop.localhost>
References: <7viq266461.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/Ld_Y60PnmkADuBI4fOC0Hp_"; protocol="application/pgp-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 25 14:31:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzTu9-0002Ia-KW
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 14:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145Ab0IYMaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 08:30:18 -0400
Received: from animux.de ([78.46.93.45]:60549 "EHLO mail.sulfrian.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985Ab0IYMaR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 08:30:17 -0400
Received: from laptop.localhost (p5DD63BD0.dip.t-dialin.net [93.214.59.208])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.sulfrian.net (Postfix) with ESMTPSA id 7D4FF875A9F7
	for <git@vger.kernel.org>; Sat, 25 Sep 2010 14:31:12 +0200 (CEST)
In-Reply-To: <7viq266461.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157148>

--Sig_/Ld_Y60PnmkADuBI4fOC0Hp_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Sep 2010 15:19:18 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> * as/daemon-multi-listen (2010-08-29) 2 commits
>   (merged to 'next' on 2010-09-10 at 69e4b23)
>  + daemon: allow more than one host address given via --listen
>  + daemon: add helper function setup_named_sock()
>=20
> I think the idea is sound.  It probably needs a bit more polish.
>=20
> If you give two --listen options and got some but not all sockets, the
> code does not say anything even when no socket was created for one of
> them, which is questionable.

Hi,

that's not true. The last version (v4) logs for every listen an error
if no socket could be created. And dies if not a single socket is there
after processing all --listen options.


Alex

--Sig_/Ld_Y60PnmkADuBI4fOC0Hp_
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEARECAAYFAkyd61MACgkQ1SSUxvEq73zCPACcCbTgqqQaY0VWlIGj7py/Ke1r
0E8An0UGJdHTRe9sUV4ErYjPScrbvGo9
=O07G
-----END PGP SIGNATURE-----

--Sig_/Ld_Y60PnmkADuBI4fOC0Hp_--
