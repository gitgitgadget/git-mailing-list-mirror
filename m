From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Mercurial to git converter.
Date: Fri, 12 Jan 2007 20:28:37 +0100
Organization: At home
Message-ID: <eo8ngk$ja$1@sea.gmane.org>
References: <1168537766.22649.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Jan 12 20:29:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5S5b-00078U-BB
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 20:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbXALT2o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 14:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbXALT2o
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 14:28:44 -0500
Received: from main.gmane.org ([80.91.229.2]:51529 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964984AbXALT2n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 14:28:43 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H5S4o-0004gJ-6p
	for git@vger.kernel.org; Fri, 12 Jan 2007 20:28:34 +0100
Received: from host-81-190-18-73.torun.mm.pl ([81.190.18.73])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Jan 2007 20:28:34 +0100
Received: from jnareb by host-81-190-18-73.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Jan 2007 20:28:34 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-73.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36695>

Stelian Pop wrote:

> I switched recently from Mercurial to git for some of my projects, and
> needed a conversion tool with branch support (unlike tailor). I didn't
> find any, so I ended up writing my own one. 
> 
> hg-to-git.py can probably be greatly improved (it's a rather crude
> combination of shell and python) but it does already work quite well for
> me. Features:
>       - supports incremental conversion (keep a git repo in sync 
>         with a hg repository)
>       - supports hg branches
>       - converts hg tags 
> 
> Feel free to use it, improve it or even include it in mainline git (like
> git-svn and friends).

Thanks. Added to
  http://git.or.cz/gitwiki/InterfacesFrontendsAndTools#hg-to-git

(Perhaps you should send it as git patch adding file contrib/hg-to-git.py
or contrib/git-hgimport/hg-to-git.py ?)
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
