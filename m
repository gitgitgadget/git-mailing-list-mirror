From: Michael Adam <obnox@samba.org>
Subject: Re: [PATCH v2] contrib/hooks/post-receive-email: send individual mails to recipients
Date: Wed, 12 Nov 2008 18:42:06 +0100
Organization: SerNet GmbH, Goettingen, Germany
Message-ID: <E1L0JjD-00ByqG-1I@intern.SerNet.DE>
References: <E1L0Iv1-00BwsF-Jh@intern.SerNet.DE> <491B0D9B.7080306@viscovery.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y4IIEhPJP4QURB7c"
Cc: Michael Adam <obnox@samba.org>, git@vger.kernel.org,
	Andy Parkins <andyparkins@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Nov 12 18:43:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0Jkg-0003Oj-0R
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 18:43:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335AbYKLRmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 12:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752334AbYKLRmQ
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 12:42:16 -0500
Received: from mail.SerNet.de ([193.175.80.2]:34890 "EHLO mail.SerNet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752311AbYKLRmP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 12:42:15 -0500
Received: from intern.SerNet.DE by mail.SerNet.DE
	with esmtp (Exim 4.63 #1)
	id 1L0JjD-0002gz-DR; Wed, 12 Nov 2008 18:42:07 +0100
Received: by intern.SerNet.DE
	id 1L0JjD-00ByqG-1I; Wed, 12 Nov 2008 18:42:07 +0100
Received: from intern.SerNet.DE (localhost [127.0.0.1])
	by localhost (AvMailGate-2.1.4-7) id 2855480-3gpfFC;
	Wed, 12 Nov 2008 18:42:07 +0100 (CET)
Received: by intern.SerNet.DE
	id 1L0JjC-00Byq5-Qh; Wed, 12 Nov 2008 18:42:06 +0100
Content-Disposition: inline
In-Reply-To: <491B0D9B.7080306@viscovery.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100781>


--y4IIEhPJP4QURB7c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Johannes Sixt wrote:
> Michael Adam schrieb:
> > This changes the behaviour of post-receive-email when a list of recipie=
nts
> > (separated by commas) is specified as hooks.mailinglist. With this modi=
fication,
> > an individual mail is sent out for each recipient entry in the list, in=
stead
> > of sending a single mail with all the recipients in the "To: " field.
>=20
> I don't think this is well-behaved:
>=20
> - The load multiplies for the sender (typically a repository server).

This is right.

> - And wouldn't each recipient get a new Message-Id? This would break
> threading if further communication takes place among the recipients.

My idea was that different recipients have different threading anyways.
OK, threading for multiple recipients can be conserved with group replies.
I thought that usually you specify a single mailing list as recipient.
My use case is that I have additional recipients that do not necessarily
want to be seen as recipients on the mailing list that is specified as
the primary recipient.

> But I may be wrong on both accounts.

Your concerns are surely valid.
Maybe it would be useful to make this optional?

Thanks for your comments!

Cheers - Michael

--=20
Michael Adam <ma@sernet.de>  <obnox@samba.org>
SerNet GmbH, Bahnhofsallee 1b, 37081 G=F6ttingen
phone: +49-551-370000-0, fax: +49-551-370000-9
AG G=F6ttingen, HRB 2816, GF: Dr. Johannes Loxen
http://www.SerNet.DE, mailto: Info @ SerNet.DE

--y4IIEhPJP4QURB7c
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: comment

iD8DBQFJGxVuyU9JOBhPkDQRAuswAJ9qErV4CoVlG2J91F3m8ODWUEuiMwCgnCP5
p0QUopRzS1bbrDjNArVMJhw=
=9bFI
-----END PGP SIGNATURE-----

--y4IIEhPJP4QURB7c--
