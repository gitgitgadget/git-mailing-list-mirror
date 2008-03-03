From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re* [PATCH] allow git-am to run in a subdirectory
Date: Mon, 3 Mar 2008 11:53:38 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803031152270.22527@racer.site>
References: <20080301062255.GA27538@coredump.intra.peff.net> <7vprue6ghc.fsf@gitster.siamese.dyndns.org> <20080301081235.GA31855@coredump.intra.peff.net> <7vlk50joe0.fsf_-_@gitster.siamese.dyndns.org> <20080303065808.GA22810@coredump.intra.peff.net>
 <7vhcfojndo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 12:55:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW9G0-0006h0-BV
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 12:55:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbYCCLyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 06:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbYCCLyY
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 06:54:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:45233 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751118AbYCCLyX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 06:54:23 -0500
Received: (qmail invoked by alias); 03 Mar 2008 11:54:21 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp017) with SMTP; 03 Mar 2008 12:54:21 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX199ib0ncHl9aXefNgoc4mQJHVuwZNcHJIYr4XBXHU
	b/i7oO5dMDgKYs
X-X-Sender: gene099@racer.site
In-Reply-To: <7vhcfojndo.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75918>

Hi,

On Sun, 2 Mar 2008, Junio C Hamano wrote:

> Have people actually used --dotest=<foo> ever?
> 
> As far as I know, I do not think it was useful in the real world.  Too 
> many things assumed that the spool directory for "am" is .dotest.
> 
> And I am very much tempted to say we should remove that option.

Concur.  While at it, we could move both .dotest/ and .git/.dotest-merge/
to .git/dotest/, no?

I know, I was opposed to this change, but let's just see how many heads 
pop up all of a sudden on the mailing list, okay?

Ciao,
Dscho

