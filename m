From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Re: Forcing --no-ff on pull
Date: Tue, 09 Dec 2008 02:45:57 -0800
Organization: Slide, Inc.
Message-ID: <1228819557.18611.80.camel@starfruit.local>
References: <1228815240.18611.48.camel@starfruit.local>
	 <8c5c35580812090149lc6dd79cj60a9d23c18089557@mail.gmail.com>
	 <1228817565.18611.54.camel@starfruit.local>
	 <8c5c35580812090231u28076844nf5a9225349c20801@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6NdBLkAdnepR0qGe3f7d"
Cc: git@vger.kernel.org
To: Lars Hjemli <lh@elementstorage.no>
X-From: git-owner@vger.kernel.org Tue Dec 09 11:47:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LA07b-0002zY-2T
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 11:47:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796AbYLIKqB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 05:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752790AbYLIKqB
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 05:46:01 -0500
Received: from mx0.slide.com ([208.76.68.7]:33435 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752763AbYLIKqA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 05:46:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Subject:From:To:Date:Message-Id; bh=y
	T0B1xK8jh62XU7zktJWTVxjdBae8cmGDiYuzuKJ1dA=; b=MjtjFIFfCrbYSHQDj
	JosbVSQkeG9P+gkulh+bi65/qmiAYcunA7gH8EYR0dUG7/5qQImEd+g03h/ABvas
	WTwCbYfilrAVHxVYECMiSN6QayhdxRCTqBObZ/plY91ZFl02rXMa/VrErpZBt0HS
	pEyq/Fu8Y0H52Umz35LfXmVQzs=
Received: from nat3.slide.com ([208.76.69.126]:59329 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1LA06J-0005sl-Kj; Tue, 09 Dec 2008 02:45:59 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id 92C7BA6F0002;
	Tue,  9 Dec 2008 02:45:59 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.47
X-Spam-Level: 
X-Spam-Status: No, score=-2.47 tagged_above=-10 required=6.6 tests=[AWL=0.030,
	BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F3ekvOugqmIH; Tue,  9 Dec 2008 02:45:59 -0800 (PST)
Received: from [10.12.0.194] (unknown [10.12.0.194])
	by calculon.corp.slide.com (Postfix) with ESMTP id 50AA2A6F0001;
	Tue,  9 Dec 2008 02:45:59 -0800 (PST)
In-Reply-To: <8c5c35580812090231u28076844nf5a9225349c20801@mail.gmail.com>
X-Mailer: Evolution 2.22.1.1 
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102625>


--=-6NdBLkAdnepR0qGe3f7d
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-12-09 at 11:31 +0100, Lars Hjemli wrote:
> On Tue, Dec 9, 2008 at 11:12, R. Tyler Ballance <tyler@slide.com> wrote:
> > On Tue, 2008-12-09 at 10:49 +0100, Lars Hjemli wrote:
> >> On Tue, Dec 9, 2008 at 10:34, R. Tyler Ballance <tyler@slide.com> wrot=
e:
> >> > Is there a header macro I can define or a config option I could defi=
ne
> >> > to make --no-ff on `git pull` implicit instead of explicit?
> >>
> >> Try this:
> >> $ git config branch.stable.mergeoptions "--no-ff"
> >
> > I recall stumbling across this a while ago looking at the git-config(1)
> > man page, but this isn't /quite/ what we need.
> >
> > I'm talking about forcing for *every* pull, it's a safe assumption to
> > make that we want a merge commit every time somebody fast-forwards a
> > branch.
>=20
> $ git config alias.xpull "pull --no-ff" ?

Interesting, I might have to try that out (wasn't aware of `git config
alias.<alias>`)

>=20
> But are you sure you never want a fast-forward on _any_ branch? I use
> --no-ff unconditionally on the master and stable branches as $dayjob,
> to make sure that the merging of feature/bugfix-branches are
> explicitly noted in history, but I almost never use it on other
> branches.

I understand this, it's a funny situation. When we were evaluating Git
my team *never* had these issues because we all kept our trees in good
condition such that we never accidentally merged down to a stable
branch, but we also almost always generated merge commits because of the
variety of changes that would be going into stable at any given time.

I agree that I wouldn't want/need to use it on WIP branches or purely
local branches for development, so if I were able to restrict --no-ff to
only be forced on tracked branches I would be happy enough :)

Really hate to take this much bandwidth up on the mailing list over such
a silly problem, but after spending a week trying to /talk/ and educate
some folks, I feel drastic measures need to be taken ;)

Cheers=20
--=20
-R. Tyler Ballance
Slide, Inc.

--=-6NdBLkAdnepR0qGe3f7d
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkk+TGUACgkQFCbH3D9R4W/9agCglHeK1x3634O+kdevKPTL/ek1
AksAn2v1+YRVHCKt1DjDRIhMb59vCeCw
=6evl
-----END PGP SIGNATURE-----

--=-6NdBLkAdnepR0qGe3f7d--
