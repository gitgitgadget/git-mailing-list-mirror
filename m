From: Robert David <robert.david.public@gmail.com>
Subject: Re: GSOC idea: build in scripts and cleanups
Date: Wed, 6 Apr 2011 01:27:45 +0200
Organization: DDM Praha
Message-ID: <201104060127.45773.robert.david.public@gmail.com>
References: <201103260141.20798.robert.david.public@gmail.com> <201104040943.10030.robert.david.public@gmail.com> <20110405165212.GB9965@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5362418.eg1lHigFvc";
  protocol="application/pgp-signature";
  micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 06 01:27:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Ff9-0007pZ-Rg
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 01:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494Ab1DEX1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 19:27:51 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36860 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984Ab1DEX1u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 19:27:50 -0400
Received: by bwz15 with SMTP id 15so709353bwz.19
        for <git@vger.kernel.org>; Tue, 05 Apr 2011 16:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:organization:to:subject:date:user-agent:cc
         :references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=pOiQKTalfBmD167PUYR780nUXKXR2u+1VrNRiQ5pD+E=;
        b=jPopBBoTGy/sdCXttLs1y9SZouXJgZgn7WS9H5AD4NFQcwKThPsTWcHPkhuyww8Ob5
         9bcorIohNWtvE49+4paBm5NtOu5fClwhJMzM6pxcidAhEunVul4MP+RxFRHfKeiuKvWw
         xUBL1VkqE9oKvP5eEOVGbRQfcQhjNRaczQ5h8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=w2SvQt1ZEIm3QiRTDkXf2vwJVjGLq9V2hxWQP4AEnGVj9wq9lupIWW+fFVqEvLuBW8
         eNQ9CNrWDno/OhFrbUZxn5z/mxniqA0qBFYbzdywQBluiUT7rWMVh0WZNlfrfNgOQDH/
         9zzbeptSxGY9NsBkYY/UHzHE6US1QRgTcaBmo=
Received: by 10.204.154.199 with SMTP id p7mr217132bkw.114.1302046069119;
        Tue, 05 Apr 2011 16:27:49 -0700 (PDT)
Received: from robert-eee.localnet (gate.chabry.cz [80.92.246.13])
        by mx.google.com with ESMTPS id w3sm4028783bkt.17.2011.04.05.16.27.47
        (version=SSLv3 cipher=OTHER);
        Tue, 05 Apr 2011 16:27:47 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-5-686; KDE/4.4.5; i686; ; )
In-Reply-To: <20110405165212.GB9965@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170940>

--nextPart5362418.eg1lHigFvc
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Dne =C3=BAter=C3=BD 05 dubna 2011 18:52:12 Jeff King napsal(a):
> On Mon, Apr 04, 2011 at 09:43:09AM +0200, Robert David wrote:
> > Today git code consists of the base written in C and many helper shell =
or
> > PERL scripts. While at a first time it is easier to write the script,
> > final code is supposed to be in C. One of these scripts is
> > git-add--interactive.
> >=20
> > Git-add--interactive is a helper script for git-add, which servers its
> > options -i and -p. It definitely need to be integrated in git-add.
>=20
> Can you expand on "definitely" here? I.e., what are the motivations for
> this change? I know what some of the arguments are, and I know how _I_
> would answer the question, but I want to hear what _you_ think.


=46rom my point of view it means to keep the code consistent in the whole=20
project. This further means better porting, avoid duplications and thus eas=
ier=20
maintenance. And at last, I think it is my personality that takes me to=20
project like this. I like to polish things up.=20

Even I like the PERL, I would not like to maintain project consisted in mor=
e=20
programming languages for a long term.


>=20
> And I am not just trying to be pedantic. Understanding the motivations
> for a change will help us figure out the right way to go about it, and
> how to figure out if we are successful at making it.
>=20
> > Interfaces
> > As this is mainly part of git-add, that means that it will need to be
> > changed at the most.
> > There are also another commands using this functionality now: git-am,
> > git- checkout, git-rebase.
>=20
> I don't think this is right. "am" and "rebase" have interactive modes,
> but the code and functionality are not shared at all with
> add--interactive. But you are missing some other commands that do have
> patch modes built on add--interactive.

Thanks for the notice, I will dive more deeply into it.


I was also thinking about the timeline of this project. And maybe another=20
solution is to constantly and slowly improve git-add--interactive, to make =
it=20
accepted in next (maybe master) on end of the SoC period. And in parallel=20
write the C code, which would be prepared for more longer term testing and=
=20
bugfixing to get in next. This also means for me a clear way, how to contin=
ue=20
contributing to git.

Robert=20

>=20
> -Peff

--nextPart5362418.eg1lHigFvc
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iF4EABEIAAYFAk2bpXEACgkQLSNWchw0XGy66gEAnAuGPmg7VG3mUmRzRhMBrvsz
etrm/nNCem0UEWPYCrcA/2nIpggCVH/WLR5CNaqaoN0a+UW797X6xZheHbYG9NPL
=Ii9E
-----END PGP SIGNATURE-----

--nextPart5362418.eg1lHigFvc--
