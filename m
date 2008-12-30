From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] git-cherry: make <upstream> parameter optional
Date: Tue, 30 Dec 2008 14:37:06 +0100
Message-ID: <200812301437.06726.markus.heidelberg@web.de>
References: <200812291845.20500.markus.heidelberg@web.de> <alpine.DEB.1.00.0812301411480.30769@pacific.mpi-cbg.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 30 14:38:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHenl-0005F4-5y
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 14:38:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbYL3NhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 08:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbYL3NhH
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 08:37:07 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:34881 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbYL3NhF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 08:37:05 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 462F9F8653BC;
	Tue, 30 Dec 2008 14:37:04 +0100 (CET)
Received: from [89.59.108.32] (helo=pluto)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #273)
	id 1LHemO-0007Uh-00; Tue, 30 Dec 2008 14:37:04 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0812301411480.30769@pacific.mpi-cbg.de>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19JfhbgMX4Qp6yohJ7CWYrfIuzy9hcs328qXw/8
	6wYtEGaPse8BKjPWvJHGGAq1KwVszL4aTRtC8QfPYpnc3/Yn7q
	bYM6b1LO7StEo0geLONA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104184>

Johannes Schindelin, 30.12.2008:
> Hi,
> 
> On Mon, 29 Dec 2008, Markus Heidelberg wrote:
> 
> > The upstream branch <upstream> now defaults to the first tracked
> > remote branch, which is set by the configuration variables
> > branch.<name>.remote and branch.<name>.merge of the current branch.
> > 
> > Without such a remote branch, the command "git cherry [-v]" fails with
> > usage output as before and an additional message.
> > 
> > Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
> 
> This would be a massively visible user interface change.  At the moment, 
> it does this (which I like):
> 
> 	$ git cherry-pick
> 	usage: git cherry-pick [options] <commit-ish>
> 
> 	    -n, --no-commit       don't automatically commit
> 	    -e, --edit            edit the commit message
> 	    -x                    append commit name when cherry-picking
> 	    -r                    no-op (backward compatibility)
> 	    -s, --signoff         add Signed-off-by:
> 	    -m, --mainline <n>    parent number
> 
> Opposed,
> Dscho

The patch was about git-cherry, not git-cherry-pick.

Markus
