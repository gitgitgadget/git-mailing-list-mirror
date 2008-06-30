From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Only use GIT_CONFIG in "git config", not other
 programs
Date: Mon, 30 Jun 2008 13:28:03 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806301247110.19665@iabervon.org>
References: <alpine.LNX.1.00.0806300328380.19665@iabervon.org> <7vskuv1hj1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 19:29:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDNBZ-0007jS-3F
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 19:29:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744AbYF3R2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 13:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752377AbYF3R2G
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 13:28:06 -0400
Received: from iabervon.org ([66.92.72.58]:48470 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752180AbYF3R2F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 13:28:05 -0400
Received: (qmail 24552 invoked by uid 1000); 30 Jun 2008 17:28:03 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Jun 2008 17:28:03 -0000
In-Reply-To: <7vskuv1hj1.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86925>

On Mon, 30 Jun 2008, Junio C Hamano wrote:

> Hmm, I actually think this is a good thing to do in the sense that it
> vastly simplifies the user experience ;-).  Two less things to explain.
> 
> Care to write up a snippet for 1.6.0 release notes, as this is quite a
> large user visible backward incompatible change, even though it would be
> an improvement?

Sure:

* GIT_CONFIG, which was only documented as affecting "git config", but 
  actually affected all git commands, now only affects "git config". 
  GIT_LOCAL_CONFIG, also only documented as affecting "git config" and not 
  different from GIT_CONFIG in a useful way, is removed.

	-Daniel
*This .sig left intentionally blank*
