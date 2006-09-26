From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 01:32:50 +0200
Organization: At home
Message-ID: <efcdaq$hld$1@sea.gmane.org>
References: <20060926232316.98065.qmail@web51009.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Sep 27 01:33:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSMQJ-0002zf-Op
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 01:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbWIZXdI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 19:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbWIZXdI
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 19:33:08 -0400
Received: from main.gmane.org ([80.91.229.2]:64721 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932494AbWIZXdG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Sep 2006 19:33:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GSMQ0-0002v2-5w
	for git@vger.kernel.org; Wed, 27 Sep 2006 01:32:52 +0200
Received: from host-81-190-26-96.torun.mm.pl ([81.190.26.96])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 Sep 2006 01:32:52 +0200
Received: from jnareb by host-81-190-26-96.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 Sep 2006 01:32:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-96.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27837>

Matthew L Foster wrote:

> After seeing how git currently accepts a remote repository's timestamp
> it occurred to me that git should probably instead prefer the time
> a particular changeset was committed to _this_ repository. Perhaps
> I don't know enough about git but it seems to me the important
> information is  when a particular changeset was committed to this
> repository, all other remote/sub/parent repositories' timestamps
> are secondary (or at least should be tracked separately). 

First, the information you want is contained in reflog. Dates the head tip
got the specified value.

Second, git cannot rewrite commits (and commits contain timestamp) when
fetching commit from remote repository for performance reasons.

Third, git uses timestams as heuristics, but relies on parent information.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
