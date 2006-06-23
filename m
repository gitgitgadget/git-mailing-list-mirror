From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] Introduce Git.pm (v3)
Date: Fri, 23 Jun 2006 06:04:17 -0600
Message-ID: <m1k678yt6m.fsf@ebiederm.dsl.xmission.com>
References: <20060622220201.19132.67536.stgit@machine.or.cz>
	<7vlkrohj9p.fsf@assigned-by-dhcp.cox.net>
	<20060622235017.GH21864@pasky.or.cz>
	<7v1wtghga6.fsf@assigned-by-dhcp.cox.net>
	<20060623011205.GJ21864@pasky.or.cz>
	<7vejxgckq9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 23 14:04:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtkOu-00033u-Nw
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 14:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933084AbWFWMEh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 08:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbWFWMEh
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 08:04:37 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:20942 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S933084AbWFWMEg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 08:04:36 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.6/8.13.6/Debian-1) with ESMTP id k5NC4I34027670;
	Fri, 23 Jun 2006 06:04:18 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.6/8.13.6/Submit) id k5NC4HSJ027669;
	Fri, 23 Jun 2006 06:04:17 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vejxgckq9.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 23 Jun 2006 01:57:50 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22410>

Junio C Hamano <junkio@cox.net> writes:

> Petr Baudis <pasky@suse.cz> writes:
>
>> Also, is there any real problem with just using -fPIC?
>
> Personally, not really, but I consider it a workaround having to
> compile with -fPIC (being able to compile with -fPIC is a
> feature).
>
> Doesn't it have performance implications to use -fPIC when you
> do not have to?
>
> By the way, you also need to adjust the testsuite so that it
> finds the Perl modules from freshly built tree before
> installing.  I think (but haven't checked yet) the stuff written
> in Python does that already, so you might want to mimic it.

So what was being compiled was a shared Git.so.

32bit x86 is on of the few architectures that allows you to build
a .so without compiling with -fPIC.  

The question is why are we building with a .so?

Eric
