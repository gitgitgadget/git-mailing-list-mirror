From: Sebastien Toulmonde <Sebastien.Toulmonde@bisnode.com>
Subject: Git 1.9.0 - build on Solaris 8 -> no git-remote-http ?
Date: Thu, 25 Sep 2014 09:00:08 +0000
Message-ID: <938AB08865DF82448B10C2CD60FD0AA1012349C5EC@EEL.pcs.sopres.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 25 11:12:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XX563-00057b-Tt
	for gcvg-git-2@plane.gmane.org; Thu, 25 Sep 2014 11:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbaIYJMO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Sep 2014 05:12:14 -0400
Received: from esa3.bisnode.c3s2.iphmx.com ([68.232.133.47]:13235 "EHLO
	esa3.bisnode.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751351AbaIYJMM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2014 05:12:12 -0400
X-Greylist: delayed 695 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Sep 2014 05:12:11 EDT
X-IronPort-AV: E=Sophos;i="5.04,595,1406584800"; 
   d="scan'208";a="2949374"
Received: from postman.wegenerdm.be (HELO postman.sopres.be) ([194.78.134.90])
  by esa3.bisnode.c3s2.iphmx.com with ESMTP; 25 Sep 2014 11:00:22 +0200
Received: from bmix.wdmbelgium.be by postman.sopres.be; Thu, 25 Sep 2014 11:00:10 +0200 (MEST)
Received: from EAGLE.pcs.sopres.be (EAGLE [172.16.70.241])
	by bmix.wdmbelgium.be (8.13.1/8.13.1) with ESMTP id s8P909lb022336
	for <git@vger.kernel.org>; Thu, 25 Sep 2014 11:00:10 +0200 (MEST)
Received: from EEL.pcs.sopres.be ([::1]) by EAGLE.pcs.sopres.be
 ([fe80::389b:5a27:371c:96f9%19]) with mapi id 14.02.0328.009; Thu, 25 Sep
 2014 11:00:09 +0200
Thread-Topic: Git 1.9.0 - build on Solaris 8 -> no git-remote-http ?
Thread-Index: AQHP2J8bRKVle0YUO0iiCBAN4VEU/A==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101
 Thunderbird/24.6.0
x-originating-ip: [172.16.69.96]
Content-ID: <D62C61923E780E41B6DC3F211117A109@bisnode.be>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257473>

Hello all,

I'm trying to build Git from source for our end-users. Our platform=20
range from Solaris 8 to 10 (we're migrating to 11 this year).
Meanwhile, I'm trying to build Git from source, as there is no package=20
for Solaris 8/10 (opencsw can't be used in our environment). I've been=20
able to build it successfully, using Sun Studio and gmake 3.84. But=20
unfortunately, the build process does not compile/link any git-remote-*=
=20
programs... Which leads me to an unusable git for use in remote=20
architecture (which is what we use).

I've found nothing in the config.log regarding this... Does anyone have=
=20
a lead to the cause of this?
In parallel, as side-note, our Solaris 11 test server has a git package=
,=20
and this one does include the git-remote-*

Thanks for your help!

--=20
___________________________________________________

SEBASTIEN TOULMONDE
UNIX System Administrator
Information Services Department
 =20
BISNODE

Direct: +32 2 555 96 86
Mobile: +32 475 49 81 45
Office fax: +32 2 521 21 98
E-mail: sebastien.toulmonde@bisnode.com
Address: Researchdreef 65 All=E9e de la Recherche, 1070 Brussels, Belgi=
um
www.bisnode.be
__________________________________________________

**** DISCLAIMER ****
"This e-mail and any attachments thereto may contain information which =
is confidential and/or protected by intellectual property rights and ar=
e intended for the sole use of the recipient(s)named above. Any use of =
the information contained herein (including, but not limited to, total =
or partial reproduction, communication or distribution in any form)by p=
ersons other than the designated recipient(s) is prohibited. If you hav=
e received this e-mail in error, please notify the sender either by tel=
ephone or by e-mail and delete the material from any computer. Thank yo=
u for your cooperation."
