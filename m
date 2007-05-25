From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: just fetching HEAD of repository
Date: Fri, 25 May 2007 12:56:44 +0200
Organization: At home
Message-ID: <f36f3t$teg$1@sea.gmane.org>
References: <566574ef0705210201wc5c0adbmaa22d197b16bf72d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 25 12:52:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrXOm-000385-Gs
	for gcvg-git@gmane.org; Fri, 25 May 2007 12:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbXEYKvw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 06:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbXEYKvw
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 06:51:52 -0400
Received: from main.gmane.org ([80.91.229.2]:34116 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751009AbXEYKvv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 06:51:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HrXOf-0002Al-E9
	for git@vger.kernel.org; Fri, 25 May 2007 12:51:49 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 May 2007 12:51:49 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 May 2007 12:51:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48356>

Stian Haklev wrote:

> After checking all the docs, I am still wondering if there is a way to
> get only the last commit from a given git repository. Sometimes I
> really just want the latest code so I can compile it - and let's say
> they are not running gitweb, or it is not convenient to go to gitweb
> and ask for a tar package to be made? This is especially relevant in
> countries with slow internet connection - here in Indonesia it takes
> me an hour to clone the git repository for example, never mind let's
> say the Linux kernel.

Depending on what you want, try either:

  $ git clone --depth=1 <repository URL>

or

  $ git archive --remote=<repository URL> HEAD

(if the remote side supports it)
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
