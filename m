From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Aug 2008, #07; Sat, 23)
Date: Sun, 24 Aug 2008 20:12:43 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808241955550.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <7v1w0ft750.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 20:08:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXK1B-000637-Jw
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 20:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752345AbYHXSHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 14:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048AbYHXSHo
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 14:07:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:44609 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752013AbYHXSHo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 14:07:44 -0400
Received: (qmail invoked by alias); 24 Aug 2008 18:07:42 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp041) with SMTP; 24 Aug 2008 20:07:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19XkSIIpXxXTf1UxKxBrTyPwpp+f1AgWCcY7yTcbg
	AioirOQICqe61g
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <7v1w0ft750.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93541>

Hi,

On Sat, 23 Aug 2008, Junio C Hamano wrote:

> ----------------------------------------------------------------
> [Stalled -- Needs Action to Proceed (or to be dropped)]
> 
> * sb/daemon (Thu Aug 14 20:02:20 2008 +0200) 4 commits
>  - git-daemon: rewrite kindergarden, new option --max-connections
>  - git-daemon: Simplify dead-children reaping logic
>  - git-daemon: use LOG_PID, simplify logging code
>  - git-daemon: call logerror() instead of error()
> 
> Can somebody who actually runs the daemon standalone comment on this 
> one?

I am somewhat uneasy about running my production machine with these 
changes, since the last commit (the one introducing a kindergarden with 
cradles) is too unobvious for me.

Ciao,
Dscho
