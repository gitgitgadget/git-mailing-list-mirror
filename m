From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-remote: show all remotes with "git remote show"
Date: Wed, 9 Apr 2008 17:54:45 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804091754170.2074@eeepc-johanness>
References: <20080409101428.GA2637@elte.hu> <20080409145758.GB20874@sigill.intra.peff.net> <20080409151551.GA30439@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ingo Molnar <mingo@elte.hu>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 09 18:55:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjdaF-0000PF-Pj
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 18:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755226AbYDIQyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 12:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754656AbYDIQyu
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 12:54:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:35615 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752559AbYDIQyt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 12:54:49 -0400
Received: (qmail invoked by alias); 09 Apr 2008 16:54:47 -0000
Received: from unknown (EHLO eeepc-johanness.st-andrews.ac.uk) [138.251.11.75]
  by mail.gmx.net (mp027) with SMTP; 09 Apr 2008 18:54:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+mzX9p4iemXQjXUJUzfZZgaB/CnSzIu6JcY1FlYL
	6Us2ZwNQbx44YZ
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080409151551.GA30439@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79117>

Hi,

On Wed, 9 Apr 2008, Jeff King wrote:

> Many other commands use the "no arguments" form to show a
> list (e.g., git-branch, git-tag). While we did show all
> remotes for just "git remote", we displayed a usage error
> for "git remote show" with no arguments. This is
> counterintuitive, since by giving it _more_ information, we
> get _less_ result.
> 
> The usage model can now be thought of as:
> 
>   - "git remote show <remote>": show a remote
>   - "git remote show": show all remotes
>   - "git remote": assume "show"; i.e., shorthand for "git remote show"
> 
> Signed-off-by: Jeff King <peff@peff.net>

Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Ciao,
Dscho
