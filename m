From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] Public Gitweb Hosting Service
Date: Wed, 20 Sep 2006 03:01:14 +0200
Organization: At home
Message-ID: <eeq3sr$npj$1@sea.gmane.org>
References: <20060920004828.GI8259@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Sep 20 03:01:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPqT9-0008Tl-1O
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 03:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWITBBk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 21:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWITBBk
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 21:01:40 -0400
Received: from main.gmane.org ([80.91.229.2]:23748 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750787AbWITBBj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Sep 2006 21:01:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GPqSw-0008P5-Mn
	for git@vger.kernel.org; Wed, 20 Sep 2006 03:01:30 +0200
Received: from host-81-190-31-133.torun.mm.pl ([81.190.31.133])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Sep 2006 03:01:30 +0200
Received: from jnareb by host-81-190-31-133.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Sep 2006 03:01:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-133.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27323>

Petr Baudis wrote:

> There's
> insane amount of tags which means the gitweb summary page takes "a bit"
> long to load, I wonder if using packed refs would improve that.

Using git-for-each-ref would certainly improve speed (one fork vs. one per
tag), using packed refs (by the way, can it be limited to tags only?) will
improve speed further (one IO vs. one IO per tag).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
