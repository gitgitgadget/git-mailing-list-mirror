From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [WIP] Get rid of msys in favor of busybox port for windows
Date: Tue, 10 Jul 2007 16:39:45 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707101638521.4047@racer.site>
References: <fcaeb9bf0707100832j3c2ff076gab5c9bd4f9d3f4a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 10 17:47:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8Hw5-0007Xh-8F
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 17:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754326AbXGJPr3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 11:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754189AbXGJPr3
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 11:47:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:46111 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753625AbXGJPr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 11:47:28 -0400
Received: (qmail invoked by alias); 10 Jul 2007 15:47:26 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp017) with SMTP; 10 Jul 2007 17:47:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18jVz54xasjB/joQkb/msRep2gW58Utwmd16M63E4
	kFpHlp9xEl3zN/
X-X-Sender: gene099@racer.site
In-Reply-To: <fcaeb9bf0707100832j3c2ff076gab5c9bd4f9d3f4a0@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52086>

Hi,

On Tue, 10 Jul 2007, Nguyen Thai Ngoc Duy wrote:

> I'm integrating some code from busybox to mingw tree so that mingw port 
> can work without msys. Posix utilities such as sed, awk, head, tail... 
> seem to work well. The main obstacle is ash, which is no where near 
> usable state (fork issues as always). Busybox ash is about 13000 lines 
> of code, not too big.
> 
> Anyone interested in?

Definitely.

Last time I wanted to assess how much work it is to compile that on MinGW, 
though, it seemed to be too much to be tractable.

Ciao,
Dscho
