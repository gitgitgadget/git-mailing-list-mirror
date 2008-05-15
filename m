From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2 v2] cvsexportcommit: chomp only removes trailing
 whitespace
Date: Thu, 15 May 2008 04:21:09 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805150421000.30431@racer>
References: <alpine.DEB.1.00.0805141526160.30431@racer> <7vskwkojhy.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0805141936410.30431@racer> <alpine.DEB.1.00.0805142327520.30431@racer> <7vk5hwi9o4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 15 05:22:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwU2a-0008UB-4Q
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 05:22:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754004AbYEODVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 23:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753888AbYEODVJ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 23:21:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:59142 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752059AbYEODVI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 23:21:08 -0400
Received: (qmail invoked by alias); 15 May 2008 03:21:06 -0000
Received: from R2b68.r.pppool.de (EHLO racer.local) [89.54.43.104]
  by mail.gmx.net (mp008) with SMTP; 15 May 2008 05:21:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/nWGNV6dPnzDdSQ1pvRQD6uSz1eVQzhctqv+5U0n
	ptgmxCZrQGaNUT
X-X-Sender: gene099@racer
In-Reply-To: <7vk5hwi9o4.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82171>

Hi,

On Wed, 14 May 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > @@ -210,7 +210,7 @@ if (@canstatusfiles) {
> >  	my $basename = basename($name);
> >  
> >  	$basename = "no file " . $basename if (exists($added{$basename}));
> > -	chomp($basename);
> > +	$basename =~ s/^\s+(.*?)\s*$/$1/;
> 
> Isn't this no-op for a basename that does not begin with a whitespace?
> Don't you want to still strip trailing whitespaces in such a case?

D'oh.  Time for bed.

Ciao,
Dscho
