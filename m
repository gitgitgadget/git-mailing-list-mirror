From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Re: [PATCH/RFC] Allow writing loose objects that are corrupted in
 a pack file
Date: Wed, 07 Jan 2009 17:06:42 -0800
Organization: Slide, Inc.
Message-ID: <1231376802.8870.635.camel@starfruit>
References: <20081209093627.77039a1f@perceptron>
	 <1231282320.8870.52.camel@starfruit>
	 <alpine.LFD.2.00.0901062005290.26118@xanadu.home>
	 <1231292360.8870.61.camel@starfruit>
	 <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain>
	 <1231314099.8870.415.camel@starfruit>
	 <alpine.LFD.2.00.0901070743070.3057@localhost.localdomain>
	 <1231368935.8870.584.camel@starfruit>
	 <alpine.LFD.2.00.0901071520330.3057@localhost.localdomain>
	 <alpine.LFD.2.00.0901071621340.3283@localhost.localdomain>
	 <1231375780.8870.629.camel@starfruit>
	 <alpine.LFD.2.00.0901071652490.3283@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-bTojaKTihSI3/0i3dEqY"
Cc: Nicolas Pitre <nico@cam.org>,
	Jan =?ISO-8859-1?Q?Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 08 02:08:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKjNi-0005cS-KG
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 02:08:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753507AbZAHBGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 20:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753133AbZAHBGv
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 20:06:51 -0500
Received: from mx0.slide.com ([208.76.68.7]:49623 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752919AbZAHBGu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 20:06:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Subject:From:To:Date:Message-Id; bh=T
	UW8cH1M60+3ldxo9UO0+GHLoztTfC0NJZLkXTMrF10=; b=z2VXIyzAL8VrrSt+d
	9gM/SwvcaI9aaRIKTgEalG9R59rN98hr+zNEQGTbS7BqlAmySf98VKJufpA3sAEF
	TQgOCyVUszAbZqIT16SBUGWF/D33M3JphRnTIEdKvli7Tk71OrN3Q4Ec1D7ICBGn
	tgQEh1VNT+NdRpgzPQcXFlKOt4=
Received: from nat3.slide.com ([208.76.69.126]:38774 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1LKjMB-0006SY-FX; Wed, 07 Jan 2009 17:06:43 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id 727BF3898B8A;
	Wed,  7 Jan 2009 17:06:43 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.889
X-Spam-Level: 
X-Spam-Status: No, score=-2.889 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.114, BAYES_00=-2.599,
	MIME_QP_LONG_LINE=1.396]
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id trRiS0gL1e5Y; Wed,  7 Jan 2009 17:06:43 -0800 (PST)
Received: from [10.10.8.190] (dhcp-10-10-8-190.corp.slide.com [10.10.8.190])
	by calculon.corp.slide.com (Postfix) with ESMTP id 49A1C3898567;
	Wed,  7 Jan 2009 17:06:43 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0901071652490.3283@localhost.localdomain>
X-Mailer: Evolution 2.24.1.1 
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104865>


--=-bTojaKTihSI3/0i3dEqY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-01-07 at 17:01 -0800, Linus Torvalds wrote:
>=20
> On Wed, 7 Jan 2009, R. Tyler Ballance wrote:
> >=20
> > I was only mentioning OS X with regards to the Samba/NFS red herring,
> > the rest of our operations are on 64-bit Linux machines.
>=20
> Ahh, ok. Good.=20
>=20
> > > I could easily see that if you have a virtual memory size limit of 1.=
5GB,=20
> > > and the pack window size is 1GB, we might have trouble. Because we co=
uld=20
> > > only keep one such pack window in memory at a time.
> >=20
> > The DEFAULT_PACKED_GIT_WINDOW_SIZE in our local builds is 256M, FWIW
>=20
> Interesting. So you already had to lower it. However, now that you mentio=
n=20
> it, and now that I search for your emails about it on the mailing list (I=
=20
> don't normally read the mailing list except very occasionally), I see you=
r=20
> patch that does
>=20
> 	#define DYNAMIC_WINDOW_SIZE_PERCENTAGE 0.85
> 	...
> 	packed_git_window_size =3D (unsigned int)(as->rlim_cur * DYNAMIC_WINDOW_=
SIZE_PERCENTAGE);
>=20
> which is actually very bad.
>=20
> It's bad for several reasons:
>=20
>  - 85% of the virtual address space is actually pessimal.
>=20
>    You need space for AT LEAST two full-sized windows, so you need less=20
>    than 50%.
>=20
>  - the way that variable is used, it _has_ to be a multiple of the page=20
>    size. In fact, it needs to be a multiple of _twice_ the page size. So=20
>    just doing a random fraction of the rlimit is not correct.

This patch never made it into any of our Git builds because my flight
landed and it wasn't stable enough (and as you pointed out, it sucks ;))



>=20
> Setting it in the .gitconfig does it right, though.
>=20
> > > If so, then adding a
> > >=20
> > > 	[core]
> > > 		packedgitwindowsize =3D 64M
> > >=20
> > > might make a difference. It would certainly be very interesting to he=
ar if=20
> > > there's any impact.
> >=20
> > I can try this still if you'd like, but it doesn't seem like that'd be
> > the issue since we're already lowering the window size system-wide
>=20
> Please do try, at least if your local git changes still match that patch =
I=20
> found, because that patch generates problems.

See my prior reply in "Public repo case!" sent at 4:57PST

--=20
-R. Tyler Ballance
Slide, Inc.

--=-bTojaKTihSI3/0i3dEqY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkllUaIACgkQFCbH3D9R4W+zXACfcve9H3a1rTT1ZKgHfoZhGOll
ZZ8AnjG8+anRUkTMUfvPRAih70c5Qu9Q
=Ilxw
-----END PGP SIGNATURE-----

--=-bTojaKTihSI3/0i3dEqY--
