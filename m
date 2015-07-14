From: Christoph Murczek <Christoph.Murczek@iteratec.at>
Subject: AW: AW: "unable to remap" error with git svn after upgrade to Win10
Date: Tue, 14 Jul 2015 21:04:57 +0000
Message-ID: <8e9a6445d54343708757e16052539b6a@CIPEXMB03N1.ci04.de>
References: <8e6220ba0ffb43dbbc7c4eaefd2ab753@CIPEXMB03N1.ci04.de>
 <cca8143375b9134b7a29f3748a3c4389@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 14 23:05:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZF7O1-0007n0-Ld
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 23:05:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190AbbGNVFE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jul 2015 17:05:04 -0400
Received: from mx68.system-hoster.com ([193.143.122.68]:60722 "EHLO
	mx58.system-hoster.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752683AbbGNVFD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jul 2015 17:05:03 -0400
Received: from CIPEXMB03N1.ci04.de (172.18.1.229) by CIPEXHUB21.ci04.de
 (172.18.1.226) with Microsoft SMTP Server (TLS) id 15.0.847.32; Tue, 14 Jul
 2015 23:04:59 +0200
Received: from CIPEXMB03N1.ci04.de (172.18.1.229) by CIPEXMB03N1.ci04.de
 (172.18.1.229) with Microsoft SMTP Server (TLS) id 15.0.847.32; Tue, 14 Jul
 2015 23:04:58 +0200
Received: from CIPEXMB03N1.ci04.de ([::1]) by CIPEXMB03N1.ci04.de
 ([fe80::b583:2a88:608e:ee53%21]) with mapi id 15.00.0847.030; Tue, 14 Jul
 2015 23:04:58 +0200
Thread-Topic: AW: "unable to remap" error with git svn after upgrade to Win10
Thread-Index: AQHQvhBG1Jc1GKW2PEqh7Lcn+V/18J3bcfwQ
In-Reply-To: <cca8143375b9134b7a29f3748a3c4389@www.dscho.org>
Accept-Language: de-AT, de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.143.102.67]
X-OLX-Disclaimer: Done
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273976>

Hi Johannes,
thanks for explaining why re-installing fixed my problem. Although I st=
ill can't wrap my head around why it happened in the first place. It co=
uld only be caused by Windows moving the base address of one, but not t=
he other thus causing the overlap. Sounds weird. But then again, what d=
o I know what's going on under the hoods when upgrading to Win10. ;)

In regards to your question: Yes I am running 64bit Windows, but the 32=
-bit version of git is the only thing I can download. I just double-che=
cked on the webpage, but there's no option to get a 64 bit download lin=
k, and if there was some logic determining whether I should get 32 or 6=
4 bit it puts me in the first bucket for some reason.
I haven't considered building from source yet, mostly because the 32bit=
 works fine so far. What would be the benefit? I guess performance when=
 dealing with large repos? If you have a 64bit version available and ne=
ed feedback let know. Always happy to help out :)

Cheers,
Christoph

-----Urspr=FCngliche Nachricht-----
Von: Johannes Schindelin [mailto:johannes.schindelin@gmx.de]=20
Gesendet: Tuesday, July 14, 2015 10:37
An: Christoph Murczek
Cc: git@vger.kernel.org
Betreff: Re: AW: "unable to remap" error with git svn after upgrade to =
Win10

Hi Christoph,

On 2015-07-13 14:24, Christoph Murczek wrote:
> Just wanted to let you know: a re-install of git also fixed the probl=
em.

That is probably because your original report (which I do not quote bec=
ause that was made too inconvenient by top-posting, sorry) suggests tha=
t the culprit was overlapping `.dll` ranges that need to be fixed using=
 the `rebase.exe` tool (which is confusingly completely unrelated to `g=
it rebase`), and that step is part of the installing process.

BTW assuming that you're on a 64-bit setup (Win10 and all...), why do y=
ou stick to the 32-bit version of Git for Windows?

Ciao,
Johannes
