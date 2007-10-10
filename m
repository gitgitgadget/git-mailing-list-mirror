From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [FEATURE REQUEST] git clone, just clone selected branches?
Date: Wed, 10 Oct 2007 20:35:02 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710102032330.4174@racer.site>
References: <011401c80b6f$1a11d1f0$04ac10ac@Jocke>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
X-From: git-owner@vger.kernel.org Wed Oct 10 21:35:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfhLC-0001HL-8t
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 21:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755046AbXJJTfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 15:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754619AbXJJTfW
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 15:35:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:38582 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751820AbXJJTfV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 15:35:21 -0400
Received: (qmail invoked by alias); 10 Oct 2007 19:35:20 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 10 Oct 2007 21:35:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ekdRgt5lezfqI3MTAzZ8QwWgOhTE4S5MB3Fnygp
	oiNR0AuGTQHjOX
X-X-Sender: gene099@racer.site
In-Reply-To: <011401c80b6f$1a11d1f0$04ac10ac@Jocke>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60531>

Hi,

On Wed, 10 Oct 2007, Joakim Tjernlund wrote:

> To my knowlede a git clone always clones all branches from the remote 
> repo. I would like the possibly to clone selected branches, like
>  git clone <repo URL> -b master -b upstream
> which will only fetch the master and upstream branch.
> 
> I know I can use git remote to do this, but it is a bit clumsy when 
> starting a new repo.

This is why I suggest: since it is an itch of yours, just fix it.  You are 
in the prime position to know when you're satisfied.

As a hint how to start: Junio dreamt of a git-clone which is a tiny 
wrapper around git-fetch and git-remote.

So you could start by writing a script which would be a replacement for 
git-clone.sh, and there you can also include the support for -b that you 
would like so much.

It would be nice, though, to keep this in separate patches, which you then 
submit to this list.

Thank you,
Dscho
