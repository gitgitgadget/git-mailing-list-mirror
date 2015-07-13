From: Christoph Murczek <Christoph.Murczek@iteratec.at>
Subject: AW: "unable to remap" error with git svn after upgrade to Win10
Date: Mon, 13 Jul 2015 12:24:00 +0000
Message-ID: <8e6220ba0ffb43dbbc7c4eaefd2ab753@CIPEXMB03N1.ci04.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 13 14:24:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEcmb-0005uw-UD
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jul 2015 14:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbbGMMYX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jul 2015 08:24:23 -0400
Received: from mx58.system-hoster.com ([193.143.122.58]:52026 "EHLO
	mx58.system-hoster.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbbGMMYW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jul 2015 08:24:22 -0400
Received: from CIPEXMB03N2.ci04.de (172.18.1.230) by CIPEXHUB20.ci04.de
 (172.18.1.225) with Microsoft SMTP Server (TLS) id 15.0.847.32; Mon, 13 Jul
 2015 14:24:02 +0200
Received: from CIPEXMB03N1.ci04.de (172.18.1.229) by CIPEXMB03N2.ci04.de
 (172.18.1.230) with Microsoft SMTP Server (TLS) id 15.0.847.32; Mon, 13 Jul
 2015 14:24:01 +0200
Received: from CIPEXMB03N1.ci04.de ([::1]) by CIPEXMB03N1.ci04.de
 ([fe80::b583:2a88:608e:ee53%21]) with mapi id 15.00.0847.030; Mon, 13 Jul
 2015 14:24:01 +0200
Thread-Topic: "unable to remap" error with git svn after upgrade to Win10 
Thread-Index: AdC9X5sYdTsXJAMfSKG4G+DvXKFKogABxv/w
Accept-Language: de-AT, de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [91.217.118.58]
X-OLX-Disclaimer: Done
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273917>

Just wanted to let you know: a re-install of git also fixed the problem=
=2E

Cheers,
Christoph

-----Urspr=FCngliche Nachricht-----
Von: Christoph Murczek=20
Gesendet: Monday, July 13, 2015 14:10
An: 'git@vger.kernel.org'
Betreff: "unable to remap" error with git svn after upgrade to Win10=20

Hi,
I'm using git for windows 1.9.5-preview20150319 and was successfully us=
ing git svn, but after upgrading (from Win8.1) to Win10 git svn doesn't=
 work anymore. I get
	C:\Program Files (x86)\Git\bin\perl.exe: *** unable to remap C:\Progra=
m Files (x86)\Git\bin\libsvn_repos-1-0.dll to same address as parent --=
 0xC30000

I found a couple of issue reports on github referring to a workaround f=
or similar problems using rebase.exe, but are somewhat reluctant to ass=
ign memory on a trial and error basis. Can someone give me some pointer=
s on how to deduce a meaningful base address for libsvn_repos-1-0.dll t=
o pass to rebase.exe?

Also with the release date of Win10 approaching you might want to consi=
der a new release addressing the issue. I'd be surprised if I was the o=
nly one affected.

Best Regards,
Christoph
