From: Todd Zullinger <tmz@pobox.com>
Subject: Re: Running "make rpm" fails on a CentOS 6.3 machine
Date: Mon, 3 Feb 2014 10:21:18 -0500
Message-ID: <20140203152118.GZ3241@zaya.teonanacatl.net>
References: <CALMr_pWHfaHq46418UPcqGKm6bFc61jw-VqGJYV8Ogc9yuHDFA@mail.gmail.com>
 <20140130181643.GG27577@google.com>
 <20140130185104.GV3241@zaya.teonanacatl.net>
 <CALMr_pVP-YVJ9K7ZpQxk3d5YBFQmCZBonFeUYY1fxdZNHHZJHA@mail.gmail.com>
 <20140202210724.GX3241@zaya.teonanacatl.net>
 <CACPiFCJh8Q63801f6zk4WQ0x=A19gBj83wO6dTD4q+EsjaBXJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l8YbbWKfojDp10WV"
Cc: Erez Zilber <erezzi.list@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 03 16:21:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WALKy-0008D8-Ey
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 16:21:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313AbaBCPVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 10:21:24 -0500
Received: from mail-qa0-f54.google.com ([209.85.216.54]:48684 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbaBCPVX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 10:21:23 -0500
Received: by mail-qa0-f54.google.com with SMTP id i13so10235869qae.27
        for <git@vger.kernel.org>; Mon, 03 Feb 2014 07:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4uVQxHrfj07buA+MIqqTWPkSvYIIKAt/6FekQwX3jqo=;
        b=htOP5zHlpCwTg9desBjzs9Lh094V3+1Xpui21dK4JHLJiL3EfkmgdWahDotHG5hX8O
         GrouQkwzEdFisrIhytH4KC8zHxFcvrYdemxB+2T0J/PfQolRZTrBtg16T8Rl6hD4i3SZ
         6mrS4o++VzhOrwpBpHiuZUSlD9ym33/sM8qB3131IcBtnDczZLdyXDKnNNatZx75toXr
         wd3y7sDyiQThh524uSeD63TCls0TxlNphfS17q5jtW38d00uEazHv2orwUtqOo5CMZjZ
         dKZHrdEj4LmA6Kpn/fCLhBs0I/akyqxMs68yEefTXCyLlKQPc19CrJKgSmxR/LVlopcI
         m6qg==
X-Received: by 10.224.161.5 with SMTP id p5mr57260014qax.32.1391440882650;
        Mon, 03 Feb 2014 07:21:22 -0800 (PST)
Received: from zaya.teonanacatl.net (zaya.teonanacatl.net. [2001:470:5:873:862b:2bff:fe5e:698b])
        by mx.google.com with ESMTPSA id h12sm27498879qge.0.2014.02.03.07.21.21
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 03 Feb 2014 07:21:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACPiFCJh8Q63801f6zk4WQ0x=A19gBj83wO6dTD4q+EsjaBXJQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241438>


--l8YbbWKfojDp10WV
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Martin Langhoff wrote:
>> # Create an el6 srpm=20
>> $ fedpkg --dist el6 srpm
>
> here I just say "fedpkg --dist el6 mockbuild" and it makes the srpm=20
> and the binaries in mock. Automagic.

Heh, and I thought I mentioning that, but since I never use it I=20
didn't want to have to test it before including it and sending anyone=20
down a rabbit hole. :)

>> /var/lib/mock/epel-6-x86_64/result/.
>
> with mockbuild the packages appear in a subdir of where I'm working.

Cool.  I'll have to make more use of that now.  Thanks Martin!

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
I have to decide between two equally frightening options.  If I wanted
to do that, I'd vote.
     -- Duckman


--l8YbbWKfojDp10WV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iQFDBAEBCAAtBQJS77PuJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzjJn4H/0WGVW0/AKnPHWNBHadkDv54q7+UtUQQcVFc
7CF66d6wNHsR6BmrbECR3xCfJravjb0hcOc20PHIcOIdVqbrakaUEBjwqsvmr1Do
m8aCI1mhRM3ML4+1OXVkNVrur8CDs9xzJa7uGhSwZxMb70uqaS0L/8Qs/UlaWngp
cC1GMg6oSHVCP2tEG/n41GbiUeEgKUhZsmCeGK3/89gBOBpx8w7b4eN4SZjui1+F
s/YfSIR9za+41tSZdkd01Pl6CthQ7Shv4gjIJ1qjT+9iZ3uC5vnc57pyGaSwlkPk
RPuFsXgU9qtvtLinU3X9mPbZrld5i6QZ+M9X/RglbGdV7n4tW8o=
=kdht
-----END PGP SIGNATURE-----

--l8YbbWKfojDp10WV--
