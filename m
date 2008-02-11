From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-pull documentation: fix linkgit in the --rebase
 option description.
Date: Mon, 11 Feb 2008 15:15:31 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802111514400.3870@racer.site>
References: <20080211132800.GV25954@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 16:17:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOaO3-0003xe-5c
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 16:16:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753627AbYBKPPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 10:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753533AbYBKPPY
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 10:15:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:35765 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753322AbYBKPPX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 10:15:23 -0500
Received: (qmail invoked by alias); 11 Feb 2008 15:15:21 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp040) with SMTP; 11 Feb 2008 16:15:21 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/uWvZEvELucsBK8TzBDSh8kLNTNAuTqPlVtpbO6w
	55YGuoFxgdUDW3
X-X-Sender: gene099@racer.site
In-Reply-To: <20080211132800.GV25954@genesis.frugalware.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73538>

Hi,

On Mon, 11 Feb 2008, Miklos Vajna wrote:

> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index 4cc633a..b9bc6ed 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -39,7 +39,6 @@ include::merge-strategies.txt[]
>  	there is a remote ref for the upstream branch, and this branch
>  	was rebased since last fetched, the rebase uses that information
>  	to avoid rebasing non-local changes.
> -
>  	*NOTE:* This is a potentially _dangerous_ mode of operation.
>  	It rewrites history, which does not bode well when you
>  	published that history already.  Do *not* use this option

The intention was to force a new paragraph.  The *NOTE* should be loud and 
clear, so that those few people who read man pages are properly warned 
that --rebase is a dangerous option if you do not know what you are doing.

Ciao,
Dscho
