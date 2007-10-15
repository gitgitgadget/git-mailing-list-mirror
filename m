From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 01:01:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710150059460.25221@racer.site>
References: <1192293466.17584.95.camel@homebase.localnet><uy7e6keyv.fsf@gnu.org><1192381040.4908.57.camel@homebase.localnet><1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr><47125F74.9050600@op5.se><Pine.LNX.4.64.0710141934310.25221@racer.site><47126957.1020204@op5.se><Pine.LNX.4.64.0710142112540.25221@racer.site>
 <20071014221446.GC2776@steel.home> <023101c80eb5$e3b6b310$2e08a8c0@CAM.ARTIMI.COM>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: 'Alex Riesen' <raa.lkml@gmail.com>, 'Andreas Ericsson' <ae@op5.se>,
	'git list' <git@vger.kernel.org>,
	'Make Windows' <make-w32@gnu.org>
To: Dave Korn <dave.korn@artimi.com>
X-From: git-owner@vger.kernel.org Mon Oct 15 02:01:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhDOa-0002qf-8n
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 02:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760086AbXJOABI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 20:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759939AbXJOABH
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 20:01:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:48594 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759930AbXJOABG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 20:01:06 -0400
Received: (qmail invoked by alias); 15 Oct 2007 00:01:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp049) with SMTP; 15 Oct 2007 02:01:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+SKUpmnwCSdW7KRmNrpeithHmUAwebAQ8+up3Euj
	K2B9Iz08rA58pU
X-X-Sender: gene099@racer.site
In-Reply-To: <023101c80eb5$e3b6b310$2e08a8c0@CAM.ARTIMI.COM>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60930>

Hi,

On Sun, 14 Oct 2007, Dave Korn wrote:

> On 14 October 2007 23:15, Alex Riesen wrote:
> 
> > Interprocess communication:
> > 
> > - no reliable text environment (I'm programming in the damn thing for
> >   10 years and I still don't know how to pass an environment variable
> >   _for_sure_)
> > 
> > - it has only one argument (limited in size) passed to started
> >   programs, which means that there is no possible way to safely pass
> >   file and text arguments on command line (more than one, that is)
> 
>   Whuh?
> 
> http://msdn2.microsoft.com/en-us/library/y5zz48s1(VS.80).aspx

It does have an exec() call, yes, since that is required by the C 
standard.  But internally, it converts that into one single command line.

In corner cases, you find problems with that.

Hth,
Dscho
