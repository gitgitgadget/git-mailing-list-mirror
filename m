From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: Sources for 3.18-rc1 not uploaded
Date: Mon, 20 Oct 2014 19:44:09 -0400
Organization: Linux Foundation
Message-ID: <54459E49.3040908@linuxfoundation.org>
References: <20141020115943.GA27144@gmail.com> <CA+55aFyDuHskYE66rBVL_P-T2pxg6f2m6mUicfz-mk+ysePBxg@mail.gmail.com> <20141020222809.GB223410@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mjQ6lRkbcEEbmqu8Mm4CtWMKBKSR9jpQF"
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	infra-steering@kernel.org, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 21 01:44:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgMci-0000ER-PZ
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 01:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404AbaJTXoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2014 19:44:21 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:38230 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177AbaJTXoU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2014 19:44:20 -0400
Received: by mail-ie0-f169.google.com with SMTP id tp5so106790ieb.0
        for <git@vger.kernel.org>; Mon, 20 Oct 2014 16:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:date:from:organization:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type;
        bh=JpfZMr+dOgAo7k1FErca8on8y4j4kzOzdQqyt5kcSh8=;
        b=T4vuF6fOiXQxUEDWVbdhpOp88KCKRUwa8cTmZPCArFkVvukf094loBMYKO8cXwKGJG
         AiYANirdYIHYJRms9zKUiKxXVNnN0D2B1hMPWnubUQ1SDlUkcqfkBUKQggnKaZDEOVFC
         2kmFXYuzvWfAXGYJuRJXEgd/3ETJmYmKM3j3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:subject:references:in-reply-to:content-type;
        bh=JpfZMr+dOgAo7k1FErca8on8y4j4kzOzdQqyt5kcSh8=;
        b=g8fLWEzvnr9Dv+hRWWjiToTZ4SaR8hSedMkVJNldpXDvVKsAtKJ3ZsubT0dTiSQNlH
         5PO6PPq0vTMn/w9yV0us+ZQwSkHZqv0LM4H2YnmQSFzIwHHe0VjHlECPaIZn5H8386Ec
         7zYFM6s5WgsiC16RK/CCWK63XtIMVeR2b/giOwryLdjU5dL47aE+jJqbawSyz8XXqb/h
         HM6I1rbwr5GPGBiEqFwMASfUHhMD/v0ICG425rYpY1GyClMtvKmFdEdYyZIeYSnlP5qZ
         Th04ZJEje5ehK1RkAXb60ihVb9G4Sb3vjT3D9L8bz0p5IEKpQzTLzEUVn5fY8tJ6wwoV
         nMNg==
X-Gm-Message-State: ALoCoQmbaA4VFeDlZ5e0PC4Vpdnq3i/WTIR7kba8NXiZXalRqt3lPDpEGKe6zoDPsyYlhM2k2Mw7
X-Received: by 10.50.6.100 with SMTP id z4mr21826736igz.37.1413848659389;
        Mon, 20 Oct 2014 16:44:19 -0700 (PDT)
Received: from nikko.mricon.com (69-165-202-194.cable.teksavvy.com. [69.165.202.194])
        by mx.google.com with ESMTPSA id a10sm4561475igo.22.2014.10.20.16.44.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Oct 2014 16:44:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <20141020222809.GB223410@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mjQ6lRkbcEEbmqu8Mm4CtWMKBKSR9jpQF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 20/10/14 06:28 PM, brian m. carlson wrote:
>> Junio, quite frankly, I don't think that that fix was a good idea. I'd=

>> > suggest having a *separate* umask for the pax headers, so that we do=

>> > not  break this long-lasting stability of "git archive" output in wa=
ys
>> > that are unfixable and not compatible. kernel.org has relied (for a
>> > *long* time) on being able to just upload the signature of the
>> > resulting tar-file, because both sides can generate the same tar-fie=
l
>> > bit-for-bit.
> It sounds like kernel.org has a bug, then.  Perhaps that's the
> appropriate place to fix the issue.

It's not a bug, it's a feature (TM). KUP relies on git-archive's ability
to create identical tar archives across platforms and versions. The
benefit is that Linus or Greg can create a detached PGP signature
against a tarball created from "git archive [tag]" on their system, and
just tell kup to create the same archive remotely, thus saving them the
trouble of uploading 80Mb each time they cut a release.

With their frequent travel to places where upload bandwidth is both slow
and unreliable, this ability to not have to upload hundreds of Mbs each
time they cut a release is very handy and certainly helps keep kernel
releases on schedule.

So, while it's fair to point out that git-archive was never intended to
always create bit-for-bit identical outputs, it would be *very nice* if
this remained in place, as at least one large-ish deployment (us) finds
it really handy.

-K


--mjQ6lRkbcEEbmqu8Mm4CtWMKBKSR9jpQF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJURZ5NAAoJEDZgaZyZ4FVXxy0H/RbBP+hSKuSrFp6Ys4+rh9Nl
YfsqrHS+bOjhK2ABz3thPJ1OAvqJC27Cl3Embqrp9b75CQLpjHaxB7Pb5A6Ndy36
tQEVbTSSR4tPPaIohgEdr9MwVs4y2Bm0oyTByhQI1rNygA4ykej9EQXitHJ9WvXQ
t779CWfJLXuCeYyHFMkqFV42dG4hridK2ZSBgijKguk5GVrpSkmjaQb+KVAwFy2X
tm8zIESEdhDr/kvro7Lnh7DqFXqNVq65SAjYAe9kp4mHa29X0TQs491x4HA/M9Lj
pD6aFP1mQ1Yni4wU7rohbAPrfNZ3xOxHrDhIc1COEUcxwSasSGnwIbNE9plUfZw=
=4u+U
-----END PGP SIGNATURE-----

--mjQ6lRkbcEEbmqu8Mm4CtWMKBKSR9jpQF--
