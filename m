From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-fetch per-repository speed issues
Date: Tue, 04 Jul 2006 17:42:12 +0200
Organization: At home
Message-ID: <e8e28j$v8v$1@sea.gmane.org>
References: <1151949764.4723.51.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Jul 04 17:43:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fxn3I-0008ER-Fo
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 17:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWGDPm6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 11:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWGDPm5
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 11:42:57 -0400
Received: from main.gmane.org ([80.91.229.2]:30376 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932260AbWGDPm4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 11:42:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Fxn2j-00086D-Nq
	for git@vger.kernel.org; Tue, 04 Jul 2006 17:42:29 +0200
Received: from host-81-190-27-124.torun.mm.pl ([81.190.27.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Jul 2006 17:42:29 +0200
Received: from jnareb by host-81-190-27-124.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Jul 2006 17:42:29 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-124.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23301>

I wonder if the problem detected here is also responsible with results 
of Jeremy Blosser benchmark comparing git with Mercurial
http://lists.ibiblio.org/pipermail/sm-discuss/2006-May/014586.html
where git wins for clone, status and log, but is slower for pull.

See summary at
http://git.or.cz/gitwiki/GitBenchmarks#head-85df1bb7f019c4c504e34cde43450ef69349882f
-- 
Jakub Narebski
