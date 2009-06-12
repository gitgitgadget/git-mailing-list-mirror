From: Todd Zullinger <tmz@pobox.com>
Subject: Re: [bug] git cannot find "git pull"?
Date: Fri, 12 Jun 2009 16:26:42 -0400
Message-ID: <20090612202642.GI5076@inocybe.localdomain>
References: <4A319CE1.6040201@garzik.org>
 <20090612011737.GB5076@inocybe.localdomain> <4A323C56.1090703@garzik.org>
 <4A32A814.5050802@garzik.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="4LwthZj+AV2mq5CX"
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Fri Jun 12 22:26:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFDKy-0005ot-FV
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 22:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755511AbZFLU0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 16:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755197AbZFLU0p
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 16:26:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37692 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbZFLU0o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 16:26:44 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6F83DB9D42;
	Fri, 12 Jun 2009 16:26:46 -0400 (EDT)
Received: from inocybe.localdomain (unknown [173.67.155.244]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6E262B9D3F; Fri,
 12 Jun 2009 16:26:43 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4A32A814.5050802@garzik.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Pobox-Relay-ID: 59AE8380-578F-11DE-BAAF-97731A10BFE7-09356542!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121447>


--4LwthZj+AV2mq5CX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jeff Garzik wrote:
> Jeff Garzik wrote:
>> No strange PATH settings, and this was a completely fresh
>> Fedora-11/x86-64 reformat and reinstall...
>>
>> Adding "--exec-path=3D/usr/libexec/git-core" seems to work.
>>
>> I wonder if it is looking for /usr/libexec64/git-core or something?
>
> Same failure (with same workaround) on Fedora 11/i386, fresh
> install.

Well hell.  I can't reproduce this.  I setup an F-11/x86_64 instance
and had no troubles.  Similarly for i386 using the Live USB image.

Is it possible that some other package is screwing up the git search
path?  Running strings on /usr/bin/git I find libexec/git-core, so I
don't think it's trying libexec64, which doesn't exist in an Fedora
release that I know of.

I'd be very curious if anyone else can reproduce this and what
differences there are in the package list between my working system
and your broken ones.

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Education is a state-controlled manufactory of echoes.
    -- Norman Douglas


--4LwthZj+AV2mq5CX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBCAAtBQJKMrn8JhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzjwcsIAJsfRnrWqdK8YY7nwL4wIccwigMuEMcQkn95
JMmXSDmrQ24YMFp11YwhqUx8R+6ahlGF/1bfi8XdC+FiMqsL7yhgOe4OyJpHEJwR
ep7DmykJkCQigUdhboLaoY5dSh7BhNfUy5ggiZNfo2399VF4RMyxWVagANHD4b8j
9cLgSoKmWrBpy2ojKqCSS3r3iMJFCAtvHFFh0LLAAlnk092nAb2xwNB63x45ZQid
rON3U63NHdRX8J39PzBt5vDtggE9pLDH0eDA39WIiTGJa+pvcEvFzWvGbaUvafFf
e1E3/J+rPnT7TtaPbI0quATlbo9AZIzna68kxU6gybQY7/Zgceg=
=agLC
-----END PGP SIGNATURE-----

--4LwthZj+AV2mq5CX--
