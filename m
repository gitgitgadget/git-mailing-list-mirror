X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Florent Thoumie <flz@xbsd.org>
Subject: Re: Problem with git-push
Date: Wed, 01 Nov 2006 22:54:53 +0000
Message-ID: <1162421693.93716.22.camel@localhost>
References: <1162306098.41547.4.camel@mayday.esat.net>
	 <7v64e0qclo.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0611011205340.1670@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7v4ptj5ghj.fsf@assigned-by-dhcp.cox.net>
	 <7v8xiu3ksl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-JgS1d9PpFSRF3uBnjgL4"
NNTP-Posting-Date: Wed, 1 Nov 2006 21:55:47 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7v8xiu3ksl.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.8.1 FreeBSD GNOME Team Port 
X-Virus-Scanned: amavisd-new at xbsd.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30661>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfO3V-0003ca-AT for gcvg-git@gmane.org; Wed, 01 Nov
 2006 22:55:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752494AbWKAVz0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 16:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752496AbWKAVz0
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 16:55:26 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:33927 "EHLO
 smtp6-g19.free.fr") by vger.kernel.org with ESMTP id S1752494AbWKAVzZ (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 16:55:25 -0500
Received: from smtp.xbsd.org (unknown [82.233.2.192]) by smtp6-g19.free.fr
 (Postfix) with ESMTP id 72D0543061; Wed,  1 Nov 2006 22:55:24 +0100 (CET)
Received: from localhost (localhost.xbsd.org [127.0.0.1]) by smtp.xbsd.org
 (Postfix) with ESMTP id 2C1F9114FF; Wed,  1 Nov 2006 22:55:24 +0100 (CET)
Received: from smtp.xbsd.org ([127.0.0.1]) by localhost (srv1.xbsd.org
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 74689-03; Wed,  1 Nov
 2006 22:55:01 +0100 (CET)
Received: from [193.120.13.130] (cream.xbsd.org [193.120.13.130]) by
 smtp.xbsd.org (Postfix) with ESMTP id 2AE2111415; Wed,  1 Nov 2006 22:54:59
 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org


--=-JgS1d9PpFSRF3uBnjgL4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-11-01 at 13:43 -0800, Junio C Hamano wrote:
> Junio C Hamano <junkio@cox.net> writes:
>=20
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> >>> but more importantly, if the directory in question was created by=20
> >>> somebody else, I do not think this chmod() would succeed even if you =
are=20
> >>> in the same group as the owner (i.e. previous creator) of the directo=
ry.
> >>
> >> But if somebody else created it, it should already have the correct=20
> >> permissions in the first place (unless the user played around with the=
m,=20
> >> which is not a pilot error, but a willfull pointing of the barrel in t=
he=20
> >> general direction of your knee).
> >
> > True; I think the yesterday's analysis is still incomplete.  I
> > haven't reached the point where I can explain "is a directory".
> > If the directory was there and mkdir() failed (but we do not
> > check its return value), it would have set errno to EEXIST not
> > to EISDIR.  There is something else going on.
>=20
> Actually, Florent's said the directory permission was screwed up
> to begin with, so after following the code a bit more I can see
> why it said "is a directory".

I screwed the perms. I have a cron job that does automatic imports and
it's running as root. I've been lured by the fact that it uses my name
and email address to do those imports, so I thought it was running under
my unprivileged account.

Florent

--=-JgS1d9PpFSRF3uBnjgL4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (FreeBSD)

iD8DBQBFSSW8MxEkbVFH3PQRAu1MAJ42Jaa5h2wrfCVv0/bAAq2tPSKFxwCfVx44
R9tG945QhfywFR8N9cDhyzc=
=gqXf
-----END PGP SIGNATURE-----

--=-JgS1d9PpFSRF3uBnjgL4--
