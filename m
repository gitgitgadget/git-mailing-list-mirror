From: Luis Ressel <aranea@aixah.de>
Subject: Re: [GSoC microproject] Add XDG support to the credential-store
 helper
Date: Fri, 6 Mar 2015 00:41:39 +0100
Message-ID: <20150306004139.2dac2502@gentp.lnet>
References: <20150305215146.394caa71@gentp.lnet>
	<CAP8UFD3kHKsUWqmfr3mEtTYwVFwGGqMF_wJgVQyoaH=2i9Ge=A@mail.gmail.com>
	<20150306001534.06882282@gentp.lnet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/N/iYxWi5DS+fjA4wfFmH=97"; protocol="application/pgp-signature"
Cc: Christian Couder <christian.couder@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 06 00:41:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTfOp-0004Ng-IY
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 00:41:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753485AbbCEXlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 18:41:47 -0500
Received: from wp260.webpack.hosteurope.de ([80.237.133.29]:47602 "EHLO
	wp260.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751197AbbCEXlp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2015 18:41:45 -0500
Received: from hsi-kbw-046-005-229-078.hsi8.kabel-badenwuerttemberg.de ([46.5.229.78] helo=gentp.lnet); authenticated
	by wp260.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	id 1YTfOh-00053y-KJ; Fri, 06 Mar 2015 00:41:43 +0100
Received: from gentp.lnet (gentp.lnet [IPv6:::1])
	by gentp.lnet (Postfix) with ESMTP id D42B1260166;
	Fri,  6 Mar 2015 00:41:42 +0100 (CET)
In-Reply-To: <20150306001534.06882282@gentp.lnet>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
X-bounce-key: webpack.hosteurope.de;aranea@aixah.de;1425598905;1d91a6eb;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264880>

--Sig_/N/iYxWi5DS+fjA4wfFmH=97
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Okay, I've had a look at Paul's patch for this. Sorry again for the
dupe, I must've missed it before. I guess I'll attempt another
microproject.

However, I feel like my patch is really all that's neccessary; I don't
think we should try to use both files if they exist -- I consider
Paul's approach to be a bit overcomplicated.

My patch still uses ~/.git-credentials as a default location, which
should be sufficient for compability. A user that wants to use
~/.config/git/credentials instead has to manually create that file
first, which he just shouldn't do if he has to stay compatible to
previous git versions.

Of course, my patch is definitly lacking a test case, and the
documentation could be a tad better, too.


Regards,
Luis Ressel

--Sig_/N/iYxWi5DS+fjA4wfFmH=97
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQJ8BAEBCgBmBQJU+OmzXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRBMjU3MDBFQTc5QkYzMkY4NEQzMTFGNDlD
NzE4OTFBNkEwRUZCN0U5AAoJEMcYkaag77fp5W0P/jJrI3rrTq6Q9jXipoZqDm+z
gOeFj4n4rtbhs3wBJA40W8GMfEiPNPntmJgy5RWTwU+/nyOrbZau7jvW7L6R1jv1
4M9ev0fcZJmqG7uT0QQBksVBvlmi+Hdt6bUHg5tSypzAcvpN9S4dmiuF02v0psj1
iXcvAn919vCdgzDIdhl1vjOTiAr+R8zwLErElltvM4Ewiz9osIb1F/dPA5B5lRWC
dfJM8r++AiUeX5qCqvqGCwfslsPeYqZEaNi09bhLH5DEnn1rxEU3C4rMDh1c4qfV
iusLBtenBCKtv9TqYkhga55j9633JcdoKuxG9ZQDY1ha6gPYu+U2NwlDk1H2qn/B
MGtVgcS94BrI4Rar3bJE8hy+pkBrHQofgHq8MB2l7bVAsFmZ4mv41T3pnvzESXzK
9K6YdtsrfggHoqcpwpGWkK2s7jsuuPovx+2xCPtOU5N1TDzCEXdYhqIL42GS1v4I
j3xT41KGJ4EpouUAANZbJDoS6fdCL4HJbhsxqcBAl2pdBdUnMHAu8opvDMVKzb0Q
7ZPLh34PHqpZ8fqEttiR5/mrTEhvBmu0u6ylpOsos4jVeqlo1aGtNXPzA9s/WJ0P
8Y/PCxjJAw+mXnA5DeWuWVrXjY7Ysh+LMNGsebQnB2Xui0GQ/4jSWXifnzscDxk5
siQ3koXIFjDbg6tjQWq2
=B173
-----END PGP SIGNATURE-----

--Sig_/N/iYxWi5DS+fjA4wfFmH=97--
