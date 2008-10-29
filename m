From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git show <tree>: show mode and hash, and handle -r
Date: Wed, 29 Oct 2008 15:41:01 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0810291540390.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.DEB.1.00.0810290207330.22125@pacific.mpi-cbg.de.mpi-cbg.de> <49080EA4.9080404@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org, schacon@gmail.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 29 15:35:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvC8T-00081S-AZ
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 15:35:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753828AbYJ2Odt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 10:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753824AbYJ2Ods
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 10:33:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:59362 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753733AbYJ2Odr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 10:33:47 -0400
Received: (qmail invoked by alias); 29 Oct 2008 14:33:45 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp059) with SMTP; 29 Oct 2008 15:33:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18I59lXfPsIx0J5qRN9XaBNHsUCm8KjphQxHZlUKN
	OTjusVm4rVeIEA
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <49080EA4.9080404@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99365>

Hi,

On Wed, 29 Oct 2008, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > Now, git show <tree> shows some more information, and with the -r option,
> > it recurses into subdirectories.
> > 
> > Requested by Scott Chacon.
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > 
> > 	The only quirk is the command line parsing for -r: we cannot use 
> > 	DIFF_OPT_TST(&rev.diffopt, RECURSIVE), because that is switched 
> > 	on not only by cmd_log_init(), but implicitly by 
> > 	diff_setup_done(), because FORMAT_PATCH is selected by git-show.
> 
> This comment should for sure go into the commit message.

Fair enough.

Junio, you want me to resend?

Ciao,
Dscho
