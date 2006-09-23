From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC][RESEND][PATCH] Allow fetching from multiple repositories at once
Date: Sat, 23 Sep 2006 20:45:01 +0200
Organization: At home
Message-ID: <ef3vb6$69d$1@sea.gmane.org>
References: <20060923164308.16334.49252.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Sep 23 20:45:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRCVL-0008VG-Ts
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 20:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWIWSpV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 14:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWIWSpV
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 14:45:21 -0400
Received: from main.gmane.org ([80.91.229.2]:57817 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751416AbWIWSpU (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 14:45:20 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GRCUw-0008RA-8b
	for git@vger.kernel.org; Sat, 23 Sep 2006 20:45:10 +0200
Received: from host-81-190-26-109.torun.mm.pl ([81.190.26.109])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Sep 2006 20:45:10 +0200
Received: from jnareb by host-81-190-26-109.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Sep 2006 20:45:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-109.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27613>

Petr Baudis wrote:

> This patch enables fetching multiple repositories at once over the Git
> protocol (and SSH, and locally if git-fetch-pack is your cup of coffee
> there). This is done especially for the xorg people who have tons of
> repositories and dislike pulls much slower than they were used to with CVS.
> I'm eager to hear how this affects the situation.
[...]

I see that objects got to the one shared object database. Where the heads
(refs) go to? Separate projects have separate ref spaces, even if they share
object database...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
