From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 1/2] git-prompt.sh: strip unnecessary space in prompt
 string
Date: Mon, 13 May 2013 11:17:19 +0200
Message-ID: <20130513091718.GA21636@goldbirke>
References: <1368289513-8700-1-git-send-email-artagnon@gmail.com>
 <1368289513-8700-2-git-send-email-artagnon@gmail.com>
 <7v61ynsci8.fsf@alter.siamese.dyndns.org>
 <CALkWK0m0dT-sX=nu5jaDj=y1oOSo0cRKQ=2K_S-yepnsm8ny7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 13 11:17:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubosq-0008Ff-Bz
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 11:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992Ab3EMJRY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 May 2013 05:17:24 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:61621 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877Ab3EMJRX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 05:17:23 -0400
Received: from localhost6.localdomain6 (f050237109.adsl.alicedsl.de [78.50.237.109])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0MWySC-1UyxwJ3CxI-00WDmo; Mon, 13 May 2013 11:17:20 +0200
Content-Disposition: inline
In-Reply-To: <CALkWK0m0dT-sX=nu5jaDj=y1oOSo0cRKQ=2K_S-yepnsm8ny7A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:D4gXyLW2/cspoIzJxUYIAvwPuxdMaZK+3dIIfk0Bhw9
 SzAaHpoP2iYvKtNP3wlRyDHkj8PKcrorHBVF1kspGJVhjU4XtQ
 3E53mfk1w1lWSfmWsYI7JyuDaEmjf2kIPf/uXU23qxXOlVRnN7
 Npuy36xOtbW3sTbwFmk3OwkJFDaSfUxhTgIeqLZYKsy5801cra
 xwFFkgwjdr5ApSL9YMZ0GZED5hxcofm7DhHSflcJtUqQouCazm
 5ylZZxarU4dkIreZLeaiTS4qUEkhoQQCLYBCHHCzT5IQj3itbo
 s9pl4HZtlBiLg1Q7jC/ksP3KfiVx3ZKmn217/+bFYKM9lbCmZ0
 ZK/kU5wlBoeNlOhP7CdRAeKl6I3NIPqpRPswjJRC9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224116>

On Mon, May 13, 2013 at 01:10:26PM +0530, Ramkumar Ramachandra wrote:
> Junio C Hamano wrote:
> > grouping related things together, and
> > separating groups of different kind apart, to make it more readable=
=2E
>=20
> You could argue that the colors are not very well thought-out
> (branch-name has the same color as +), but I really don't see the
> problem otherwise.  How is this more readable:
>=20
>     artagnon|master *=3D:~/src/git$
>=20
> than:
>=20
>     artagnon|master*=3D:~/src/git$
>=20
> (where master is green, * is red, and =3D is white)?

IMHO that's just ugly ;)

Don't forget that others might use a different prompt format and using
colors in the prompt is optional.  With the default prompt format and
without colors I find that that space definitely helps readability.


G=E1bor
