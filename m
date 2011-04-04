From: Robert David <robert.david.public@gmail.com>
Subject: Re: GSOC idea: build in scripts and cleanups
Date: Mon, 4 Apr 2011 20:51:31 +0200
Organization: DDM Praha
Message-ID: <201104042051.31874.robert.david.public@gmail.com>
References: <201103260141.20798.robert.david.public@gmail.com> <201104040943.10030.robert.david.public@gmail.com> <7vwrj999dv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart14631375.3D69oozpSd";
  protocol="application/pgp-signature";
  micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 20:52:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6osi-0000i1-R3
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 20:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755392Ab1DDSvj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 14:51:39 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51135 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755390Ab1DDSvg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 14:51:36 -0400
Received: by fxm17 with SMTP id 17so4123725fxm.19
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 11:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:organization:to:subject:date:user-agent:cc
         :references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=WEqGdax6POVTgQVDMXAFQbXA5fLVHMeAUhIG0tB4zho=;
        b=BqF2JsjTWcMkyrlMQPY68p04LrBkQrs4pG459PYLmlHABnil+8T2wLGsAup7q0eue8
         owpeFFJS/vRQaP04D4p5d7sXn/MwhETV16CI4rbtbGv0iuMtkF/mBDjaRuB9oNg1rk+t
         h6GsUx/2T8d5aQoBxjSvfVsk9w6wjVVZxlGBA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=lUXUWDz9olqLvIXSNjJwVsdOsAe9LRFpXRP1uwuWEnlHPyivtYYJVJFITSl7O7OUlw
         /OJcG/AgqJwl6CyTh5pSz/OesHZscy46efTyrNHCUT+zI2i4AhamHmGz3e/Ofxcro+d9
         XrgTznpuT455wYvx90x/wuBsNnB98Wz5FAHJw=
Received: by 10.223.110.81 with SMTP id m17mr775382fap.32.1301943095589;
        Mon, 04 Apr 2011 11:51:35 -0700 (PDT)
Received: from robert-eee.localnet (gate.chabry.cz [80.92.246.13])
        by mx.google.com with ESMTPS id n2sm1838831fam.4.2011.04.04.11.51.33
        (version=SSLv3 cipher=OTHER);
        Mon, 04 Apr 2011 11:51:34 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-5-686; KDE/4.4.5; i686; ; )
In-Reply-To: <7vwrj999dv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170833>

--nextPart14631375.3D69oozpSd
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Dne pond=C4=9Bl=C3=AD 04 dubna 2011 20:09:00 Junio C Hamano napsal(a):
> Robert David <robert.david.public@gmail.com> writes:
> > 1) Pre-coding time
> > 2) 1-3 week
> > 3) 4-5 week
> > 4) 6-7 week
> > 5) 8-11 week
> > Extend the C code to the state it should be.
> > Adopt other git commands to work with the new interface correctly.
> > Test extensively.
> > Update documentation where needed.
> >=20
> > 6) 12 week
> > Write more documentation, to document what was done and how.
> > Correct bugs and test.
>=20
> I am afraid to say that the above schedule is too ambitious and does not
> leave any time for reviews and re-rolls.  Please keep in mind that
> historically patch series by more experienced contributors of substantial
> size (comparable or even smaller scale than the topic you are proposing)
> all typically took three or four review-reroll cycles, if not less, and we
> don't automatically get extra review bandwidth just because GSoC is going
> on.

Thanks, this is what I wanted to hear.=20
I wrote the proposal from my point of view. I'm prepared to change the size=
 of=20
the task and schedule on mentors and developers comments.
I'm also trying to understand your development cycle, to get that more=20
precise. But I want also say that I'm prepared for a lot of work. I have th=
e=20
time in this period.

If I understand correctly, you mean to divide this task in more terms? And =
do=20
less more precise. Test more, etc.

Robert=20

>=20
> I am starting to suspect that it might make sense to say "as far as GSoC
> participation is concerned, we would call a topic "merged upstream" when
> it hits 'next', even if it is not ready for 'master' at the end of the
> term".
>=20
> What do regular reviewers and potential mentors think?  Perhaps we have
> more stringent quality requirements than other open source projects that
> take "commit first, review and fix as necessary" cycle, and they may
> declare success when "commit first" happens.  If that is the case, 'next',
> whose definition is "without glaring design and implementation bugs and
> fit enough for dogfooding, but needs extra polish", might be a better
> success criteria to be fair for our students.
>=20
> I am not in the mentor pool and I would rather not to be to stay neutral,
> so I'll leave it up to the mentors.

--nextPart14631375.3D69oozpSd
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iF4EABEIAAYFAk2aEzMACgkQLSNWchw0XGyJnAD8CuDQMdWVGUPLdeSsZh+IjPYT
McMbemW1fd4qusQZ3iYBAIo7rpIpZG6HBbCS9eL/oMlzQw3gWQ0rA7IDLTT8hJrH
=CFq8
-----END PGP SIGNATURE-----

--nextPart14631375.3D69oozpSd--
