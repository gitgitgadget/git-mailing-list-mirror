From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: t7300-clean.sh fails "not ok 32 - should avoid cleaning possible
 submodules" on debian jessie
Date: Wed, 8 Jun 2016 09:12:27 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1606080911440.2680@virtualbox>
References: <5756856A.4020406@debian.org> <alpine.DEB.2.20.1606071229500.28610@virtualbox> <5756C6F4.5050300@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Pirate Praveen <praveen@debian.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 09:12:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAXfO-0005GK-W6
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 09:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195AbcFHHMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 03:12:39 -0400
Received: from mout.gmx.net ([212.227.15.15]:56633 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750837AbcFHHMi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 03:12:38 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MAyVY-1bIGuF2ptM-009zh8; Wed, 08 Jun 2016 09:12:27
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <5756C6F4.5050300@debian.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:xINDQf5X/8niLfsL5ilFl0DCPSUP1HwUsPUrhMI/igB+Zb/wEQ2
 3sr5KECTy44ULM7JPr9/t9Oum97Kxg5NZ5vqs0cEtTCevdayos4473+ABCU3d73wH5dwOdz
 KWbKsYP8lj3dG3eHzpLyo2APKQzU/lnoFM2arrx4W5Yzd0AgFNMFSim3tJihDUnKnF825Hk
 AUPA5EufJemjcneHVpL5w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:14H9AcSulNo=:19fHoXXPk8dYmczJJVNXZC
 FUstWv4s97/v+gJWrv7dZcKCO1MaqZJLqouohA4RPpRURwJsYyhjJExI0cg1tQcnfwkVizAFD
 kwF/5zJt+1cTQqDr4MDHekMN6m+Uji9T3Ig4+gUpDZRzG0am3TXtOrxyU72Xpxd+lReZwvabm
 ROIHvWkE5wPc2nnq8QEyThKuI3ph/N1aD6gYwzLzT0BP0bV747seF3t+PPJu7kTX+szswGm3D
 N5YYkZ6uCBkN6IR7zCLV96otc7IW3BoyEhsBttMrV/VcPOmqn0yUj/L+72uYQlVgESR1yA2AF
 9yvOxWSNFCaHa4kIH56XtG9/677biLOlCr92iXbxDKi1o5N04kEbITwJlowmfryQ57jb9BMCR
 0OvaKgRX+E5X+4gSn0WkBCXMNcfiEU19MPuCeWypqV6ZrD3+AwVAPW739m91b4ZyN/PI1ju1l
 ZLOFfg61B9CJE01rhbeek1sqjk1q3ZTYCmadM4OqGZOYj49m5eYTHhcIdkcUzCV1+EQJTyvJ9
 W8CbvRqniLRDYTuW4HyFH88qi1Kqz5Ood/Y2v6xSMa0VVNEXKXvncgITYPhlkw7srKwnCt1eJ
 T5cIut7E+26CTVV7h4IWgd+aCVShDbLCD8jCu6zQqfGWMrPnD2ZetEhTiRs4ePKR1B70N9c0k
 ifa6bgqHldJhS57crLiqhP75YHfdxKkT2SxmPM10N5WVT0Z71nEjitehixUn0BxUv9IuBIxf5
 hIXbh+Pw5LIa6TB74CM9Sk/qUxrM1x6GCG5kfnU9WH10HR1eavbU5KSX7TD3NFusRQ8LKJ/g 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296759>

Hi Pirate Praveen,

On Tue, 7 Jun 2016, Pirate Praveen wrote:

> On Tuesday 07 June 2016 04:00 PM, Johannes Schindelin wrote:
> > Hi Pirate Praveen,
> > 
> > On Tue, 7 Jun 2016, Pirate Praveen wrote:
> > 
> >> I'm trying to rebuild git 2.8.1 on debian jessie/stable and I get this
> >> error (tests upto this succeeds).
> >>
> >> not ok 32 - should avoid cleaning possible submodules
> > 
> > How about re-running the script with -i -v -x? If the output is still
> > not shining enough light on it, maybe you want to paste the (relevant part
> > of the) output into a reply?
> 
> + rm -fr to_clean possible_sub1
> [...]

Sorry, I must have missed your diligent analysis.

Ciao,
Johannes
