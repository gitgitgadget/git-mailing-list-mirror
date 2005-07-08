From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [ANNOUNCE] Cogito-0.12
Date: Thu, 07 Jul 2005 20:11:22 -0600
Message-ID: <m11x6akpx1.fsf@ebiederm.dsl.xmission.com>
References: <20050703234629.GF13848@pasky.ji.cz>
	<42CBC822.30701@didntduck.org> <20050707144501.GG19781@pasky.ji.cz>
	<7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507071158220.3293@g5.osdl.org>
	<m1vf3muwxw.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0507071520220.25104@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 04:12:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqiLe-0003id-9n
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 04:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVGHCME (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 22:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbVGHCME
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 22:12:04 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51619 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261393AbVGHCMC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2005 22:12:02 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j682BOU8012781;
	Thu, 7 Jul 2005 20:11:24 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j682BMoC012780;
	Thu, 7 Jul 2005 20:11:22 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507071520220.25104@g5.osdl.org> (Linus
 Torvalds's message of "Thu, 7 Jul 2005 15:23:11 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Thu, 7 Jul 2005, Eric W. Biederman wrote:
>>
>> For optimizing network bandwidth that sounds like the way to go.  For
>> adhoc development I don't know.  For a central sever you still need
>> an authenticated way to push content, which makes it another dimension
>> of the problem.
>
> I'm convinced that "ssh" is the only sane way for pushing. If you don't 
> trust somebody enough to give him ssh access, you shouldn't trust him with 
> write access to your project in the first place.

Agreed, I brought that up only so I could dismiss it :)  

> So I don't worry about pushing. I think we've got that covered. It's 
> really the anonymous pulling that needs something.

So long as we remember there is a tradeoff between efficiency and
ease of setup for anonymous access and small projects.

Eric
