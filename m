From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/14] fork/exec removal series
Date: Sun, 14 Oct 2007 03:50:33 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710140348550.25221@racer.site>
References: <1192305984-22594-1-git-send-email-johannes.sixt@telecom.at>
 <20071014021149.GO27899@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>, gitster@pobox.com,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Oct 14 04:50:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgtZ6-0000tO-HZ
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 04:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754527AbXJNCui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 22:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754509AbXJNCui
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 22:50:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:45598 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752630AbXJNCuh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 22:50:37 -0400
Received: (qmail invoked by alias); 14 Oct 2007 02:50:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp026) with SMTP; 14 Oct 2007 04:50:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/hGNl8VszhtAdfdMvOWiPejC1KGs08CTqN2aBwcs
	mbTkHL0eiZVQ9m
X-X-Sender: gene099@racer.site
In-Reply-To: <20071014021149.GO27899@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60793>

Hi,

On Sat, 13 Oct 2007, Shawn O. Pearce wrote:

> Since builtin-pack-objects now accepts (limited) pthread support, 
> perhaps this should be implemented in terms of pthread support when 
> pthreads are available?

Falling back to fork() when no pthreads are available?  Yes, that makes 
sense.

It might also (marginally) speed up operations, since the switches between 
threads are cheaper than those between processes, right?

Ciao,
Dscho
