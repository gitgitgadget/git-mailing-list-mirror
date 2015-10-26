From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 00/34] libify mailinfo and call it directly from am
Date: Mon, 26 Oct 2015 15:25:25 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1510261524000.31610@s15462909.onlinehome-server.info>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com> <1445239731-10677-1-git-send-email-gitster@pobox.com> <xmqqh9ll6xo8.fsf@gitster.mtv.corp.google.com> <5627B496.7030102@ramsayjones.plus.com> <5627EFE4.1060106@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Oct 26 15:26:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zqiih-0002EX-Bv
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 15:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246AbbJZOZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 10:25:34 -0400
Received: from mout.gmx.net ([212.227.17.21]:64663 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754126AbbJZOZc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 10:25:32 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0LezI3-1aI1v73DyR-00qhyw;
 Mon, 26 Oct 2015 15:25:26 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <5627EFE4.1060106@kdbg.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:FbUX0QqIGAW6C/wq0sfXQDwtJS8N29P52cUH6env9yCg5oeHOhb
 mJICa5QrWvgE+HxcTmOZJJKfJiSWPUyae9rePzXISQZj+0LCypfFxPgUdiCUgcmxAbiYwI1
 DXPGH3lSibZNK3VV3GKxLiTkBx4s9Fo6jZvKtJxIegNLwH+uvDGzdhOLXG/wLN1gdz4TDpo
 JTIV8iAhwlW9RJ0f+Of5g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ROsHdVryLNY=:JlznDjcdFpcVBddtvn6aKe
 2FlJB5CbyPEjKCbiC61Bsc6/mf5Xyx8sstjwgl62+v6CjacC13ksBeKaJKZxv5+uXNXtv5Cv5
 N8WefXxJdFQBuDYPUx6+rtl2bHVauQ2ym2iKrmwFvgx4JmapyZXcBpteqwvo8EPsGbMXnknTp
 zOacuckqHDqDyPjnJMUCEGImGyEPS/XtlbYrPlSYBtxBZAhpm//JqEMTQ1aMPAAYFKVqGmN5/
 u4acgVUrB+S4EVPXtWRGa0/jIc2JcxnY2qj2KzPTwMXWBEciYBOhadR6W+Z0ej124fFXVwy2X
 +OaWKEen6WwIF4k1WEp9OLP1SIVVx+/+dAy+dvQX6wmuHJwzbAuNIrF9P46jaEgZDVCRQYiK2
 xkMwEqwRY2SoePbL/jiyOsq3AAYEHBvXlV6R6GOcLq+d71XndfSMgS1LuJ7lGTcsQKEX3PZ87
 aHMPP/KMB0dZ8xe+5HeX7yzqrKMO85aPy53RTelNN0xgwfLxgxaQYc10KUdd3Vl4i9nbHamho
 B6LWFiuPIwaEVo74/CJGYZvMj4GnnclwPRDUgPsMAQpsgW5j0bFRsLQ6mrOkXwO5SpVcsbeoe
 ifPikczBHMlSm8jQm1+Q+1ouHR6XKDYcArtYFOq3vp+8NQHQ6DTZE5oTSpD4oh66m4NjD2x22
 Za/PFtWJ5knY+P5bDkwk6IAKiPSzIPvDnlx1Xcd4Ou0y3OQms5pzpKueFdIHjsRxShgguFVeA
 jcfhooeGzwdEyrWNMuktWZf53IsHq4362G9STAo3A9U0OuoP86yRb3LlT51k8SHTsLydHdmx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280196>

Hi,

On Wed, 21 Oct 2015, Johannes Sixt wrote:

> Am 21.10.2015 um 17:51 schrieb Ramsay Jones:
> > On 20/10/15 22:24, Junio C Hamano wrote:
> > > Junio C Hamano <gitster@pobox.com> writes:
> > > some numbers on my desktop (Dell T3500 2.66GHz Xeon X5650 with 12GB,
> > > running Ubuntu),
> >
> > I suspect that I haven't tested exactly the same version as you, but I had
> > a quick look at testing this on Cygwin today. I have included a complete
> > transcript (below), so you can see what I did wrong! :-P
> >
> > >
> > > Between 'master' and the version with this series (on 'jch'),
> > > applying this 34-patch series itself on top of 'master' using "git
> > > am", best of 5 numbers for running:
> > >
> > >      time git am mbox >/dev/null
> > >
> > > are
> > >
> > >        (master)                 (with the series)
> > >      real    0m0.648s            real    0m0.537s
> > >      user    0m0.358s            user    0m0.338s
> > >      sys     0m0.172s            sys     0m0.154s
> > >
> >
> > The corresponding times for me were:
> >
> >      (master)           (with the series)
> >    real	0m9.760s      real	0m5.744s
> >    user	0m0.531s      user	0m0.656s
> >    sys	0m5.726s      sys	0m3.520s
> >
> > So, yes, a noticeable improvement! :)
> 
> Same here, on Windows built with the old msysgit environment:
> 
> (master)             (with the series)
> real    0m3.147s      real    0m1.947s
> user    0m0.016s      user    0m0.000s
> sys     0m0.015s      sys     0m0.031s
> 
> Although I tested 'git am patches/*' where the patches/* are the result of
> 'git-format-patch v2.6.1..github/jc/mailinfo-lib'.

2.548s vs 2.068s here.

Ciao,
Johannes
