From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] chronoversion: chronological archiving script with temporary commits
Date: Tue, 13 Mar 2007 16:42:47 +0100
Organization: At home
Message-ID: <et6gkk$ngm$1@sea.gmane.org>
References: <e1dab3980703130526t4b573f18h793a065d54c9369@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 13 16:41:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HR981-0004YD-N0
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 16:41:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030734AbXCMPk5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 11:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030747AbXCMPk5
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 11:40:57 -0400
Received: from main.gmane.org ([80.91.229.2]:34256 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030734AbXCMPk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 11:40:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HR97E-0005sU-Fr
	for git@vger.kernel.org; Tue, 13 Mar 2007 16:40:44 +0100
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Mar 2007 16:40:44 +0100
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Mar 2007 16:40:44 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42121>

[Cc: git@vger.kernel.org]

David Tweed wrote:

> Hi, I believe that I've now got temporary commits (for bookkeeping,
> hi-granularity bisecting recent changes) working, so I'm just
> mentioning there's a new version of chronoversion at
> 
> http://www.personal.rdg.ac.uk/~sis05dst/chronoversion.tgz

By the way, do you have homepage for this project? If not, perhaps
you could write a few sentences on git wiki, e.g. at
  http://git.or.cz/gitwiki/Chronoversion
(linking it from http://git.or.cz/gitwiki/InterfacesFrontendsAndTools)

[...] 
> Is there any neat way of using builtin stuff like git-rev-parse to ask
> if a ref has a given SHA1 value and return an easily parsed yes/no
> answer?

There is git-show-ref which was made because of introduction of packed
refs, and there is git-for-each-ref which _might_ be used to avoid
extra forking (extra calls).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
