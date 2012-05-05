From: Marc Weber <marco-oweber@gmx.de>
Subject: Re: recipe to use git for deployment
Date: Sat, 05 May 2012 06:10:46 +0200
Message-ID: <1336190286-sup-3813@nixos>
References: <jo283q$kna$1@dough.gmane.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 05 06:11:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQWL7-0003Hy-2R
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 06:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845Ab2EEEKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 May 2012 00:10:50 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:53791 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750731Ab2EEEKt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2012 00:10:49 -0400
Received: (qmail invoked by alias); 05 May 2012 04:10:46 -0000
Received: from p4FF8B575.dip.t-dialin.net (EHLO mail.gmx.net) [79.248.181.117]
  by mail.gmx.net (mp030) with SMTP; 05 May 2012 06:10:46 +0200
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX18wrF8IXYkwDFebBuFXfc7NYgNhi+V3AmAAZXgJfJ
	wHsXcDIz0gkoJx
Received: by mail.gmx.net (sSMTP sendmail emulation); Sat, 05 May 2012 06:10:46 +0200
In-reply-to: <jo283q$kna$1@dough.gmane.org>
User-Agent: Sup/git
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197089>

I always did "git pull" on the servers - but the history of my projects
is not that huge.. Thus I never cared.
Great: You can keep some server specific config settings and rebase
them - and you can do a fast git status to check whether file contents
have been modified (eg determine whether you've been hacked ..)

If you really care that much about history why not push a zip file using
git archive --format=zip and unpack that on the deployment server
instead?

For FTP access only this did a great job for small projects:
https://github.com/MarcWeber/git-ftp (-> git-ftp-minimal.sh)
It only copies changed files *and* checks whether they have been
modified on the server first (detecting work of others).
But that's probably not a good thing for automatic deployment.

Marc Weber
