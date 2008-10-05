From: Marc Weber <marco-oweber@gmx.de>
Subject: What about renaming ga -i [r]evert to [r]eset ?
Date: Sun, 5 Oct 2008 17:26:54 +0200
Message-ID: <20081005152654.GA13618@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 05 17:28:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmVWk-0003wB-A7
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 17:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754054AbYJEP1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 11:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754048AbYJEP1A
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 11:27:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:59919 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754014AbYJEP07 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 11:26:59 -0400
Received: (qmail invoked by alias); 05 Oct 2008 15:26:56 -0000
Received: from pD9E0B72A.dip.t-dialin.net (EHLO nixos) [217.224.183.42]
  by mail.gmx.net (mp018) with SMTP; 05 Oct 2008 17:26:56 +0200
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX1+Fq4YunzuF/8iWxtx+kvmTsP35WjrsdNC+Q2BqXu
	g8NgqmLNiEfUNa
Received: by nixos (sSMTP sendmail emulation); Sun, 05 Oct 2008 17:26:54 +0200
Mail-Followup-To: Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-04-06)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97510>

Hi,

Some time ago I told a friend to use ga -i  [r](evert).. and I thought
it would do the same as svn revert (set the working copy back to the
state recorded in repo (which git checkout does)..

The ga -i help display reveals that reverting does reset the index
(cache to be comitted) instead.
I think it's better to rename the command [r]evert to [r]eset ?

I've also added the command [c]heckout last.

You can get the patch from git://mawercer.de/git_my_patches branch
revert_to_reset_renaming

Maybe someone of you beeing more familiar with perl,
git-add--interactive and git can review it maybe telling me what should
be done so that it can be committed upstream?

Thanks
Marc
