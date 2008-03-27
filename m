From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] Allow git-cvsserver database table name prefix to be
 specified.
Date: Thu, 27 Mar 2008 23:35:26 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803272334470.3802@racer.site>
References: <20080327205727.GN2324@opal.elsasser.org> <12066517343988-git-send-email-josh@elsasser.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Frank Lichtenheld <frank@lichtenheld.de>,
	Junio C Hamano <gitster@pobox.com>
To: Josh Elsasser <josh@elsasser.org>
X-From: git-owner@vger.kernel.org Thu Mar 27 23:36:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jf0hj-0003wx-Vc
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 23:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209AbYC0Wfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 18:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753200AbYC0Wfa
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 18:35:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:33022 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751442AbYC0Wf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2008 18:35:29 -0400
Received: (qmail invoked by alias); 27 Mar 2008 22:35:27 -0000
Received: from host86-139-218-102.range86-139.btcentralplus.com (EHLO racer.home) [86.139.218.102]
  by mail.gmx.net (mp033) with SMTP; 27 Mar 2008 23:35:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19JpQUwGiJJnaNL8IR05PsAvBJ9lS7ci4vYDo6U9q
	b6K2E8XyEW1VqN
X-X-Sender: gene099@racer.site
In-Reply-To: <12066517343988-git-send-email-josh@elsasser.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78377>

Hi,

On Thu, 27 Mar 2008, Josh Elsasser wrote:

> Adds a gitcvs.dbtablenameprefix config variable, the contents of which 
> are prepended to any database tables names used by git-cvsserver. The 
> same substutions as gitcvs.dbname and gitcvs.dbuser are supported, and 
> any non-alphabetic characters are replaced with underscores.
> 
> A typo found in contrib/completion/git-completion.bash is also fixed.
> ---
> 
> This version of the patch is a bit cleaner, it calls a function to get 
> the table names instead of pasting a variable reference everywhere. The 
> config var name has also been changed from gitcvs.dbprefix to 
> gitcvs.dbTableNamePrefix

I probably missed something, but I cannot find a reason why you need this.  
In the commit message, I mean.

Ciao,
Dscho
