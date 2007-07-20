From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add --log-size to git log to print message size
Date: Fri, 20 Jul 2007 19:41:08 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707201939170.14781@racer.site>
References: <e5bfff550707201115v2531434erd9e10a2b816a59bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 20:41:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBxPl-0003O5-LJ
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 20:41:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759781AbXGTSlR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 14:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760811AbXGTSlR
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 14:41:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:33610 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759781AbXGTSlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 14:41:16 -0400
Received: (qmail invoked by alias); 20 Jul 2007 18:41:15 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp046) with SMTP; 20 Jul 2007 20:41:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19KvL1xZoBKNP2vmo7xR74k+ZTPglIYUxCKcJDhGO
	xHVhz6UnenjckA
X-X-Sender: gene099@racer.site
In-Reply-To: <e5bfff550707201115v2531434erd9e10a2b816a59bf@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53113>

Hi,

On Fri, 20 Jul 2007, Marco Costalba wrote:

> This is take 3 of this patch. In this case has been clearly added that 
> diff content size is not included.

Two concerns and a half:

- if you do not include the diff content size, don't you need to parse the 
  output anyway?

- what do you do if the underlying Git does not support --log-size? Exit?

- Would it not be much quicker to read the rev-list, and read messages 
  only on demand?

Ciao,
Dscho
