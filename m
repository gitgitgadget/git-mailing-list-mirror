From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: markdown 2 man, was Re: Git Community Book
Date: Fri, 1 Aug 2008 11:46:26 +0200
Message-ID: <200808011146.29883.trast@student.ethz.ch>
References: <d411cc4a0807290920p62f5d7e1r727a62ef2b4611fc@mail.gmail.com> <7vvdylv9zq.fsf@gitster.siamese.dyndns.org> <4892B714.8010401@lyx.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1356167.zM00BnAThh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Scott Chacon <schacon@gmail.com>, Petr Baudis <pasky@suse.cz>
To: Abdelrazak Younes <younes@lyx.org>
X-From: git-owner@vger.kernel.org Fri Aug 01 11:47:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOrEB-0006kr-NM
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 11:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752576AbYHAJqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 05:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752560AbYHAJqN
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 05:46:13 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:47881 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751158AbYHAJqM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 05:46:12 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 1 Aug 2008 11:46:11 +0200
Received: from [192.168.0.3] ([84.75.158.234]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 1 Aug 2008 11:46:11 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <4892B714.8010401@lyx.org>
X-OriginalArrivalTime: 01 Aug 2008 09:46:11.0496 (UTC) FILETIME=[6E4BE280:01C8F3BB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91047>

--nextPart1356167.zM00BnAThh
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

You wrote:
> Junio C Hamano wrote:
> >
> > How greppable and "log -p"-able is the documentation written in LyX?
>=20
> LyX format is plain text, loosely based on LateX. Here's attached a=20
> sample .lyx file FYI. We have one tag per line and a maximum of 80 char=20
> per line so that the format is easily parsable. Advanced users often use=
=20
> unix tools (grep, sed, etc) to modify the .lyx file manually.

Is it just me or is the format very hard to read?  For example, line
492ff spells a list of quoted items as

    \begin_layout Standard
    Generally, you would send email to lyx-foo-subscribe@lists.lyx.org to s=
ubscribe
     to these lists or to lyx-foo-unsubscribe@lists.lyx.org to unsubscribe,=
 where
    =20
    \begin_inset Quotes eld
    \end_inset

    foo
    \begin_inset Quotes erd
    \end_inset

     is one of=20
    \begin_inset Quotes eld
    \end_inset

    announce
    \begin_inset Quotes erd
    \end_inset

etc.  Of course I can "parse" the language, but my untrained eye is
unable to fluently read the text hiding behind it.

Also, if I made a commit changing the "announce", you would have to
turn up diff context to at least 13 lines to get any _semantic_
context of the change.

=2D Thomas


--nextPart1356167.zM00BnAThh
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiS23UACgkQqUud07tmzP06cQCfaEOqmOtp7p6LQmXQQVkatXTN
iVoAoIVXaG0MlUyHkJ1NlPQn/sbjABRa
=vHuC
-----END PGP SIGNATURE-----

--nextPart1356167.zM00BnAThh--
