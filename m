From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/5] Make xstrndup common
Date: Tue, 1 May 2007 00:21:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705010020070.29859@racer.site>
References: <46339819.8030007@freedesktop.org> <Pine.LNX.4.64.0704291416370.28708@iabervon.org>
 <4635003F.7080408@freedesktop.org> <Pine.LNX.4.64.0704301508550.29859@racer.site>
 <20070430205050.GC4385@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Josh Triplett <josh@freedesktop.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 01 00:22:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HieG2-0006mq-Qe
	for gcvg-git@gmane.org; Tue, 01 May 2007 00:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423747AbXD3WWH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 18:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423768AbXD3WWH
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 18:22:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:36244 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1423747AbXD3WWF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 18:22:05 -0400
Received: (qmail invoked by alias); 30 Apr 2007 22:22:01 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp058) with SMTP; 01 May 2007 00:22:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX186d8MgPCY6gzCf9oS4hfoC4u+TdAvnsuNRhRqstZ
	5yTizMy2HE7q7F
X-X-Sender: gene099@racer.site
In-Reply-To: <20070430205050.GC4385@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45884>

Hi,

On Mon, 30 Apr 2007, Jeff King wrote:

> On Mon, Apr 30, 2007 at 03:12:50PM +0200, Johannes Schindelin wrote:
> 
> > Unless I am missing something, I think this should work:
> > 
> > static inline char *xstrndup(const char *str, int len)
> > {
> > 	char *result = strndup(str, len);
> > 	if (result == NULL)
> > 		die ("xstrndup(): out of memory");
> > 	return result;
> > }
> > 
> > Hmm?
> 
> I can't speak for the original authors, but I imagine part of the
> impetus was that strndup is a GNU-ism.

D'oh! I never thought this was a GNU-ism.

Ciao,
Dscho
