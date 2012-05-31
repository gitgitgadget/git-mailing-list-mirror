From: Lanny Ripple <lanny@spotinfluence.com>
Subject: Re: Bug: rebase when an author uses accents in name on MacOSx
Date: Thu, 31 May 2012 12:49:16 -0500
Message-ID: <69ED148F-BD10-4DE3-91F2-D31F83A0EAB7@spotinfluence.com>
References: <06DD2F56-F956-46DF-84A4-3443D4702CDE@spotinfluence.com> <7vehq18c82.fsf@alter.siamese.dyndns.org> <20120531011911.GC5488@sigill.intra.peff.net> <7v62bc97w1.fsf@alter.siamese.dyndns.org> <78E7FEAC-6587-4EB3-B78B-08D321F53BF9@spotinfluence.com> <7vtxyw6ypx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: multipart/signed; boundary="Apple-Mail=_56C39AD9-C5A5-43CB-BBF0-5DB7195D7844"; protocol="application/pgp-signature"; micalg=pgp-sha1
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 31 19:49:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa9V0-0004nn-FJ
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 19:49:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837Ab2EaRtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 13:49:21 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:61357 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141Ab2EaRtV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 13:49:21 -0400
Received: by obbtb18 with SMTP id tb18so1633589obb.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 10:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :message-id:references:to:x-mailer:x-gm-message-state;
        bh=4hoA1jd79dl3ZsFo8Wx1gMjaHYRHFHodKVaN269kZ1c=;
        b=mLAaGGyxkAHbfdCgkqc7KzaVGVljKAkruGjQ2ABcNSTey25x9rtpox+7Dn0E8ufpkm
         i528DNeCd9Doi1UfQm3KDwPVrdj0KUv8/eJ/C+/I7SCl0DvvSrVGrCKJoU86gmtRJVQc
         MAH03QJfK5LFKj5vpFbJnB9Wihm3n8VbNsiNUATJMSJQzG7PQGUgVnh0EgZ2pVrms+Kp
         ZF/7kL4FQYZwX7gWnm3yw3TozqOyfilre/x0wNT7OOQ2Wnydmg9X+XRff+bJWcyLMOIB
         LwDlbgDd2ChKNnuDzE72sMt6IIJ7gBhxK624QKTn4ed54wF3NmWSOWL+3LnkuJBa1I0j
         PR0g==
Received: by 10.182.187.42 with SMTP id fp10mr20197370obc.30.1338486560601;
        Thu, 31 May 2012 10:49:20 -0700 (PDT)
Received: from [192.168.1.4] (c-98-198-192-29.hsd1.tx.comcast.net. [98.198.192.29])
        by mx.google.com with ESMTPS id b8sm2941603obw.1.2012.05.31.10.49.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 31 May 2012 10:49:19 -0700 (PDT)
In-Reply-To: <7vtxyw6ypx.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1278)
X-Gm-Message-State: ALoCoQklO+3MtjvAj+YNOs6N0IZCqSOpoPIV5GllVULlsT/L8cPH/2CdGQcsyG0z4swCf/qP2POx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198929>


--Apple-Mail=_56C39AD9-C5A5-43CB-BBF0-5DB7195D7844
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=iso-8859-1

Perhaps the error message in git-am could be modified to indicate sed is =
a suspect?.  E.g.,

 lanny(master);<work/IdeaProjects/Piper> git rebase master rl-clean292
 First, rewinding head to replay your work on top of it...
 /sw/lib/git-core/git-am: line 692: Leblond: command not found
 Patch does not have a valid e-mail address.  (Used /sw/bin/sed found on =
PATH).
                                              ^  ^  ^  ^  ^  ^  ^  ^  ^  =
^  ^
 lanny((ae6c220...)|REBASE);<work/IdeaProjects/Piper>=20

Alternately in git-am a comment at the error emit point explaining that =
third-party seds are often the problem for this error and a suggestion =
to modify the PATH so the platform sed occurs first.

  Regards,
  -ljr
---
Lanny Ripple
lanny@spotinfluence.com


On May 31, 2012, at 12:34 PM, Junio C Hamano wrote:

> Lanny Ripple <lanny@spotinfluence.com> writes:
>=20
>> Bingo.
>>=20
>>  lanny;~> echo "R=E9mi Leblond" | LANG=3DC LC_ALL=3DC /usr/bin/sed =
-ne 's/.*/GIT_AUTHOR_NAME=3D'\''&'\''/p'
>>  GIT_AUTHOR_NAME=3D'R=E9mi Leblond'
>>=20
>> Just occurred to me that I'm using fink and that git-am doesn't use =
/usr/bin/sed but just sed.  My suggestion is to be explicit on the path =
in git-am.
>>=20
>> So it now stands at two bug-reports and one pebkac.
>=20
> My impression from reading the older thread Peff mentioned is that
> the other ones are also broken implementation of sed supplied by
> third-party, so it probably is not two Xs and one Y.  It is three
> something.


--Apple-Mail=_56C39AD9-C5A5-43CB-BBF0-5DB7195D7844
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.17 (Darwin)

iF4EAREIAAYFAk/Hrx0ACgkQ+owW65SoXfgANAD/Q0vsxTuVAvJYAaYHJzdk+X3A
TNKtBn8hT9IagCp+TlwA/3dRJsZnG/5jmM7uQJVv4CBtr90vSl0AyX/VMegUDWUc
=WLXG
-----END PGP SIGNATURE-----

--Apple-Mail=_56C39AD9-C5A5-43CB-BBF0-5DB7195D7844--
