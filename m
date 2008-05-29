From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-init: treat option `--bare'
Date: Thu, 29 May 2008 14:51:06 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805291448161.13507@racer.site.net>
References: <20080519175313.GA17305@bit.office.eurotux.com> <20080520194850.GB19226@bit.office.eurotux.com> <7vy761sgks.fsf@gitster.siamese.dyndns.org> <20080528185103.GA4431@bit.office.eurotux.com> <20080528185357.GB4431@bit.office.eurotux.com>
 <7vzlqaq67h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Luciano Rocha <luciano@eurotux.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 29 15:54:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1iZ5-0006AL-Hg
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 15:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757388AbYE2NwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 09:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757382AbYE2NwS
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 09:52:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:59555 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757377AbYE2NwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 09:52:16 -0400
Received: (qmail invoked by alias); 29 May 2008 13:52:14 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO none.local) [132.187.25.128]
  by mail.gmx.net (mp043) with SMTP; 29 May 2008 15:52:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18maBVLxXImMD0cqhgEuhPL8OhHofxcy+1hbSUbi6
	Jk12lQ4TT7kNYm
X-X-Sender: gene099@racer.site.net
In-Reply-To: <7vzlqaq67h.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83201>

Hi,

On Wed, 28 May 2008, Junio C Hamano wrote:

> In general, I am not particularly fond of this kind of special casing, 
> but initializing a bare repository would be a common enough operation 
> that I personally think it is probably Ok to take this as an exception.

I like the Perl way (having multiple options to do the same thing), and do 
not like the Python way ("there is only one way to do one thing").

> Opinions?  Breakages?

I like the intent of the patch.  It will definitely make initializing 
bare Git repositories easier for new users.

Also keep in mind that "git --bare <some-command-other-than-init" is 
_really_ rare, at least in my experience.  I had to use it exactly _twice_ 
since I started using Git.

Ciao,
Dscho
