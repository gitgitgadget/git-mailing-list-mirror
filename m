From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 1/3] Add valgrind support in test scripts
Date: Mon, 26 Jan 2009 00:35:31 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901260034520.14855@racer>
References: <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302> <alpine.DEB.1.00.0901201602410.5159@intel-tinevez-2-302> <20090121001219.GA18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210209580.19014@racer> <20090121190201.GA21686@coredump.intra.peff.net>
 <alpine.DEB.1.00.0901212137130.3586@pacific.mpi-cbg.de> <20090121215318.GA9107@sigill.intra.peff.net> <alpine.DEB.1.00.0901212332030.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901260014470.14855@racer> <alpine.DEB.1.00.0901260018340.14855@racer>
 <20090125232954.GC19099@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 26 00:36:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LREWh-0002GM-Fo
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 00:36:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbZAYXfD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 18:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbZAYXfD
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 18:35:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:34448 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750789AbZAYXfC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 18:35:02 -0500
Received: (qmail invoked by alias); 25 Jan 2009 23:35:00 -0000
Received: from pD9EB3E0E.dip0.t-ipconnect.de (EHLO noname) [217.235.62.14]
  by mail.gmx.net (mp070) with SMTP; 26 Jan 2009 00:35:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19xRqZ1U1RxDs89bqgKCY3OYy37Jjy45H07SstdG/
	YKQLR6D1p941tv
X-X-Sender: gene099@racer
In-Reply-To: <20090125232954.GC19099@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107134>

Hi,

On Sun, 25 Jan 2009, Jeff King wrote:

> On Mon, Jan 26, 2009 at 12:18:50AM +0100, Johannes Schindelin wrote:
> 
> > Note: it is safe to run the valgrind tests in parallel, as the links 
> > in t/valgrind/bin/ are created using proper locking.
> 
> I actually kind of liked the original atomic version over the one with
> locking. But I find this one acceptable.

The locking is only in there because of you...

> > Initial patch and all the hard work by Jeff King.
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> I don't know that there is much of my work left in here, but feel free 
> to add:
> 
>   Signed-off-by: Jeff King <peff@peff.net>

Will do!

Ciao,
Dscho
