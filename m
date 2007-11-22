From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] bundle create: keep symbolic refs' names instead of
 resolving them
Date: Thu, 22 Nov 2007 12:03:14 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711221201240.27959@racer.site>
References: <8aa486160711210654p357ccd87i4809e0cda9471303@mail.gmail.com> 
 <Pine.LNX.4.64.0711211554370.27959@racer.site>
 <8aa486160711210815g5a1973c2see28a6263fc56030@mail.gmail.com>
 <Pine.LNX.4.64.0711211652470.27959@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 13:03:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvAmR-0004Jy-78
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 13:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754247AbXKVMDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 07:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753962AbXKVMDV
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 07:03:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:52056 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753591AbXKVMDU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 07:03:20 -0500
Received: (qmail invoked by alias); 22 Nov 2007 12:03:18 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp031) with SMTP; 22 Nov 2007 13:03:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19OGGI1HcROvMchuhp7PPWw2nDwns6zFW/S2HA7Hf
	i6ImBLKD2o7SSr
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0711211652470.27959@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65812>

Hi,

On Wed, 21 Nov 2007, Johannes Schindelin wrote:

> 
> When creating a bundle, symbolic refs used to be resolved to the
> non-symbolic refs they point to before being written to the list
> of contained refs.  I.e. "git bundle create a1.bundle HEAD master"
> would show something like
> 
> 388afe7881b33102fada216dd07806728773c011        refs/heads/master
> 388afe7881b33102fada216dd07806728773c011        refs/heads/master

Aaargh.

My patch broke "git bundle create x master".  I somehow believed that 
resolve_ref () would turn "master" into "refs/heads/master", which it does 
not do.

So please ignore this patch.

Ciao,
Dscho
