From: Max Horn <max@quendi.de>
Subject: Re: [PATCH v5 08/10] fast-import: add support to delete refs
Date: Thu, 31 Oct 2013 19:41:52 +0100
Message-ID: <08E1EB05-D3E1-4393-A950-60AB46930BB1@quendi.de>
References: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com> <1383212197-14259-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/signed; boundary="Apple-Mail=_DBAC7A5D-6ED0-4E29-9CA5-1B6EDB536569"; protocol="application/pgp-signature"; micalg=pgp-sha256
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 19:42:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbxBw-0001Fk-5b
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 19:42:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755454Ab3JaSl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 14:41:56 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:59960 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753621Ab3JaSl4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Oct 2013 14:41:56 -0400
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1VbxBo-0008ML-G9; Thu, 31 Oct 2013 19:41:52 +0100
In-Reply-To: <1383212197-14259-4-git-send-email-felipe.contreras@gmail.com>
X-Mailer: Apple Mail (2.1510)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1383244915;8505ad6d;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237154>


--Apple-Mail=_DBAC7A5D-6ED0-4E29-9CA5-1B6EDB536569
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


On 31.10.2013, at 10:36, Felipe Contreras <felipe.contreras@gmail.com> =
wrote:

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
> Documentation/git-fast-import.txt |  3 +++
> fast-import.c                     | 13 ++++++++++---
> t/t9300-fast-import.sh            | 18 ++++++++++++++++++
> 3 files changed, 31 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/git-fast-import.txt =
b/Documentation/git-fast-import.txt
> index 73f9806..c49ede4 100644
> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -483,6 +483,9 @@ Marks must be declared (via `mark`) before they =
can be used.
> * Any valid Git SHA-1 expression that resolves to a commit.  See
>   ``SPECIFYING REVISIONS'' in linkgit:gitrevisions[7] for details.
>=20
> +* The special null SHA-1 (40 zeros) specifices that the branch is to =
be

s/specifices/specifies/

(this was previously pointed out by Eric Sunshine for patch 7 of v4 of =
this series).


--Apple-Mail=_DBAC7A5D-6ED0-4E29-9CA5-1B6EDB536569
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iF4EAREIAAYFAlJypHAACgkQIpJVslrhe1mFwwEAr4CXiT+7RuaPZ7A5bjv8W2s+
e01vAvJvncfbAWMsSIwA/1IRU2GOMmK2GCjRUiiEhqbDnhbyEMsdaP09SUFZPcaq
=nuHU
-----END PGP SIGNATURE-----

--Apple-Mail=_DBAC7A5D-6ED0-4E29-9CA5-1B6EDB536569--
