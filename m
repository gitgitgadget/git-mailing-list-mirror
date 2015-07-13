From: Christoph Murczek <Christoph.Murczek@iteratec.at>
Subject: "unable to remap" error with git svn after upgrade to Win10
Date: Mon, 13 Jul 2015 12:10:25 +0000
Message-ID: <9e9cbd8bf56d44dea4194dbac482f168@CIPEXMB03N1.ci04.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 13 14:16:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEceS-00022a-OX
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jul 2015 14:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbbGMMP7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2015 08:15:59 -0400
Received: from mx68.system-hoster.com ([193.143.122.68]:44250 "EHLO
	mx58.system-hoster.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751469AbbGMMP7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jul 2015 08:15:59 -0400
X-Greylist: delayed 327 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Jul 2015 08:15:58 EDT
Received: from CIPEXMB03N2.ci04.de (172.18.1.230) by CIPEXHUB21.ci04.de
 (172.18.1.226) with Microsoft SMTP Server (TLS) id 15.0.847.32; Mon, 13 Jul
 2015 14:10:28 +0200
Received: from CIPEXMB03N1.ci04.de (172.18.1.229) by CIPEXMB03N2.ci04.de
 (172.18.1.230) with Microsoft SMTP Server (TLS) id 15.0.847.32; Mon, 13 Jul
 2015 14:10:27 +0200
Received: from CIPEXMB03N1.ci04.de ([::1]) by CIPEXMB03N1.ci04.de
 ([fe80::b583:2a88:608e:ee53%21]) with mapi id 15.00.0847.030; Mon, 13 Jul
 2015 14:10:26 +0200
Thread-Topic: "unable to remap" error with git svn after upgrade to Win10 
Thread-Index: AdC9X5sYdTsXJAMfSKG4G+DvXKFKog==
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273916>

Hi,
I'm using git for windows 1.9.5-preview20150319 and was successfully using git svn, but after upgrading (from Win8.1) to Win10 git svn doesn't work anymore. I get
	C:\Program Files (x86)\Git\bin\perl.exe: *** unable to remap C:\Program Files (x86)\Git\bin\libsvn_repos-1-0.dll to same address as parent -- 0xC30000

I found a couple of issue reports on github referring to a workaround for similar problems using rebase.exe, but are somewhat reluctant to assign memory on a trial and error basis. Can someone give me some pointers on how to deduce a meaningful base address for libsvn_repos-1-0.dll to pass to rebase.exe?

Also with the release date of Win10 approaching you might want to consider a new release addressing the issue. I'd be surprised if I was the only one affected...

Best Regards,
Christoph
