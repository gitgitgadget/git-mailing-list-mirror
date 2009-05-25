From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] am: do not do any reset on --abort
Date: Mon, 25 May 2009 13:49:18 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905251348050.4288@intel-tinevez-2-302>
References: <20090525104308.GA26775@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 25 13:49:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8YgN-0007cL-3h
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 13:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbZEYLtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 07:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751769AbZEYLtT
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 07:49:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:42683 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751599AbZEYLtS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 07:49:18 -0400
Received: (qmail invoked by alias); 25 May 2009 11:49:19 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp065) with SMTP; 25 May 2009 13:49:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18/PFgs6vs/VGgBiGpHK5XAtj15/etAUwNrWqV9zw
	nvzqb8XFIlksV7
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090525104308.GA26775@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119925>

Hi,

On Mon, 25 May 2009, Jeff King wrote:

> We really have no idea what state the tree is in at this
> point, and whether the user might have done useful work on
> top of it. So let's err on the side of keeping the user's
> data intact.
> 
> The downside is that if they do have cruft to get rid of, or
> want to pretend as if earlier parts of the series that were
> applied did not exist, they must manually "git reset --hard"
> now.
> 
> Signed-off-by: Jeff King <peff@peff.net>

Hmm.  I think I would revert that patch after merging git.git right away.

Can you at least check for a dirty tree and reset --hard if it is clean?  
In the other case, you could still say "you seem to have modifications, 
bla bla bla"...

Ciao,
Dscho
