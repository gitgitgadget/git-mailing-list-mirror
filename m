From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] do not mangle short options which take arguments
Date: Thu, 1 Oct 2009 23:53:23 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910012353010.4985@pacific.mpi-cbg.de>
References: <20090925233226.GC14660@spearce.org> <20091001201648.GA12175@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Thu Oct 01 23:51:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtTYv-0002NA-Kr
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 23:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084AbZJAVvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2009 17:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751925AbZJAVvH
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 17:51:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:51249 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751557AbZJAVvE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2009 17:51:04 -0400
Received: (qmail invoked by alias); 01 Oct 2009 21:51:07 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp034) with SMTP; 01 Oct 2009 23:51:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+sDxBA5uSsg13XKX/ndaMXbBZrWWaZdE9tpSKWUf
	I0PfgPcIHVENx2
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20091001201648.GA12175@localhost>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129413>

Hi,

On Thu, 1 Oct 2009, Clemens Buchacher wrote:

> Instead of
> 
>   $ git commit -a -ammend
>   [work ce38944] mend
>    1 files changed, 2 insertions(+), 0 deletions(-)
> 
> we now get
> 
>   $ git commit -a -ammend
>   error: switch `m' must not be mangled with other options
>   usage: git commit [options] [--] <filepattern>...
>   [...]
> 
> Signed-off-by: Clemens Buchacher <drizzd@aon.at>

Sweet!  And the patch looks good to me!

Ciao,
Dscho
