From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: Bug: git push crashing
Date: Fri, 12 Apr 2013 21:32:59 +0200
Message-ID: <201304122132.59464@pali>
References: <201304122050.26471@pali> <20130412190630.GM2222@serenity.lan>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6618889.Y5tEnS0VAS";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Apr 12 21:33:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQjig-0000qG-Dm
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 21:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296Ab3DLTdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 15:33:04 -0400
Received: from mail-ee0-f48.google.com ([74.125.83.48]:41421 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037Ab3DLTdD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 15:33:03 -0400
Received: by mail-ee0-f48.google.com with SMTP id b15so1448204eek.35
        for <git@vger.kernel.org>; Fri, 12 Apr 2013 12:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=YIiHJJyV59MIKs+Je9jHB7y3LB/6GYkV7NcMLBGYGfc=;
        b=03C/Mpdv4l/wrYDVRDrraNa+ffT+xeMUvGuUc71Tm1w56n+RHvxZfobT6s0WfpMrI+
         Su76YaEQsQKR6GWdGiyitU2/ZI2ILfngRzUjb+4XmgU9rfuvobvFOgrmZy4tLPaAEj0i
         nIfscyH3HptbnARNbzb2I2IDje6JIPDZ7kLTfO/fgWz7tBFPtmhh5hVLFx9Mkg48wAho
         dbHIY1n+9Sfo0oaIBHzKPNmOEJd9iMiMHVqDKId4r7c1hJ6wf1O1YPmboTSL5k63noO4
         VUiJbA6dA0jnpbENjCKj10eS0Wdb0oLgaiuwF7RszAKlhmOwNALHLKcdbWzj2Kf1OcrT
         ZDhQ==
X-Received: by 10.14.89.69 with SMTP id b45mr31186138eef.10.1365795181869;
        Fri, 12 Apr 2013 12:33:01 -0700 (PDT)
Received: from pali-elitebook.localnet (pali.kolej.mff.cuni.cz. [78.128.193.202])
        by mx.google.com with ESMTPS id f47sm12699402eep.13.2013.04.12.12.33.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Apr 2013 12:33:00 -0700 (PDT)
User-Agent: KMail/1.13.7 (Linux/3.5.0-27-generic; KDE/4.10.2; x86_64; ; )
In-Reply-To: <20130412190630.GM2222@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221018>

--nextPart6618889.Y5tEnS0VAS
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 12 April 2013 21:06:31 John Keeping wrote:
> On Fri, Apr 12, 2013 at 08:50:25PM +0200, Pali Roh=C3=A1r wrote:
> > when I'm trying to push one specific branch from my git
> > repository to server, git push crashing. Pushing branch is
> > rejected by server (because non fast forward), but local
> > git app should not crash.
> >=20
> > I'm using git from ubuntu apt repository (compiled myself
> > for debug symbols), version git_1.7.10.4-1ubuntu1 on amd64
> > ubuntu system:
> > http://packages.ubuntu.com/source/quantal/git
> >=20
> > Here are gdb backtrace and valgrind outputs. I changed
> > server, repo and branch strings from output. It looks like
> > that git crashing in strcmp function because one of
> > arguments is NULL.
> >=20
> > If you need more info, I can send it. This crash occur
> > always. I can reproduce it again and again...
>=20
> This looks like the same issue that was fixed by commit
> 1d2c14d (push: fix segfault when HEAD points nowhere -
> 2013-01-31).
>=20
> Can you try again with Git 1.8.2 and see if the crash still
> happens?

Hello, now I tried version 1.8.2.1 and git push not crashing :-)=20
I also tried version 1.8.1 and as expected it crashed.

So thanks for quick reply, seems that this problem is already=20
fixed in 1.8.2.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart6618889.Y5tEnS0VAS
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlFoYWsACgkQi/DJPQPkQ1INJgCcCdgE958KK4JmNrn7iwwnhPaX
UycAn2T8Q0GbhVgSpmFOryRad/PUsNpX
=f4eo
-----END PGP SIGNATURE-----

--nextPart6618889.Y5tEnS0VAS--
