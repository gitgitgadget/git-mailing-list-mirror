From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add NO_CROSS_DIRECTORY_HARDLINKS support to the
 Makefile
Date: Mon, 11 May 2009 21:08:15 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905112107420.27348@pacific.mpi-cbg.de>
References: <loom.20090511T101424-212@post.gmane.org> <alpine.DEB.1.00.0905111256580.4973@intel-tinevez-2-302> <4A085280.3090501@gmx.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Cedric Staniewski <cedric@gmx.ca>
X-From: git-owner@vger.kernel.org Mon May 11 21:18:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3b1H-000299-SL
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 21:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439AbZEKTSX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 15:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752997AbZEKTSX
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 15:18:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:37591 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752504AbZEKTSW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 15:18:22 -0400
Received: (qmail invoked by alias); 11 May 2009 19:08:11 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 11 May 2009 21:08:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Fee1udoyFHS4SGrOraa9nmjrdb0m0wzLHIGbylo
	wwvJUoDjRSMQ5A
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4A085280.3090501@gmx.ca>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118820>

Hi,

On Mon, 11 May 2009, Cedric Staniewski wrote:

> Johannes Schindelin wrote:
> > 	I do not understand how this commit could be responsible, but here 
> > 	is an attempt to fix things.
> 
> The important difference is that before this commit, git-add was
> hardlinked to a file outside of DESTDIR. Thus, when the build directory
> was removed or you tar'ed DESTDIR, git-add was just a regular file and
> all the other builtins were hardlinked to it.

Ah.

But you did not say if you like/tested the patch or not.

Ciao,
Dscho
