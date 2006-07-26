From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] gitweb: fix two warnings
Date: Wed, 26 Jul 2006 20:43:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607262040270.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060726174841.90834.qmail@web31809.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Jul 26 20:44:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5oMT-000175-Nn
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 20:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWGZSn7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 14:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWGZSn7
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 14:43:59 -0400
Received: from mail.gmx.net ([213.165.64.21]:23457 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751002AbWGZSn6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jul 2006 14:43:58 -0400
Received: (qmail invoked by alias); 26 Jul 2006 18:43:57 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 26 Jul 2006 20:43:57 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <20060726174841.90834.qmail@web31809.mail.mud.yahoo.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24235>

Hi,

On Wed, 26 Jul 2006, Luben Tuikov wrote:

> --- Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> > These warnings cluttered up my log.
> 
> Can you please give more details of the warnings, cut-and-paste
> would be nice, the problem as you perceive it, and your solution to it?

Sure: The log contains these lines over and over again (I wrapped them 
manually):

Wed Jul 26 15:54:52 2006] [error] [client 192.168.0.67] \
[Wed Jul 26 15:54:52 2006] \
gitweb.cgi: Parentheses missing around "my" list at \
/[my-private-repo]/.git/gitweb/gitweb.cgi line 798., \
referer: http://dumbo:1234/?p=.git;a=summary

and

[Wed Jul 26 15:54:52 2006] [error] [client 192.168.0.67] \
[Wed Jul 26 15:54:52 2006] \
gitweb.cgi: Parentheses missing around "my" list at \
/[my-private-repo]/.git/gitweb/gitweb.cgi line 813., \
referer: http://dumbo:1234/?p=.git;a=summary

And my solution was to add the parentheses around the parameter of "my".

Ciao,
Dscho
