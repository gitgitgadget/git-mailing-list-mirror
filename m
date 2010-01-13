From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: default behaviour for `gitmerge` (no arguments)
Date: Wed, 13 Jan 2010 10:26:05 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001131024420.3043@intel-tinevez-2-302>
References: <loom.20100111T185144-655@post.gmane.org> <7v7hrojukz.fsf@alter.siamese.dyndns.org> <20100112162355.GB25092@coredump.intra.peff.net> <7vhbqr2nxt.fsf@alter.siamese.dyndns.org> <20100112182550.GA15696@coredump.intra.peff.net>
 <7vwrzmqypn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Gareth Adams <gareth.adams@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 10:26:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUzUV-0001KV-V5
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 10:26:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755200Ab0AMJ0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 04:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754915Ab0AMJ0J
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 04:26:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:41291 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754867Ab0AMJ0I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 04:26:08 -0500
Received: (qmail invoked by alias); 13 Jan 2010 09:26:06 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp044) with SMTP; 13 Jan 2010 10:26:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/NreFP5e/N/XDDPTlcZG896DmFGDd4Jd77b3UbKn
	fvGwgpPSyj/5WO
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vwrzmqypn.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136795>

Hi,

On Tue, 12 Jan 2010, Junio C Hamano wrote:

> I wondered why it doesn't hook into interpret_branch_name(), and instead 
> adds itself to the static substitute_branch_name(); it forbids the use 
> of the syntax from by callers of strbuf_branchname().

I _think_ it was to allow something like

	git log -g @{u}

but frankly, this is so long ago, I do not remember, I reconstructed this 
reasoning as being the most likely.

Ciao,
Dscho
