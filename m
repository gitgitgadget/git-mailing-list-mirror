From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: rerere fails to record resolution if file doesn't exist in merge
 base
Date: Mon, 9 Jul 2007 14:40:14 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707091438540.5546@racer.site>
References: <20070709070725.GA4445@lala> <7vps32ugu2.fsf@assigned-by-dhcp.cox.net>
 <20070709113543.GA12633@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Mon Jul 09 15:47:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7taj-0004Hu-Rw
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 15:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703AbXGINru (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 09:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752607AbXGINru
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 09:47:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:58408 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751315AbXGINru (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 09:47:50 -0400
Received: (qmail invoked by alias); 09 Jul 2007 13:47:48 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp021) with SMTP; 09 Jul 2007 15:47:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19NGcdMM+FNfWOpmTnbcYMM0o4voHCan5pQjH/Zov
	qsXL8+VEFytIgB
X-X-Sender: gene099@racer.site
In-Reply-To: <20070709113543.GA12633@informatik.uni-freiburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51992>

Hi,

On Mon, 9 Jul 2007, Uwe Kleine-K?nig wrote:

> Junio C Hamano wrote:
>
> > Not even compile tested, but something like this should do.
> It compiles, but seems not to work.  I will try to make up a test.

I compiled it, and it works as expected.  For safety, git-rerere leaves 
the index unmerged, so that you can verify that you wanted this 
resolution.

Will resubmit with a test case.

Ciao,
Dscho
