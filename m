From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Heads up: major rebase -i -p rework coming up
Date: Sun, 25 Jan 2009 16:24:46 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901251622310.14855@racer>
References: <alpine.DEB.1.00.0901242056070.14855@racer>  <200901242347.23187.trast@student.ethz.ch>  <alpine.DEB.1.00.0901250303150.14855@racer>  <alpine.DEB.1.00.0901250324320.14855@racer>  <glhqdi$tec$1@ger.gmane.org>  <alpine.DEB.1.00.0901251509550.14855@racer>
 <bd6139dc0901250707m5e1898cdu530a0d7566ca2da5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 25 16:25:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LR6rl-0005kw-ET
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 16:25:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755433AbZAYPYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 10:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754093AbZAYPYT
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 10:24:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:57975 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753115AbZAYPYT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 10:24:19 -0500
Received: (qmail invoked by alias); 25 Jan 2009 15:24:17 -0000
Received: from pD9EB3E0E.dip0.t-ipconnect.de (EHLO noname) [217.235.62.14]
  by mail.gmx.net (mp062) with SMTP; 25 Jan 2009 16:24:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18yMclMNM8yEU4KWiEkGBm92R37QJ/cBTCsritsBd
	+PCKzlvvx9Uxu0
X-X-Sender: gene099@racer
In-Reply-To: <bd6139dc0901250707m5e1898cdu530a0d7566ca2da5@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, 25 Jan 2009, Sverre Rabbelier wrote:

> On Sun, Jan 25, 2009 at 15:17, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >> >>       merge (B) A # Merge...
> >> >         merge B parent A' # Merge...
> >> merge B with A' # Merge...
> >        merge B Merge bla/blub
> >        parent A' bla/blub
> 
> Oh goody, more painting! I was wondering when the next pick-a-word
> contest would be!

In this case, it is not about painting.  I will gladly ignore all those 
who think they must submit a new word for this action.

The thing is: I want the command to be intuitive, so I need a syntax where 
even the most idiotic dullard will understand what are the parents, and 
why we need the original merge's commit name, too.

So maybe I answered my question myself:

	merge parents $sha1 [$sha1...] original $sha1 $msg

Ciao,
Dscho
