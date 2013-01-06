From: Stephen & Linda Smith <ischis2@cox.net>
Subject: Re: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Sat, 05 Jan 2013 23:20:56 -0700
Message-ID: <1890551.8jTmplCF6O@thunderbird>
References: <2491041.bQ51Qu8HcA@thunderbird>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org, jpyeron@pdinc.us
X-From: git-owner@vger.kernel.org Sun Jan 06 07:20:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrjbD-0006g6-H3
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 07:20:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996Ab3AFGU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 01:20:27 -0500
Received: from fed1rmfepo202.cox.net ([68.230.241.147]:34861 "EHLO
	fed1rmfepo202.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab3AFGU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 01:20:26 -0500
Received: from fed1rmimpo305 ([68.230.241.173]) by fed1rmfepo202.cox.net
          (InterMail vM.8.01.04.00 201-2260-137-20101110) with ESMTP
          id <20130106062026.OEVP1243.fed1rmfepo202.cox.net@fed1rmimpo305>
          for <git@vger.kernel.org>; Sun, 6 Jan 2013 01:20:26 -0500
Received: from thunderbird ([24.251.82.172])
	by fed1rmimpo305 with cox
	id kWLR1k00Q3j4oj401WLRJ7; Sun, 06 Jan 2013 01:20:25 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020206.50E917A9.0078,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=H8hZMpki c=1 sm=1
 a=+a/fVzVtFbLp+jmGrq7Gkg==:17 a=HhTkiSSM8msA:10 a=e0l_DMu7-BoA:10
 a=G8Uczd0VNMoA:10 a=kj9zAlcOel0A:10 a=kviXuzpPAAAA:8 a=fF2DVJrTF3UA:10
 a=NEAV23lmAAAA:8 a=N83Ps1sA_vDuXM3BTygA:9 a=CjuIK1q_8ugA:10
 a=+a/fVzVtFbLp+jmGrq7Gkg==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.localnet (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id 7E67A14093C;
	Sat,  5 Jan 2013 23:20:56 -0700 (MST)
User-Agent: KMail/4.9.3 (Linux/3.5.0-21-generic; KDE/4.9.3; x86_64; ; )
In-Reply-To: <2491041.bQ51Qu8HcA@thunderbird>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212753>

> Was it the commit before 
> 9fca6cffc05321445b59c91e8f8d308f41588b53 that compiles or was 
> it 9fca6cffc05321445b59c91e8f8d308f41588b53 that compiled? I 
> am doing a cygwin update presently to look at it.

Since the email earlier today, I had blown away the directory.   I just now 
did the following

git clone https://github.com/git/git.git git-src && cd git-src && make all
...   The make errored out as before

git co 9fca6c && make all
...   The make errored out as before

git co 9fca6c^  && make all
... and this compiles to completion

CYGWIN_NT-5.1 WINXPMACHINE 1.7.14(0.260/5/3) 2012-04-24 17:22 i686 Cygwin

What else can I do to test this out (I will get a current cygwin tomorrow to 
use in a test).
