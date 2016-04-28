From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] fixes for sanitized submodule config
Date: Thu, 28 Apr 2016 16:02:07 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604281600020.9313@virtualbox>
References: <60724588-B06E-47E8-9302-8709C4601826@gmail.com> <CAGZ79kYmAr-O6_Jw2KO9eZEfZQ+_WBiERF=nhOYLJCZpUjSSyA@mail.gmail.com> <CA+P7+xoaqNF+uBHVnD2QR7j-=0Hyvd-scTc_vOdV+etC0VS9jA@mail.gmail.com> <20160425212449.GA7636@sigill.intra.peff.net>
 <017AA7DB-5224-49C3-A4A6-6C93005BF006@gmail.com> <20160428112511.GA11522@sigill.intra.peff.net> <20160428120504.GA22399@sigill.intra.peff.net> <20160428121753.GA5023@sigill.intra.peff.net> <20160428133534.GA19056@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git Users <git@vger.kernel.org>, Jens.Lehmann@web.de
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 28 16:02:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avmWO-0005j0-Ss
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 16:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbcD1OCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 10:02:20 -0400
Received: from mout.gmx.net ([212.227.17.22]:52343 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932AbcD1OCT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 10:02:19 -0400
Received: from virtualbox ([89.204.153.107]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LpPg1-1baru30bOn-00f77U; Thu, 28 Apr 2016 16:02:10
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160428133534.GA19056@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:hJlPY5+LYa51VHgwjMZMGrR5/ZMK01lYlKy9D2jnZ1/unQVH0X/
 oygS2vBWr74643LCgJdgTN5xsFfIdpUUKw2HnBycn3+vEkFX1e7002f3/2MROUV1wNSO0mV
 6HuRZvJtT4uNbo92Pwqi24eI7EWOqMrLEhBHFZU9xYyBu1svvupM0EHK8Et7fHWuv138AjL
 UhdkyQ/wUMkiabVxnQn1w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dn7oCjmh/L0=:yGFAMFQ9jjRKhnXuWuTXGC
 fensfChZkc6rsWHpfERAWOdAcrR1PFYG8Id4ssx/kujFJft8fwmVDrZzwcGyN3OzlRs9JOV3P
 7q4h+uSJiT27zBMF4+Ft8ix1qIq0H8giol+Uo006N8WcRmv1ZnbS2zfkrLYcIj0veFog64bQ/
 jkqpOzad6Wizhi1TziP6G8X9HWHOl348NBp9lKF4c9foP4+DR4Bv+hwLc+QbP+DPwuSLbEJPf
 nPNhTAr1NE/W+977lX7zotTmfhty3Ohcfna+rA2QwG6TZqw5XrkcmCHlhrnuoXMAJP7ziPw8o
 xoFSlOmhkeWpp5Q/XcZQRdsZQCvyMCvyhcsOKtwMk+mP6vHRfC4waCYvyaF145AEnVu2RUnOi
 xUjvNjaPsIV8rnVtVL1cgi8Z/s0RhlVzgWGIfvvs0haSlTY4YMy8aT9oMn1ulhJ4gra5qLSjM
 UeNs5DRRJFgjs9ghCW9SlBjvnvrAdR08lFQ6+Ej8LuAwmJ/6o/nGxSezjVM9Z3QwNhphWTs2T
 5vh5JMumR4Cnl4Ke/cegoDQOZBJeasO34nVJrLVq0x5d6eLH30lh53nboFG5i8l7GXLqtZPbH
 dSEthfemnCNiESUSnQzISLnO0eucNDfIl3HMlK1Vc9vdO7+8fviZL4+1zRGsnheaBzG4co+uF
 Z0B8L7HkDMS0/vdJJ77ZIHTm2dSI6YWVijAqr8QbyNvn7XSrnASoE6HnDW67784FhhIXRmxLn
 Z6zTpDD7DjIH2TNgTArDeVtXE9UqAQWHbhmL0l9w5Ks/2hqRhLLB7GWv+ig+txfAzOd++LHP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292885>

Hi Peff,

On Thu, 28 Apr 2016, Jeff King wrote:

> On Thu, Apr 28, 2016 at 08:17:53AM -0400, Jeff King wrote:
> 
> > So that case _is_ correct right now. It's just that t5550 isn't testing
> > the shell script part, which is broken. Probably running "git submodule
> > update" in the resulting clone would cover that.
> > 
> > And for the fetch case, we probably just need to be calling
> > prepare_submodule_repo_env() there, too.
> 
> So here's a series which fixes sanitizing in the "git-submodule" shell
> script, along with "git fetch". And cleans up a few things along the
> way.

Nice!

I reviewed those changes and they all look sensible to me (did not apply
them locally for lack of time, though).

Ciao,
Dscho
