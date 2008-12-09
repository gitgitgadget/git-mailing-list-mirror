From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Re: is gitosis secure?
Date: Tue, 09 Dec 2008 01:07:00 -0800
Organization: Slide, Inc.
Message-ID: <1228813620.18611.41.camel@starfruit.local>
References: <200812090956.48613.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-QnNBY+5D04H8hMQ+twFt"
Cc: Git Mailing List <git@vger.kernel.org>, dabe@ymc.ch
To: Thomas Koch <thomas@koch.ro>
X-From: git-owner@vger.kernel.org Tue Dec 09 10:42:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9z6M-0000BP-Dv
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 10:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506AbYLIJkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 04:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752472AbYLIJkl
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 04:40:41 -0500
Received: from mx0.slide.com ([208.76.68.7]:48498 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752462AbYLIJkk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 04:40:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Subject:From:To:Date:Message-Id; bh=W
	BghCapDvAnI3fBwjy5XTPjgYVGFnhycd1IN9v+XMDY=; b=b/F7zamVjuJ03lWX2
	rYaULsn0Fg0vnJxnG2EEIINS8AawFby1v68g3hfLrOYXH1nP9d/dolvF5VPmxPiu
	+PIffFZyuS0blwnkDPdvsKpNGYej4rqhFz6k1w+e9qSphS2NGUc0EmjEOrP/P9Ma
	dMDIxXgmkxIdmNFf5VOF99x8bM=
Received: from nat3.slide.com ([208.76.69.126]:46761 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1L9yYY-0003Ez-GG; Tue, 09 Dec 2008 01:07:02 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id 70687A6F0002;
	Tue,  9 Dec 2008 01:07:02 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.153
X-Spam-Level: 
X-Spam-Status: No, score=-3.153 tagged_above=-10 required=6.6
	tests=[AWL=-0.654, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6GXPEXPXwHbX; Tue,  9 Dec 2008 01:07:02 -0800 (PST)
Received: from [10.12.0.194] (unknown [10.12.0.194])
	by calculon.corp.slide.com (Postfix) with ESMTP id 2CB00A6F0001;
	Tue,  9 Dec 2008 01:07:02 -0800 (PST)
In-Reply-To: <200812090956.48613.thomas@koch.ro>
X-Mailer: Evolution 2.22.1.1 
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102613>


--=-QnNBY+5D04H8hMQ+twFt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-12-09 at 09:56 +0100, Thomas Koch wrote:
> Sorry for the shameless subject, but I presented gitosis yesterday to
> our sysadmin and he wasn't much delighted to learn, that write access to
> repositories hosted with gitosis would need SSH access.

Accounts set up with keys for Gitosis are given restricted accounts
(from my understanding similar to how CVS or SVN operate over SSH
tunnels).=20

The sysadmins here at Slide also had similar frustrations/concerns about
using Gitosis, but we were able to convince them that keys were a far
better solution than keyboard-interactive login sessions over HTTPS for
Subversion.

We're using gitosis with plenty of developers (coming up on 50) and
haven't had any issues with security (yet, crossed fingers). We even
have some accounts that are able to read but not write, i.e. they can
clone and pull, but not push back up to the central repository. YMMV.

>=20
> So could you help me out in this discussion, whether to use or not to
> use gitosis?=20
> Our admin would prefer to not open SSH at all outside our LAN, but
> developers would need to have write access also outside the office.

I recommend using VPN if the need to push/pull while outside of the
office (more fun solutions include SSH gateways that tunnel outside to
inside). Otherwise, why could they not simply commit locally, etc, and
then when they come into the office push/pull?

Cheers
--=20
-R. Tyler Ballance
Slide, Inc.

--=-QnNBY+5D04H8hMQ+twFt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkk+NTQACgkQFCbH3D9R4W+LVgCeP2M/Uc/3eIJTkDe+kIb8dMo9
SJQAoLbYMm5GJ8/7kzOW750QUuOMiSkh
=jY1Z
-----END PGP SIGNATURE-----

--=-QnNBY+5D04H8hMQ+twFt--
