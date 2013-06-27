From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH] pull: require choice between rebase/merge on
 non-fast-forward pull
Date: Thu, 27 Jun 2013 16:30:07 -0400
Message-ID: <20130627203007.GG9999@odin.tremily.us>
References: <CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
 <20130523102959.GP9448@inner.h.apk.li> <20130523110839.GT27005@serenity.lan>
 <7vd2shheic.fsf@alter.siamese.dyndns.org>
 <20130523164114.GV27005@serenity.lan>
 <7vbo81e7gs.fsf@alter.siamese.dyndns.org>
 <20130523215557.GX27005@serenity.lan>
 <7vli75cpom.fsf@alter.siamese.dyndns.org>
 <CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
 <7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="m972NQjnE83KvVa/"
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	John Keeping <john@keeping.me.uk>,
	Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 27 22:30:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsIpj-0006Ii-Lb
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 22:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754260Ab3F0UaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 16:30:18 -0400
Received: from vms173015pub.verizon.net ([206.46.173.15]:61147 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754219Ab3F0UaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 16:30:16 -0400
Received: from odin.tremily.us ([unknown] [72.68.87.33])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MP20090NJM7FC10@vms173015.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 27 Jun 2013 15:30:13 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 5E035A5443B; Thu,
 27 Jun 2013 16:30:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1372365007; bh=7q4XkD+cm/AyUKYdy2ckGrrdtoZLgwjVx7BhFaRas7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=prt0IjptFTaoJUW8y3dkfu5dijieuR0cJ4j2C+v0Vn08BZZFpnDfQKCG6NONuilgu
 SjJQ17AAvPmh6qsp2fCVw6qy1iKV3bFBfo3IMHoJQ/anZaeCIHY7kwh3UrrqAwKBIC
 JVtXto31zlMM1bz5kOcn7+AfQLuShgudQd8HQ8Zk=
Content-disposition: inline
In-reply-to: <7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229153>


--m972NQjnE83KvVa/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Assorted minor edits:

On Thu, Jun 27, 2013 at 12:48:52PM -0700, Junio C Hamano wrote:
> Because letting a trivial merge automatically handled by Git is so

Maybe:

  Because letting Git handle a trivial merge automatically is so=E2=80=A6

> that the project s/he is interacting with may prefer "rebase"
> workflow.  Add a safety valve to fail "git pull" that is not a

Maybe (adding an "a"):

  a "rebase" workflow.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--m972NQjnE83KvVa/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRzKDKAAoJEKKfehoaNkbtwdYQAJh8xD9d2GX6q2jNkXCMHt/w
r0Gw1/c5UuksnLHQHGoJPXNVqCI63FZO7WgIoSLDqGT9Q7rEr12eqfQhGhQyH1iS
9OqyEP8J0WZeXWISkOmj1Ki9wYtRHjbAP+Qndu9+F358zwKUaD728Euy0nawTGiJ
lrmr++Y1NveRhM3mf//MxFZzxnIbicHM2WQVXveHeERms7oXyfFE+J5M5lldoMGL
Eo7tXU1PI99vOqSnv079pLkv8DPm9tXiAUyNlLnQjjzj+oUhzklCKsardM1sK3cT
+GlWm9UD1h5KtuoktNcR4PJ+E2N11CAgk0g/x7ghPytr9mlW4yObWO7XBg07lhPG
6fMOefKJYkJDyso7FVDuFSRLy4CS9O2X6cmcpgJ1Us3MG0VJNbOFrxmkic0/1sAk
e0Ff+HQfpI6GksI0Q2qHrwVaR3ixMBn7nDwrJ+45tJWlQmkMK5s6wyAqGgXYQcIf
ajWs6Q1D7lYl2KwkRD+r3ENFcfJELSQ5+InPZlRFgBFST17dF4d5dbENPh9vuOaC
DgqMaA9JcncQFvYk6gl2jMWSAZungF+P4yzHU4fLliIFeU57x4aZkn02TU1Z5Tam
PDhKb4EGDHyBiZBAqr075bQAn1uD6rPgmr1apKXFxWVoyx9NDA8/jkRtwAyZEzRa
w7rQYBWk0yVRd2tdVgsJ
=cFr6
-----END PGP SIGNATURE-----

--m972NQjnE83KvVa/--
