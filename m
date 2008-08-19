From: Marcus Griep <neoeinstein@gmail.com>
Subject: Re: Stange diff in "mailinfo: re-fix MIME multipart boundary parsing"
Date: Tue, 19 Aug 2008 13:51:01 -0400
Message-ID: <48AB0805.1020309@gmail.com>
References: <e5bfff550808191038u645cf4baldca5c2c4bbd02162@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB00F686FD422F2C53423D0C9"
Cc: Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 19:53:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVVOD-0000zF-3y
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 19:53:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755711AbYHSRvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 13:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751746AbYHSRve
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 13:51:34 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:61128 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbYHSRvd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 13:51:33 -0400
Received: by an-out-0708.google.com with SMTP id d40so10945and.103
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 10:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type;
        bh=xo6a7cm2+/Aeqn8hHEkkJIgdcUlHqbd/yf9jsLGWxZY=;
        b=lbpYrvIfHSM6rYgTwuS+oBrVGwqZs968YOsD87rZmrqHJTgHwJCjfnX9n/3LLIY12M
         K/tStKFnxfUiHreU7pFaWULhJNkR+tUOf6ORwYKVuqhWrFcwvcn+RMyGSiQmNLi6HTUU
         qI3PUHS/Kgxtdz5Uv2FVq3YnjtdrzzQJ4pA7c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type;
        b=SZw4b0rCW+gSVSPmMeO1uB7oLQibOnHwUs3ORcVj5nWyedaartrAsMjB/9mO0MoT/0
         AkzO0iMF/UP+BndfOIOoQ7oZ4H64Io5BM+eqjN3Jh5G3i+f6/WSnP3eYD4l2NV0l4tfZ
         aHYb0/y4suRKCctrvtl6JL0FElYCU0xxXoNnE=
Received: by 10.100.41.9 with SMTP id o9mr1316691ano.42.1219168292477;
        Tue, 19 Aug 2008 10:51:32 -0700 (PDT)
Received: from ?10.95.36.106? ( [4.79.245.132])
        by mx.google.com with ESMTPS id 14sm744895wrl.39.2008.08.19.10.51.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Aug 2008 10:51:31 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <e5bfff550808191038u645cf4baldca5c2c4bbd02162@mail.gmail.com>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92886>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB00F686FD422F2C53423D0C9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Marco Costalba wrote:
> Looking the diff at
>=20
> http://git.kernel.org/?p=3Dgit/git.git;a=3Dcommitdiff;h=3D289796dd29dd6=
56734cfd59b657deb943a71cf6a
>=20
> the part of the patch applied to /t/t5100/sample.mbox file seems very
> strange, is it correct ?

It looks like an empty line added to the end of the file.
Unsanitary, but ok since it comes after the last MIME
multipart boundary.  Junio could probably just ax the change
to sample.mbox from the patch before applying it.

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4


--------------enigB00F686FD422F2C53423D0C9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIVAwUBSKsIHAPFruyc22R/AQITqBAAsT90eJWqyF18tmqTGnFPHhht5SR8Iuq3
w4qvj2Z8mEbluyVBD/6rfbHyGWR82FIfSFY890qO/UKW7zbKzAN48sa3XwW9x09P
LsYmiwx9tVlJBZt9jVaj44n5bwEOkYdATNbre4/9EkTeoaHeralDzrq6SWAyvn1v
4thEl2WHbZdmGu8dnj5tC+pStiEIJ0qhYQloF+oEIpxkvlhvhfBxqEKPCTZLOOWG
HFANinVkzacP5+6pkpCsNP7FCmTUKgizF9K3UMj787ZNavQLqXoY+7mHstbBA1QV
rrb7XVraRLzZYKX16hOKV4gpRDsbg//srmpMbqnVicKenkuBtqmm71X5NDppAkZZ
TU7cechV0GIC9zsPik2y32M5I/HRQCaj5ObRG63tLrpY00i1lbxXW8m1PQMqVLVF
4d0v76Is0L7eOEBfUIHIeUerYOtqEV5bXWdKM7eEDpyL0Pw/Q+MZmMQ7wsROQVH3
gTNgOJQVg6VDtUcV7EYfFS4SQTVpSVkkoKCOqs+fAO3y8ydN1M/WPBbv1R8sWzpC
LfKriFCE2hblfCz24TT4dUy9zL5psO9xGKPGNpE33PKTULa2Oa/FGkTxY6RXMYHN
tIcsshb8X8cJ59s5IXP7NSCJ7R6ajOqwLGo3eKHNLwH/FZY6kHY8It4leh/037b1
aq6kVLkoUOU=
=dgbD
-----END PGP SIGNATURE-----

--------------enigB00F686FD422F2C53423D0C9--
