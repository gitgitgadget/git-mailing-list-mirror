From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Dropping Git.pm (at least Git.xs)?
Date: Mon, 11 Sep 2006 00:13:01 +0200
Organization: At home
Message-ID: <ee22lb$uia$1@sea.gmane.org>
References: <7vodtxuqt4.fsf@assigned-by-dhcp.cox.net> <20060903150305.G50c94aea@leonov.stosberg.net> <4504529A.70401@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Sep 11 00:13:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMXYd-0007eg-Va
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 00:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWIJWN0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 18:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWIJWN0
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 18:13:26 -0400
Received: from main.gmane.org ([80.91.229.2]:34730 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932136AbWIJWNZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Sep 2006 18:13:25 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GMXYG-0007bF-Oa
	for git@vger.kernel.org; Mon, 11 Sep 2006 00:13:20 +0200
Received: from host-81-190-17-209.torun.mm.pl ([81.190.17.209])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Sep 2006 00:13:20 +0200
Received: from jnareb by host-81-190-17-209.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Sep 2006 00:13:20 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26817>

Sam Vilain wrote:

> Dennis Stosberg wrote:
>> Having perl bindings to git internals and sometime in the future to a
>> libified git is a great thing.  It will allow people to do interesting
>> things, quickly trying concepts without having to write any C code.
>> And I expect that gitweb can be sped up remarkably by using Git.pm (no
>> forking, parsing of command output often not necessary, easy caching of
>> frequently cached data across calls, etc)
> 
> FWIW, I have been starting on a perl implementation.  It uses the
> Git.pm, but not for anything *that* important.  It's still very young,
> but once I have reading and writing files basically working, I'll
> release it to CPAN separately - no reason it needs to be distributed
> with Git itself.
> 
> See http://utsl.gen.nz/gitweb/?p=VCS-Git

Could you please put appropriate information on GitWiki
  http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
Perhaps it would be good time to start new section, Git Implementations,
and put egit (Java GIT library and Eclipse plugin) there too.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
