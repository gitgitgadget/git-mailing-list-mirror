From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Tue, 7 Jan 2014 11:45:03 -0800
Message-ID: <20140107194503.GA26583@odin.tremily.us>
References: <20140105212458.GG3156@odin.tremily.us>
 <20140105225733.GB4660@book.hvoigt.net>
 <20140105233943.GJ3156@odin.tremily.us>
 <20140106003314.GL3156@odin.tremily.us>
 <20140106011255.GM3156@odin.tremily.us>
 <20140106160202.GE27265@t2784.greatnet.de>
 <CALas-ijXQFcUHWk-jJrLifqsMHAKo6NNKya+jR6RJGGDXY76hg@mail.gmail.com>
 <CALas-ijNgaTQr77DZw3acypgaJHpDFVnGdq97ECM4zu+CPma0w@mail.gmail.com>
 <xmqqd2k3ejfr.fsf@gitster.dls.corp.google.com>
 <CALas-ihPmJSf9eH0P7Vf28pB4zN_dsa_2=fe+_moZgiP0C3UTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, Git <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Francesco Pretto <ceztko@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 20:45:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0caX-0006mF-Dp
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 20:45:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952AbaAGTpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 14:45:13 -0500
Received: from qmta12.westchester.pa.mail.comcast.net ([76.96.59.227]:38986
	"EHLO qmta12.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752610AbaAGTpH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jan 2014 14:45:07 -0500
Received: from omta13.westchester.pa.mail.comcast.net ([76.96.62.52])
	by qmta12.westchester.pa.mail.comcast.net with comcast
	id B0Ym1n00217dt5G5C7l6wJ; Tue, 07 Jan 2014 19:45:06 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta13.westchester.pa.mail.comcast.net with comcast
	id B7l51n006152l3L3Z7l5dv; Tue, 07 Jan 2014 19:45:06 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id CFC29EA9860; Tue,  7 Jan 2014 11:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389123903; bh=2gfjPKdeiMN1J6wa3zc7TI4ZZZxw1YWa1qIv2wdR2nY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ya/HeRAHWoC1jd1tp7R4bNK6aWde2bdJ4eQXcOTH3YddptIfPEG9625B7M3UBoud1
	 eoZwFkkrRNjErRCEqYGj8uBBwdcaub4lxanbBb76A2euWRTdN6pdaohmCj0ctPIzZ5
	 y5DW//DyIn35qolHpHXy4oaniSmvEVBIXbrOhp7k=
Content-Disposition: inline
In-Reply-To: <CALas-ihPmJSf9eH0P7Vf28pB4zN_dsa_2=fe+_moZgiP0C3UTA@mail.gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389123906;
	bh=on1FKMhVk7LpaXWieg8x98Xmfce6BepIsDX5n6a8Bzw=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=puZVlFMzBt/tsd/70eHHga90T7KWDrEFop4CFHNjFGc+QraGaGF9MDRr8uT8ugfws
	 9g8Mi3uw12X76582ZoDVKUa5z3NKsLc/j6vZHrbtRqsgqxONMen8e5hRtebYOaA/RM
	 c0MxzmWZqrEWamb7I+FObVwGg0oP5ntZzj8xuTNMlSGdbS2fafzMN+Ut4gYQ8Il1YY
	 nKlJ4lHT2KIlCRxfvEnPWp6QjM9dc3vkFyrd3ToX3UEl+7upmwbpGsRDN3xWQRKRPR
	 Cuqh2me9xqxCAZ5jO4p2OEHdy4/97xkm5/kyADgvOY/vD1afk+0+tClhxgElH3Cc5X
	 enPtNubbUwj2A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240137>


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2014 at 08:19:49PM +0100, Francesco Pretto wrote:
> 2014/1/7 Junio C Hamano <gitster@pobox.com>:
> > It is not immediately obvious to me why anybody who specifies the
> > submodule.*.branch variable to say "I want _that_ branch" not to
> > want to be on that branch but in a detached state, so from that
> > perspective, submodule.*.attach feels superfluous.
>=20
> Junio, for what it concerns me I fully support this patch as, IMO, it
> makes cleaner the role of the property "submodule.<name>.branch".

No, submodule.<name>.branch is the name of the remote-tracking branch
for 'update --remote'.  In this patch, I'm using it as a hint for the
preferred local branch name [1], which I now think was a bad idea.
After [2], I think that we should just define the preferred local
branch name explicitly (submodule.<name>.local-branch?).

Cheers,
Trevor

[1]: http://article.gmane.org/gmane.comp.version-control.git/239980
[2]: http://article.gmane.org/gmane.comp.version-control.git/240097

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzFk9AAoJEKKfehoaNkbtPJcQAKcgX5H7grEOjuKH7ixRpJej
UBijssVcopqDbwvSDAiwN0NLcoWakMWbJjTtwIoEw6sLaUqacviU8ABPWIQZx73Y
hit6SphiDiamr194EzYZf9HMGBK+dVGuiPQ3ZpsopsO9msCEZ/BCYB2UCPy+iCQ9
qp8Ai3qM3UM/pobJgmjZTTA23tveMQ+Mp7nNDjvjhRgdLPJtSmqfXRbKRe0v9Iq9
RNTez9h4MvWnse/uwyhivye2p4SSMFAsLFehxokAWiFZBgOwVAUp74cuzSOSpdwL
8fhlQYBX+Emm7AWxuzi8nHDvkFW7yYwE2XRkddgBVz6hc2RqHsBs4a2LhCdlOvqU
/yQQ/zkz4LdO7NMYqIBgSFeS8Ssr8sH3Xgkpi5bQ3lZ1CdGz0+BdEMNc27zZLLgQ
vi9rRv3XUXB4i6AXNxCAdrUL6qIBGtxchct0RMfwn12uBaKR/daWVRlfsMdUoiCK
xc6IMQMCrshcsIobHOjDureCRiwS9mtVr0/9TuKhOK34CW0rrfglpwltrj4+at57
A1eyHq2d0zcYkYqC7xn0tMjh/NRABBmNjao0j2G5tKK3BUKvBmNt4N062fMWPIVz
b/3cGqwikVuFIJtZqo8xOz/aKBFeRZBC2PhyCBoD2xW8Qw7U9/SmIr446rC9zH3W
FJW0xY21GWZdCPkX8yiU
=9rxn
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
