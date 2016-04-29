From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 2/2] submodule: pass on http.extraheader config
 settings
Date: Fri, 29 Apr 2016 14:48:44 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604291443561.9313@virtualbox>
References: <3b71deffa5d07cf73a793773cc3d60ff611843fa.1461759454.git.johannes.schindelin@gmx.de> <cover.1461837783.git.johannes.schindelin@gmx.de> <89d0024450b0e6e9997ad9e3d681248bde1bafc0.1461837783.git.johannes.schindelin@gmx.de> <xmqqshy54j2h.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1604291429560.9313@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 14:49:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw7qu-0004IO-2j
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 14:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753558AbcD2Msz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 08:48:55 -0400
Received: from mout.gmx.net ([212.227.17.22]:63411 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753531AbcD2Msy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 08:48:54 -0400
Received: from virtualbox ([88.128.80.158]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M6fXs-1bsTjW0JMq-00wVS8; Fri, 29 Apr 2016 14:48:46
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <alpine.DEB.2.20.1604291429560.9313@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:viv2p2SEr1yoOtqPAYUCB9PtbiBpXndsIBC0Daa92A8FVpfh/6U
 lzc22y+3kGeRPomMlI6uauMZ8nT0n1jUX14SH0rjGGr7imKHescF5bpuZNr/UFeYBj+HJYD
 7rSgnKmuQt47R94rCdDxhTRqUX5WT3w9RHCJ48DOCPCvwmcqW5uQGE/o0/1uqoO+gvIH6oS
 Gsa1dNAC5YLN+Z3og8Qlw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hcoyJ+Z2Tq4=:isad0CrtopRP90PZlaFyew
 Chd1au7BejlKWb+ksF95OEp9EWV1SUoF3CAC/j1nwIToFyXbXAca7501WW3AO8ng0WuvYQBod
 QVrjKkY6APu0Vfte9/gCy7HgSk9YG6OW6eAkdkj9HNSkeTfT9Xwc2opdFfm0297gX2n4Imr/p
 xIPR/QJ480Z8MtmdpkpwmqTypoYGxsyjTClqRHc02FVgAdv931l2eFLXuRShU/6Sxj8rX6Dj5
 eBYzbMWmXlEagLqPDtgHVwjp3rKdLwXnuqwZKOWUH2fQAh342qiPjs71uLMyrvF2xoGcOTrpo
 VvRnkl0B4fKPwlfF5hF8W7yNUk62aiguDKKR6T56gaXe9zhwqAFgN9YAoIMqGkqDvG5TBG3rD
 +A0uzSr47ZKditIMsVTYGYBQ+rqCeEfH92eFtrWSdSJKqK16ouf4vsPfm9HTw7IWQtAJEM3dj
 u8K1is184KoT/+lCsXM7R69UzYoCtSjQdvOg18rIs8VcIaAwU1+Kj5HhdiN8Apepkv2aaDgbw
 YckjfsbS3v6v4Y/KZsZBmG9Zylrz3YqkahTCkZNR5IhtWyxb3/7FskdjYKE9TaXSeXIDegpz/
 zoRWdydtnyFjL0ZElka8h30H5pywsVaFhi2I3fhnJk2AMjT87Ijb0VM6IigOjNAC04tJgYhpz
 iNki3+fS5XdVL4Xvt9ndbjkyIY68AzDFeZfLBD74Zn20hxZY9jQIFrRoRFHKmdjSaMpvsh80b
 xNqUPQPWGrr2JZZQzCv6WRUBwQvGy1bHXL/ilj1CXF/8FrYj56ebYFJf54/5UFWip5bynZ0K 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292992>

Hi Junio,

On Fri, 29 Apr 2016, Johannes Schindelin wrote:

> On Thu, 28 Apr 2016, Junio C Hamano wrote:
> 
> > Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> > 
> > > -     if (starts_with(var, "credential."))
> > > +     if (starts_with(var, "credential.") ||
> > > +                     (starts_with(var, "http.") &&
> > > +                      ends_with(var, ".extraheader")))
> > 
> > I know you are fond of indenting with HT without aligning things,
> > but this is going too far in the quest of making the code
> > unreadable.
> 
> Hah. I am actually not fond of anything there, but I go with the default
> in my vim when selecting lines and pressing the '=' key...
> 
> If you know off-hand how to teach my vim to use your preferred indenting,
> I'll gladly just brow-beat it into submission.

For the record, I think the default in vim is to indent two tabs after an
unclosed parenthesis in an `if` line (the "(2s" just below
http://vimdoc.sourceforge.net/htmldoc/indent.html#javascript-indenting in
the default cinoptions). The "(0" setting fixes this, I think, so I forced
my vim to use

	cinoptions=>s,e0,n0,f0,{0,}0,^0,L-1,:s,=s,l0,b0,gs,hs,ps,ts,is,+s,c3,C0,/0,(0,us,U0,w0,W0,m0,j0,J0,)20,*70,#0

from now on.

Ciao,
Dscho
