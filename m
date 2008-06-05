From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git remote rename, why dosen't it exists?
Date: Thu, 5 Jun 2008 05:30:41 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806050529350.21190@racer>
References: <1212497390.30731.3.camel@omicron.ep.petrobras.com.br>  <alpine.DEB.1.00.0806031449010.13507@racer.site.net>  <1212503641.30731.11.camel@omicron.ep.petrobras.com.br>  <alpine.DEB.1.00.0806032102350.13507@racer.site.net> 
 <1212591245.30731.17.camel@omicron.ep.petrobras.com.br>  <alpine.DEB.1.00.0806041649270.13507@racer.site.net> <1212634394.13109.10.camel@mithrandir.bogado.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Victor Bogado da Silva Lins <victor@bogado.net>
X-From: git-owner@vger.kernel.org Thu Jun 05 06:33:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K479o-0001S4-JV
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 06:33:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbYFEEcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 00:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbYFEEcH
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 00:32:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:36798 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751118AbYFEEcF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 00:32:05 -0400
Received: (qmail invoked by alias); 05 Jun 2008 04:32:03 -0000
Received: from unknown (EHLO racer.local) [128.177.17.254]
  by mail.gmx.net (mp003) with SMTP; 05 Jun 2008 06:32:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+7tXIDPue7kaTvhNZAnbkqNUJ3wxeR+kaa42qx/+
	jibb1mXb+e8neD
X-X-Sender: gene099@racer
In-Reply-To: <1212634394.13109.10.camel@mithrandir.bogado.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83855>

Hi,

On Wed, 4 Jun 2008, Victor Bogado da Silva Lins wrote:

> On Wed, 2008-06-04 at 16:51 +0100, Johannes Schindelin wrote:
>
> > On Wed, 4 Jun 2008, Victor Bogado da Silva Lins wrote:
> > 
> > > I trying to refactor [in builtin-remote.c] rm into rm_or_rename, but 
> > > I stumbled into a problem, how do I free a remote struct obtained 
> > > with "remote_get"?
> 
> It seems that git-remote thinks that remote_get will return NULL if
> there is no such remote, but in fact it does not do this, it always
> alloc a new remote struct and returns that newly allocated.

>From remote.c, remote_get(), line 601--602 in my checkout:

        if (!ret->url)
                return NULL;

Hth,
Dscho
