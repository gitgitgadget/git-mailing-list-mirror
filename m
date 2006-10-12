From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] diff --stat: use asymptotic scaling in graph
Date: Fri, 13 Oct 2006 00:52:12 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610130051440.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <d620685f0610121237k458665c5m7bbde2d565d7ef81@mail.gmail.com>
 <20061012201646.GC10922@admingilde.org> <d620685f0610121437m38eb454g7597b2a93010b023@mail.gmail.com>
 <452EBF99.5020108@gmail.com> <20061012222703.GA31152@admingilde.org>
 <452EC625.7050301@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Waitz <tali@admingilde.org>, apodtele <apodtele@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 13 00:59:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY9Pc-0004lF-W7
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 00:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWJLWwQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 18:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWJLWwQ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 18:52:16 -0400
Received: from mail.gmx.de ([213.165.64.20]:16844 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751278AbWJLWwO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Oct 2006 18:52:14 -0400
Received: (qmail invoked by alias); 12 Oct 2006 22:52:13 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp018) with SMTP; 13 Oct 2006 00:52:13 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
In-Reply-To: <452EC625.7050301@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28817>

Hi,

On Thu, 12 Oct 2006, A Large Angry SCM wrote:

> Martin Waitz wrote:
> > On Thu, Oct 12, 2006 at 03:20:09PM -0700, A Large Angry SCM wrote:
> > > > +    if (it)
> > > > +        return it * width / (it + width) + 1;
> > > > +    else
> > > > +        return 0;
> > > No conditional needed:
> > > 
> > > 	return it * width / (it + width - 1)
> > 
> > But then it would start scaling much earlier
> > (for width 10: at 2 instead of 4).
> > This is not bad per se, but different...
> > 
> 
> OK:
> 	return (it * width + (it + width)/2)) / (it + width - 1)
> 
> Now it's back at 4. ;-)

Am I the only one finding non-linear diffstat ugly and misleading?

Ciao,
Dscho
