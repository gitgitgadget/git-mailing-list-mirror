From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Re: [ANNOUNCE] git-cola 1.3.4
Date: Fri, 26 Dec 2008 02:44:38 -0600
Organization: Slide, Inc.
Message-ID: <1230281078.14882.89.camel@starfruit>
References: <20081225233625.GA11029@gmail.com>
	 <1230277737.14882.54.camel@starfruit>
	 <402731c90812252359r5b6b9420hcadbfa076f561feb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-tNqM0AfiHq/AHIqaWqNs"
Cc: Git Mailing List <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 26 09:46:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LG8Kc-0005EU-E9
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 09:46:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886AbYLZIoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 03:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752805AbYLZIop
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 03:44:45 -0500
Received: from mx0.slide.com ([208.76.68.7]:49589 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750752AbYLZIoo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 03:44:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Subject:From:To:Date:Message-Id; bh=7
	4zINWa7a6Kh4QPTPbQFtgNkAeFw3XPK8pLO6XSOLBY=; b=AeYfuAleAU9tL6JW4
	JMGZais+8Emda1940w3jZxXZD5ME3SjfDltUDDklHaKiDdHvuzzLOV0Uh2qLuf8j
	amEFNW3s5CqVgH6Li0fblKkZvrctIRdnhbkn0AQ9nG0oVVRSWFnjJxb2dWZkPe1Z
	99klsm/810bWa4C6M+8N6kSt1s=
Received: from nat3.slide.com ([208.76.69.126]:39249 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1LG8JH-0005et-Mj; Fri, 26 Dec 2008 00:44:43 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id A71ACA6F0002;
	Fri, 26 Dec 2008 00:44:43 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.524
X-Spam-Level: 
X-Spam-Status: No, score=-2.524 tagged_above=-10 required=6.6
	tests=[AWL=-0.025, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Jjc+DNaqLZl; Fri, 26 Dec 2008 00:44:43 -0800 (PST)
Received: from [10.12.0.194] (unknown [10.12.0.194])
	by calculon.corp.slide.com (Postfix) with ESMTP id F14FEA6F0001;
	Fri, 26 Dec 2008 00:44:42 -0800 (PST)
In-Reply-To: <402731c90812252359r5b6b9420hcadbfa076f561feb@mail.gmail.com>
X-Mailer: Evolution 2.24.1.1 
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103924>


--=-tNqM0AfiHq/AHIqaWqNs
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-12-25 at 23:59 -0800, David Aguilar wrote:

> I'm on debian.  There's official debian packages these days that are
> making their way into both ubuntu and debian.
>=20
> I'm probably doing something wrong since maybe pyuic4 isn't supposed
> to be called via subprocess.Popen()?  See the INSTALL file under
> 'build issues'.  Your pyuic4 is missing a shebang line at the top of
> the file.  I'm not sure if that's a packaging bug (openSUSE) or pyqt4
> bug.  debian's pyuic4 has a #!/bin/sh line at the top and thus doesn't
> have this issue.  I should probably change it so that it works either
> way...  i'll see if I can work around that.


Impressive call! Adding the shebang to pyuic4 solved the issue, but I'm
as far in the dark as you are as to whose packaging domain this bug
falls under.

So that issue is out of the way, here's the next one I figure I should
pass your way :)

       =20
        tyler@starfruit:~/source/git/git> git cola
        Traceback (most recent call last):
          File "/usr/local/bin/git-cola", line 54, in <module>
            main()
          File "/usr/local/lib64/python2.6/site-packages/cola/main.py",
        line 114, in main
            view =3D View(app.activeWindow())
          File
        "/usr/local/lib64/python2.6/site-packages/cola/views/main.py",
        line 22, in __init__
            self.setupUi(self)
          File
        "/usr/local/lib64/python2.6/site-packages/cola/gui/main.py",
        line 183, in setupUi
            self.splitter.setSortingEnabled(__sortingEnabled)
        AttributeError: setSortingEnabled
        tyler@starfruit:~/source/git/git>=20


(Pdb) self.splitter
<PyQt4.QtGui.QSplitter object at 0x9d88d0>
(Pdb) [f for f in dir(self.splitter) if f.lower().find('sort') >=3D 0]
[]
(Pdb)=20

I went ahead and changed the following lines in cola/gui/main.py to get
it up and running:


       =20
        181         item =3D QtGui.QTreeWidgetItem(self.status_tree)
        182         item =3D QtGui.QTreeWidgetItem(self.status_tree)
        183         #self.splitter.setSortingEnabled(__sortingEnabled)
        184         self.horizontalLayout_2.addWidget(self.splitter)
        185
        #self.centralwidget.setSortingEnabled(__sortingEnabled)
        186         main.setCentralWidget(self.centralwidget)
       =20

This whole set up is very confusing to me, it appears that those files
(judging by your .gitignore) are being generated by the Qt4 .ui files,
but how that translates into submitting a patch I haven't the faintest
idea :)


I got something running at the very least I suppose :)

Cheers

--=20
-R. Tyler Ballance
Slide, Inc.

--=-tNqM0AfiHq/AHIqaWqNs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklUmXYACgkQFCbH3D9R4W/bkACeOUrqjBRxwhJbZZRrM4MutIi+
NIkAoKKoBhQSrQOsOiOEi6eq8FfKTSat
=0dTp
-----END PGP SIGNATURE-----

--=-tNqM0AfiHq/AHIqaWqNs--
