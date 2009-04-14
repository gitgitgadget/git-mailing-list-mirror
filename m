From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 5/5] docs/checkout: clarify what "non-branch" means
Date: Tue, 14 Apr 2009 13:36:58 +0200
Organization: At home
Message-ID: <gs1sgq$99e$1@ger.gmane.org>
References: <20090413110947.GA15647@coredump.intra.peff.net> <20090413112104.GE15982@coredump.intra.peff.net> <7vmyakh5wc.fsf@gitster.siamese.dyndns.org> <200904132340.36191.mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 14 13:38:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtgyV-0004bh-5U
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 13:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271AbZDNLhN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 07:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbZDNLhN
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 07:37:13 -0400
Received: from main.gmane.org ([80.91.229.2]:53583 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751896AbZDNLhM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 07:37:12 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ltgwu-0000L5-W1
	for git@vger.kernel.org; Tue, 14 Apr 2009 11:37:09 +0000
Received: from abwx202.neoplus.adsl.tpnet.pl ([83.8.247.202])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 14 Apr 2009 11:37:08 +0000
Received: from jnareb by abwx202.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 14 Apr 2009 11:37:08 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwx202.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116531>

Mark Levedahl wrote:


> In this vein, I suggest that
>       $ git checkout --detach master
> as a way to get a detached HEAD on branch master is more understandable than
>       $ git checkout refs/heads/master

To detach, use
        $ git checkout master^0

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
