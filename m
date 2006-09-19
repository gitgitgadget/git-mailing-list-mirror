From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Support for custom per-project owner string
Date: Wed, 20 Sep 2006 01:04:50 +0200
Organization: At home
Message-ID: <eept0r$5d0$1@sea.gmane.org>
References: <20060919225522.GB13132@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Sep 20 01:05:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPody-0005o4-9T
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 01:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971AbWISXEm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 19:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752098AbWISXEm
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 19:04:42 -0400
Received: from main.gmane.org ([80.91.229.2]:50891 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751971AbWISXEl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Sep 2006 19:04:41 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GPodV-0005gD-9a
	for git@vger.kernel.org; Wed, 20 Sep 2006 01:04:18 +0200
Received: from host-81-190-31-133.torun.mm.pl ([81.190.31.133])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Sep 2006 01:04:17 +0200
Received: from jnareb by host-81-190-31-133.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Sep 2006 01:04:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-133.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27311>

Petr Baudis wrote:

> This adds very simple support for per-project setting of the owner string
> (in an environment where the actual owners won't have access to the
> repositories accessed by gitweb, so faking identity is not an issue).

Is it really needed? If $projects_list is a _file_, you can set correct
ownership information there.

Now $projects_list being a directory (usually $projectroot) support
hierarchy of repositories; generating appropriate projects' index file
is as easy as unsetting $projects_list (so it is by default set to
$projectroot), going to summary view, clicking [TXT] link on the left of
[OPML] link at the bottom, copy the result to projects' index file, correct
ownership information (and perhaps remove some projects), and set
$projects_list to this file.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
