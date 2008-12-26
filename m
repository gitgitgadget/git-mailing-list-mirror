From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Re: [ANNOUNCE] git-cola 1.3.4
Date: Fri, 26 Dec 2008 01:48:57 -0600
Organization: Slide, Inc.
Message-ID: <1230277737.14882.54.camel@starfruit>
References: <20081225233625.GA11029@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-MYlCpFe+hq+QX5uIrEEY"
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 26 08:50:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LG7Sr-00044l-TK
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 08:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799AbYLZHtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 02:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752797AbYLZHtH
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 02:49:07 -0500
Received: from mx0.slide.com ([208.76.68.7]:53764 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752111AbYLZHtG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 02:49:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Subject:From:To:Date:Message-Id; bh=s
	SQPemg68Vqjsd58LrJpldzOoICI6eOZhfeVXpuihDA=; b=wsdfmsloFtOMZFVG4
	9XXGfEY8Na8U589k7+Kgy7FwD7jLOGRC4h1wCJOA69VZJGmHnRzWeLWccvjjbAJu
	MRT3uAo+23vnMVOczDxz9PtE3H7KAv+QdREC+C1wR6PoZdtFrVXB1sSU+sGKSr3q
	0wFFfUi+sDvfLdWs+a28vSwmXo=
Received: from nat3.slide.com ([208.76.69.126]:40510 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1LG7RR-0004Bf-Ra; Thu, 25 Dec 2008 23:49:05 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id CC2C0A6F0002;
	Thu, 25 Dec 2008 23:49:05 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.541
X-Spam-Level: 
X-Spam-Status: No, score=-2.541 tagged_above=-10 required=6.6
	tests=[AWL=-0.042, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qr0dCEVkTn-s; Thu, 25 Dec 2008 23:49:01 -0800 (PST)
Received: from [10.12.0.194] (unknown [10.12.0.194])
	by calculon.corp.slide.com (Postfix) with ESMTP id 74C34A6F0001;
	Thu, 25 Dec 2008 23:49:01 -0800 (PST)
In-Reply-To: <20081225233625.GA11029@gmail.com>
X-Mailer: Evolution 2.24.1.1 
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103921>


--=-MYlCpFe+hq+QX5uIrEEY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-12-25 at 15:36 -0800, David Aguilar wrote:
> The latest git-cola release v1.3.4 is available at the
> usual places:

Looks pretty nice, I was trying to give this a whirl on Python 2.6 and
was receiving the following errors while trying to build:

       =20
        tyler@starfruit:~/source/git/git-cola> /usr/bin/python setup.py
        build
        Traceback (most recent call last):
          File "setup.py", line 131, in <module>
            main()
          File "setup.py", line 21, in main
            __check_pyqt_version()
          File "setup.py", line 98, in __check_pyqt_version
            pyqtver =3D utils.run_cmd('pyuic4', '--version').split()[-1]
          File "/home/tyler/source/git/git-cola/cola/utils.py", line 50,
        in run_cmd
            return git.Git.execute(command)
          File "/home/tyler/source/git/git-cola/cola/git.py", line 96,
        in execute
            stdout=3Dsubprocess.PIPE)
          File "/usr/lib64/python2.6/subprocess.py", line 595, in
        __init__
            errread, errwrite)
          File "/usr/lib64/python2.6/subprocess.py", line 1106, in
        _execute_child
            raise child_exception
        OSError: [Errno 8] Exec format error
        tyler@starfruit:~/source/git/git-cola>=20
       =20
       =20
openSUSE 11.1 (my current OS) ships with 2.6 by default now, so I'm
curious as to the environment you're running cola in?

Looks fancy, can't wait to get it running :)

Cheers
--=20
-R. Tyler Ballance
Slide, Inc.

--=-MYlCpFe+hq+QX5uIrEEY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklUjGgACgkQFCbH3D9R4W8dUwCgh/T3cg8UGpaMCshSd0qC9MBI
KbMAoInvITutSmKl41PSF374shD7LYij
=IpP0
-----END PGP SIGNATURE-----

--=-MYlCpFe+hq+QX5uIrEEY--
