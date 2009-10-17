From: Sean Estabrooks <seanlkml@sympatico.ca>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Sat, 17 Oct 2009 00:24:17 -0700
Message-ID: <BLU0-SMTP840FB343954FC20ACA699CAEC30@phx.gbl>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>
	<76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
	<alpine.LNX.2.00.0910141509200.32515@iabervon.org>
	<alpine.LFD.2.00.0910141616530.20122@xanadu.home>
	<7v7huxbtbk.fsf@alter.siamese.dyndns.org>
	<alpine.LFD.2.00.0910141647390.20122@xanadu.home>
	<7vws2xa9lu.fsf@alter.siamese.dyndns.org>
	<20091014230934.GC29664@coredump.intra.peff.net>
	<alpine.LFD.2.00.0910141926170.20122@xanadu.home>
	<7viqeha2zv.fsf@alter.siamese.dyndns.org>
	<20091015014737.GA9923@coredump.intra.peff.net>
	<alpine.LFD.2.00.0910142237010.20122@xanadu.home>
	<alpine.DEB.1.00.0910160256180.4985@pacific.mpi-cbg.de>
	<alpine.LFD.2.00.0910152118360.20122@xanadu.home>
	<alpine.DEB.1.00.0910160357370.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Oct 17 09:24:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mz3ee-0005jr-VR
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 09:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbZJQHY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2009 03:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751999AbZJQHYU
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 03:24:20 -0400
Received: from blu0-omc1-s13.blu0.hotmail.com ([65.55.116.24]:7976 "EHLO
	blu0-omc1-s13.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751316AbZJQHYQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Oct 2009 03:24:16 -0400
Received: from BLU0-SMTP84 ([65.55.116.8]) by blu0-omc1-s13.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Oct 2009 00:24:20 -0700
X-Originating-IP: [66.183.8.119]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from lex.hookers.net ([66.183.8.119]) by BLU0-SMTP84.blu0.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Oct 2009 00:24:20 -0700
In-Reply-To: <alpine.DEB.1.00.0910160357370.4985@pacific.mpi-cbg.de>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.16.6; x86_64-redhat-linux-gnu)
X-OriginalArrivalTime: 17 Oct 2009 07:24:20.0308 (UTC) FILETIME=[D7D12940:01CA4EFA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130546>

On Fri, 16 Oct 2009 04:07:23 +0200 (CEST)
Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> Just recently, I had a user request (a very valid one, mind you) where the 
> user does not want to provide a commit message, and wants to just commit 
> all the current changes.  In that particular case, it is very sensible to 
> ask for these things.  It is something utterly simple to ask for. Yet, it 
> is utterly hard with Git, especially if I have to explain it.

Hey Johannes,

It's actually easy, but maybe hard to find:

	$ git commit --cleanup=verbatim -m ""

Cheers,
Sean
