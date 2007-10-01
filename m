From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] git stash: document apply's --index switch
Date: Mon, 1 Oct 2007 12:49:31 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710011247430.28395@racer.site>
References: <1191239139-26992-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Bruno Haible <bruno@clisp.org>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Oct 01 13:50:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcJnX-00044I-Sp
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 13:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbXJALup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 07:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751906AbXJALuo
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 07:50:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:36434 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751845AbXJALuo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 07:50:44 -0400
Received: (qmail invoked by alias); 01 Oct 2007 11:50:42 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp035) with SMTP; 01 Oct 2007 13:50:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX189MisUmRc9avQ6POOq/5V5cmf1iSnPaYfaNsjfgF
	r3P8vkN5ZqvgSo
X-X-Sender: gene099@racer.site
In-Reply-To: <1191239139-26992-1-git-send-email-vmiklos@frugalware.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59606>

Hi,

On Mon, 1 Oct 2007, Miklos Vajna wrote:

> > - the lines are a bit too long, no?
> 
> all lines are shorter than 80 chars, i think it is correct. or am i 
> wrong?

No, you are not.  But judging from the lines before your change:

> @@ -71,6 +71,11 @@ apply [<stash>]::
>  +
>  This operation can fail with conflicts; you need to resolve them
>  by hand in the working tree.
> ++
> +If the `--index` option is used, this command tries to reinstate not only the
> [...]

it seemed to me that the lines were meant to be shorter.  At least they 
are easier to read when quoted as a diff in an email.

But it really does not matter much to me.

Ciao,
Dscho
