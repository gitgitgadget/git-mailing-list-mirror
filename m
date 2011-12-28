From: Thomas Hochstein <thh@inter.net>
Subject: Re: GIT and SSH
Date: Wed, 28 Dec 2011 12:34:42 +0100
Message-ID: <gcvg.1112281234.3780@landroval.ancalagon.de>
References: <loom.20111228T091942-66@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 28 21:12:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rfzrr-0006qP-32
	for gcvg-git-2@lo.gmane.org; Wed, 28 Dec 2011 21:12:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754503Ab1L1UMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Dec 2011 15:12:50 -0500
Received: from lo.gmane.org ([80.91.229.12]:38188 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754460Ab1L1UMt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Dec 2011 15:12:49 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Rfzrh-0005sT-IA
	for git@vger.kernel.org; Wed, 28 Dec 2011 21:12:45 +0100
Received: from p4fccee6b.dip.t-dialin.net ([79.204.238.107])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Dec 2011 21:12:45 +0100
Received: from thh by p4fccee6b.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Dec 2011 21:12:45 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p4fccee6b.dip.t-dialin.net
User-Agent: ForteAgent/6.00-32.1186  Hamster/2.1.0.11
X-Uptime: 0 day(s), 9 hour(s), 6 minute(s), 46 second(s) [landroval | 66433]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187757>

Reza Mostafid schrieb:

> a.) Does the communication that takes place between a GIT `client` and a remote
>     GIT `repository` involve 'ssh' traffic?

Depends on how you do it (as already described by others).

> Our connections here are heavily censored and ssh traffic is suppressed most of
> the time which is why I need to figure out why a simple  
>
>     $ git clone git://<URL> 
>
> command chokes to a halt and freezes most of the time ( the same command when
> executed remotely on our V.P.S. in Europe works flawlessly ).

"git://" uses the git protocol which does not involve SSH.

    $ git clone ssh://<URL>

would use SSH.

-thh
