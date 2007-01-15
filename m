From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Mon, 15 Jan 2007 16:44:37 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701151639490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701150144.56793.jnareb@gmail.com>  <200701151003.44498.jnareb@gmail.com>
  <20070115095613.GA4037@localdomain>  <200701151132.00971.jnareb@gmail.com>
  <20070115112635.GA5134@localdomain>  <Pine.LNX.4.63.0701151313050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <dbfc82860701150734j7322de15v30dc6822b456ea66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eric Wong <normalperson@yhbt.net>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 18:59:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6ViH-0006lY-1l
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:33:41 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6VAj-0003eK-Dj
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:59:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbXAOPuQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 10:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbXAOPuP
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 10:50:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:36995 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750875AbXAOPuO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 10:50:14 -0500
Received: (qmail invoked by alias); 15 Jan 2007 15:45:18 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp012) with SMTP; 15 Jan 2007 16:45:18 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Nikolai Weibull <now@bitwi.se>
In-Reply-To: <dbfc82860701150734j7322de15v30dc6822b456ea66@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36805>

Hi,

On Mon, 15 Jan 2007, Nikolai Weibull wrote:

> On 1/15/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > On Mon, 15 Jan 2007, Eric Wong wrote:
> 
> > > > Would you write "git repo-config --perl", then? ;-)
> 
> > > The below patch should be a start (only tested on my fairly standard
> > > .git/config).  A --python option should be easy, too :)
> 
> > A bit shorter (and gets the booleans right, plus being even easier
> > towards --python extension):
> 
> If we're going down this slippery slope, why not just give up and add
> a --xml switch instead?

AFAIR this switch was meant to _enhance_ performance.

> That said, parsing the config file as-is can't be so difficult that we 
> need to export it to separate files with a different syntax, now can it?

The point is having one parser to rule them all, and avoid having 
different parsers, all with their own set of shortcomings.

Ciao,
Dscho
