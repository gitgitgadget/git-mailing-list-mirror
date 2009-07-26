From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make git config fail on variables with no section, as
 documented
Date: Sun, 26 Jul 2009 18:49:28 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907261849110.8306@pacific.mpi-cbg.de>
References: <1248474081-sup-2762@utwig> <1248625102-472-1-git-send-email-alex@chmrr.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Alex Vandiver <alex@chmrr.net>
X-From: git-owner@vger.kernel.org Sun Jul 26 18:49:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MV6uk-0005KC-3N
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 18:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753856AbZGZQtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 12:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753852AbZGZQtY
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 12:49:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:45164 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753851AbZGZQtY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2009 12:49:24 -0400
Received: (qmail invoked by alias); 26 Jul 2009 16:49:23 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp050) with SMTP; 26 Jul 2009 18:49:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ybMMaTgayaDlc5dXJZBmWQ1qgMEOQ+lCnOQtS8i
	rebKTXLDtMqIXB
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1248625102-472-1-git-send-email-alex@chmrr.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124129>

Hi,

On Sun, 26 Jul 2009, Alex Vandiver wrote:

> Documentation/config.txt claims:
> 
>     Each variable must belong to some section, which means that there
>     must be a section header before the first setting of a variable.
> 
> However, the parsing code did not enforce this.  This change makes it
> a syntax error to defined a variable before the first section header.

Is there any downside in allowing this?

Ciao,
Dscho
