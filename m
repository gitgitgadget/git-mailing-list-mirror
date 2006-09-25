From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: Add committags support
Date: Mon, 25 Sep 2006 20:06:44 +0200
Organization: At home
Message-ID: <ef95rk$o4q$1@sea.gmane.org>
References: <200609212356.31806.jnareb@gmail.com> <200609231034.49545.jnareb@gmail.com> <20060923121134.GM13132@pasky.or.cz> <200609231533.02455.jnareb@gmail.com> <20060923140535.GK8259@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Sep 25 20:08:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRurr-00056e-V5
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 20:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbWIYSHn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Sep 2006 14:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWIYSHm
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Sep 2006 14:07:42 -0400
Received: from main.gmane.org ([80.91.229.2]:58772 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751430AbWIYSHl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Sep 2006 14:07:41 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GRurS-0004z3-QY
	for git@vger.kernel.org; Mon, 25 Sep 2006 20:07:25 +0200
Received: from host-81-190-26-109.torun.mm.pl ([81.190.26.109])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Sep 2006 20:07:22 +0200
Received: from jnareb by host-81-190-26-109.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Sep 2006 20:07:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-109.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27748>

Petr Baudis wrote:

> Dear diary, on Sat, Sep 23, 2006 at 03:33:01PM CEST, I got a letter
> where Jakub Narebski <jnareb@gmail.com> said that...
>> Petr Baudis wrote:
>> 
>> > Dear diary, on Sat, Sep 23, 2006 at 10:34:49AM CEST, I got a letter
>> > where Jakub Narebski <jnareb@gmail.com> said that...
>> 
>> > Also, there is a fundamental limitation for the multi-word patterns that
>> > they won't work if the line wraps at that point in the log message. This
>> > will likely be a problem especially for the msgids, because those are
>> > very long and are very likely to cause a linewrap immediately before.
>> 
>> We do not wrap log messages in gitweb. So the problem is only when
>> commit message is wrongly wrapped itself (pre imples nowrap).
> 
> The commit message is not "wrongly" wrapped but just wrapped to fit into
> 72 or whatever columns. It would be silly to mandate users to use msg-id: <200609231533.02455.jnareb@gmail.com>
> with the message id stretching far away just for the sake of some
> gitweb limitations when having the message wrapped such as msg-id:
> <200609231533.02455.jnareb@gmail.com> looks much more reasonable.

So when putting message if into commit message, just put the commit
message in separate line, perhaps even with some indentation, like
below:
  Msg-Id: <200609231533.02455.jnareb@gmail.com>

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
