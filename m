From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: FW: git via http protocol _and_ a proxy using NTLM authentication
 -- git 1.5.4.2 & curl 7.18.0
Date: Fri, 29 Feb 2008 00:59:58 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802290057230.22527@racer.site>
References: <AA28F077645B324881335614E4F7C428034C11@win-ex01.bench.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ken.Fuchs@bench.com
X-From: git-owner@vger.kernel.org Fri Feb 29 02:01:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUtcm-0005iL-V2
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 02:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761533AbYB2BAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 20:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761484AbYB2BAg
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 20:00:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:43888 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761463AbYB2BAe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 20:00:34 -0500
Received: (qmail invoked by alias); 29 Feb 2008 01:00:33 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp033) with SMTP; 29 Feb 2008 02:00:33 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19jJU0fhDNj2ZdLcvGptXf1V40AIztPEt/iR8wiar
	5Y+to4mrG7bWbG
X-X-Sender: gene099@racer.site
In-Reply-To: <AA28F077645B324881335614E4F7C428034C11@win-ex01.bench.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75478>

Hi,

On Thu, 28 Feb 2008, Ken.Fuchs@bench.com wrote:

> On Wed, 27 Feb 2008, Johannes Schindelin wrote:
> 
> > On Wed, 27 Feb 2008, Ken Fuchs wrote:
> > 
> > [Ken did not say who said this:]
> 
> Sorry, Mike Hommey wrote the following on 27 Feb 2008:
> 
> > > > git-clone is not a builtin yet. When it is (and a patch 
> > > > has come for that), it will correctly use proxys.
> > > 
> > > Is there a work-around for cloning a git repository via a proxy?
> 
> > Yes.
> > 
> > Just export "http_proxy".  AFAICT this works... See
> > 
> >
> http://repo.or.cz/w/msysgit.git?a=commitdiff;h=257a62710c0253d940a59b6fb
> 2f371afa84dcf56
> 
> > for a working example.
> 
> Unfortunately, this will not work because "git clone" is
> implemented by git-clone.sh and has no support for dealing
> with proxies at all.

I fail to see why git-clone.sh, which uses git http-fetch directly, should 
behave differently from git fetch, which uses git http-fetch directly.

I strongly suspect that you did not even try what I suggested.

> So it seems that git's http protocol via a proxy isn't completely 
> supported.

If that should really be the case, well, Git is a programmers' tool, so 
you should be perfectly able to find out what is happening _exactly_.

If not, well, I heard subversion and Mercurial have nice Windows support.

Ciao,
Dscho

