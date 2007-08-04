From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: core.gitproxy and non-git protocols
Date: Sat, 04 Aug 2007 02:33:52 +0200
Organization: At home
Message-ID: <f90hhb$3tg$1@sea.gmane.org>
References: <ee77f5c20708012221j4d75ff0dl8fbf16cdaf1401bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 04 02:34:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH7b7-0006Od-Qs
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 02:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763835AbXHDAeI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 20:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763798AbXHDAeH
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 20:34:07 -0400
Received: from main.gmane.org ([80.91.229.2]:57160 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756948AbXHDAeF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 20:34:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IH7ak-0008Bh-Fu
	for git@vger.kernel.org; Sat, 04 Aug 2007 02:34:02 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 04 Aug 2007 02:34:02 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 04 Aug 2007 02:34:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54779>

[Cc: David Symonds <dsymonds@gmail.com>, gmane.comp.version-control.git]

David Symonds wrote:

> I have a situation where I'd like to push to a remote git repository
> on a machine that is a little weird to access, so I need two different
> types of ssh'ing to reach it depending on my location. That is easily
> scriptable, which is how I did it with SVN (ended up with a
> svn+voltron:// protocol), but is not currently possible with git.

See http://git.or.cz/gitwiki/GitTip, section "How to push/pull via ssh to
host behind gateway?". It describes two solutions: first, using
ProxyCommand option of ssh and netcat utility on gateway, second via ssh
tunnel set up.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
