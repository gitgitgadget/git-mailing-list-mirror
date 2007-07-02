From: free cycle <freecycler23@yahoo.com>
Subject: git Intall problem:  cannot stat `lib/tclIndex'
Date: Mon, 2 Jul 2007 15:16:15 -0700 (PDT)
Message-ID: <594387.97825.qm@web56006.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 00:16:31 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5UC0-00078S-Ef
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 00:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756263AbXGBWQR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 2 Jul 2007 18:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756130AbXGBWQR
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 18:16:17 -0400
Received: from web56006.mail.re3.yahoo.com ([216.252.110.185]:30441 "HELO
	web56006.mail.re3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755999AbXGBWQQ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 2 Jul 2007 18:16:16 -0400
Received: (qmail 98984 invoked by uid 60001); 2 Jul 2007 22:16:15 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=Q3029HGWJTuMZbPNwWHMKACMWALZBMjYghpcrBDhBq3MYiu5xNcRyB9qUHuViWzXF1536gcJvJPuGQbhF009vxSEa6hQ8RGPLCCxrwQAF/C4ZXDd5FADbVfVhuA6OAWAbxlntOab5UMaslWFq0rhNeojUs5JdO+FxV10HtNaJyA=;
X-YMail-OSG: bXx19YIVM1lIq3S5vDtRBHRbbkAiYgqb4WLZlFn0n4_P6NxOLIPZN9h1NKbKlxuaYwdO_COCfA--
Received: from [134.134.136.5] by web56006.mail.re3.yahoo.com via HTTP; Mon, 02 Jul 2007 15:16:15 PDT
X-Mailer: YahooMailRC/651.38 YahooMailWebService/0.7.41.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51415>


Apologies in advance..  I=92m not experienced at installing SW packages

   and I could not find anything in the FAQs about this=85

    =20

   I=92m trying to install git and I have run the following steps:

    =20

   make configure

   ./configure --prefix=3D/p/tools/git

   make all

   make install

    =20

    =20

   Everything works OK up until the =93make install=94 step at which po=
int I get the following error:

    =20

    =20

   ... stuff deleted

    =20

   install -d -m755 '/p/nhm/rtl/tools/git/share//git-gui/lib'

   install -m644 lib/tclIndex '/p/nhm/rtl/tools/git/share//git-gui/lib'

   install: cannot stat `lib/tclIndex': No such file or directory

   make[1]: *** [install] Error 1

   make[1]: Leaving directory `/nfs/site/disks/nhm.work.658/testing/git=
/git-gui'

   make: *** [install] Error 2

    =20

    =20

   =3D=3D=3D=3D=3D=3D=3D

    =20

   Note: it works OK if I don=92t try to install the gui.. and I have b=
een able to setup

   a git repo and I ran through the git tutorial (no gui required).

    =20

  =20
