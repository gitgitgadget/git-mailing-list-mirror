From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Replace git --paginate by git --pager[=PAGER_CMD].
Date: Tue, 21 Aug 2007 10:42:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0708211041170.16728@wbgn129.biozentrum.uni-wuerzburg.de>
References: <fadhkv$amj$2@sea.gmane.org> <11876854283229-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Aug 21 10:42:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INPJj-0002pX-UH
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 10:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587AbXHUImY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 04:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752530AbXHUImY
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 04:42:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:54057 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751964AbXHUImX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 04:42:23 -0400
Received: (qmail invoked by alias); 21 Aug 2007 08:42:21 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp003) with SMTP; 21 Aug 2007 10:42:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18A3NUf8CkAzCwHRdpSfheGHj/Hrkj61ftJ5CKTsI
	NgSrQuKGjvSOuu
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <11876854283229-git-send-email-Matthieu.Moy@imag.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56285>

Hi,

On Tue, 21 Aug 2007, Matthieu Moy wrote:

> The previous one was -p|--paginate, but doesn't accept a natural
> negation. This patch changes it to -p|--pager|--pager=PAGER_CMD, which
> makes the negation --no-pager more natural, and provides a simple way to
> override the pager command (git --pager=CMD is equivalent to
> GIT_PAGER=CMD git with most shells).
> 
> --paginate is kept as a backward-compatibility, deprecated option.

Personally, I like to read "git --paginate log" better than to read "git 
--pager log".  So I would not unnecessarily deprecate --paginate.  It's 
not like it hurts or something.

Ciao,
Dscho
