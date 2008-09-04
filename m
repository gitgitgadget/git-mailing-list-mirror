From: Thomas Moschny <thomas.moschny@gmx.de>
Subject: Re: [Monotone-devel] Re: [RFC] mtn to git conversion script
Date: Thu, 4 Sep 2008 12:50:09 +0200
Message-ID: <200809041250.17715.thomas.moschny@gmx.de>
References: <94a0d4530808240218j4bedbe3di99303da9addc93a4@mail.gmail.com> <94a0d4530808280203o6d97f69we4768115e12800c2@mail.gmail.com> <94a0d4530809040243k49635fd3kfef1ee22a6865e98@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1693009.TNRes9HpYr";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: "Felipe Contreras" <felipe.contreras@gmail.com>,
	"Anand Kumria" <wildfire@progsoc.org>, git@vger.kernel.org
To: monotone-devel@nongnu.org
X-From: git-owner@vger.kernel.org Thu Sep 04 12:51:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbCQz-0008Q6-1p
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 12:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069AbYIDKuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 06:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753113AbYIDKuW
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 06:50:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:41406 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752992AbYIDKuW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 06:50:22 -0400
Received: (qmail invoked by alias); 04 Sep 2008 10:50:19 -0000
Received: from 1erlei.de (EHLO 1erlei.de) [87.230.13.31]
  by mail.gmx.net (mp023) with SMTP; 04 Sep 2008 12:50:19 +0200
X-Authenticated: #2034325
X-Provags-ID: V01U2FsdGVkX1/upsgRhqju4s39oB5RsRco8RJTN+t9+GolKV8pmJ
	iQl43VShtmTDUa
User-Agent: KMail/1.10.0 (Linux/2.6.25-14.fc9.x86_64; KDE/4.1.0; x86_64; ; )
In-Reply-To: <94a0d4530809040243k49635fd3kfef1ee22a6865e98@mail.gmail.com>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94925>

--nextPart1693009.TNRes9HpYr
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thu, Sep 4, 2008, Felipe Contreras wrote:
> Ok, now the basics seem to be working. So I'm uploading some code if
> anyone wants to take a look.
>
> The C code is generating a topologically sorted list of revisions, and
> storing the relevant information (certs and parents) separately. This
> code is very fast. It's using GLib and sqlite3, so probably the GLib
> stuff should be converted to use libgit.
> http://gist.github.com/8742

You shouldn't access Monotone's sqlite database directly, for various reaso=
ns.=20
Use the Automation Interface instead, see=20
http://www.monotone.ca/docs/Automation.html#Automation. Using 'mtn automate=
=20
stdio', you can feed an arbitrary amount of commands to one single running =
mtn=20
process.

=2D Thomas


--nextPart1693009.TNRes9HpYr
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAki/vWkACgkQm/6MhNYca5gxpACfSrgsELBnssWO+sfFb1+uSSvF
rNkAnRp/NuGH/Ku7XxQPDneQ/EwWAUrY
=j+jK
-----END PGP SIGNATURE-----

--nextPart1693009.TNRes9HpYr--
