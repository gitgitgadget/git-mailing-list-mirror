From: <Ankush_Aggarwal@DELL.com>
Subject: RE: Unable to clone GIT project
Date: Fri, 21 Sep 2012 17:24:23 +0000
Message-ID: <0D5A104FDD13FC4C9EE1E66F4FA3ABF60FD03E66@NOIX10HMNOI01.AMER.DELL.COM>
References: <0D5A104FDD13FC4C9EE1E66F4FA3ABF60FCFDB65@NOIX10HMNOI01.AMER.DELL.COM>
	<20120916104651.GF32381@localhost.localdomain>
	<CABPQNSbPF=_a7-+JnojM2DQAkkj7ZLhSnO+n-Ab=LSrHge1dnQ@mail.gmail.com>
	<20120917202124.GC24888@sigill.intra.peff.net>
	<0D5A104FDD13FC4C9EE1E66F4FA3ABF60FCFE5FB@NOIX10HMNOI01.AMER.DELL.COM>
 <m2392fk8dx.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <peff@peff.net>, <kusmabite@gmail.com>,
	<flatworm@users.sourceforge.net>, <git@vger.kernel.org>
To: <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Sep 21 19:30:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TF742-0005do-Sr
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 19:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141Ab2IURaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 13:30:46 -0400
Received: from ausxipps301.us.dell.com ([143.166.148.223]:21353 "EHLO
	ausxipps301.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932070Ab2IURao convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Sep 2012 13:30:44 -0400
X-Loopcount0: from 10.170.28.41
Thread-Topic: Unable to clone GIT project
Thread-Index: AQHNlXzdYCaE3mC8TS6/mSjwtniZiZeVEGgg
In-Reply-To: <m2392fk8dx.fsf@igel.home>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.16.82.164]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206140>

I have tried with iconv by adding its path in PATH and LIBRARY Path but failed to get any solution...
Still getting below error

c:\Ankush Data\work\Test-GIT\trial_1>git clone ssh://bea@<IP>:/home/bea/GIT/sample_project
Cloning into 'sample_project'...
bea@.<IP>:'s password:
git-upload-pack: error while loading shared libraries: libiconv.so.2: cannot open shared object file: No such file or directory
fatal: The remote end hung up unexpectedly 


-----Original Message-----
From: Andreas Schwab [mailto:schwab@linux-m68k.org] 
Sent: Tuesday, September 18, 2012 2:36 PM
To: Aggarwal, Ankush
Cc: peff@peff.net; kusmabite@gmail.com; flatworm@users.sourceforge.net; git@vger.kernel.org
Subject: Re: Unable to clone GIT project

<Ankush_Aggarwal@DELL.com> writes:

> On Linux machine
> 	Installed libiconv-1.14 unded /usr/local/lib path.

Why do you need that library?  iconv is part of glibc.  Moreover, git wouldn't link against libiconv anyway unless you explicitly ask for it.

Andreas.

--
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5 "And now for something completely different."
