From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] clone: support cloning full bundles
Date: Wed, 12 Dec 2007 18:46:30 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712121846070.27959@racer.site>
References: <1197456485-22909-1-git-send-email-sbejar@gmail.com> 
 <Pine.LNX.4.64.0712121449310.27959@racer.site>
 <8aa486160712120721k26158972qf11c889da98572c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 19:47:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Wbz-0002wi-5Z
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 19:47:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758935AbXLLSqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 13:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756503AbXLLSqe
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 13:46:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:55027 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757969AbXLLSqd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 13:46:33 -0500
Received: (qmail invoked by alias); 12 Dec 2007 18:46:31 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp037) with SMTP; 12 Dec 2007 19:46:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+hFOIOUseh/Bl0Mw8rx5HlBQHes2iHCIgSto6JPI
	xUEvji8tG8RtIw
X-X-Sender: gene099@racer.site
In-Reply-To: <8aa486160712120721k26158972qf11c889da98572c6@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68085>

Hi,

On Wed, 12 Dec 2007, Santi B?jar wrote:

> On Dec 12, 2007 3:50 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > On Wed, 12 Dec 2007, Santi B?jar wrote:
> >
> > > It still fails for incremental bundles.
> >
> > Of course it does.  The whole point of incremental bundles is that 
> > they do _not_ contain all objects, but rely on some objects being 
> > present on the "fetch" side.
> 
> I know this. But then there is no bundle equivalent of the shallow 
> clones, as with:
> 
> git clone --depth <depth> <repo>

Ah, thanks.  Completely forgot about this.

Ciao,
Dscho
