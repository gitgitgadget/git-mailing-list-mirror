From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Re: [RFC PATCH] clone: add clone.recursesubmodules config
 option
Date: Thu, 5 Jun 2014 11:43:40 -0700
Message-ID: <20140605184340.GA31746@odin.tremily.us>
References: <xmqqoay9wvo6.fsf@gitster.dls.corp.google.com>
 <1401874256-13332-1-git-send-email-judge.packham@gmail.com>
 <xmqqvbsgvb9l.fsf@gitster.dls.corp.google.com>
 <538F6E52.9000009@web.de>
 <xmqq4mzzte2z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org,
	mara.kim@vanderbilt.edu, Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 21:20:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wscep-0001aq-67
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 20:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbaFESno (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 14:43:44 -0400
Received: from qmta07.westchester.pa.mail.comcast.net ([76.96.62.64]:35719
	"EHLO qmta07.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751799AbaFESnn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jun 2014 14:43:43 -0400
Received: from omta10.westchester.pa.mail.comcast.net ([76.96.62.28])
	by qmta07.westchester.pa.mail.comcast.net with comcast
	id AiVn1o0080cZkys57ijic6; Thu, 05 Jun 2014 18:43:42 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta10.westchester.pa.mail.comcast.net with comcast
	id Aijh1o004152l3L3WijhEb; Thu, 05 Jun 2014 18:43:42 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id B8E2E120A648; Thu,  5 Jun 2014 11:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1401993820; bh=jIQw4AXu6+DdyvFTrpevXBIpuqPVD6P85Isa6lI85Cg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I+lMeqMGCeclYqBJ+hIg6H0eZjDsV1nP/iGBaG4aANm6t/B553Z2cUgVxaSbH/3J5
	 C3T/ajj3nW3aSXmJ2FsLS8qIASWBIqGjDuXZLMLAW7zykeSXoMw9yB3XEzv9Ft3w1W
	 MjaeIZqDRQWfAlLe5MuxaZ8g53uvw/s1zdB9yrD0=
Content-Disposition: inline
In-Reply-To: <xmqq4mzzte2z.fsf@gitster.dls.corp.google.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1401993822;
	bh=pFrfl6/eYAq4ngVfc3w/K5Admkd1+lUumz6vBQzYFug=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=GIat8xaYzp0KGwrMYuH39yCoBVRWVHLfc+af2FgK5rEKFfBSJX8LkzJ9pfoYYxTs9
	 YqTo1g1A1o4UxqSuOtACmvZiYOZRH3lyAJ12QxnWaMSAJkkhTe0oxt5fYOhp2zoRRt
	 cxMtFROu9kNl9vBJJPNS/XLx6TkPXyZBYldyVmVSvRK+Weik0SEC9eXK4Ph8hg8NFO
	 2i003mDjWlqzbWNOcIfF90Taf/vkpRJt+9OHplUhGhNi9hn/gudWOMXQHZMcnL3lrm
	 arQYdvpmR12dm6nroCUGDesJhg3dhHMjt/vrx+6lElQ32U6i3CBbGZR+59C6vIUZuL
	 RO04Z57xKQMhA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250856>


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 05, 2014 at 11:18:28AM -0700, Junio C Hamano wrote:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> > We had two settings in mind,...
> > So what if clone would just do an "git submodule init" for now when
> > "submodule.autoinit" is set but "submodule.autoupdate" isn't [?]
> > ... and a single "submodule.auto" setting would be what users really wa=
nt?
>=20
> I do not offhand think of a sensible scenario where you want to init
> a submodule once but do not want to update it when the superproject
> changes.  Even if the user uses the mode to detach the submodule
> HEAD, i.e. the branches in submodules do not matter and the whole
> tree is described by the superproject's commit and gitlinks recorded
> in it, the user would want the new objects necessary for the updated
> superproject, which means a submodule that is init'ed (whether it is
> via "git submodule init" or the submodule.autoinit variable) must be
> updated.

I agreed that once we have the ability to do so, autoupdating any
initialized submodules should be automatic and non-optional.  However,
making it optional during a transition period while the ability gets
fleshed out would make sense too (so checkout-mode folks can opt in
before we clobber the local-branch folks ;).

Ceers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTkLpaAAoJEG8/JgBt8ol8zN8QAJMzSpY+mZ4PjCvDOf7vafgT
Vbqkcqf1A3GpIArvKx7R0zWURoD9jpKPu6lBiSkAGveLFvc8/vVav5BbiqBIkaMA
gQTu7NbMxOvUHCnzuzo6y1phOYz7cERN+QBAUkom9CiWFS0+vG9+7fH4qnr+TyIG
ubJGFjixvAnJx7Lo6ceIQvQpWUEkM4lT7Fz3JPS80ct74ePWSl0JwjZ7qoFdWaJL
M383F66Hk+f9KedOfpUIeT+ll7jFYmbzYxV72nG+zOv4LHdjjnRRKqFadf5dS9f5
2dVJ5tOXL1Se06gjkQZqIsSX2fNlev8o4wu4isGlm2n4hTLNJw0HOqh13wwtzE7L
8uxT5V9MScXKRGkwEgsaJ7OSqRjSzYxnSa6TC67WphxVPF9Mk2GXqbCl+DM0Pj8m
SBVipH9V497+RJI9ofAyGlVLDGLV6nWUVbVuqNbGxDfuecaAxYHSdTD1YD1/3lDY
OcMbJrrnsrhffKoeB/Na/UghMGSRToNudJcVhd+7CQAsRt18uzwejCXWZl/MRcXW
ZZTvqWII4+DbjkB1GrfkXETC/mtr7wBZTvezQlPfrvS4y/H3lE5kQLFa4jIPUwe0
WG3ZOc4uNhZuIY0gsqMP/hEyOxCc2TMq+5se2c7OSLw33C+SJsckmW2h7oewnkcH
Jc+tdOTgLWmaku+rBumN
=BueQ
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
