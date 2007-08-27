From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb and remote branches
Date: Tue, 28 Aug 2007 01:29:25 +0200
Organization: At home
Message-ID: <favmoh$aqr$2@sea.gmane.org>
References: <favitd$3ff$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 29 16:13:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPo1d-0001eK-1A
	for gcvg-git@gmane.org; Tue, 28 Aug 2007 01:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319AbXH0X3e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 19:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753274AbXH0X3e
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 19:29:34 -0400
Received: from main.gmane.org ([80.91.229.2]:35995 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850AbXH0X3d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 19:29:33 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IPo1O-0002lj-Ns
	for git@vger.kernel.org; Tue, 28 Aug 2007 01:29:26 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Aug 2007 01:29:26 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Aug 2007 01:29:26 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56900>

[Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org]

Giuseppe Bilotta wrote:

> Currently, remote branch heads are only shown in the
> shortlog, but I would like them to appear in the heads list,
> together with the local branches. Is there some option for it?
> I've browsed the gitweb source but I haven't found anything
> that looked like it.

It is on my [long] TODO list for gitweb. But thanks for reminding
it.

Quick and dirty hack would be to change git for 'heads' view to accept
'-a' (all branches) extra option...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
