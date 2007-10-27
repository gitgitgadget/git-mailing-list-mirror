From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Allow git-runstatus to limit its scope to a set of
 files/directories.
Date: Sat, 27 Oct 2007 19:24:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710271922340.4362@racer.site>
References: <ffofbm@ger.gmane.org> <1193508519-14140-1-git-send-email-mma@objectxp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Michel Marti <mma@objectxp.com>
X-From: git-owner@vger.kernel.org Sat Oct 27 20:25:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlqLC-0005Vh-By
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 20:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbXJ0SYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 14:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbXJ0SYq
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 14:24:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:47449 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751003AbXJ0SYp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 14:24:45 -0400
Received: (qmail invoked by alias); 27 Oct 2007 18:24:43 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp020) with SMTP; 27 Oct 2007 20:24:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18kWd5ZhvEkNfVvlCXJZ1ipGqFcmaTd+MpES9cakG
	GtjG/xFNykLvyN
X-X-Sender: gene099@racer.site
In-Reply-To: <1193508519-14140-1-git-send-email-mma@objectxp.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62507>

Hi,

On Sat, 27 Oct 2007, Michel Marti wrote:

> Signed-off-by: Michel Marti <mma@objectxp.com>
> ---
> IMO, the next step should be to tweak git-status/git-commit: I suggest 
> introducing a new option '--what-if' to 'git-commit' that behaves like current
> 'git-status [<path>...]' and in return stop 'git-status' from displaying 
> '[<path>...]'  as "Changes to commit".

I am not sure this is the correct way to go, since "git status" as a "git 
commit --dry-run" has worked well so far.

Besides, I would like to see builtin-commit go in as soon as possible, and 
this patch would delay that.

Ciao,
Dscho
