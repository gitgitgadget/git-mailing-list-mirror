From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git log of all (modifying) commands run on a repo?
Date: Thu, 8 Feb 2007 19:36:58 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702081934300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <17866.20355.744025.133326@lisa.zopyra.com>
 <Pine.LNX.4.64.0702071441160.8424@woody.linux-foundation.org>
 <7vd54l60gg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071525270.8424@woody.linux-foundation.org>
 <7vtzxx4k1c.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071539390.8424@woody.linux-foundation.org>
 <7v8xf94hq1.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702080140230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmz3p321n.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702080948240.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 08 19:37:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFE8n-0005Hj-Ge
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 19:37:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398AbXBHShB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 13:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752416AbXBHShA
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 13:37:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:58679 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752398AbXBHShA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 13:37:00 -0500
Received: (qmail invoked by alias); 08 Feb 2007 18:36:58 -0000
X-Provags-ID: V01U2FsdGVkX18brNh0sR8bAFCJcn7BQygF1xWb3VIsf+Bv0R2WMS
	f4Gg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0702080948240.8424@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39070>

Hi,

On Thu, 8 Feb 2007, Linus Torvalds wrote:

> On Wed, 7 Feb 2007, Junio C Hamano wrote:
> > 
> > I think we are in agreement.  I showed an outright hacky one
> > because I am not ready to do somewhat involved one at the end of
> > the rc period.
> 
> How about this?
>
> [...]
> 
>  Documentation/git-reflog.txt |   17 +++++++++++++----

Wow: documentation by Linus! ;-)

> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
> diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt

Not using commit & format-patch?

> index 1138865..bc7c987 100644
> --- a/Documentation/git-reflog.txt
> +++ b/Documentation/git-reflog.txt
> @@ -8,13 +8,18 @@ git-reflog - Manage reflog information
>  
>  SYNOPSIS
>  --------
> -[verse]
> -'git-reflog' expire [--dry-run] [--stale-fix]
> -	[--expire=<time>] [--expire-unreachable=<time>] [--all] <refs>...
> -
> +'git reflog' <subcommand> <options> 

This line has white space at the end.

Besides those (TIC) comments, I also have this one: Looks good to me!

Ciao,
Dscho
