From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] checkout: fix attribute handling in checkout all
Date: Mon, 13 Aug 2007 17:14:32 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708131712030.25989@racer.site>
References: <11869508753328-git-send-email-prohaska@zib.de>
 <118695087531-git-send-email-prohaska@zib.de> <7veji8ifs2.fsf@assigned-by-dhcp.cox.net>
 <7vfy2ogdvl.fsf@assigned-by-dhcp.cox.net> <8D126F5A-5998-4CB2-89BE-1CAEF5AE621F@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Brian Downing <bdowning@lavos.net>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Aug 13 18:16:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKcaY-0000Kt-Jc
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 18:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S946277AbXHMQPm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 12:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S945910AbXHMQPj
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 12:15:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:47922 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S946277AbXHMQPc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 12:15:32 -0400
Received: (qmail invoked by alias); 13 Aug 2007 16:15:29 -0000
Received: from R43a9.r.pppool.de (EHLO noname) [89.54.67.169]
  by mail.gmx.net (mp010) with SMTP; 13 Aug 2007 18:15:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19oi5d5tHRo0yNsWXmcK/cmciNFmkhUJ5C6i21Ohm
	T8N1NsZOwaS7Ng
X-X-Sender: gene099@racer.site
In-Reply-To: <8D126F5A-5998-4CB2-89BE-1CAEF5AE621F@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55769>

Hi,

On Mon, 13 Aug 2007, Steffen Prohaska wrote:

> Could we drop reading the file [.gitattributes] in the work tree 
> completely?

NACK.

It is not good to hide things away from the working tree.  It is much 
easier to just edit a file than to edit it and put it into the index.

Ciao,
Dscho
