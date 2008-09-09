From: Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH v2] Git.pm: Use File::Temp->tempfile instead of ->new
Date: Tue, 09 Sep 2008 13:35:44 -0400
Message-ID: <48C6B3F0.505@griep.us>
References: <1220889063-20387-1-git-send-email-marcus@griep.us> <1220892781-24343-1-git-send-email-marcus@griep.us> <20080909020605.GA19190@toroid.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig67A8096AEDE03E702A7EA8A7"
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>,
	"Tom G. Christensen" <tgc@statsbiblioteket.dk>
To: Abhijit Menon-Sen <ams@toroid.org>
X-From: git-owner@vger.kernel.org Tue Sep 09 19:37:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd79M-0007xd-Pz
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 19:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755919AbYIIRgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 13:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755851AbYIIRgB
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 13:36:01 -0400
Received: from rn-out-0910.google.com ([64.233.170.188]:31128 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755614AbYIIRf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 13:35:59 -0400
Received: by rn-out-0910.google.com with SMTP id k40so672757rnd.17
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 10:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:sender;
        bh=oPtotOP3PrbyzRQw+nefmGDCE1rU/HCEziuXyfEXpIo=;
        b=Rp+bns82J/FGGoPRnk1tOtQamjLRDELKaaUSbhMCAyadJAsedxLbW6gpsDkwIqaPHn
         IgXfO4cphZw2IegyluwUdbl86xZMXjCm0RbulwPlh6iklfmk08n7h2p8I2mpoKyGJCc0
         ezvMKAwaXtloOUK4s+ocbomBJQCdgtUrxD/Ck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type:sender;
        b=Rev1xDrD96WEBBRYqPp27AIlJo7inz00TqxPjQuIjHTDl3bC2rsuIX9cN21gl931/X
         PzAxTPWDE2MVesRjuHhy0Hm1KpEI5lCYfDTIx33NAbECgIv24n8zZIpyVzNcUpCCCMq+
         sf3jdQcLi1gPkptGeFI+WWbgINkE5LJKS7AJU=
Received: by 10.151.79.6 with SMTP id g6mr106156ybl.185.1220981758488;
        Tue, 09 Sep 2008 10:35:58 -0700 (PDT)
Received: from ?10.95.36.106? ( [4.79.245.132])
        by mx.google.com with ESMTPS id i37sm1013808wxd.9.2008.09.09.10.35.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Sep 2008 10:35:56 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <20080909020605.GA19190@toroid.org>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95410>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig67A8096AEDE03E702A7EA8A7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Abhijit Menon-Sen wrote:
> At 2008-09-08 12:53:01 -0400, marcus@griep.us wrote:
>> +		my $fname;
>> +		($$temp_fd, $fname) =3D File::Temp->tempfile(
>> +			'Git_XXXXXX', UNLINK =3D> 1
>>  			) or throw Error::Simple("couldn't open new temp file");
>=20
> What happens when tempfile croaks on error?

I was indifferent to the idea of catching the ->tempfile croak just to hi=
de it in our
own error (since the ->tempfile croak would have more information), in wh=
ich case the
extra 'or throw' may be superfluous, but I kept it as a defensive program=
ming practice.

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4


--------------enig67A8096AEDE03E702A7EA8A7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIVAwUBSMaz+QPFruyc22R/AQKGyQ//epqFqXjgr+bIwEJpJzV93PKFQli6dkVz
f4Xs9yOooQKs3ohHC4r4mcqPL5ivLPS6dpA6efd0ITN215GWE9xBtaAS7Lu3pbXF
c475kW9P1/U3P1boKzBLGEcMai/5Bq6JWt+xkA2U4ZFfg0UkrsETLwaIG1UFlHAz
3o0PQuNtecEQLVgzgc0sEx+Yp1dvj6J7iyh5wZsuRFG/H90GBtBC7j9KCGFAPy1c
3zk2lpx0W86AXp/ZdSWVz+yfa4izQQqfqGGxBvbofVGxPY/ITkHQE3SLvHFXovum
A2BatfKyaMOyz06dXp33FHGJ0ylPH6j90Eb97kRkCRuDiYJsWMghjoHXsOyhmDuV
o5/kIt2Bq5wi5rISesi8/thyF93J/HkXvdIK/Oty1BLy03ZKcOm/SxZLKVm5hZTH
MuNUz7dA3Bf9hi8VxeTvRwiDjz3B1uvDw0YtyxEikzIsX8YpvWRA48gMVdUhCQZl
AVBY9xPHsJHcMYe7QaFgpD2Q5VPc8waoSmoLTCUI447LTy5tCVdKtrKR05yaDS4c
sDBUA9npzIQjm+sMrgJA00gNSS0A0K3mLWCKJVBCu/bU3SB59mAfeFqUDxY2Wp0g
p5R4iWwDqpv/o5FSqxajdIHwQzKq+XM2rHapTQI5nWxVhKTPLkG2jx/FIPZpTQaz
mCS/k0s0efY=
=vcH7
-----END PGP SIGNATURE-----

--------------enig67A8096AEDE03E702A7EA8A7--
