From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: diffcore-rename performance mode
Date: Tue, 18 Sep 2007 12:20:52 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709181220130.28586@racer.site>
References: <20070918082321.GA9883@coredump.intra.peff.net>
 <7vsl5cwe6p.fsf@gitster.siamese.dyndns.org> <20070918085413.GA11751@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 18 13:21:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXb9F-0003eS-B2
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 13:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755193AbXIRLVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 07:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754724AbXIRLVl
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 07:21:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:50960 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754174AbXIRLVk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 07:21:40 -0400
Received: (qmail invoked by alias); 18 Sep 2007 11:21:38 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp048) with SMTP; 18 Sep 2007 13:21:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/3tfZSCW33GfFufxbi9HCSVeflpuSxArpZO24S/7
	1ggXpDm9sK2uSd
X-X-Sender: gene099@racer.site
In-Reply-To: <20070918085413.GA11751@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58581>

Hi,

On Tue, 18 Sep 2007, Jeff King wrote:

> On Tue, Sep 18, 2007 at 01:49:50AM -0700, Junio C Hamano wrote:
> 
> > > However, keeping around _just_ the cnt_data caused only about 100M 
> > > of extra memory consumption (and gave the same performance boost).
> > 
> > That would be an interesting and relatively low-hanging optimization.
> 
> OK, I will work up a patch. Is it worth making it configurable?

Yes, I think it would be worth making it configurable... For example, one 
of the machines I work on has only 128M.

Thanks,
Dscho
