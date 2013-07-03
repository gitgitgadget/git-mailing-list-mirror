From: Jed Brown <jed@59A2.org>
Subject: Re: Review of git multimail
Date: Wed, 03 Jul 2013 16:09:52 -0500
Message-ID: <87ppuzz6xr.fsf@mcs.anl.gov>
References: <1372793019-12162-1-git-send-email-artagnon@gmail.com> <51D36BD8.1060909@alum.mit.edu> <CALkWK0=taYiV3UTaj9r-FLdaCeZRzVBTp_MH4sQt8-v+YYqbaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jul 03 23:10:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuUJb-0001lT-7M
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 23:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933032Ab3GCVJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 17:09:56 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:45073 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932842Ab3GCVJz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 17:09:55 -0400
Received: by mail-oa0-f49.google.com with SMTP id n9so888031oag.22
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 14:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=JgemAKmahgGV7MhSiA+KLQqB/mD/tuDYJ/jUZ/k13XA=;
        b=eFcl61bZL7PNwAbflng5wCTM8C8fuPX6zsfPfnjX9MZ9nkQt4HBvTfVrHPSs2o+KmI
         /WjoAkttJ61kiBuC66F+EyFT3Xk1L8308kC8lAu2HOeih0IA/W6fTK/0yqeBJl5W7Uf0
         nGCegSoGbofZHFHxRFX+MhTRgjGxasEIqYJqfRTFA+nKgqLEgT8AjztAjCmf1N7B4pXe
         9QTXNSz8lpTqh4CiXBfGxYzunKfSQE2Q1yqlTcWU/lqaVQz+DgIHaWsJxIHxfDFu53x1
         9uBvKzvVuDuPT9vAVcdE8KyELKsCkfQsABct0xpL3vmoP9v8uvaQtqDxWJ8Mc30Gxhuz
         nKlw==
X-Received: by 10.182.237.82 with SMTP id va18mr2871417obc.0.1372885794426;
        Wed, 03 Jul 2013 14:09:54 -0700 (PDT)
Received: from localhost (vis-v410v070.mcs.anl-external.org. [130.202.17.70])
        by mx.google.com with ESMTPSA id m11sm14429574oer.4.2013.07.03.14.09.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Jul 2013 14:09:53 -0700 (PDT)
In-Reply-To: <CALkWK0=taYiV3UTaj9r-FLdaCeZRzVBTp_MH4sQt8-v+YYqbaA@mail.gmail.com>
User-Agent: Notmuch/0.15.2+129~g1907b1d (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229534>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Yeah, this is good reasoning.  And yes, I'm on Arch: python points to
> python3, and python2 points to python2.=20=20

I'm also on Arch and it has been this way since October 2010 [1].
Ubuntu plans to remove python2 from the desktop CD images in 14.04 [2],
so having code that does not work with python3 will become more painful
pretty soon.

Note that RHEL5 has only python2.4 and will be supported through March,
2017.  Since it is not feasible to have code that works in both python3
and any versions prior to python2.6, any chosen dialect will be broken
by default on some major distributions that still have full vendor
support.

> A couple of thoughts while we're on the subject:
>
> 1. We should probably convert git-remote-{hg,bzr} to use this style
> too:=20

Python-2.6.8 from python.org installs only python2.6 and python, but not
python2, so this will break on a lot of older systems.  Some
distributions have been nice enough to provide python2 symlinks anyway.

Michael's rationale that at least the error message is obvious still
stands.

> Debian uses an alternatives mechanism to have multiple versions of the
> same package

Alternatives is global configuration that doesn't really solve this
problem anyway.


[1] https://www.archlinux.org/news/python-is-now-python-3/
[2] https://wiki.ubuntu.com/Python/3

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1JMgAAoJEM+2iNHeMalNGWoP/0zqoHnt+mnNf0RA/p0ilcC7
tDA82zdPY5YvpHlHV7KePo+t2GRpy25A3+iKWslPTApNQvn/vR2QiWu8/AH7K+lm
1zhAJVsrsMfdY+qjKpw0RVAe6Aky6yqhSuA/i/xciBNTtigajL8qmgT6Fp101KvA
iuhV4i4QZFeYqgqosGM7ymuFfsAewahrE/bfH+dZhynQuWMf+Qhe+1zflTnGRY/9
5MhEsENPdZwm8C8F0YARFKKx/hA3M1VlXW53u1pkBorJgWPI7Fhtp/+MsNaHOvu9
6LYsJTxlcJmubTfmuUdkAu10uocXAO18Ft4uS6Q2v3pNl4r56gp+bkKjNrGWMVRw
nP7rfquv4u51XVsRGQCvMC6IOlQKy2wZOBmILEZ0teUhn/Dn5RGZFcUykDhn7jHk
abk1Rjq0lJMjhoo9rYb2blCV618r+4QvYCWZwCP6WiFgQxmKK2TJn5jsjQ2Fo7GM
huEqlf5R3UHx0TCk01vtSYPmjwkMn7LqXuH8Co0vok3eDH//d6f/zVJ5x1vkY8p4
nXp6wcLvBQ45t32Hzl4KAKGUGogJeobQbv4kyDSvkKe1V03yDc9IUzoVMtug4KJH
32lhxBg5vzkoO+2Q+iMzaBIdi6jqe+VoKRmMqXnsEc9AmvJxlYU8MFeHpiYuploI
IRsHCPKVUd51QGDCfF2A
=adSN
-----END PGP SIGNATURE-----
--=-=-=--
