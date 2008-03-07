From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Problems building git with custom curl installation
Date: Fri, 7 Mar 2008 03:17:45 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803070317010.19395@racer.site>
References: <47D08EA7.8000607@gravity.psu.edu> <9b3e2dc20803061737l1832fb82g6532808b58a12ab5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ian Hinder <hinder@gravity.psu.edu>, git@vger.kernel.org
To: Stephen Sinclair <radarsat1@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 03:18:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXSAT-0000Vj-Dm
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 03:18:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276AbYCGCRs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 21:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756144AbYCGCRs
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 21:17:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:57718 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752960AbYCGCRr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 21:17:47 -0500
Received: (qmail invoked by alias); 07 Mar 2008 02:17:44 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp024) with SMTP; 07 Mar 2008 03:17:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/w6ZJwRz7wmVQYuN3PfwbSSKpNUIcS+xWIYvOPs8
	Diik7RcL88LqGO
X-X-Sender: gene099@racer.site
In-Reply-To: <9b3e2dc20803061737l1832fb82g6532808b58a12ab5@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76451>

Hi,

On Thu, 6 Mar 2008, Stephen Sinclair wrote:

> On Thu, Mar 6, 2008 at 7:39 PM, Ian Hinder <hinder@gravity.psu.edu> wrote:
> [snip]
> >  1. Configure: Specifying the curl location leads to output that
> >  indicates that curl was not correctly located, even though a
> >  subsequent make finds it successfully and includes it in the build.
> 
> I'd just like to add that configure also doesn't detect and warn about
> a missing gettext package, which became evident to me today when I
> tried compiling it on a newly installed machine.  The configure is
> successful, but the build fails.

You probably forgot to include the relevant output.

But I guess I know it already: msgfmt ist not found.  Alas, there are 
patches underway to fix that already.

Hth,
Dscho

