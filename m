From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Recording cherry-picked commits
Date: Sun, 23 Mar 2008 15:12:38 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803231512110.4353@racer.site>
References: <ae63f8b50803210533n12645fb3w9a8be601c4cc394@mail.gmail.com>  <ae63f8b50803220937k78571fbdl1eeb60966ec7aa40@mail.gmail.com>  <b77c1dce0803221548x3250cb90taa9a9d53464f7ea7@mail.gmail.com>  <ae63f8b50803230407u7062586dy26fab7d98090efb9@mail.gmail.com>
  <alpine.LSU.1.00.0803231309370.4353@racer.site> <b77c1dce0803230657i6d61abefg3b0ee7b42119927c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jean-Baptiste Quenot <jbq@caraldi.com>, git@vger.kernel.org
To: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 15:13:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdQwq-0007dK-0I
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 15:13:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759074AbYCWOMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 10:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758973AbYCWOMj
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 10:12:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:58894 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754674AbYCWOMj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 10:12:39 -0400
Received: (qmail invoked by alias); 23 Mar 2008 14:12:37 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43]
  by mail.gmx.net (mp056) with SMTP; 23 Mar 2008 15:12:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/VaXBL+DjVqXJwAi6yBayPBqCjlz86pjCdzfD7aC
	daZ8nBhMQJmqVv
X-X-Sender: gene099@racer.site
In-Reply-To: <b77c1dce0803230657i6d61abefg3b0ee7b42119927c@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77904>

Hi,

On Sun, 23 Mar 2008, Rafael Garcia-Suarez wrote:

> On 23/03/2008, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Actually, you should not store it in the root of the working tree, but in
> >  the git dir (because it should never be tracked!), and then you can make
> >  it non-hidden:
> >
> >         file="$(git rev-parse --git-dir)"/cherry
> 
> But this way, how can it be shared among several repositories?

As I said, I would not want it shared.  Or tracked.

You can still do what you want to, though.

Ciao,
Dscho
