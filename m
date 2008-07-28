From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-merge: allow using a custom strategy
Date: Tue, 29 Jul 2008 01:59:12 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807290158470.2725@eeepc-johanness>
References: <1217288908-21124-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 01:59:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNccQ-0000g2-1I
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 01:59:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbYG1X6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 19:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752062AbYG1X6H
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 19:58:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:60624 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751847AbYG1X6G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 19:58:06 -0400
Received: (qmail invoked by alias); 28 Jul 2008 23:58:04 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp038) with SMTP; 29 Jul 2008 01:58:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/cRv8DW8Hc7rH0uea1oTDarLlJotTutNqwQmZq0i
	JM59RanWGsN+dn
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1217288908-21124-1-git-send-email-vmiklos@frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90529>

Hi,

On Tue, 29 Jul 2008, Miklos Vajna wrote:

> On Mon, Jul 28, 2008 at 03:06:09PM +0200, Johannes Schindelin 
> <Johannes.Schindelin@gmx.de> wrote:
>
> > The change in the signature of list_commands() is not part of this 
> > patch.  So at least one of your commits should result in an 
> > uncompileable revision...
> 
> Right. I just squashed patch 4 and 5, and this solves the problem: patch 
> 3 changes the signature and fixes all usage (in help.c, it's not used 
> outside help.c), then the squashed patch introduces the usage of the new 
> list_commands() in builtin-merge.c.

Thanks,
Dscho
