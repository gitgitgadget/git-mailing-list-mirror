From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Re: [PATCH/RFC] Allow writing loose objects that are corrupted in
 a pack file
Date: Tue, 06 Jan 2009 18:47:55 -0800
Organization: Slide, Inc.
Message-ID: <1231296475.8870.89.camel@starfruit>
References: <20081209093627.77039a1f@perceptron>
	 <1231282320.8870.52.camel@starfruit>
	 <alpine.LFD.2.00.0901062005290.26118@xanadu.home>
	 <1231292360.8870.61.camel@starfruit>
	 <alpine.LFD.2.00.0901062059230.26118@xanadu.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-+pzsm9trJF0BDIyFVs+p"
Cc: Jan =?ISO-8859-1?Q?Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Jan 07 03:49:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKOUL-00007s-NA
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 03:49:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759786AbZAGCsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 21:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759871AbZAGCsD
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 21:48:03 -0500
Received: from mx0.slide.com ([208.76.68.7]:42569 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755276AbZAGCsB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 21:48:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Subject:From:To:Date:Message-Id; bh=W
	W3dSjsmmYZO0WUD8ABoa+t2MCdinpqqOt/xwpJGHqk=; b=oft2/0nLV2NYi/4nE
	QiT6WgT4QQcD8cMmcFUuwyE99sF/nM+X4PBbzNhJQ0OJxSBI2FzKmLgO3PDoYpr8
	Wu7FYYLw2EVavkQh573Bj16VVwH0RvFon2W4vrJXsWhqZpj4P4jVUtMQPBTBRHee
	WhaMwAeTmOIwBfMXlzIc87MylI=
Received: from nat3.slide.com ([208.76.69.126]:41301 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1LKOSZ-0005Dx-Rt; Tue, 06 Jan 2009 18:47:55 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id CD965A6F0002;
	Tue,  6 Jan 2009 18:47:55 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.536
X-Spam-Level: 
X-Spam-Status: No, score=-2.536 tagged_above=-10 required=6.6
	tests=[AWL=-0.037, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Deo1UG5onNXJ; Tue,  6 Jan 2009 18:47:55 -0800 (PST)
Received: from [10.12.0.194] (unknown [10.12.0.194])
	by calculon.corp.slide.com (Postfix) with ESMTP id 7DDD0A6F0001;
	Tue,  6 Jan 2009 18:47:55 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0901062059230.26118@xanadu.home>
X-Mailer: Evolution 2.24.1.1 
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104747>


--=-+pzsm9trJF0BDIyFVs+p
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-01-06 at 21:09 -0500, Nicolas Pitre wrote:
> > I've tarred one of the repositories that had it in a reproducible
> state
>=20
> That is wonderful.
>=20
> > so I can create a build and extract the tar and run against that to
> > verify any patches anybody might have, but unfortunately at 7GB of
> > company code and assets, I can't exactly share ;)
>=20
> First step is to understand what is going on.  Only then could reliable=20
> patches be made.

If you want to point me in the right direction, I have a few hours to
kill this evening and fscking around with gdb(1) and printf() just might
be some of my favorite things</sarcasm> ;)

Looking forward to killing this issue


Cheers

--=20
-R. Tyler Ballance
Slide, Inc.

--=-+pzsm9trJF0BDIyFVs+p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklkF9sACgkQFCbH3D9R4W80UQCgtWK7QEbHP5JjxGbsJhKH3L1Y
PMAAnR/6P4aLkyFbP8Z9P+Eusp7FTbcm
=Evue
-----END PGP SIGNATURE-----

--=-+pzsm9trJF0BDIyFVs+p--
