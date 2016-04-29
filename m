From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 2/2] submodule: pass on http.extraheader config
 settings
Date: Fri, 29 Apr 2016 17:56:40 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604291756290.9313@virtualbox>
References: <3b71deffa5d07cf73a793773cc3d60ff611843fa.1461759454.git.johannes.schindelin@gmx.de> <cover.1461837783.git.johannes.schindelin@gmx.de> <89d0024450b0e6e9997ad9e3d681248bde1bafc0.1461837783.git.johannes.schindelin@gmx.de> <xmqqshy54j2h.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1604291429560.9313@virtualbox> <alpine.DEB.2.20.1604291443561.9313@virtualbox> <20160429131029.GA30931@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 29 17:57:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awAnH-0007Kt-G5
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 17:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753737AbcD2P5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 11:57:23 -0400
Received: from mout.gmx.net ([212.227.17.22]:58777 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753675AbcD2P5X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 11:57:23 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MfAog-1bJuzZ1kZm-00OpQe; Fri, 29 Apr 2016 17:56:43
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160429131029.GA30931@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:HvRJk9sRpyLfU/0oLbS7mAY2Vui762ztnfsaCq7hSfNCJFXG38z
 2UT5GZ3wniXqp+etLyAkLRQizayvMDW1AD0/3DSCNlgK7fPi7lTtX6gy30SCOXjccYScbHD
 XmPCQr4D7M75OzzESgcrHQgXdTd2FXlWegknMzBZCfnLG8PLcunLsVwsYyEX5uTGAg8oBiN
 ZWPzsrFAVFBDmx9UKb3cQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9tMfI/J2ySw=:NgDX6ONfX/2IDfCCtU8sq1
 iaDFuVvw+YKf2YTaTziAxjR+Nl59+QK+HRdk7PfS4Rjb2cHyo4ZfSuOF6pJkcacswoBkgIh3E
 3ZOWGkpFxtmYNtwebtAg1vnzsAQZ9BtToDkLsLRWf3AE07pz2Z6n2q7VCZRieXNVwC5rh7iG6
 EcInd835ubya6YGEsl7Hl/UMYm5eQhnEr0G//qWuNplNJ6hlc5xREIX5q0L6pB/bjLgrRyJbv
 HaXlWDN7a+lPE0i7XaThB89XQ8AfduRjfjlG+33GiOA8q5n67DEMRo2djRxsHg7mq7y24sbZ7
 j+VyEjoY3Mct0h3RVjJdsVmP8DSpW2UHiag+vghVx8uezJ+OARGgslQeLukoV4E4EoyT6lPu9
 IkqGK6b/eiHaqtNEum0q9ZympL9BJ+TvwAStd0n/v9XOKbPPu1rf3EFE0PhviSQTOEcJENmK1
 Vl8zbOTxdigYvjlCnZuK63KViRyhPQ3FGMPWMWWXL00oh6nQQxA5JrFHAHvdz0bysyafKEqy5
 Lftes1ZUhxo8ccbRKffFCGW110GCNOKw/TcX7c0NW+37AsBJUmQx14lj3VpW+QaBifjM0KYiQ
 2f8bPUMo0Q3A5ipmRva6sJTI+BvU45MGGipMHPwYESJSrglTGR5fU7Q8ZVsx1QvheVGGNNyiQ
 AKSPQYQRYRBK9gFSy5ketNJhc+IoSacaFW+d69oudZqQOsInTEC5v0ZpK/zJYgmkJtRf5K4ox
 sooRx+4SPeBdxWzF6XMLTd0k/i3dqMrtf6WYDWr+8lTT863DZ3N3gWnyEBxXXIA+6eurbfIv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293022>

Hi Peff,

On Fri, 29 Apr 2016, Jeff King wrote:

> On Fri, Apr 29, 2016 at 02:48:44PM +0200, Johannes Schindelin wrote:
> 
> > > If you know off-hand how to teach my vim to use your preferred indenting,
> > > I'll gladly just brow-beat it into submission.
> > 
> > For the record, I think the default in vim is to indent two tabs after an
> > unclosed parenthesis in an `if` line (the "(2s" just below
> > http://vimdoc.sourceforge.net/htmldoc/indent.html#javascript-indenting in
> > the default cinoptions). The "(0" setting fixes this, I think, so I forced
> > my vim to use
> > 
> > 	cinoptions=>s,e0,n0,f0,{0,}0,^0,L-1,:s,=s,l0,b0,gs,hs,ps,ts,is,+s,c3,C0,/0,(0,us,U0,w0,W0,m0,j0,J0,)20,*70,#0
> > 
> > from now on.
> 
> Yeah, "(0" is the only non-default cinoption I use for git.  Other than
> that, everything fits our guidelines (I guess I explicitly make sure
> shiftwidth and tabstops are all at 8, but I think those are the
> defaults, too).

Thanks for the confirmation!

Ciao,
Dscho
