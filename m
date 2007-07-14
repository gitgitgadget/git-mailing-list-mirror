From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] make git-send-email.perl handle email addresses with no
 names when Email::Valid is present
Date: Sat, 14 Jul 2007 20:38:42 +1000
Message-ID: <20070714203842.bf6c43cc.sfr@canb.auug.org.au>
References: <20070713041749.GA28824@kroah.com>
	<7vr6ncrh22.fsf@assigned-by-dhcp.cox.net>
	<20070713063414.GN24317@kroah.com>
	<20070713182818.fd37372f.sfr@canb.auug.org.au>
	<20070714040050.GA11773@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sat__14_Jul_2007_20_38_42_+1000_O8MLgXgpMn/kr=lj"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Greg KH <greg@kroah.com>
X-From: git-owner@vger.kernel.org Sat Jul 14 12:39:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9f1m-0007ew-30
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 12:39:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755239AbXGNKiw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 06:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755015AbXGNKiv
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 06:38:51 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:54637 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755117AbXGNKiv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 06:38:51 -0400
Received: from localhost (ta-1-1.tip.net.au [203.11.71.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id F1449368041;
	Sat, 14 Jul 2007 20:38:48 +1000 (EST)
In-Reply-To: <20070714040050.GA11773@kroah.com>
X-Mailer: Sylpheed 2.4.3 (GTK+ 2.10.13; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52468>

--Signature=_Sat__14_Jul_2007_20_38_42_+1000_O8MLgXgpMn/kr=lj
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Jul 2007 21:00:50 -0700 Greg KH <greg@kroah.com> wrote:
>
> On Fri, Jul 13, 2007 at 06:28:18PM +1000, Stephen Rothwell wrote:
> >=20
> > This would be a bug in Email::Valid as it complains that the second
> > address fails the rfc822 check, however rfc822 says that the "display
> > name" before the '<' is optional.
>=20
> I agree, do you know how to get such a fix made?

I would be inclined to make it my distribution's problem :-) i.e. on
Debian I would report a bug against libemail-valid-perl.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__14_Jul_2007_20_38_42_+1000_O8MLgXgpMn/kr=lj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGmKe2TgG2atn1QN8RAkLdAJ0ZRP7pif/oM0eqI5pmkvYBJEfuNgCfc0/A
10N8sY9V2TF3StoJGcv0blM=
=Sh6r
-----END PGP SIGNATURE-----

--Signature=_Sat__14_Jul_2007_20_38_42_+1000_O8MLgXgpMn/kr=lj--
