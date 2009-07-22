From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/1] Fix rebase -p --onto
Date: Wed, 22 Jul 2009 20:05:13 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907222004370.7343@intel-tinevez-2-302>
References: <20090722163738.GO7503@vinegar-pot.mit.edu> <alpine.DEB.1.00.0907221905360.7343@intel-tinevez-2-302> <20090722173635.GN7878@vinegar-pot.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Greg Price <price@ksplice.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 20:05:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTgBz-0006B6-Eb
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 20:05:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbZGVSFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 14:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbZGVSFR
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 14:05:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:43818 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751157AbZGVSFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 14:05:16 -0400
Received: (qmail invoked by alias); 22 Jul 2009 18:05:15 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp014) with SMTP; 22 Jul 2009 20:05:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Sf8djtvpSE821tP5LKN9brHR17M2tnyrPiNnXnY
	76g/QF1UJAV7qI
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090722173635.GN7878@vinegar-pot.mit.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123762>

Hi,

On Wed, 22 Jul 2009, Greg Price wrote:

> On Wed, Jul 22, 2009 at 07:07:17PM +0200, Johannes Schindelin wrote:
> > On Wed, 22 Jul 2009, Greg Price wrote:
> > > [...] when the great day comes that rebase -i -p can reorder commits 
> > 
> > If you want to help, I would be so thankful.  In that case, it might make 
> > more sense to hold off this patch and integrate it into the rebase-i-p 
> > patch series, rather than requiring a rebase of rebase-i-p on top of your 
> > patches, which will postpone said day only further.
> 
> Where is your patch series and what are the big things that need doing
> before it can be merged?  I can't promise a great deal of time up
> front, but I would be glad to look at it and may be able to pitch in.
> 
> Because this patch is about --onto together with -p and doesn't really
> involve -i, I think it still makes sense to merge.  It's only one line
> plus tests, so I don't think it will create that much of a rebase burden.

Fair enough.  I was fooled by the size of the mail; the main part is the 
test (which is good), though, so strike my objections.

Ciao,
Dscho
