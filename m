From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Re: [PATCH/RFC] Allow writing loose objects that are corrupted in
 a pack file
Date: Wed, 07 Jan 2009 00:32:11 -0800
Organization: Slide, Inc.
Message-ID: <1231317131.8870.471.camel@starfruit>
References: <20081209093627.77039a1f@perceptron>
	 <1231282320.8870.52.camel@starfruit>
	 <alpine.LFD.2.00.0901062005290.26118@xanadu.home>
	 <1231292360.8870.61.camel@starfruit>
	 <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain>
	 <1231314099.8870.415.camel@starfruit>
	 <7vaba3bken.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-OEBgP7wLjUCiSDTs369N"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@cam.org>,
	Jan =?ISO-8859-1?Q?Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 09:33:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKTrE-00057Z-BR
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 09:33:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312AbZAGIcU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 03:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752211AbZAGIcT
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 03:32:19 -0500
Received: from mx0.slide.com ([208.76.68.7]:55062 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751856AbZAGIcT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 03:32:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Subject:From:To:Date:Message-Id; bh=P
	fXW/KGqpxst2kiktIulNEPSKKGivDUdyNm9atr94t4=; b=URiBLYNRzqd0Fh4xT
	I453vrEQRbnZySmDrCW5HQxvvTNfOU7gy0SR/dyK50FjKzUZvtjQaN0IlffLQQfG
	YFPPjEgy+NghnBRqrckwZkWV1x3U4syhavvJABBonJbaWiid5Ha+TkkklVJp47Vm
	lfITOeAPBoWl+XiL0ODdyaT8w4=
Received: from nat3.slide.com ([208.76.69.126]:60571 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1LKTpk-0006W7-CA; Wed, 07 Jan 2009 00:32:12 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id 5749AA6F0002;
	Wed,  7 Jan 2009 00:32:12 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.562
X-Spam-Level: 
X-Spam-Status: No, score=-2.562 tagged_above=-10 required=6.6
	tests=[AWL=-0.063, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B36KEo+rSadO; Wed,  7 Jan 2009 00:32:12 -0800 (PST)
Received: from [10.12.0.194] (unknown [10.12.0.194])
	by calculon.corp.slide.com (Postfix) with ESMTP id 06CEDA6F0001;
	Wed,  7 Jan 2009 00:32:12 -0800 (PST)
In-Reply-To: <7vaba3bken.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.24.1.1 
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104775>


--=-OEBgP7wLjUCiSDTs369N
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-01-07 at 00:16 -0800, Junio C Hamano wrote:
> "R. Tyler Ballance" <tyler@slide.com> writes:
>=20
> > Unfortunately it doesn't, what I did notice was this when I did a `git
> > status` in the directory right after untarring:
> >         tyler@grapefruit:~/jburgess_main> git status
> >         #
> >         # ---impressive amount of file names fly by---
> >         # ----snip---
> > ...
> > Basically, somehow Git thinks that *every* file in the repository is
> > deleted at this point.
>=20
> That makes me suspect that your .git/index file is corrupt.

Would this be tied to the corrupted pack file issue, or separate.

Either way, how could I verify your assumptions? (i'll be lurking in
#git for a while if you want to interactively help ;))

Cheers
--=20
-R. Tyler Ballance
Slide, Inc.

--=-OEBgP7wLjUCiSDTs369N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklkaIsACgkQFCbH3D9R4W+HxACfTomorVmPpxtxAhDLH6xCmaOs
S3YAoKgBAGXMF3Z7caKp27YDbQxInnop
=sASa
-----END PGP SIGNATURE-----

--=-OEBgP7wLjUCiSDTs369N--
