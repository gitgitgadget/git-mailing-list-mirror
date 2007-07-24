From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Tue, 24 Jul 2007 14:33:04 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707241431540.14781@racer.site>
References: <Pine.LNX.4.64.0707221956210.14781@racer.site>
 <Pine.LNX.4.64.0707222205050.23426@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707222223460.14781@racer.site>
 <Pine.LNX.4.64.0707222234020.5382@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707222255010.14781@racer.site>
 <Pine.LNX.4.64.0707222302170.19212@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707230000020.14781@racer.site> <20070723035644.GC32566@spearce.org>
 <7v1wezohi4.fsf@assigned-by-dhcp.cox.net> <46A5B5F5.6000202@trolltech.com>
 <Pine.LNX.4.64.0707241002410.14781@racer.site> <7vd4yigmla.fsf@assigned-by-dhcp.cox.net>
 <46A5DF1F.2030307@trolltech.com> <Pine.LNX.4.64.0707241337470.14781@racer.site>
 <46A5FDF0.3060801@trolltech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 15:33:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDKVz-0005Nz-Nm
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 15:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757610AbXGXNdY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 09:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757590AbXGXNdY
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 09:33:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:51001 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754208AbXGXNdX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 09:33:23 -0400
Received: (qmail invoked by alias); 24 Jul 2007 13:33:22 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 24 Jul 2007 15:33:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1829Ngdad02VJ3NH9aFUBaKDXq///igxdUGBTBeuQ
	L777DR9bfPBhia
X-X-Sender: gene099@racer.site
In-Reply-To: <46A5FDF0.3060801@trolltech.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53588>

Hi,

On Tue, 24 Jul 2007, Marius Storm-Olsen wrote:

> So, it's look like this ('yes' mean CRLF EOL):
>     Repo | Working dir | Convert EOL?
>     ---------------------------------
> 1)  -      LF            no
> 2)  -      CRLF          yes
> 3)  LF     LF            no
> 4)  LF     CRLF          yes
> 5)  CRLF   LF            no
> 6)  CRLF   CRLF          yes
> 
> The problem is that currently 6) is 'yes', and turns the file into a LF file,
> which it shouldn't.

Shouldn't it?  But then you should set core.autocrlf = false, no?

AFAIU the purpose of autocrlf is to _always_ have UNIX line endings in the 
checked in stuff.

Ciao,
Dscho
