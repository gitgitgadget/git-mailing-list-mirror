From: Robert David <robert.david.public@gmail.com>
Subject: Re: GSOC idea: build in scripts and cleanups
Date: Sun, 17 Apr 2011 20:50:27 +0200
Organization: DDM Praha
Message-ID: <201104172050.28441.robert.david.public@gmail.com>
References: <201103260141.20798.robert.david.public@gmail.com> <201104040943.10030.robert.david.public@gmail.com> <20110411063444.GA6608@elie>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3213552.yI0Xur8P6q";
  protocol="application/pgp-signature";
  micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 20:50:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBX3b-0007gS-Ut
	for gcvg-git-2@lo.gmane.org; Sun, 17 Apr 2011 20:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528Ab1DQSug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2011 14:50:36 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35802 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753231Ab1DQSue (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2011 14:50:34 -0400
Received: by bwz15 with SMTP id 15so3296208bwz.19
        for <git@vger.kernel.org>; Sun, 17 Apr 2011 11:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:organization:to:subject:date:user-agent:cc
         :references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=RFVLeHrQ8rbWeICWxI6YuW0Y4VntJQI2EFDrfkJTz+4=;
        b=Ws9wR++qpQODx4610J6YPDDzxyzqTzD0fsF9zJTbMJwIIdQgmV1Dmc5BLhLEBYc7OS
         w+9a9bRHkISsSBQSZuT06QCLYEkXOKsz7IH4CYee8Z3aRzRO9Uk4fzbGTrLlflcc6FQi
         mf7CpVA4s0BnrotOxGjzUHJoDT0OoQSGCCPGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=AOIDpdFYLc5JrOqoK7JWZMWt7JPXkYD5Vxi78jTI10owJ2tppSbPg6xWzrD0GtDXK8
         WNJJwvaabSwazqGyY6a2w8jEIQWpNKmui5cDXQIOxlylp0jdg5rIUZy5qo9yEKEbMqdi
         PkYV+jhQBs4g1fDfhF3WqRvrcEjwLJSM5HiYM=
Received: by 10.204.26.200 with SMTP id f8mr1702800bkc.99.1303066232605;
        Sun, 17 Apr 2011 11:50:32 -0700 (PDT)
Received: from robert-eee.localnet (gate.chabry.cz [80.92.246.13])
        by mx.google.com with ESMTPS id b6sm2724852bkb.10.2011.04.17.11.50.29
        (version=SSLv3 cipher=OTHER);
        Sun, 17 Apr 2011 11:50:30 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-5-686; KDE/4.4.5; i686; ; )
In-Reply-To: <20110411063444.GA6608@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171727>

--nextPart3213552.yI0Xur8P6q
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Dne pond=C4=9Bl=C3=AD 11 dubna 2011 08:34:44 Jonathan Nieder napsal(a):
> Hi,
>=20
> Robert David wrote:
> > I'm sending copy of my proposal to ml.
>=20
> Thanks, and sorry for a slow response.

I'm also sorry for the late response, I was off for holiday now.

>=20
> Full disclosure: I locally use a patch[1] to teach a --patience option
> to add -p, checkout -p, etc (to use the "patience diff" algorithm).  I
> never submitted it since it wasn't clear to me how to integrate it
> (and other diff options) properly.  I will be very happy to see a
> cleaner add--interactive.
>=20
> So I'm a likely early consumer of your code, although I don't think
> I'll have time to co-mentor.  Luckily there seems to be no shortage of
> willing mentors.
>=20
> Some quick impressions.  This is off-the-cuff; please feel free to let
> me know if something sounds crazy.
>=20
> > Today git code consists of the base written in C and many helper shell =
or
> > PERL scripts. While at a first time it is easier to write the script,
> > final code is supposed to be in C. One of these scripts is
> > git-add--interactive.
>=20
> [...]
>=20
> > But before that, it is need to clean and extend the current git-add--
> > interactive, to serve user needs at the best.
>=20
> I see two goals in tension: (1) to integrate add--interactive as C
> code, and (2) to clean it up and change its feature set.  Either one
> could happen without the other, and for planning it would be useful to
> know which is going to drive decisions (e.g., what if time is short
> and something has to get cut?).
>=20
> If (1) is the main goal, it might be easiest to first translate the
> existing code, perhaps modulo small preparatory changes that make the
> translation easier, into C and leave major changes for afterwards.
> Tracking down bugs due to a major change (like switch in
> implementation language) is a lot easier if the pre-change version is
> well tested and well understood.
>=20
> If (2) is the main goal, it might be easiest to rewrite small parts of
> add--interactive in C where convenient rather than rewriting the whole
> thing.  In that story, the result is a series of small patches without
> any single world-changing patch. :)

As I updated the proposal, to focus mainly on the (2) way to go. I agree wi=
th=20
your suggestions and I think it will be part of the second round, when the=
=20
git-add--interactive will be done and tested enough.


>=20
> [...]
>=20
> > How to consider this project has success? That is pretty easy, the
> > already done functionality will be integrated in git-add and the user
> > usage would be consistent.
>=20
> After each patch, the test suite should pass.  If some important
> functionality is not exercised in the test suite, ideally it can be
> added to the test suite.  (Though that's no replacement for trying the
> changes in day-to-day use, of course.)
>=20
> [...]
>=20
> > The official time-line consists of 12 coding week, starting 24th May. T=
he
> > mid- evaluation is in the 8th week.
> > So the plan is written in week order beginning on the first coding week.
>=20
> Jeff and Junio's advice seems sane to me.  More advice that might help
> with writing a timeline: [2] and Christian's reply.
>=20
> Because of the uncertainty I mentioned above, it's hard to give an
> example, but an ideal proposal would include a timeline that gives a
> technical plan for the summer.
>=20
> Also during the bonding time or even earlier it would be nice to get
> used to sending patches and reviewing them (as explained in
> Documentation/SubmittingPatches) if you find time for it.

I'm planing to submit some patches as soon as it will have more time to ful=
ly=20
get in the code, I think it will be something like perl style cleanups.

Thanks for your attention,
Robert.=20

>=20
> Thanks again, and hope that helps.
> Jonathan
>=20
> [1] http://bugs.debian.org/522361
> [2]
> http://thread.gmane.org/gmane.comp.version-control.git/142623/focus=3D142=
877

--nextPart3213552.yI0Xur8P6q
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iF4EABEIAAYFAk2rNnQACgkQLSNWchw0XGzvGwEAsHJ7ANnSoMfGhqASRzxEtkG/
cxEPMX7F5gzEba4CPw4A/0ScgdKU6gOzmBaADZ1eMAK3TzcOe+eg7sxJRnU15gSk
=0X1O
-----END PGP SIGNATURE-----

--nextPart3213552.yI0Xur8P6q--
