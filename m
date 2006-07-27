From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Licensing and the library version of git
Date: Thu, 27 Jul 2006 18:38:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607271831200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910607261436v4c0802e5v7301e904593f9bab@mail.gmail.com> 
 <20060727114105.GZ13776@pasky.or.cz>  <Pine.LNX.4.63.0607271400160.29667@wbgn013.biozentrum.uni-wuerzburg.de>
  <9e4733910607270554p5622ee20ida8c264cf3122500@mail.gmail.com> 
 <20060727131127.GA13776@pasky.or.cz> <9e4733910607270911p50d25d97w1a898fc7a9119e7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 18:38:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G68sG-0004Fw-Hu
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 18:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWG0QiI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 12:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbWG0QiI
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 12:38:08 -0400
Received: from mail.gmx.net ([213.165.64.21]:29062 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750873AbWG0QiH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 12:38:07 -0400
Received: (qmail invoked by alias); 27 Jul 2006 16:38:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp020) with SMTP; 27 Jul 2006 18:38:05 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910607270911p50d25d97w1a898fc7a9119e7d@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24296>

Hi,

On Thu, 27 Jul 2006, Jon Smirl wrote:

> On 7/27/06, Petr Baudis <pasky@suse.cz> wrote:
> > > You may like trying to force GPL onto the app but many apps are
> > > stuck with the license they have and can't be changed since there is
> > > no way to contact the original developers.
> > 
> > At this point, git-shortlog lists exactly 200 people (at least entries
> > like Unknown or No name are all linux@horizon.com ;-).
> 
> Inability to integrate with Microsoft Visual Studio is going to have a
> lot of impact on the cross platform use of git.  Is a conscious
> decision being made to stop this integration or is this just unplanned
> side effect of the original license? If this is an unplanned side
> effect, the quicker we move, the easier it is to fix.

If you want to do it, go ahead. I think the reason it has not been done so 
far is that nobody had the need, or alternatively was not ready to do 
it or hire someone to do it.

> Note that only the code going into the library needs to be LGPL. That
> should significantly reduce the number of authors that need to be
> contacted.

No and no.

Let me tackle the second point first: Almost all functionality is in the 
library, and more is to be transferred to it.

The first point: If you want to integrate git into MSVC, you have to 
provide it via the SCCI. Note that the letter "I" stands for "Interface", 
which makes a runtime linking with the component a non-derivative work. 
Which basically means that you need not GPL MSVC.

> A first step to fixing this would be to add an immediate requirement
> that all new code that is targeted to library functions be licensed
> LGPL. That will at least stop the problem from getting any worse.

If you still feel the need for LGPL, go ahead, find all contributors and 
contact them.

Ciao,
Dscho
