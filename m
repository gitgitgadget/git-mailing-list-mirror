From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git-imap-send and "From "
Date: Sat, 21 Oct 2006 19:11:54 +0100
Message-ID: <200610211911.54920.andyparkins@gmail.com>
References: <200610211751.21581.andyparkins@gmail.com> <20061021175519.GA7432@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2508538.fE6HqaS7pl";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Oct 21 20:14:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbLMe-0002Er-DM
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 20:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWJUSO3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 14:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964773AbWJUSO3
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 14:14:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:6118 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964800AbWJUSO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 14:14:28 -0400
Received: by ug-out-1314.google.com with SMTP id o38so964319ugd
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 11:14:27 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:message-id;
        b=oT99HVevLRTK1xf8y1lSQ6PWas3nWp6s6WWnopT6WwSWViSxn1rDPsPzJCJBTRDFv46ohNrSkLNAY+K45ej0uovL2JH1+NlQ+zl27wjEi7qaRGYy0d7osiQCYBCOpiPh+FGkdnK/6Yj4NbSC6+y4mBmrmTTelhlm6AsidIcc7AY=
Received: by 10.66.224.19 with SMTP id w19mr4161089ugg;
        Sat, 21 Oct 2006 11:14:26 -0700 (PDT)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id u1sm1619995uge.2006.10.21.11.14.25;
        Sat, 21 Oct 2006 11:14:26 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <20061021175519.GA7432@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29650>

--nextPart2508538.fE6HqaS7pl
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 2006, October 21 18:55, Jeff King wrote:

> git-imap-send shouldn't be sending it. The IMAP protocol works with
> RFC822 messages, not mboxes.

I grabbed the latest git; and started looking at fixing it.  It looks fixed=
 to=20
me; a quick "git log imap-send.c" found me commit=20
e0b0830726286287744cc9e1a629a534bbe75452; which already fixes this problem.

Goodness I love git :-)


Andy

=2D-=20
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com

--nextPart2508538.fE6HqaS7pl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFOmLqwQJ9gE9xL20RAsKrAKDGWdNY4OuKKomOZVImPlbRpyoodwCgyepy
Gy0OmF9Ij5cfVOvnw5IxFmg=
=2SwS
-----END PGP SIGNATURE-----

--nextPart2508538.fE6HqaS7pl--
