From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git remote rename, why dosen't it exists?
Date: Wed, 4 Jun 2008 16:51:04 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806041649270.13507@racer.site.net>
References: <1212497390.30731.3.camel@omicron.ep.petrobras.com.br>  <alpine.DEB.1.00.0806031449010.13507@racer.site.net>  <1212503641.30731.11.camel@omicron.ep.petrobras.com.br>  <alpine.DEB.1.00.0806032102350.13507@racer.site.net>
 <1212591245.30731.17.camel@omicron.ep.petrobras.com.br>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Victor Bogado da Silva Lins <victor@bogado.net>
X-From: git-owner@vger.kernel.org Wed Jun 04 17:53:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3vIM-0002QW-Sf
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 17:53:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756940AbYFDPwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 11:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755595AbYFDPwJ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 11:52:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:60875 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756572AbYFDPwI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 11:52:08 -0400
Received: (qmail invoked by alias); 04 Jun 2008 15:52:06 -0000
Received: from unknown (EHLO none.local) [128.177.17.254]
  by mail.gmx.net (mp045) with SMTP; 04 Jun 2008 17:52:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19HlpMjvaxHlncdcnhR5mW8i59qfY7/4TYuvLe0pm
	oYC/HPvcPpZ5d9
X-X-Sender: gene099@racer.site.net
In-Reply-To: <1212591245.30731.17.camel@omicron.ep.petrobras.com.br>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83791>

Hi,

On Wed, 4 Jun 2008, Victor Bogado da Silva Lins wrote:

> I trying to refactor [in builtin-remote.c] rm into rm_or_rename, but I 
> stumbled into a problem, how do I free a remote struct obtained with 
> "remote_get"?

At the moment, there is no way to do that.

> Another possibility would be another way to check if a remote already 
> exists without allocating it in case it does. The need comes from 
> testing whether the destination name already exists, if it does exists I 
> must free the remote_get and bail_out.

I think in the first step, you can just _not_ free() it, just die().

Ciao,
Dscho
