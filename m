From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Multiple checkouts of the same repository
Date: Sun, 1 Oct 2006 21:17:57 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610012116310.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <3bbc18d20610011203p40d631b7o3bd2c6971a2bfcca@mail.gmail.com> 
 <Pine.LNX.4.63.0610012105590.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <3bbc18d20610011214y6132d98eq9cd58b23721bb87d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 01 21:18:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GU6p8-0007F5-Ef
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 21:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWJATSA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 15:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWJATR7
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 15:17:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:22210 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932221AbWJATR7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Oct 2006 15:17:59 -0400
Received: (qmail invoked by alias); 01 Oct 2006 19:17:57 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp017) with SMTP; 01 Oct 2006 21:17:57 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Matt McCutchen <hashproduct+git@gmail.com>
In-Reply-To: <3bbc18d20610011214y6132d98eq9cd58b23721bb87d@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28193>

Hi,

On Sun, 1 Oct 2006, Matt McCutchen wrote:

> On 10/1/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > A better method is to use a local clone:
> > 
> >         git-clone --local --shared A  B
> > 
> > Such a clone will be very fast, and cheap, because it sets up links (not
> > just symbolic links, but links that git understands).
> 
> But that gives me two separate repositories, so I have to push and
> pull to keep them in sync, which is a pain.

So you want the commits to show in A, too? I propose using a hook for 
that.

The fact is, your setup is fragile, and I think that is hard to fix if you 
do not make A and B git repositories in their own right.

Hth,
Dscho
