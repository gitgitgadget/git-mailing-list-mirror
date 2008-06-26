From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git rebase interactive: usability issue
Date: Thu, 26 Jun 2008 04:17:55 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0806260416410.4503@eeepc-johanness>
References: <20080625233208.GE5737@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 04:19:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBh4U-0005Lh-AA
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 04:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600AbYFZCRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 22:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752248AbYFZCRw
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 22:17:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:60567 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751999AbYFZCRw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 22:17:52 -0400
Received: (qmail invoked by alias); 26 Jun 2008 02:17:50 -0000
Received: from unknown (EHLO eeepc-johanness) [87.112.52.237]
  by mail.gmx.net (mp066) with SMTP; 26 Jun 2008 04:17:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19fYJZVBdNfuH2l02Ck3PSCP7ekQaNRZHP0xZTMGJ
	4qYXLGZikFfUIQ
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080625233208.GE5737@dpotapov.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86386>

Hi,

On Thu, 26 Jun 2008, Dmitry Potapov wrote:

> -- >8 --
> From: Dmitry Potapov <dpotapov@gmail.com>
> Date: Wed, 25 Jun 2008 23:23:22 +0400
> Subject: [PATCH] don't allow 'commit --amend' during rebase conflict resolution

This is a very funny way to interpret the SubmittingPatches document.  
Just stating a fact here.

> Running 'commit --amend' during git rebase is almost certainly a 
> mistake, which causes that two consequent patches are squashed together. 
> Moreover, the commit message of the second commit is silently lost. It 
> is almost certainly not what the user expects. In that very unlikely 
> case when you really want to combine two patches during rebase conflict 
> resolution, you can do that using "git reset --soft HEAD^" followed by 
> "git commit".

NACK.

You just broke the 'edit' command.

Ciao,
Dscho
