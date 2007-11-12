From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] status&commit: Teach them to show submodule commit
 summary
Date: Mon, 12 Nov 2007 16:13:19 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711121612250.4362@racer.site>
References: <1194877277-31777-1-git-send-email-pkufranky@gmail.com>
 <4738784F.7010106@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ping Yin <pkufranky@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Nov 12 17:14:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrbvW-0004vH-62
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 17:14:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195AbXKLQNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 11:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753206AbXKLQNf
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 11:13:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:47998 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752394AbXKLQNe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 11:13:34 -0500
Received: (qmail invoked by alias); 12 Nov 2007 16:13:32 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 12 Nov 2007 17:13:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/BEz08e+jB33OXKsP49irA2qNvco/c66xZ7CGEi6
	k3yfHJKKurOlpp
X-X-Sender: gene099@racer.site
In-Reply-To: <4738784F.7010106@viscovery.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64647>

Hi,

On Mon, 12 Nov 2007, Johannes Sixt wrote:

> Ping Yin schrieb:
> > git status/commit just treats submodules as ordinary files when 
> > reporting status changes. However, one may also wonder how submodules 
> > change (the commits).
> > 
> > This commit teaches git status/commit to additionally show commit 
> > summary of user-cared (i.e. checked out) modified submodules since 
> > HEAD (or HEAD^ if --amend option is on). For submodules deleted or 
> > initially added, commit summary are not shown.
> 
> In general, I like the idea (as I've already pointed out).
> 
> But at this time git-commit is about to be made a builtin, and since 
> your implementation contains a lot of non-portable constructs ($'', >&) 
> and a new dependency on awk (and, hence, has little chances of being 
> accepted), I suggest that you stay tuned, and implement this in the 
> forth-coming builtin-commit.c.

I agree.

> > A configuration variable 'submodule.status' is used to turn this 
> > summary behaviour on or off (default off). Also --submodule and 
> > --no-submodule options are added.
> 
> There is already 'status.color', I suggest the configuration to become 
> 'status.submoduleSummary'.

You could make this variable even a numeric one.  Saying how many lines 
you want to have maximally (-1 meaning unlimited).

Ciao,
Dscho
