From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] commit: ensure correct permissions of the commit
 message
Date: Wed, 30 Dec 2015 15:50:09 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1512301535550.14434@virtualbox>
References: <4aa11f02f4de113bf38152b8815658da42690f43.1450549280.git.johannes.schindelin@gmx.de> <20151220074559.GF30662@sigill.intra.peff.net> <xmqq7fk8io3f.fsf@gitster.mtv.corp.google.com> <20151221065944.GA3550@sigill.intra.peff.net>
 <xmqqio3rhg2f.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Yaroslav Halchenko <yoh@onerussian.com>,
	=?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 15:50:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEI5V-0006eV-DO
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 15:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680AbbL3Ouj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 09:50:39 -0500
Received: from mout.gmx.net ([212.227.17.20]:49953 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751537AbbL3Oui (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 09:50:38 -0500
Received: from virtualbox ([37.24.143.189]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M7Y9j-1a1Ae3203j-00xNNQ; Wed, 30 Dec 2015 15:50:12
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqio3rhg2f.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:1XoMLBRrfFoTliB0v2mCFWtluv76SgcubxK1lpZRA0NaI1BrwmY
 ARpOkttSHYeHl0nmA8fyGcG3gpIiF413YVTjqqLNJ1WiwX3MNwTNJIX5pInhMDNDM8hNMJZ
 WqjC3gMIkKofZ8FvA/lB2wfSzt4C81FjttNtWwoNCBMrwSuYcPEtYFdJMYVuWH842nhnbuY
 37ePJbhsPZBhA30zq+ByQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:29V9F+qhVYw=:9Uz9o1MGidZNFqu5Le3tet
 QLMgsf6fCy8YnLLEJyxnm/7Zbu9rgwxzXUfxRrldYGR3enRiYYBtlH4HSs1nQMCkGPpev/8O0
 yYzfRU/18PREKX/iPhsFFpcXDywJnd5qkqa5nZTbiHBrW3qco2orV/K4m591A4UbuWyw+MM0C
 nZavmM57XOSviFIo4O1dBzPS+LC0K8L3GsHIT1i/mV8CpY241yzoEDZ9JBVAT9BO65QCtRm/6
 +YH9lAkfKPPL+i2KJeaSy5APR4pseuxVx0cKB0Ffn8wrf/PksBDZKqpVBbsUXQAo1IUlbQ4g4
 HMC3xhDEfe26KPJZY91yiHrsvCHfTNZaVJAf2AxK+Du3JIX1/dS8ZoAnDADU5a3uDYLlhOfCY
 Sc+4vqCs8bahjunk9VxGSwVVN3acJ1y7f54N2CL83yDrf3yWgWT/tXsBtF1itaUtLoIWcqt6e
 Fff3vZQZ3DIp4GKLBjVuxthbLZY+RKWRifj+EZpBbUU/kp09UwVFi6WdpyXAihxS36UUN9zul
 H7ovf5CFFXkes5PTWX8mcnGPLRCJIEc+Ns/bnDVuBCEYhjIeo8SBxtRE3lS70KBg7MiC8L0Nz
 bj7qsnRyNk5vvrpPzaLV3b45jqyHDfuqf+LQKSnVlcM1STHeQaBWTqI9D4Lo3+jCLpaSlBZI0
 cCpMInGmzVpjvmuTAkb8dgKz5XfaQUePQU2lKP2Qx4dZ+NGNgnuwJ6ANz7syeDIh8abWJ3QOw
 3JMiqsYPwZUJZW9f3V4oxZXmRquDgbe6wdWlerLA/9LAk0cX/u1CfNMYuWpk/P8dfEpxM33B 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283184>

Hi,

On Mon, 21 Dec 2015, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Sun, Dec 20, 2015 at 05:31:48PM -0800, Junio C Hamano wrote:
> >
> >> we could do something like this, perhaps?
> >> 
> >>         FILE *fopen_forcibly(const char *path, const char *mode)
> >>         {
> >>                 FILE *ret = fopen(path, mode);
> >> 
> >>                 if (!ret && errno == EPERM) {
> >>                         if (!unlink(path))
> >>                                 ret = fopen(path, mode);
> >>                         else
> >>                                 errno = EPERM;
> >>                 }
> >>                 return ret;
> >>         }
> >
> > Yeah, I think that is a much nicer solution for this case. It should
> > work even in a shared repo, since we set the permissions for the
> > surrounding $GIT_DIR appropriately[1].
> >
> > I guess it would not apply to any files that do not want to truncate the
> > existing contents. Probably it should drop the "mode" parameter at all,
> > since anything but "w" would be crazy?
> 
> Absolutely.  Thanks for spotting.

So maybe

	fcreate_or_truncate(const char *path)
	{
		 FILE *ret = fopen(path, "w");

		 if (!ret && errno == EPERM) {
			 if (!unlink(path))
				 ret = fopen(path, "w");
			 else
				 errno = EPERM;
		 }
		 return ret;
	 }

?

Ciao,
Dscho
