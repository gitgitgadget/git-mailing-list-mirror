From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make --color available to git-status
Date: Sat, 5 May 2007 19:58:45 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705051956200.4015@racer.site>
References: <11783866694076-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sat May 05 19:59:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkOXH-0000dX-Mh
	for gcvg-git@gmane.org; Sat, 05 May 2007 19:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934072AbXEER7I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 13:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934171AbXEER7I
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 13:59:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:47058 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934072AbXEER7G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2007 13:59:06 -0400
Received: (qmail invoked by alias); 05 May 2007 17:59:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp022) with SMTP; 05 May 2007 19:59:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+am9pZ53Sak3nDBlYNR6hnLcDX0kti5/6NBfzVmI
	glA/GfEKCo5kgo
X-X-Sender: gene099@racer.site
In-Reply-To: <11783866694076-git-send-email-Matthieu.Moy@imag.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46278>

Hi,

On Sat, 5 May 2007, Matthieu Moy wrote:

> Git has a nice colored output for status, using
> 
> $ git runstatus --color
> 
> However, this --color is not made available to git-status itself.

AFAIR there have been attempts to enable this by default, when git-status 
is run interactively (i.e. its output is not piped). However, this proved 
to be remarkably complex, given that the output of runstatus _is_ piped.

IMHO the proper solution would be to go the full nine yards, and teach 
runstatus about the remaining parts of git-status. Then, automatic color 
works automatically.

Ciao,
Dscho
