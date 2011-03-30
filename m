From: Robert David <robert.david.public@gmail.com>
Subject: Re: GSOC idea: build in scripts and cleanups
Date: Wed, 30 Mar 2011 23:17:17 +0200
Organization: DDM Praha
Message-ID: <201103302317.17855.robert.david.public@gmail.com>
References: <201103260141.20798.robert.david.public@gmail.com> <20110328142121.GB14763@sigill.intra.peff.net> <201103301739.12691.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1859848.1GTREOiQSX";
  protocol="application/pgp-signature";
  micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Mar 30 23:17:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q52li-0002YZ-Iv
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 23:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965191Ab1C3VRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 17:17:25 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60740 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964852Ab1C3VRW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 17:17:22 -0400
Received: by fxm17 with SMTP id 17so1382192fxm.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 14:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:organization:to:subject:date:user-agent:cc
         :references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=a0ABGwbZl+SGjHixuy6RFXsxD/NTS1JNTBE4clMceYI=;
        b=fqfX/ub7Ubzx3H4kF5JM5eqiOvsGCIJjuJGooqwQEqw5QEpEpEzasOmDVFTOEgHm/H
         a95iJVW3XZzQsVQ44zWpNJLvxNns15ujt0qyUIUtTzy0GPowUK0ufNhl8DILoY3Q7mHR
         BDQ79tstAUQXkfaAbQqt4/ZWKb2s0imZ810RQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=f+SzR65Zj7RVqVDhn5b2ly00VDW3CddFomp+1l+l+b5NEi19egV9RGRCKTGAd+gOS9
         q6ddEiIf8EjADSyWkHA7bmi8HrkK+RF9uP5/DREhe6zshWjsO+SJSiG86EMZ+5R9wwNY
         Xd25K03wiUo6f0+olNY+kw3sqHslbJuB0EyxE=
Received: by 10.223.117.134 with SMTP id r6mr1891935faq.147.1301519841536;
        Wed, 30 Mar 2011 14:17:21 -0700 (PDT)
Received: from robert-eee.localnet (gate.chabry.cz [80.92.246.13])
        by mx.google.com with ESMTPS id p16sm175065fax.21.2011.03.30.14.17.19
        (version=SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 14:17:19 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-5-686; KDE/4.4.5; i686; ; )
In-Reply-To: <201103301739.12691.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170425>

--nextPart1859848.1GTREOiQSX
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Dne st=C5=99eda 30 b=C5=99ezna 2011 17:39:12 Thomas Rast napsal(a):
> Jeff King wrote:
> > On Mon, Mar 28, 2011 at 10:55:22AM +0200, Robert David wrote:
> > > > As far as cleanup versus features, I think Thomas would have to
> > > > comment on that. He is the one who did the most work on patch-mode,
> > > > and therefore the one who most thinks it needs cleaned up. :)
> > >=20
> > > Is Thomas going to be a mentor in this task?
> >=20
> > I hope so. I can also co-mentor if it helps.
>=20
> I'm certainly ready; I didn't propose any projects that I would not
> also mentor.  (However, I won't mentor more than one...)

Thank you for your attention.

>=20
> Note that while it's certainly a bonus, porting it to C probably makes
> the project more difficult and time-consuming.  We'll have to see in
> the proposal timelines however.

It is not a big problem to me. I plan to begin full time work on this in ha=
lf=20
June.
Before that I plan some cleanups and fixes to simplify the upcoming porting.

>=20
> As for cleanup, my gut feeling right now is that the Perl code can
> probably cope with incremental cleanups as required for each feature.
> On the other hand, the C port should start from a clean redesign so as
> to not rewrite it twice.

I agree that porting to C should be done from scratch. Thats why I would cl=
ean=20
and extend the script first to make a "preview". Than when it will comply=20
with requirements, I will port that from scratch to C.

Robert

--nextPart1859848.1GTREOiQSX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iF4EABEIAAYFAk2Tnd0ACgkQLSNWchw0XGyM/QEAk7N/BnujWSrN5nZtzVkGupYx
ztdc1lq1jZyw8+B5INgA/1gqi3Kha0M7C6COVRKJLTdDuHaP7wU2zQ3vYi24JA/d
=2c7Y
-----END PGP SIGNATURE-----

--nextPart1859848.1GTREOiQSX--
