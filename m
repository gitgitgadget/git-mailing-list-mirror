From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Multiple checkouts of the same repository
Date: Mon, 2 Oct 2006 12:16:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610021214070.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <3bbc18d20610011203p40d631b7o3bd2c6971a2bfcca@mail.gmail.com> 
 <Pine.LNX.4.63.0610012105590.14200@wbgn013.biozentrum.uni-wuerzburg.de> 
 <3bbc18d20610011214y6132d98eq9cd58b23721bb87d@mail.gmail.com> 
 <Pine.LNX.4.63.0610012116310.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <3bbc18d20610011404x52d8ba15ib51ac2a7060bd25e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 02 12:16:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUKqT-0007pH-Ty
	for gcvg-git@gmane.org; Mon, 02 Oct 2006 12:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWJBKQS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Oct 2006 06:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbWJBKQS
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Oct 2006 06:16:18 -0400
Received: from mail.gmx.de ([213.165.64.20]:58799 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750713AbWJBKQS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Oct 2006 06:16:18 -0400
Received: (qmail invoked by alias); 02 Oct 2006 10:16:16 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp007) with SMTP; 02 Oct 2006 12:16:16 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Matt McCutchen <hashproduct+git@gmail.com>
In-Reply-To: <3bbc18d20610011404x52d8ba15ib51ac2a7060bd25e@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28223>

Hi,

On Sun, 1 Oct 2006, Matt McCutchen wrote:

> On 10/1/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > The fact is, your setup is fragile, and I think that is hard to fix if you
> > do not make A and B git repositories in their own right.
> 
> I think my setup is much simpler than having two separate repositories
> that update each other using hooks.  What can go wrong, besides the
> scenario I mentioned where one working tree doesn't get updated when I
> commit through the other one?

I do not know, but it feels wrong. Git does not expect something like 
this, much like an operating system does not expect another computer to 
access its root hard disk. So _I_ think your setup is fragile.

Ciao,
Dscho
