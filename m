From: Christof =?ISO-8859-1?Q?Kr=FCger?= <git@christof-krueger.de>
Subject: Re: importing history
Date: Wed, 29 Jun 2011 19:02:40 +0200
Message-ID: <1309366960.2417.55.camel@oxylap>
References: <20110629164514.58175480.mihamina@bbs.mg>
	 <348bd65ad7c7690bcce553fe3c8e0bfb.squirrel@mail.localhost.li>
	 <m2sjqswp85.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Mihamina Rakotomandimby <mihamina@bbs.mg>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Wed Jun 29 19:03:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbyAF-00064Z-A0
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 19:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222Ab1F2RCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jun 2011 13:02:54 -0400
Received: from vserver.localhost.li ([85.214.46.152]:53898 "EHLO
	mail.localhost.li" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912Ab1F2RCx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2011 13:02:53 -0400
Received: from p5794c8fc.dip.t-dialin.net ([87.148.200.252]:48391 helo=[192.168.0.126])
	by mail.localhost.li with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <git@christof-krueger.de>)
	id 1Qby9y-00013e-9B; Wed, 29 Jun 2011 19:02:43 +0200
In-Reply-To: <m2sjqswp85.fsf@igel.home>
X-Mailer: Evolution 2.30.3 
X-Spam-Score: 0.0 (/)
X-Spam-Report: none
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176448>

On Mi, 2011-06-29 at 18:56 +0200, Andreas Schwab wrote:
> Careful.  git svn uses the remotes namespace in a non-std way.  Better
> to locally clone the from-svn repository into a new one, then use "git
> remote add origin user@example.com/path/to/repository.git" to add the
> remote repository.  Then you can safely push the master branch.
Doesn't git svn use svn-remove.svn.* and not remote.*?
I've been doing that before and it worked for me.

"git svn dcommit" and "git push" are orthogonal to my understanding. If
you have an example, where git svn doesn't play well with "usual" git
remotes, I'd be happy to see them.

Regards,
  Chris 
