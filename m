From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Re: [WIP/PATCH 4/9] Teach merge the
 --[no-]recurse-submodules option
Date: Fri, 7 Feb 2014 14:08:53 -0800
Message-ID: <20140207220853.GZ14197@odin.tremily.us>
References: <xmqqd2k4hh4p.fsf@gitster.dls.corp.google.com>
 <52CC3E16.4060909@web.de>
 <xmqqvbxvekwv.fsf@gitster.dls.corp.google.com>
 <52EFF25E.6080306@web.de>
 <52EFF311.1090202@web.de>
 <xmqq4n4fdcnd.fsf@gitster.dls.corp.google.com>
 <52F54ED7.2010302@web.de>
 <xmqqeh3etwg8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DTeHUGp76GcuSc2J"
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 07 23:09:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBtbi-0003st-Eo
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 23:09:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbaBGWI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 17:08:57 -0500
Received: from qmta03.westchester.pa.mail.comcast.net ([76.96.62.32]:41397
	"EHLO qmta03.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751750AbaBGWI4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Feb 2014 17:08:56 -0500
Received: from omta02.westchester.pa.mail.comcast.net ([76.96.62.19])
	by qmta03.westchester.pa.mail.comcast.net with comcast
	id PYdC1n00G0QuhwU53a8v9T; Fri, 07 Feb 2014 22:08:55 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta02.westchester.pa.mail.comcast.net with comcast
	id Pa8u1n00F152l3L3Na8vel; Fri, 07 Feb 2014 22:08:55 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id F37FAFFB6C2; Fri,  7 Feb 2014 14:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1391810934; bh=8LooPNjiyB1gffzqljeRWAJQjy2eLIDpgSB8HeaIHrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=rb+fVoKFXQweHleHY9HfT5p0fRNoSR4XVZrlPHrUaGPHWAYI0b2IiTYtlPTTXDS8H
	 aRPYSrQhH+d4vZ+iFTkQQWRwi/2sKFY5+ILu7A6CjjY2EgFypyiGjI99g26y7kP5ku
	 E2DLMih6peklbFJbjdlK9FvP7qdALIAprYiIXn/g=
Content-Disposition: inline
In-Reply-To: <xmqqeh3etwg8.fsf@gitster.dls.corp.google.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1391810935;
	bh=HczRtsnPEYk/fNmTPd9p7SxSJbbtVqxq5wV99C9SKlM=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=IDRZCbz8Qt6i5YvDrBVCVSQ2tFLA0U+lxnNinXt3Jn8z+9ox3h5c5QlXix9Z90b9y
	 rsDSzue/QsWDX7zzZMRyhjweCURFbMFMA4/Vx/3ZlCESlqYkGI51NXXvG+xECQQWy+
	 s7d7qk2K1LdtuGxRr0FhoXCJxHGTU/W+1MVqoQxQ5Qyr+w5iFtrqX6kvd6RZ4UJEcA
	 KYL0tWWlRR64NyYpdP0kJf9ecZByCvNYEBBf9AoF4U40lpvATFTaYSPzjZxWm+sWOl
	 +uGSamR0vR7eiYfYiHwo9HeKhF7ObRGIhg4/Ju1wVnofwFP++ROEOwI6hWXbvgfaBN
	 IBG23xYIBzy7A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241810>


--DTeHUGp76GcuSc2J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2014 at 02:00:23PM -0800, Junio C Hamano wrote:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> > I think the user needs to sort things out, just like she has to do
> > when a file has a merge conflict. But unfortunately we cannot use
> > conflict markers here, so I'd propose the following:
> >
> > * When merge proposes a merge resolution (which it does today by
> >   telling the user "Found a possible merge resolution for the
> >   submodule ... [use] git update-index --cacheinfo 160000 ...")
> >   that commit should be checked out in the submodule but not
> >   staged. Then the user can simply add and commit.
> > =E2=80=A6
> =E2=80=A6
>=20
> For the former, "add and commit" at the top-level makes perfect
> sense, =E2=80=A6

This still works if the merge issue is in a grandchild submodule, but
it's going to be a bit tedious if the user has to add-and-commit at
each level from the troublesome sub-sub-=E2=80=A6-module on up to the
top-level superproject.  I can't think of a cleaner solution though.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--DTeHUGp76GcuSc2J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS9Vl0AAoJEKKfehoaNkbtlPQP/RFldXBQf+VvGaAEf32F9G21
0YISrJTC97M7PjxxaqfNJFTcgnogsW43EATzQdHrjuxw9qeygcp/nq73hBfnytC7
Sp291HnRTJxZuhN0wx5qO255/XZMTTUCLVRCjOFrMOZPVX3uB2U350R9fEsEwEZU
JsJSR1uBn8wGKTrrUxEUjCeSDD8UhbklBW3YF74uPgV8RrKuROBSSmhaFer6djx0
ROGcMsVgMmJ9jDxqZxPjcyXYFuFRwT4J0bMOxpEcN5jGH8dqkRIZ5sGg2L7YQNrr
olofY0ACAbte/2glGPTUSVSdF3lPlNf0rNJJwJLHR7bAhoFoYvbNYIyL1eaRzfAY
Xp6ccsSpSgj80wfNv8glevv6RyJQVquI+nuj5kYP9a2m9QqNo8QPSwEoI6AgkThq
37BAAJUvBo0hi3Fu+E/eIn/cNLk74qsA6ZUEcgCNHOHjD8OH+I/uaSKfjw6plGjJ
NZEQxxlh7ZMehlkL8S+Z9/IJVu1flW6FcGvBNW0QbfXbIhZjrg+/n25cQs2AWZYe
DzAvfOzcdRVWkM9W8bNs7k+fYApgYB/1hkHMhHwJSd4nViF8/H+uuK/WDXNdfcj6
JkJDT89RDsfMC/ZxWMbFKqVNhBqtWKBeo5ae6ZSyGloeflrWhUt1aYQ3x3rdh7qH
/P5bHL0Ed+GDTgVON0wW
=Een5
-----END PGP SIGNATURE-----

--DTeHUGp76GcuSc2J--
