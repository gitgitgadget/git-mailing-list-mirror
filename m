From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 00:40:20 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705240039370.4113@racer.site>
References: <11799589913153-git-send-email-skimo@liacs.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Thu May 24 01:41:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hr0SB-0002Ke-JM
	for gcvg-git@gmane.org; Thu, 24 May 2007 01:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757308AbXEWXlM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 19:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757025AbXEWXlL
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 19:41:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:59545 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756624AbXEWXlK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 19:41:10 -0400
Received: (qmail invoked by alias); 23 May 2007 23:41:09 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 24 May 2007 01:41:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/I2f5QuGfIQV1vHfhrXLR6PFEZWfhbcRRVzfiUkE
	ifCO2Ito1nQVsn
X-X-Sender: gene099@racer.site
In-Reply-To: <11799589913153-git-send-email-skimo@liacs.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48210>

Hi,

On Thu, 24 May 2007, skimo@liacs.nl wrote:

> This patch series implements a mechanism for cloning submodules.
> Each submodule is specified by a 'submodule.<submodule>.url'
> configuration option, e.g.,
> 
> bash-3.00$ ./git-config --remote=http://www.liacs.nl/~sverdool/isa.git --get-regexp 'submodule\..*\.url' 
> submodule.cloog.url /home/sverdool/public_html/cloog.git
> submodule.cloog.url http://www.liacs.nl/~sverdool/cloog.git

I am sorry to complain so late in the game, but I am not really interested 
in submodules. However, what you say here is not a task for git-config 
IMHO, but rather for git-remote.

Ciao,
Dscho
