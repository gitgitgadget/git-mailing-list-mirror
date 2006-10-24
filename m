From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Make search type a popup menu
Date: Tue, 24 Oct 2006 09:33:12 +0200
Organization: At home
Message-ID: <ehkfis$6da$1@sea.gmane.org>
References: <20061024031546.2877.51620.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Oct 24 09:33:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcGmb-000490-G1
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 09:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbWJXHdF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 03:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752101AbWJXHdF
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 03:33:05 -0400
Received: from main.gmane.org ([80.91.229.2]:30403 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1752096AbWJXHdD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 03:33:03 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GcGmO-000475-L3
	for git@vger.kernel.org; Tue, 24 Oct 2006 09:32:56 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Oct 2006 09:32:56 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Oct 2006 09:32:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29939>

Petr Baudis wrote:

> This makes the multiple search types actually usable by the user;
> if you don't read the gitweb source, you don't even have an idea
> that you can write things like that there.

This is I think good change, although I'm not sure if I like changing
using search operators to using additional CGI parameter.

Having help page for search is _certainly_ very good change. Perhaps
we should put it out-of-line, not embedded? Just a thought...

This patch changes search box into something similar to Google
"Advanced Search". Yet Google "Advanced Search" box generates search
query using search operators. Search operators are just more powerfull.
I know that gitweb doesn't use this power now (it uses only one operator,
first if I remember correctly), but we can do this in the future
(e.g. searching for both author and specified string in commit message,
or searching for given author OR given committer). Well, we can always
change it back...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
