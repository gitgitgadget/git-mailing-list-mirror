From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Introduce git-supported-features for porcelain use
Date: Wed, 30 May 2007 13:34:57 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705301333410.4011@racer.site>
References: <20070530043113.GA12300@spearce.org>
 <81b0412b0705300504h24c4c32ew8460dede4aeffd52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 30 14:36:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtNQ4-0004pJ-4x
	for gcvg-git@gmane.org; Wed, 30 May 2007 14:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655AbXE3Mgq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 08:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbXE3Mgq
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 08:36:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:53235 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751655AbXE3Mgp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 08:36:45 -0400
Received: (qmail invoked by alias); 30 May 2007 12:36:44 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp046) with SMTP; 30 May 2007 14:36:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+lx1pga86loy62YIn+zkmQtgg/U8dZLHtBmlAHXa
	f0ZfxflOU3aPex
X-X-Sender: gene099@racer.site
In-Reply-To: <81b0412b0705300504h24c4c32ew8460dede4aeffd52@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48756>

Hi,

On Wed, 30 May 2007, Alex Riesen wrote:

> On 5/30/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> > As a porcelain author I'm finding it difficult to keep track of
> > what features I can use in git-gui.  Newer versions of Git have
> > newer capabilities but they don't always immediately get newer
> > version numbers that I can easily test for.
> 
> git-version --features?

Melikes. (Even if it is not strictly separating between plumbing and 
porcelain; I consider git-version porcelain...)

Ciao,
Dscho
