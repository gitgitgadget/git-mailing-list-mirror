From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: 100% (was: [PATCH] diffcore-rename: favour identical basenames)
Date: Fri, 22 Jun 2007 13:49:02 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706221347480.4059@racer.site>
References: <20070621030622.GD8477@spearce.org>
 <alpine.LFD.0.98.0706202031200.3593@woody.linux-foundation.org>
 <Pine.LNX.4.64.0706211248420.4059@racer.site> <20070621131915.GD4487@coredump.intra.peff.net>
 <Pine.LNX.4.64.0706220214250.4059@racer.site> <467B777D.C47BFE0E@eudaptics.com>
 <Pine.LNX.4.64.0706221122200.4059@racer.site> <86ps3oi7ma.fsf_-_@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Jun 22 14:49:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1iZb-00064K-Iv
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 14:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001AbXFVMtK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 08:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753643AbXFVMtJ
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 08:49:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:39522 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753001AbXFVMtI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 08:49:08 -0400
Received: (qmail invoked by alias); 22 Jun 2007 12:49:06 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp047) with SMTP; 22 Jun 2007 14:49:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+dNpQ9iRedsoL9VSyucneGbECXe2sC7nf/FpSviq
	gjZHGhM88acEr2
X-X-Sender: gene099@racer.site
In-Reply-To: <86ps3oi7ma.fsf_-_@lola.quinscape.zz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50694>

Hi,

On Fri, 22 Jun 2007, David Kastrup wrote:

> As a note aside: would it be possible to always round downwards when 
> computing similarities or converting between them?

I'd rather not. This would be counterintuitive. People expect rounded 
values.

> I very much would like to see the 100% figure reserved for identity.
> This is particularly relevant when interpreting the output of git-diff
> --name-status with regard to R100, C100 and similar flags.

You should never depend on the output of --name-status if you're 
interested in identifying identical files, but on the object names.

Ciao,
Dscho
