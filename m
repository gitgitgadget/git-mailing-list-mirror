From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 03/40] Add target architecture MinGW.
Date: Thu, 13 Mar 2008 00:06:06 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803130005560.1656@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <200803112230.57004.johannes.sixt@telecom.at> <alpine.LSU.1.00.0803120028130.3873@racer.site> <200803122359.30411.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Thu Mar 13 00:06:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZa1x-0008EA-Mb
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 00:06:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbYCLXGB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 19:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752232AbYCLXGB
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 19:06:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:39369 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751059AbYCLXGA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 19:06:00 -0400
Received: (qmail invoked by alias); 12 Mar 2008 23:05:59 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp027) with SMTP; 13 Mar 2008 00:05:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/WFLoD4jjWoB3MnY8sgX8tUEMaohpNmidlUSljRd
	okgcMKEs27JG51
X-X-Sender: gene099@racer.site
In-Reply-To: <200803122359.30411.johannes.sixt@telecom.at>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77021>

Hi,

On Wed, 12 Mar 2008, Johannes Sixt wrote:

> On Wednesday 12 March 2008 00:28, Johannes Schindelin wrote:
> > On Tue, 11 Mar 2008, Johannes Sixt wrote:
> > > On the positive side, we can now reuse Michal's vsnprintf wrapper, 
> > > which fixes snprintf, too, (which was not the case previously). Note 
> > > that on Windows we have to adjust the size parameter.
> >
> > Actually, I have to admit that I like strbuf_vaddf() more and more. 
> > Anything you would wish me to implement there?
> 
> Only that you keep an eye on PRIuMAX; if it is ever used in a format 
> string of strbuf_vaddf() then you ought to implement %I64u as well as 
> %llu. ;)

Sure!

Ciao,
Dscho
