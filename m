From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] clone: respect the settings in $HOME/.gitconfig and
 /etc/gitconfig
Date: Sun, 29 Jun 2008 22:49:42 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806292248160.9925@racer>
References: <27C25D70-0BFC-4362-A771-C7CAD89BC198@ai.rug.nl> <alpine.DEB.1.00.0806271353350.9925@racer> <alpine.LNX.1.00.0806271149580.19665@iabervon.org> <7vvdzuo61b.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0806291359330.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Jun 29 23:52:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD4pB-0001pV-75
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 23:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbYF2Vvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 17:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbYF2Vvo
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 17:51:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:36624 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751426AbYF2Vvn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 17:51:43 -0400
Received: (qmail invoked by alias); 29 Jun 2008 21:51:41 -0000
Received: from 87.113.36.200.plusnet.pte-ag1.dyn.plus.net (EHLO racer.local) [87.113.36.200]
  by mail.gmx.net (mp052) with SMTP; 29 Jun 2008 23:51:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18pcqs8cPoppjcAhmcrDeOsE1T+DMpYgiFOmQT8oz
	Wlc2WK8dSup29M
X-X-Sender: gene099@racer
In-Reply-To: <alpine.LNX.1.00.0806291359330.19665@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86835>

Hi,

On Sun, 29 Jun 2008, Daniel Barkalow wrote:

> Did we even make a commitment on whether:
> 
> GIT_CONFIG=foo git clone bar
> 
> must ignore the environment variable, or simply doesn't necessarily obey 
> it?

I'd rather strongly argue that no matter what is the answer to this 
question, we _HAVE TO_ unsetenv() GIT_CONFIG at some stage, otherwise no 
.git/config will be written.

So, this is a NACK on your patch.

Ciao,
Dscho
