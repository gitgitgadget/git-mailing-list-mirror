From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Re: Managing submodules on large multi-user projects
Date: Fri, 29 May 2009 13:09:29 -0700
Message-ID: <20090529200928.GH11222@starfruit.corp.slide.com>
References: <20090529184125.GE11222@starfruit.corp.slide.com> <32541b130905291253k3fa1d675yde1dddb5e8090ef9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nhYGnrYv1PEJ5gA2"
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 29 22:10:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA8PA-0007L8-B1
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 22:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760774AbZE2UKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 16:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758466AbZE2UKG
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 16:10:06 -0400
Received: from mx0.slide.com ([208.76.68.7]:58985 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756665AbZE2UKF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 16:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Date:From:To:Subject:Message-ID; bh=i
	N8gfR6jlYzhTogh6pXi3jiiS3kyob6+JvGEIrQPHHI=; b=rfpK1d8OHNP04VL05
	IsCh3b2RAt9diaOphIZIj37e8CEQjuffGNtKPia4Izkfo5IDzf/4/2GuwazI3nBO
	4Fo1NiRoA2l9ldluRvvI8nCFysXVYzyO66OhxMey7x26gdWxQTR8PyxJLxjAOSra
	B/qGyv8M8jIy5GLfyB52VmawDE=
Received: from nat3.slide.com ([208.76.69.126]:59310 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1MA8P0-0002SU-AA; Fri, 29 May 2009 13:10:06 -0700
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id 49337A6F0002;
	Fri, 29 May 2009 13:10:06 -0700 (PDT)
X-Virus-Scanned: amavisd-new at calculon.corp.slide.com
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Og1-kw6Jeq8; Fri, 29 May 2009 13:10:06 -0700 (PDT)
Received: from starfruit.corp.slide.com (starfruit.corp.slide.com [10.10.10.45])
	by calculon.corp.slide.com (Postfix) with ESMTP id 0DBA9A6F0001;
	Fri, 29 May 2009 13:10:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <32541b130905291253k3fa1d675yde1dddb5e8090ef9@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120309>


--nhYGnrYv1PEJ5gA2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2009 at 03:53:26PM -0400, Avery Pennarun wrote:
> On Fri, May 29, 2009 at 2:41 PM, R. Tyler Ballance <tyler@slide.com> wrot=
e:
> > As some of you may recall from my last swath of emails to the list
> > regarding memory usage and repository size, we have quite a large
> > repository. About a month ago, I added a submodule to the primary repo
> > in an effort to start to segment where possible, particularly around
> > third party modules.
> >
> > I've noticed that keeping submodules updated is an absolute pain,
> > particularly with a large multiuser setup with *lots* of branches.
>=20
> Just so I understand, is the reason you're splitting into submodules
> *just* to avoid memory usage / repository size issues?  I can sort of
> understand the memory usage issues - sort of - but how does it reduce
> repository size if you need to need to check out all the submodule
> repositories along with the main project anyway?

I've got an eye on submodules as a way of avoiding the need to require a
whole tree clone to just work on parts of it, but that's not really
relevant to my query, just explaining our environment and setting the stage=
 ;)

We're using submodules right now similar to how we used svn externals in
the past (except better, clearly), to incorporate outside components
(like open source projects) that our stack depends on.

> Just looking to clarify for myself.  (I'm continuing my work on
> git-subtree, which is getting more and more positive feedback.  It
> solves all the *other* problems that you listed vs. submodules, but it
> certainly doesn't resolve any repository size issues.)

Good to know, we're still on Git 1.6.1, are there any benefits or
additional features in more recent releases of Git that help alleviate
the submodules issues I outlined at the top of the thread?


Cheers
--=20
-R. Tyler Ballance
Slide, Inc.

--nhYGnrYv1PEJ5gA2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkogQPgACgkQFCbH3D9R4W9wjwCcCEjg/yJz3fQe9HPZK4NfKRgX
ZMAAoIJXP7blzFc6oEETQR1R3403rp3Y
=VHL3
-----END PGP SIGNATURE-----

--nhYGnrYv1PEJ5gA2--
