From: Stephen & Linda Smith <ischis2@cox.net>
Subject: Re: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Sun, 06 Jan 2013 07:09:24 -0700
Message-ID: <2339898.c8oKya4a2t@thunderbird>
References: <2491041.bQ51Qu8HcA@thunderbird> <50E9647F.4090209@gmail.com> <20130106120917.GC22081@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Jason Pyeron <jpyeron@pdinc.us>,
	Eric Blake <eblake@redhat.com>, git@vger.kernel.org,
	Torsten =?ISO-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: ischis2@cox.net
X-From: git-owner@vger.kernel.org Sun Jan 06 15:09:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrquY-0006OM-F0
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 15:09:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755985Ab3AFOIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 09:08:54 -0500
Received: from fed1rmfepo201.cox.net ([68.230.241.146]:39429 "EHLO
	fed1rmfepo201.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755929Ab3AFOIx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 09:08:53 -0500
Received: from fed1rmimpo110 ([68.230.241.159]) by fed1rmfepo201.cox.net
          (InterMail vM.8.01.04.00 201-2260-137-20101110) with ESMTP
          id <20130106140852.WFQZ19285.fed1rmfepo201.cox.net@fed1rmimpo110>
          for <git@vger.kernel.org>; Sun, 6 Jan 2013 09:08:52 -0500
Received: from thunderbird ([24.251.82.172])
	by fed1rmimpo110 with cox
	id ke8s1k00D3j4oj401e8sjw; Sun, 06 Jan 2013 09:08:52 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020203.50E98574.0076,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=d8F3OGfE c=1 sm=1
 a=+a/fVzVtFbLp+jmGrq7Gkg==:17 a=HhTkiSSM8msA:10 a=e0l_DMu7-BoA:10
 a=G8Uczd0VNMoA:10 a=kj9zAlcOel0A:10 a=kviXuzpPAAAA:8 a=fF2DVJrTF3UA:10
 a=OR6XOmeiMEfmZnhQEd0A:9 a=CjuIK1q_8ugA:10 a=+a/fVzVtFbLp+jmGrq7Gkg==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.localnet (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id 34EAF14093C;
	Sun,  6 Jan 2013 07:09:25 -0700 (MST)
User-Agent: KMail/4.9.3 (Linux/3.5.0-21-generic; KDE/4.9.3; x86_64; ; )
In-Reply-To: <20130106120917.GC22081@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212804>

On Sunday, January 06, 2013 04:09:17 AM Jonathan Nieder wrote:
> Mark Levedahl wrote:
> >                                                          However, the
> >                                                          newer
> > 
> > win32api is provided only for the current cygwin release series, which can
> > be reliably identified by having dll version 1.7.x, while the older frozen
> > releases (dll versions 1.6.x from redhat, 1.5.x open source) still have
> > the
> > older api as no updates are being made for the legacy version(s).
> 
> Ah.  That makes sense, thanks.
> 
> (For the future, if we wanted to diagnose an out-of-date win32api and
> print a helpful message, I guess cygcheck would be the command to use.)

Thank you for the information.   I will update my cygwin installation.
