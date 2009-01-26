From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] Valgrind support: check for more than just programming
 errors
Date: Mon, 26 Jan 2009 01:43:13 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901260142100.14855@racer>
References: <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302> <alpine.DEB.1.00.0901201602410.5159@intel-tinevez-2-302> <20090121001219.GA18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210209580.19014@racer> <20090121190201.GA21686@coredump.intra.peff.net>
 <alpine.DEB.1.00.0901212137130.3586@pacific.mpi-cbg.de> <20090121215318.GA9107@sigill.intra.peff.net> <alpine.DEB.1.00.0901212332030.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901260014470.14855@racer> <alpine.DEB.1.00.0901260019160.14855@racer>
 <20090125234249.GE19099@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 26 01:44:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRFaD-0007Uy-Jh
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 01:44:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbZAZAmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 19:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbZAZAmo
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 19:42:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:48897 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750880AbZAZAmn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 19:42:43 -0500
Received: (qmail invoked by alias); 26 Jan 2009 00:42:41 -0000
Received: from pD9EB3E0E.dip0.t-ipconnect.de (EHLO noname) [217.235.62.14]
  by mail.gmx.net (mp061) with SMTP; 26 Jan 2009 01:42:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18L8UtilNcLWZ27WweUPSls3ULskqs+J9gKRSUpO9
	CQ/6FFoA76bVQW
X-X-Sender: gene099@racer
In-Reply-To: <20090125234249.GE19099@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107148>

Hi,

On Sun, 25 Jan 2009, Jeff King wrote:

> On Mon, Jan 26, 2009 at 12:20:21AM +0100, Johannes Schindelin wrote:
> 
> > While it is not strictly necessary to look through the whole PATH to
> > find git binaries to override, it is in line with running an expensive
> > test (which valgrind is) to make extra sure that no binary is tested
> > that actually comes from the git.git checkout.
> 
> Should this be "...no binary is tested that _doesn't_ actually come from
> the git.git checkout"?

Yep, that was half the change to "that only binaries are tested...".

Thanks,
Dscho
