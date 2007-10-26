From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make rebase smarter
Date: Sat, 27 Oct 2007 00:13:56 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710270013030.4362@racer.site>
References: <1193328386.4522.352.camel@cacharro.xalalinux.org>
 <1193373682-3608-1-git-send-email-stevenrwalter@gmail.com>
 <7vk5p9wpwd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Walter <stevenrwalter@gmail.com>, git@vger.kernel.org,
	federico@novell.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 27 01:14:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlYO4-0006Vr-Ia
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 01:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbXJZXOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 19:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbXJZXOc
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 19:14:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:38399 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751507AbXJZXOc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 19:14:32 -0400
Received: (qmail invoked by alias); 26 Oct 2007 23:14:29 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp012) with SMTP; 27 Oct 2007 01:14:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18uQCAweC4uzByY4fS0g4ZPpmrfSh/Txb6W3f3S28
	dFSkootYScuVY2
X-X-Sender: gene099@racer.site
In-Reply-To: <7vk5p9wpwd.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62451>

Hi,

On Fri, 26 Oct 2007, Junio C Hamano wrote:

> Steven Walter <stevenrwalter@gmail.com> writes:
> 
> > It is a common workflow to run "git fetch; git rebase origin/<foo>" 
> > Where foo is the remote tracking branch.  git-rebase should default to 
> > using the remote tracking branch if no other ref is given.
> 
> This would be a reasonable choice between refusing outright and
> picking one possible action.

Another sensible choice would be "git rebase FETCH_HEAD", at least just 
after a "git fetch <nick> <branch>"...

Ciao,
Dscho
