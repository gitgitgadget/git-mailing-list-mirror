From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: cgit vs. gitweb
Date: Mon, 25 Dec 2006 23:19:34 +0100
Organization: At home
Message-ID: <empikd$s32$1@sea.gmane.org>
References: <8c5c35580612250921o765e141cq27f81b06364d0a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Dec 25 23:17:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gyy8E-0000Sm-O6
	for gcvg-git@gmane.org; Mon, 25 Dec 2006 23:17:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754550AbWLYWRB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Dec 2006 17:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754553AbWLYWRB
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Dec 2006 17:17:01 -0500
Received: from main.gmane.org ([80.91.229.2]:34261 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754550AbWLYWRA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Dec 2006 17:17:00 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Gyy7r-0006R8-JU
	for git@vger.kernel.org; Mon, 25 Dec 2006 23:16:55 +0100
Received: from host-81-190-19-121.torun.mm.pl ([81.190.19.121])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Dec 2006 23:16:55 +0100
Received: from jnareb by host-81-190-19-121.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Dec 2006 23:16:55 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-19-121.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35396>

[Cc: git@vger.kernel.org]

Lars Hjemli wrote:

> I wanted to compare cgit against gitweb to see the effect of using
> libgit and internal caching. So I ran the attached scripts against
> http://hjemli.net/git/ and http://hjemli.net/cgi-bin/gitweb.cgi as a
> very simplistic benchmark.

First, could you try this also with mod_perl, not only CGI?

> The scripts forks a number of similar child processes (specified by
> $1) and then uses curl(1) to request the first log page of three
> repositories $2 times. This is an attempt to simulate concurrent
> requests for different pages/repositories (I chose the log-pages since
> they're pretty similar in cgit and gitweb, both showing info for 100
> commits).

Could you include ApacheBench (ab) results?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
