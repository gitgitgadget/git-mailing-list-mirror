From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] (Really) Fix install-doc-quick target
Date: Mon, 6 Aug 2007 23:50:21 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708062349460.14781@racer.site>
References: <7vmyx6fohv.fsf_-_@assigned-by-dhcp.cox.net>
 <11864401942772-git-send-email-mdl123@verizon.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ren Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Tue Aug 07 00:51:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIBPs-0006tD-Pk
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 00:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932915AbXHFWvA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 18:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbXHFWvA
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 18:51:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:41541 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932801AbXHFWu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 18:50:58 -0400
Received: (qmail invoked by alias); 06 Aug 2007 22:50:57 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp027) with SMTP; 07 Aug 2007 00:50:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+uw9wVpOCu+1oQ3Eri8nGeD+TwvRy8WbMeDJEeWF
	XuSk/KXbk1+wiO
X-X-Sender: gene099@racer.site
In-Reply-To: <11864401942772-git-send-email-mdl123@verizon.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55183>

Hi,

On Mon, 6 Aug 2007, Mark Levedahl wrote:

> -	for i in `git ls-tree -r --name-only $head`
> +	for i in `git --git-dir="$GIT_DIR" ls-tree -r --name-only $head`

This awfully looks like hiding a bug.  It should _never_ be necessary to 
say '--git-dir="$GIT_DIR"'.

Ciao,
Dscho
