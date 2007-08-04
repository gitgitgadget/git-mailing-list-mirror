From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: rc4 - make quick-install-doc is broken
Date: Sat, 4 Aug 2007 21:21:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708042120320.14781@racer.site>
References: <46B49617.3070402@gmail.com> <Pine.LNX.4.64.0708041637450.14781@racer.site>
 <46B4A2B0.9080208@gmail.com> <46B4DF39.2070506@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Aug 04 22:21:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHQ8F-0000AX-2T
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 22:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761866AbXHDUVo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 16:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761708AbXHDUVo
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 16:21:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:51541 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761536AbXHDUVn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 16:21:43 -0400
Received: (qmail invoked by alias); 04 Aug 2007 20:21:41 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp046) with SMTP; 04 Aug 2007 22:21:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19H8EUveNVHRK+aL/Pz+twoDgAqR1CPMXSURbFih6
	/hBSkJ/MpQLUUW
X-X-Sender: gene099@racer.site
In-Reply-To: <46B4DF39.2070506@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54903>

Hi,

On Sat, 4 Aug 2007, Ren? Scharfe wrote:

> Mark Levedahl schrieb:
> > git>git bisect good
> > 6490a3383f1d0d96c122069e510ef1af1d019fbb is first bad commit
> 
> I've started a bisect run myself and ended up at a different commit,
> viz. e90fdc39b6903502192b2dd11e5503cea721a1ad ("Clean up work-tree
> handling").  Hmm.  I guess this candidate has a greater chance of
> actually being the culprit than yours. ;-)
> 
> I can't offer a fix, but I think I've captured install-doc-quick.sh's
> problem in a test script (see below).  It fails with e90fdc3 (and
> master) but succeeds with e90fdc3^.
> 
> Apparently checkout-index (and ls-files, but this is not used by the
> install script) can now be confused by running it from inside an
> untracked directory.
> 
> Johannes, does this help you in finding out what's going on here?

Thanks for doing this.  I will work on this in a few minutes; at the 
moment I am occupied with msysGit...

Ciao,
Dscho
