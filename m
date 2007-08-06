From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] (Really) Fix install-doc-quick target
Date: Tue, 7 Aug 2007 00:43:12 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708070042450.14781@racer.site>
References: <7vmyx6fohv.fsf_-_@assigned-by-dhcp.cox.net>
 <11864401942772-git-send-email-mdl123@verizon.net> <Pine.LNX.4.64.0708062349460.14781@racer.site>
 <7vzm149s8s.fsf@assigned-by-dhcp.cox.net> <46B7B10F.4060402@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mdl123@verizon.net>,
	Git Mailing List <git@vger.kernel.org>,
	Ren Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 01:43:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IICEr-0003CS-6h
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 01:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933129AbXHFXnu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 19:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933121AbXHFXnu
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 19:43:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:50986 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933037AbXHFXnt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 19:43:49 -0400
Received: (qmail invoked by alias); 06 Aug 2007 23:43:47 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp036) with SMTP; 07 Aug 2007 01:43:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+psEIv7pmpEP8salraYJxpGvWNJP0IvS4I3tdvX9
	6SB+cEBr6c5aH5
X-X-Sender: gene099@racer.site
In-Reply-To: <46B7B10F.4060402@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55189>

Hi,

On Mon, 6 Aug 2007, Mark Levedahl wrote:

> Junio C Hamano wrote:
> > Yes.  And 00d8c51 obviously "works for me", so there is
> > something different between what Mark and I are doing.  I cannot
> > tell what it is.
> >   
> GZ=1 make quick-install-doc
> 
> ...fails because git-ls-tree is called when cwd=$mandir which is nowhere under
> or related to $GIT_DIR.

Ah, I suspect you do not have the latest 'master' installed?

Ciao,
Dscho
