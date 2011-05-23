From: Grant Limberg <glimberg@gmail.com>
Subject: Re: [git-p4] Trouble importing all perforce branches into git repository
Date: Sun, 22 May 2011 20:27:48 -0700
Message-ID: <398FA881-E4A1-49AC-80F2-2D46E9F2ABB9@gmail.com>
References: <20110522114917.GA19927@arf.padd.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-4--750929581"
Content-Transfer-Encoding: 7bit
Cc: Vitor Antunes <vitor.hda@gmail.com>, git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon May 23 05:28:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOLoM-0006ZN-4U
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 05:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334Ab1EWD2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2011 23:28:00 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:33018 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823Ab1EWD17 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2011 23:27:59 -0400
Received: by pvg12 with SMTP id 12so2406957pvg.19
        for <git@vger.kernel.org>; Sun, 22 May 2011 20:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:mime-version:content-type:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to:x-pgp-agent:x-mailer;
        bh=Yc+CNItXGje04VfiPwqi7ZjT093Py42jrVbgAsFIOtY=;
        b=gBzONfVswE3iMow1Hwmw1a0qyKRIPRFQsaEhwKrpj+4/YrOPOh8z3e3KEFyk9HsdBB
         abW4dbiopiVspuCkMEPkse7zWfTox7baan5WfKRzuHbUvRWFFkxqr7d17ujq5lbQDQqH
         UXNAuKOjgk3yWwzrq8Ub6hIasFDfT4TSBEPks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-pgp-agent
         :x-mailer;
        b=E/ueisSr2h+8xtSZyJGIYsOpombE+sAwucmYeaiH06+yQNTxr6q6mNUz5wxe0xAU8n
         JnWH0dW2T7bkvh52XiWK6xQwTlKCyEZpvXkTkkO38yROTr4OE6PKFJTRBW/rAlRxhNTl
         KLUFYrnQ5TRFbtH9GE/Sflv3WnSZC1f22lC+k=
Received: by 10.68.30.226 with SMTP id v2mr1967438pbh.186.1306121279103;
        Sun, 22 May 2011 20:27:59 -0700 (PDT)
Received: from [192.168.15.2] (ip68-4-195-196.oc.oc.cox.net [68.4.195.196])
        by mx.google.com with ESMTPS id j2sm4070032pbg.60.2011.05.22.20.27.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 22 May 2011 20:27:57 -0700 (PDT)
In-Reply-To: <20110522114917.GA19927@arf.padd.com>
X-Pgp-Agent: GPGMail 1.3.3
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174222>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-4--750929581
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=us-ascii

On May 22, 2011, at 4:49 AM, Pete Wyckoff wrote:

> glimberg@gmail.com wrote on Thu, 19 May 2011 19:32 +0000:
>> [git-p4 automatic branch detection]
>>> git p4 clone --verbose --detect-branches --max-changes=3D100 =
//project/...@all
>=20
> I worry that --max-changes prevents it from pulling in the
> ref for Branch-foo, and this confuses the automatic branch
> detection that assumes it has all its parents.
>=20
> It would certainly be more reliable if you did "git-p4 sync
> --branch foo //project/foo@all" for each branch you care about.
>=20
> Vitor has some modifications to auto-branch detection that might
> be useful, or maybe some thoughts as to what's going on.
>=20
> 		-- Pete
>=20
> (Vitor: full mail is here:
> http://article.gmane.org/gmane.comp.version-control.git/173996/ )
>=20

Removing --max-changes=3D100 has no effect on the crash I'm =
experiencing.   Same crash still happens on the very first imported =
commit.

If i do "git-p4 sync --branch foo //project/foo@all" for each branch, =
does that convert 'p4 integrate' commands into git merges?  I"m trying =
to keep all history intact when importing from p4 into git.

Thanks,

-Grant


--Apple-Mail-4--750929581
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.17 (Darwin)
Comment: GPGTools - http://gpgtools.org

iQIcBAEBAgAGBQJN2dQ1AAoJEH+RGVrhASuPkR0P/iQYDmCJC67UpxKZxykQV0hS
tGdNAeOHGTPQ4ZP7v9Axw1n5YXtsiBkVsKMQwHVyPQGpk3ISfSBxo78gnktvlJbF
NMrKyUsjupH/TqpdLaTmO+TCtKbzpgwoM+3A7y3LONO1QvCNiscsD+7E1H1KVwGw
XkIYkxaygch/0ZeCYSHeHcR313MXXfKmpghVrCFN9wfuw2EbFPfVwI/3PUSqKmzk
438SU2eEJHfJbvA8OTPbbehfbc91diHjfaYgUIxmyQ1qlo1baUzFHiNf2E5EqCfF
K8UMVKfWluxT0sirzC2AEpa1lfvmLnyTQ2XBwgIy0jnvVUtBzwZ8mLcGNru7uhXn
iMngbAOo9hB1B4tZYDJMrLMP4ak9NufdL68czXPIjbtmupY/zZQwEWVGz9picDn9
oH4CEMadVql4MfDVPY5UdIbELeM1QirbbatsFHjxSwegatIIjj/cfN0Az44tUtW7
BmsJbGg+V+gnTIthV8APQ2eofDur2e3+SetO4skqDN9uOAK+RVPkpLtD33hfOirF
ZbGXLNtPUsx6A6/+npdQTrNVoYA5qTgnSwDt+am3yvxe4F5try4mDn3i6CA1Xs4f
fq4vnnCyenHJ7A4DweqBDjYxoy3cl6mEoil3naRlj41LvxS3ah1L6H2oFGIQ4ZYO
3nTb8b1pToI2c7zncaoC
=+SKn
-----END PGP SIGNATURE-----

--Apple-Mail-4--750929581--
