From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: rc4 - make quick-install-doc is broken
Date: Sat, 4 Aug 2007 16:38:27 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708041637450.14781@racer.site>
References: <46B49617.3070402@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 17:39:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHLie-0004pI-KD
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 17:39:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762090AbXHDPjF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 11:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756957AbXHDPjE
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 11:39:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:38394 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761892AbXHDPjD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 11:39:03 -0400
Received: (qmail invoked by alias); 04 Aug 2007 15:39:00 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp048) with SMTP; 04 Aug 2007 17:39:00 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+0jSl2g0G0Oa/U3LA6JFwVmaGP6YRBX1BndxIiBT
	DFv/AVl9YsVF0j
X-X-Sender: gene099@racer.site
In-Reply-To: <46B49617.3070402@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54868>

Hi,

On Sat, 4 Aug 2007, Mark Levedahl wrote:

> Beginning with commit
> 
> 6490a3383f1d0d96c122069e510ef1af1d019fbb Fix work-tree related breakages
> 
> install-doc-quick.sh no longer installs man pages, at least not to the defined
> $mandir (if "git-checkout-index" is putting them somewhere else, I haven't
> discovered where). Reverting the above commit eliminates this problem. This is
> on Cygwin, haven't tried on Linux.

Could it be that you did not find this commit by bisecting the issue?  I 
highly doubt that said commit changes anything in the build process.

Ciao,
Dscho
