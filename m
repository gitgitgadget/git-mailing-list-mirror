From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase-i-p: delay saving current-commit to REWRITTEN if
 squashing
Date: Wed, 22 Oct 2008 17:21:53 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810221721370.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <cover.1224055978.git.stephen@exigencecorp.com> <759654ef1f1781cd2b102e21c6f972b065560398.1224055978.git.stephen@exigencecorp.com> <20081022125149.GA17092@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephen Haberman <stephen@exigencecorp.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 22 17:16:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsfRV-0001eO-4k
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 17:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139AbYJVPO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 11:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751561AbYJVPO7
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 11:14:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:59212 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750815AbYJVPO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 11:14:59 -0400
Received: (qmail invoked by alias); 22 Oct 2008 15:14:56 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp026) with SMTP; 22 Oct 2008 17:14:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+1AsA9Dxa1puUPqokzYW7gpcRcHdodZbVg/Fa6gb
	0yWmWxYlKlAnZY
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20081022125149.GA17092@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98878>

Hi,

On Wed, 22 Oct 2008, Jeff King wrote:

> On Wed, Oct 15, 2008 at 02:44:36AM -0500, Stephen Haberman wrote:
> 
> > +		if [ "$fast_forward" == "t" ]
> 
> This one even fails on my Linux box. :) "==" is a bash-ism.

Did we not also prefer "test" to "["?

Ciao,
Dscho
