From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's in git.git
Date: Fri, 04 Aug 2006 12:27:41 +0200
Organization: At home
Message-ID: <eav7do$p84$1@sea.gmane.org>
References: <7v7j1on71n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Aug 04 12:27:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8wu3-0000z4-MJ
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 12:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161144AbWHDK1e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 06:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161142AbWHDK1e
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 06:27:34 -0400
Received: from main.gmane.org ([80.91.229.2]:31932 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161144AbWHDK1d (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 06:27:33 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G8wtg-0000ug-L4
	for git@vger.kernel.org; Fri, 04 Aug 2006 12:27:16 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 12:27:16 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 12:27:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24784>

Junio C Hamano wrote:

>   - Not-universally-liked Git.pm by Pasky with help from Dennis
>     Stosberg, Johannes Schindelin, Pavel Roskin and others.
>     One drawback is this pretty much makes Perl scripts that use
>     Git.pm unusable with ActiveState right now.

It would be nice if when compiling with NO_GIT_XS (or equivalent) defined,
Git.pm used pure Perl implementation. It would be even better if we could
avoid unnecessary code repetition.

I think it would solve (read: paper on the problem) ActiveState problem...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
