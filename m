X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: Merging five months of Linux kernel history
Date: Mon, 30 Oct 2006 08:50:02 +0100
Message-ID: <20061030075002.GT26271@lug-owl.de>
References: <20061029193228.GR26271@lug-owl.de> <7vhcxm274i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jASSyw8pZdwiLt00"
NNTP-Posting-Date: Mon, 30 Oct 2006 07:50:26 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vhcxm274i.fsf@assigned-by-dhcp.cox.net>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30484>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeRuQ-0001Z8-Nw for gcvg-git@gmane.org; Mon, 30 Oct
 2006 08:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161187AbWJ3HuH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 02:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161190AbWJ3HuG
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 02:50:06 -0500
Received: from lug-owl.de ([195.71.106.12]:42900 "EHLO lug-owl.de") by
 vger.kernel.org with ESMTP id S1161187AbWJ3HuE (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 02:50:04 -0500
Received: by lug-owl.de (Postfix, from userid 1001) id 89317F079E; Mon, 30
 Oct 2006 08:50:02 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org


--jASSyw8pZdwiLt00
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-10-29 12:34:53 -0800, Junio C Hamano <junkio@cox.net> wrote:
> Jan-Benedict Glaw <jbglaw@lug-owl.de> writes:
> > Due to a move to a new flat and other reasons, I wasn't able to
> > do daily merges from Linus's tree into our vax-linux tree.
> > My time situation has improved and I want to merge all the new
> > and shiny stuff, but it seems a straight "git pull" isn't the
> > best way to do that.
> >
> > What I'd actually love to do is to go through all commits since the
> > last merge and pull/accept/cherry-pick then one by one.  That way I'll
> > learn about new stuff. I'll specifically see generic changes that
> > imply arch-specific stuff, things I'll need to implement later on.
> >
> > Is there any sane way to cluse such a large gap?  I don't mind looking
> > through tenthousands of commits, as long as I get a chance to spot
> > "important" ones.
>=20
> I think the best way is:
>=20
> 	git pull
>         git log ORIG_HEAD..
>=20
> The latter would give your ten thousands of commits to inspect.
>=20
> If the pull results in a conflict, then
>=20
> 	git pull
> 	git log --merge
>=20
> 	... fix conflicts ...
> 	git commit
>         git log ORIG_HEAD..

That's the point--I don't really expect any conflicts, or only a very
little number of them. Basically, only the Makefiles and the Kconfig
files do have a chance to conflict.  It's no more than a new arch/
directory and some drivers.

The hard part will be to figure out all the needed changes in arch
code, like the IRQ handling rework etc :)

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
Signature of:           Ich hatte in letzter Zeit ein bi=C3=9Fchen viel Rea=
litycheck.
the second  :               Langsam m=C3=B6chte ich mal wieder weitertr=C3=
=A4umen k=C3=B6nnen.

--jASSyw8pZdwiLt00
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFRa6qHb1edYOZ4bsRAsDeAJ4hw+hqEhjIvFKvE/GvoIuV9UAgvQCfVfBH
+EhzuiksoJcs9dOFLmzrA1g=
=i+rf
-----END PGP SIGNATURE-----

