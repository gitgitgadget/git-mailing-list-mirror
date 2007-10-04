From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-init: don't base core.filemode on the ability to
 chmod.
Date: Thu, 4 Oct 2007 13:49:43 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710041345280.4174@racer.site>
References: <20071003105501.GD7085@admingilde.org> <470388DC.4040504@viscovery.net>
 <20071003231941.GA20800@admingilde.org> <Pine.LNX.4.64.0710040053380.28395@racer.site>
 <470482A2.3080907@op5.se> <7vr6kbbdph.fsf@gitster.siamese.dyndns.org>
 <20071004071751.GD20800@admingilde.org> <7vir5nb89d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Waitz <tali@admingilde.org>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 14:39:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdPzY-0004Ne-M0
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 14:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754316AbXJDMjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 08:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753468AbXJDMjj
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 08:39:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:38777 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752443AbXJDMji (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 08:39:38 -0400
Received: (qmail invoked by alias); 04 Oct 2007 12:39:36 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp021) with SMTP; 04 Oct 2007 14:39:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18nWHgTh7gnWPFLxtkbYQ3KcPqbj8tcK1hhHeCoZI
	sdPXEMciX1YTu5
X-X-Sender: gene099@racer.site
In-Reply-To: <7vir5nb89d.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59943>

Hi,

On Thu, 4 Oct 2007, Junio C Hamano wrote:

> I do not think git on Cygwin nor WinGit creates $GIT_DIR/config with 
> executable bit set.  Is this pretty much a workaround only for 
> vfat-on-Linux ?

I do not know precisely about Cygwin (a quick test on my USB stick shows 
that .git/config is created without the executable bit set), but in MSys 
plain files which start with a she-bang are automatically +x, while all 
other plain files are automatically -x (therefore this applies to 
.git/config).

Given these findings, I fail to see what the patch should achieve, as 
the first test (for -x) always succeeds...

Ciao,
Dscho
