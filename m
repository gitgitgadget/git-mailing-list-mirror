From: "Boettger, Heiko" <Heiko.Boettger@karlstorz.com>
Subject: git submodule sync / git submodule rm
Date: Wed, 11 Nov 2015 10:18:40 +0000
Message-ID: <8C0042D8869AEA4AA334B49AFBBCEF8294713B41@TUT-EX02-PV.KSTG.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 11 11:18:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwSUH-0001ck-Tv
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 11:18:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350AbbKKKSm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Nov 2015 05:18:42 -0500
Received: from mx1.karlstorz.com ([62.134.46.135]:11714 "EHLO
	mx1.karlstorz.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121AbbKKKSl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Nov 2015 05:18:41 -0500
X-IronPort-AV: E=Sophos;i="5.20,275,1444687200"; 
   d="scan'208";a="34555946"
Received: from unknown (HELO TUT-EX04-PV.KSTG.corp) ([10.0.10.234])
  by mx1.karlstorz.com with ESMTP; 11 Nov 2015 11:18:40 +0100
Received: from TUT-EX02-PV.KSTG.corp ([169.254.2.245]) by
 TUT-EX04-PV.KSTG.corp ([10.0.10.234]) with mapi id 14.03.0248.002; Wed, 11
 Nov 2015 11:18:40 +0100
Thread-Topic: git submodule sync / git submodule rm
Thread-Index: AdEcaAQCoTIVxeKrQg+xTAlDUnoCxg==
Accept-Language: de-CH, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.10.246]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281157>

Hi,

i'm currently on a migration from svn to git and also have the task to =
convert the svnexternal to git submodules. During the migration step I =
am doing an automatic verification which needs a reliable way to switch=
 the working tree to another branch include the submodules.
When the submodule definition changes I miss a reliable command to upda=
te the .git/config:

1. the git submodule sync seems to do nothing if a module was removed
2. git submodule update complains about the missing entry in .gitmodule=
s
3. git submodule deinit doesn't work either and complains about missing=
 path in .gitmodules as well

These issues are partially described in the git book under https://git-=
scm.com/book/en/v2/Git-Tools-Submodules in section "Issues with Submodu=
les". Now what I am really missing is a way to keep the .git/config and=
 references in sync with the .gitmodules file which at best is integrat=
ed into git checkout. It is clear that I could write a script for that =
by myself, but it would be much better to have an integrated command fo=
r that which I though is git submodule sync, but unfortunately it doesn=
't do a complete sync of all settings.

In the google forum there was someone asking for a git submodule remove=
 command:

https://groups.google.com/forum/#!searchin/git-users/submodule/git-user=
s/Md72iVvPHqw/H_j3mT7bRq4J

I don't think that it is strictly required to remove the untracked file=
, this can be archived by a git clean as well, but is there any progres=
s on this.

Heiko B=F6ttger

STORZ Endoskop Produktions GmbH
Niederlassung Schaffhausen
Schneckenackerstr. 1
8200 Schaffhausen
Switzerland

-----------------------------------------------------------------------=
------------------------------------------
We would be most pleased to welcome you to MEDICA 2015 in D=FCsseldorf,
Germany, 16th -=A019th November 2015. You will find us in hall 10 booth=
 D22.
-----------------------------------------------------------------------=
------------------------------------------
