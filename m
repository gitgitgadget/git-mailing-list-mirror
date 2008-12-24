From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Re: Git with Hudson
Date: Wed, 24 Dec 2008 14:59:25 -0600
Organization: Slide, Inc.
Message-ID: <1230152365.14882.48.camel@starfruit>
References: <D2F0F023-862A-4BAB-88B9-BFEFC5592D10@strakersoftware.com>
	 <20081218160734.b1992eb8.stephen@exigencecorp.com>
	 <c115fd3c0812181758m5fe4af95s860181d25f1992ee@mail.gmail.com>
	 <20081222210018.f21d9e07.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-1ZkZwHWPK4/kuZNpKjMM"
Cc: Tim Visher <tim.visher@gmail.com>,
	Indy Nagpal <indy@strakersoftware.com>, git@vger.kernel.org
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Wed Dec 24 22:00:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFaqZ-00049p-55
	for gcvg-git-2@gmane.org; Wed, 24 Dec 2008 22:00:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbYLXU7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2008 15:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbYLXU7c
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Dec 2008 15:59:32 -0500
Received: from mx0.slide.com ([208.76.68.7]:38045 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952AbYLXU7b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2008 15:59:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Subject:From:To:Date:Message-Id; bh=p
	AFUdOZLeci8qc+0rE+3rjapmmWtv2ZxPi2q1O/MlL4=; b=XD/92l4tejHxONt2H
	guie3xt2I7VS5IHrs5BsAeKwDidwXd6GMf6EU0h24sg6hIGdvHHMerlwHRk15YZd
	71J9Z4J6kgYr2dbSFJ3luclNlvSV9GaGgKh89OBn4CekzhE6VDWXOz+pfUszV8e+
	BxhzZJ/PtyNtz4aJYcWCkqUYzc=
Received: from nat3.slide.com ([208.76.69.126]:38252 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1LFapF-0004DC-0O; Wed, 24 Dec 2008 12:59:29 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id EA7EEA6F0002;
	Wed, 24 Dec 2008 12:59:28 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rJiwobo18XxM; Wed, 24 Dec 2008 12:59:28 -0800 (PST)
Received: from [10.12.0.194] (unknown [10.12.0.194])
	by calculon.corp.slide.com (Postfix) with ESMTP id 37E39A6F0001;
	Wed, 24 Dec 2008 12:59:28 -0800 (PST)
In-Reply-To: <20081222210018.f21d9e07.stephen@exigencecorp.com>
X-Mailer: Evolution 2.24.1.1 
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103863>


--=-1ZkZwHWPK4/kuZNpKjMM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-12-22 at 21:00 -0600, Stephen Haberman wrote:
> > I'm interested!  Please publish away!
>=20
> Here's the "git2" Hudson plugin that worked well for us:
>=20
> http://github.com/stephenh/hudson-git2
>=20
> There is a git.hpi file checked into the target directory so that you
> don't have to build it yourself.

I decided that I'd check this out, as the existing Git plugin chokes on
our git-rev-list(1) on our enormous Git repository.

Correct me if I'm wrong, but did you actually upload or check in the
target/ directory? Your .markdown references target/git.hpi as well, but
I can't seem to find it :-/


Cheers
--=20
-R. Tyler Ballance
Slide, Inc.

--=-1ZkZwHWPK4/kuZNpKjMM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklSoq0ACgkQFCbH3D9R4W9OeQCfaeMw6x70YEdHVgMxT2bnrN0J
ZPUAoIKxV+epTfKh6DpYvOKhYnz6LieM
=aC7V
-----END PGP SIGNATURE-----

--=-1ZkZwHWPK4/kuZNpKjMM--
