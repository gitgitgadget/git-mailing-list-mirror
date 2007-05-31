From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [RFH] QGit: how to cram a patch in a crowded screen
Date: Thu, 31 May 2007 21:56:33 +0200
Message-ID: <20070531195633.GA3252@efreet.light.src>
References: <e5bfff550705260146q51350f40q1c80cfe8079f47c6@mail.gmail.com> <200705261034.53723.andyparkins@gmail.com> <e5bfff550705261344l604543e7h64c20c1fc0979f20@mail.gmail.com> <20070527153852.GA30365@efreet.light.src> <e5bfff550705270856o195b9075u1c99a05e79d69742@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Pavel Roskin <proski@gnu.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 31 21:56:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtqlM-0005P1-NY
	for gcvg-git@gmane.org; Thu, 31 May 2007 21:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761204AbXEaT4l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 15:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760933AbXEaT4l
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 15:56:41 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:60026 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760852AbXEaT4j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 15:56:39 -0400
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id AE54557376;
	Thu, 31 May 2007 21:56:37 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1Htql7-0001ct-V6; Thu, 31 May 2007 21:56:33 +0200
Content-Disposition: inline
In-Reply-To: <e5bfff550705270856o195b9075u1c99a05e79d69742@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48820>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 27, 2007 at 17:56:05 +0200, Marco Costalba wrote:
> On 5/27/07, Jan Hudec <bulb@ucw.cz> wrote:
> >On Sat, May 26, 2007 at 22:44:28 +0200, Marco Costalba wrote:
> >> On 5/26/07, Andy Parkins <andyparkins@gmail.com> wrote:
> >> >
> >> >For example, the log view widget would show:
> >> >
> >> ><Header>
> >> ><Log Message>
> >> ><Patch>
> >> >
> >> >All visually distinct to improve searching by eye (perhaps including
> >> >clear separators between files patched).  Then the file list could
> >> >include a "<header>" psuedo-file that would jump back to the top of t=
he
> >> >viewer.
> >>
> >> This seems really gitk like. Not that I don' t like it, but _if_ it's
> >> possible I would prefer something a little bit more original.
> >
> >IMHO there's no point in being original.
>=20
> True. But there's no point also in avoiding experimenting a little bit.
>=20
> I've pushed some patches to use different ways to switch between diff
> and messages, please read the last patch log message for a summary of
> the changes.
>=20
> If interested give it a try. it would be grat to hear your comment on tha=
t=20
> also.

I have to say that I like the gitk way better. There is the issue of
over-scrolling. I often want to quickly scan through the diff, so I scroll
pretty quickly and it switches over when I reach the end.

I understand the reason to not calculate the diff until it's requested.
I think I might like it if only message is shown initially and when user
scrolls at -- or rather past -- the end, the diff would be APPENDED to it.
That way the scrolling would look more natural, while still only generating
the diff only on request.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGXyhxRel1vVwhjGURAmafAKCkeMriBYHTRNCCPnZotcoriLvqagCfWw5j
OpNLB/XPceb6LhrZIQJRuHc=
=wiEk
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
