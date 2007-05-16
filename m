From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Smart fetch via HTTP?
Date: Wed, 16 May 2007 12:33:18 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705161232120.6410@racer.site>
References: <20070515201006.GD3653@efreet.light.src>
 <46a038f90705152225y529c9db3x8615822e876c25a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 16 13:33:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoHku-0005HZ-Vw
	for gcvg-git@gmane.org; Wed, 16 May 2007 13:33:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755781AbXEPLdP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 07:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756011AbXEPLdP
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 07:33:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:49646 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755781AbXEPLdO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 07:33:14 -0400
Received: (qmail invoked by alias); 16 May 2007 11:33:12 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 16 May 2007 13:33:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19f68U5Nx5fl9/t9W2XzCuYhXMUmCgaha9MIZh01+
	zvYlwiOWz5gCId
X-X-Sender: gene099@racer.site
In-Reply-To: <46a038f90705152225y529c9db3x8615822e876c25a8@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47435>

Hi,

On Wed, 16 May 2007, Martin Langhoff wrote:

> On 5/16/07, Jan Hudec <bulb@ucw.cz> wrote:
> > Did anyone already think about fetching over HTTP working similarly to the
> > native git protocol?
> 
> Do the indexes have enough info to use them with http ranges? It'd be
> chunkier than a smart protocol, but it'd still work with dumb servers.

It would not be really performant, would it? Besides, not all Web servers 
speak HTTP/1.1...

Ciao,
Dscho
