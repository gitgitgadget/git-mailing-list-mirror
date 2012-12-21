From: Dennis Putnam <dap1@bellsouth.net>
Subject: Installation Plan
Date: Fri, 21 Dec 2012 09:43:53 -0500
Message-ID: <50D475A9.9020407@bellsouth.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8113CE7C413195FE75AB2B72"
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 21 15:51:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm3wH-0005ug-Js
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 15:51:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318Ab2LUOus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 09:50:48 -0500
Received: from nm12.access.bullet.mail.mud.yahoo.com ([66.94.237.213]:39843
	"EHLO nm12.access.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751031Ab2LUOuq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Dec 2012 09:50:46 -0500
X-Greylist: delayed 412 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Dec 2012 09:50:46 EST
Received: from [66.94.237.195] by nm12.access.bullet.mail.mud.yahoo.com with NNFMP; 21 Dec 2012 14:43:54 -0000
Received: from [98.138.226.240] by tm6.access.bullet.mail.mud.yahoo.com with NNFMP; 21 Dec 2012 14:43:54 -0000
Received: from [127.0.0.1] by smtp111.sbc.mail.ne1.yahoo.com with NNFMP; 21 Dec 2012 14:43:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bellsouth.net; s=s1024; t=1356101034; bh=yrWdt3t+NNg0rd4ffUQlDzYu17k+Iti1RiibetWHIjk=; h=X-Yahoo-Newman-Id:X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:Received:Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:X-Enigmail-Version:Content-Type; b=k8Uh/Be+9mc6TGsNbBJ8EiOt1PyNsO64kQjfD1l4zMwGg+YffGSPZ2ZRlDDGBQ77LJo3lBcV+jBsaHTDiQxvvkZasazPnYid6TsC88GL0nz2FYRZMZOHMTeGF5pexWPrOB5UeqlNZmSvYnc5yoNcVDwY+46wTowk8eWc8kSgUp4=
X-Yahoo-Newman-Id: 91702.22694.bm@smtp111.sbc.mail.ne1.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: ksqJ2yMVM1nSHOtKZhVXCJLM85ZwC0_cHMUCRFGG9zT_sYt
 eYvlSby5SJotrAfAzqxx0Vkz.QXJFTRz_AFAZkkkvO9BllJDvyJARh8KYCCs
 7vus8srVSh9Cyt3Lh9q4FmtfVJJObvQ33_NtvoH.sbPUX0N7DhwhAWFRx610
 hrGTVfdbyJjNeqm_oJ3nlGypE5GImV91Psf1lXdQXq9CytvqSPhuyUjG.9Et
 35mBzVdnso2zGGnoLs.uF6rm9TbijOd1t0Qn5ZBcFa3LGajcCKulZTZ_Cc7z
 tS_nh6RHUx0OBcEdKp1totGAR853yHcCSTgTimHpApO8.N_GHM3OUEufu9_V
 yB5En19GdOImU9Ep7g5xooP.QYHdzlUtFdWAswGQXqHB15BqRS43UTndGJX8
 y2p9N646o3SFkrxHv2xRYOcCcepMM45PJv2offI3P3DAbcfMxS57E
X-Yahoo-SMTP: vUK3UKuswBCE01YQVYEZ1wHCa.HPSVCYhektzgdifA--
Received: from [192.168.0.100] (dap1@74.232.16.78 with plain)
        by smtp111.sbc.mail.ne1.yahoo.com with SMTP; 21 Dec 2012 06:43:53 -0800 PST
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/17.0 Thunderbird/17.0
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211973>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8113CE7C413195FE75AB2B72
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

After re-reading the git documentation and with Andrew's input I have
changed my thinking on how to set  this up and want a central
repository. If I understand correctly, I am doing builds while I am
developing new code so I need to clone my repository for Eclipse (I'm
assuming the git plugin supports all this). Before I go to the trouble
of setting it up please correct where my thinking is flawed or where I
may run into gotchas.

1) Install git on Linux.
2) Copy existing Eclipse project to a new directory to become the
central repository.
3) git init in that new directory (I think I then do a git add and git
commit).
4) Modify build scripts to build from that directory (I am guessing I
need to git ignore the javac generated binary directory).
5) Install git plugin on Windows version of Eclipse. (Do I need git on
Windows or is the plugin sufficient?)
6) Configure plugin for remote git, if necessary?
7) Clone new repository for development and testing on Windows. (Do I
need the shared drive any more?)
8) When a new version is ready for release, push commit to remote
repository after which builds will use new code (I'm assuming the file
copies happen automagically).

Am I over simplifying things? I also think that this will open the door
for collaborators in the event I need them with no changes to the way I
work. I should note that builds are done on demand so is there a way to
detect when a push is occurring and have the build script wait for
completion and I suppose vise-versa? Thanks.


--------------enig8113CE7C413195FE75AB2B72
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDUdaoACgkQ/fiWYqZ2tVRuEQCgslAP3Obvbic1DtRARwNgovsD
iZYAn06kkoxxhDEz9QpGFpFyg9EeCrRy
=m6MA
-----END PGP SIGNATURE-----

--------------enig8113CE7C413195FE75AB2B72--
