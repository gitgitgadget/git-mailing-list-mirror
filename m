From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: make test
Date: Mon, 15 Oct 2012 15:18:03 +0200
Message-ID: <003f01cdaad7$82969690$87c3c3b0$@schmitz-digital.de>
References: <k5gov5$fe1$1@ger.gmane.org> <507BEB12.9040101@viscovery.net> <003101cdaac4$430b7a30$c9226e90$@schmitz-digital.de> <507BF0EA.7000805@viscovery.net> <003801cdaac9$81d5bff0$85813fd0$@schmitz-digital.de> <507BF8FE.1060502@viscovery.net> <003901cdaacc$6f87e640$4e97b2c0$@schmitz-digital.de> <507BFD03.7060208@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Johannes Sixt'" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 15 15:18:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNkZ9-0003zL-ST
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 15:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753417Ab2JONSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 09:18:30 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:51772 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325Ab2JONS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 09:18:28 -0400
Received: from DualCore (dsdf-4d0a1987.pool.mediaWays.net [77.10.25.135])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0M5xcn-1TZEsM1kHB-00xrQL; Mon, 15 Oct 2012 15:18:27 +0200
In-Reply-To: <507BFD03.7060208@viscovery.net>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIVSFpveJljjAzS/2bNxxeCRCIxGwHjqAgSAptEk9IBw7/mtgF+OhWNAdUX+SMA3Fi1dgIPN99PlscRoAA=
Content-Language: de
X-Provags-ID: V02:K0:W2S5i6OiwQvYoJ9NL0s2ILrtD9eNCbxy6y3M61aRNnF
 v5+jCqPG0ZkEPTCYMDaDT+3ym8vBjrOOftGiA5c2aM7957X1v9
 kaSg1+oSCpH/2aRQzPmDvDafAEl8cVE7hHCYOBh0ywXfHHV3S9
 Nub24FV/MeMwOG+uZid9ZIspHMBErNNd+TkuFfZYIiBjdX1V5S
 uARyEl41ym+rG4YGpOtT0alhF+S8K4WTdVxXkfP/1DwCI3vwGo
 lWfpDofYmanPEjSq01fbXMqk7VbJRmwhggFQ8UAaFJU5Ov55xb
 JIH3wnY/UW7Ipzr+eDSJ/xQwrHLiitbswGI5lraO2DMfnFFWWr
 EGSbSKu2wzPEy9oCwGN/R8S7KRoh14ZeCTKT6wfWCKBhDkmpyt
 qgBEJSxZlErDA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207744>

> From: Johannes Sixt [mailto:j.sixt@viscovery.net]
> Sent: Monday, October 15, 2012 2:10 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org
> Subject: Re: make test
> 
> Am 10/15/2012 13:58, schrieb Joachim Schmitz:
> > ++ mkdir failing-cleanup
> > ++ cd failing-cleanup
> > ++ cat
> > ++ chmod +x failing-cleanup.sh
> > ++ test_must_fail ./failing-cleanup.sh
> > + eval_ret=1
> 
> I wonder why the log does not show the commands of function
> test_must_fail. Is there a 'set +x' hidden somewhere? Run
> ./failing-cleanup.sh manually. Check its exit code (it should be non-zero,
> but not something strange like 127 and above; see test_must_fail()) and
> dig further from there. I'll stop here.


It returns 0.
