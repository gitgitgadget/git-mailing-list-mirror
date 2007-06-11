From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Introduce light weight commit annotations
Date: Mon, 11 Jun 2007 11:22:40 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706111121120.4059@racer.site>
References: <Pine.LNX.4.64.0706091854330.4059@racer.site>
 <alpine.LFD.0.99.0706102206590.12885@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com,
	Johan Herland <johan@herland.net>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Jun 11 12:26:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxh69-0000X2-D3
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 12:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760520AbXFKK0B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 06:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760337AbXFKK0B
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 06:26:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:55472 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759491AbXFKK0A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 06:26:00 -0400
Received: (qmail invoked by alias); 11 Jun 2007 10:25:58 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp036) with SMTP; 11 Jun 2007 12:25:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19n6WdvDbVnyXRJO1IjpajrxHcMtZFMdFnfMblbeI
	2TSL7EfFHid1bb
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.99.0706102206590.12885@xanadu.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49842>

Hi,

On Sun, 10 Jun 2007, Nicolas Pitre wrote:

> On Sat, 9 Jun 2007, Johannes Schindelin wrote:
> 
> > The annotations are tracked in a new ref, refs/annotations/commits,
> > in the same fan-out style as .git/objects/??/*, only that they only
> > exist in the object database now.
> 
> Isn't this abusing the refs namespace a bit?  Why not 
> .git/annotations/... instead?

In the way I planned it, it is not at all abusing the refs namespace. 
These annotations _are_ tracked in a proper branch. Only that the "file 
names" in the tree objects actually refer to commit names.

Ciao,
Dscho
