From: Jose Luis Rivas Contreras <ghostbar38@gmail.com>
Subject: git-daemon whitelist issue
Date: Sat, 24 May 2008 09:34:58 -0430
Message-ID: <4838208A.6020205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 24 16:06:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzuNd-00023g-Uj
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 16:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046AbYEXOFB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 May 2008 10:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753225AbYEXOFB
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 10:05:01 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:57718 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032AbYEXOFA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 10:05:00 -0400
Received: by yw-out-2324.google.com with SMTP id 9so639375ywe.1
        for <git@vger.kernel.org>; Sat, 24 May 2008 07:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:x-enigmail-version:content-type:content-transfer-encoding;
        bh=yLm886D8EJgwCbP+zg9KLpt27sKHyUL7CyuUjMno8tY=;
        b=ROOd72iveSje5/6HfjIckNjN7nw0yb0EKl3igkRARFIFMsKYAZG2Aaz1gQFIe2QFEboBjG0mkRcFByvruu9FOEHuXCWiRYbI9EUYq+4lhnRyXfiyJ0uyPd9AebbtQLFnghp0pqcq88E6eN2zlphbyaGQZkkLBtnaFDUpn7SAMFo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:x-enigmail-version:content-type:content-transfer-encoding;
        b=PTgCh8mRdtITZ/uYQ/A52bfjinHLqkp5s4VV6WkpxS4VlB/zm7zgzbwx1lAuznHw0leYy5izgOxujqlln9hte6kRbzjOp3PsqSD5rhxv87SI+CbK/Fz14sgSr6nyUGGrS8BZY23l4sWlbeLylohydmkgTgSwxcvq8BsFv0+pMl8=
Received: by 10.150.50.3 with SMTP id x3mr1186356ybx.30.1211637898761;
        Sat, 24 May 2008 07:04:58 -0700 (PDT)
Received: from ?12.0.3.101? ( [190.37.64.169])
        by mx.google.com with ESMTPS id 4sm10959524yxd.2.2008.05.24.07.04.57
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 May 2008 07:04:58 -0700 (PDT)
User-Agent: Mozilla-Thunderbird 2.0.0.14 (X11/20080509)
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82815>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

[Please CC me, I'm not subscribed]

Hi, I know this will be a dummy question but I cannot find how to solve
this trying in several ways but none of them work. The issue is that
when I try to clone I get:

May 24 09:25:39 jooga git-daemon: [14724]
'/home/repo/git/xscreensaver.git': not in whitelist

My git-daemon conf is this:
8< -----
service git
{
        disable         =3D no
        type            =3D UNLISTED
        socket_type     =3D stream
        protocol        =3D tcp
        user            =3D nobody
        wait            =3D no
        server          =3D /usr/bin/git-daemon
        server_args     =3D --inetd --export-all
}
8< -----

I've tried with `--inetd --export-all /home/repo/git', `--inetd
- --export-all --base-path=3D/home/repo/git /home/repo/git', with
interpolated to with a symlink but nothing works, I'm trying with:

git clone git://repo.ghostbar.ath.cx/home/repo/git/xscreensaver.git nos=
eless

Anyway, cloning trough http worked but is not what I want :)

Any toughs?

Regards.
- --
Jose Luis Rivas. San Crist=C3=B3bal, Venezuela. PGP: 0xCACAB118
http://ghostbar.ath.cx/{about,acerca} - http://debian.org.ve
`ghostbar' @ irc.debian.org/#debian-ve,#debian-devel-es
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIOCCKOKCtW8rKsRgRArKWAKDFE4f1vbXZeuchYeQA7SnVqOzRdACdGWLs
MHWJpXTr5189qCEm07IX59w=3D
=3D5g4F
-----END PGP SIGNATURE-----
