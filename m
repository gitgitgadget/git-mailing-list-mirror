From: Christof =?ISO-8859-1?Q?Kr=FCger?= <git@christof-krueger.de>
Subject: Re: importing history
Date: Thu, 30 Jun 2011 07:00:43 +0200
Message-ID: <1309410043.2417.70.camel@oxylap>
References: <20110629164514.58175480.mihamina@bbs.mg>
	 <348bd65ad7c7690bcce553fe3c8e0bfb.squirrel@mail.localhost.li>
	 <m2sjqswp85.fsf@igel.home> <1309366960.2417.55.camel@oxylap>
	 <m262nofhid.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Mihamina Rakotomandimby <mihamina@bbs.mg>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Thu Jun 30 07:01:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qc9N7-0001uR-FA
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 07:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091Ab1F3FA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jun 2011 01:00:57 -0400
Received: from vserver.localhost.li ([85.214.46.152]:42763 "EHLO
	mail.localhost.li" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab1F3FA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2011 01:00:56 -0400
Received: from p5794caec.dip.t-dialin.net ([87.148.202.236]:56387 helo=[192.168.0.126])
	by mail.localhost.li with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <git@christof-krueger.de>)
	id 1Qc9Mr-0004Xz-6n; Thu, 30 Jun 2011 07:00:46 +0200
In-Reply-To: <m262nofhid.fsf@igel.home>
X-Mailer: Evolution 2.30.3 
X-Spam-Score: 0.0 (/)
X-Spam-Report: none
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176474>

On Mi, 2011-06-29 at 23:35 +0200, Andreas Schwab wrote:
> I'm not talking about the config options, but of the ref namespace.  If
> your svn repository would have a branch named origin it would be stored
> as refs/remotes/origin by git svn, which would conflict with "git remote
> add origin ..."
Ah, thanks for explaining.
As of now, I only had to do with rather "dump" SVN repositories with
only a trunk (or only non-stdlayout branches I didn't care about
anyways).

But do you think things could be seriously screwed up because of this?
Or would just one of the commands gracefully fail, leaving the
unexperienced user with an error message he doesn't understand?

Chris.
