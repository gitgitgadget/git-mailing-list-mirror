From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-edit-index.perl
Date: Thu, 18 Dec 2008 14:48:39 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812181446430.6952@intel-tinevez-2-302>
References: <20081217204749.GA18261@janet.wally> <20081218043734.GD20749@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Neil Roberts <bpeeluk@yahoo.co.uk>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 18 14:50:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDJGN-0004Wq-Dd
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 14:50:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbYLRNso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 08:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbYLRNso
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 08:48:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:51127 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750985AbYLRNsn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 08:48:43 -0500
Received: (qmail invoked by alias); 18 Dec 2008 13:48:40 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp007) with SMTP; 18 Dec 2008 14:48:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+h/GoM9y2hbClKTAic9FvZUXL0RUsmyyCaVzrg6X
	tEXZaAgMBr2il6
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20081218043734.GD20749@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103459>

Hi,

On Wed, 17 Dec 2008, Jeff King wrote:

> On Wed, Dec 17, 2008 at 08:47:49PM +0000, Neil Roberts wrote:
> 
> > This script can be used to edit a file in the index without affecting 
> > your working tree. It checkouts a copy of the file to a temporary file 
> > and runs an editor on it. If the editor completes successfully with a 
> > non-empty file then it updates the index with the new data.
> 
> Hmm. Neat idea.

Yes, it is a neat idea.  But I always keep in mind what Junio had to say 
about my "add -e" thing (that I use pretty frequently myself): you will 
put something into the index that has _never_ been tested.

Would we really want to bless such a workflow with "official" support?

Ciao,
Dscho
