From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC 2/2] Add Git-aware CGI for Git-aware smart HTTP transport
Date: Mon, 4 Aug 2008 12:26:01 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808041225050.9611@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20080803025602.GB27465@spearce.org> <1217748317-70096-1-git-send-email-spearce@spearce.org> <1217748317-70096-2-git-send-email-spearce@spearce.org> <7vwsix7nhw.fsf@gitster.siamese.dyndns.org> <20080804035921.GB2963@spearce.org>
 <4896D19C.6040704@dawes.za.net> <alpine.DEB.1.00.0808041208060.9611@pacific.mpi-cbg.de.mpi-cbg.de> <4896D669.30402@dawes.za.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
To: Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Mon Aug 04 12:22:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPxD7-0004Bh-BM
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 12:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753063AbYHDKVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 06:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752985AbYHDKVg
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 06:21:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:44909 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753020AbYHDKVf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 06:21:35 -0400
Received: (qmail invoked by alias); 04 Aug 2008 10:21:34 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp005) with SMTP; 04 Aug 2008 12:21:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/iisN6ZcjiTnaPy5ZVn/Xo67+CLd8r4GYbBCofjP
	Pkorc0pU/E9n1N
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <4896D669.30402@dawes.za.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91340>

Hi,

On Mon, 4 Aug 2008, Rogan Dawes wrote:

> Johannes Schindelin wrote:
> 
> > On Mon, 4 Aug 2008, Rogan Dawes wrote:
> > 
> > > I don't understand why you would want to keep the commands in the 
> > > URL when you are doing a POST?
> > 
> > Caching.
> 
> If you are expecting something to be cacheable, then should you not be 
> using a GET anyway?

Yes.

And I think the wget thing is not an issue: we should not try to prevent 
every single idiocy.

Ciao,
Dscho
