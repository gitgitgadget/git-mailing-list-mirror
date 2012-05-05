From: Marc Weber <marco-oweber@gmx.de>
Subject: Re: recipe to use git for deployment
Date: Sat, 05 May 2012 07:04:15 +0200
Message-ID: <1336194247-sup-6608@nixos>
References: <jo283q$kna$1@dough.gmane.org> <1336190286-sup-3813@nixos> <4FA4AFE4.6040701@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 07:04:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQXAO-0003vs-Ou
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 07:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159Ab2EEFET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 May 2012 01:04:19 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:55528 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750789Ab2EEFES (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2012 01:04:18 -0400
Received: (qmail invoked by alias); 05 May 2012 05:04:15 -0000
Received: from p4FF8B575.dip.t-dialin.net (EHLO mail.gmx.net) [79.248.181.117]
  by mail.gmx.net (mp034) with SMTP; 05 May 2012 07:04:15 +0200
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX19TsCB1OgJTtPayYTnjsYX5JNNSPaB3/QlYRNyDUn
	J5O6xTwxqMU4Vn
Received: by mail.gmx.net (sSMTP sendmail emulation); Sat, 05 May 2012 07:04:15 +0200
In-reply-to: <4FA4AFE4.6040701@gmail.com>
User-Agent: Sup/git
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197094>

I've been deploying .php files this way only..

If you want to deploy full configuration of hosts you may also want to
learn about nixos.org (which handles restarting apache etc) or chef
like systemms:
http://www.rubyinside.com/chef-tasty-server-configuraiton-2162.html
using nixos you can easily automatically generate additional cron job
ensuring that permissions are correct etc.

Maybe talking about your exact use case will make others list more
options.

Marc Weber
