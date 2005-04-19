From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: [2/4] Sorting commits by date
Date: Mon, 18 Apr 2005 22:36:35 -0400
Message-ID: <42646EB3.8070701@dwheeler.com>
References: <Pine.LNX.4.21.0504182139250.30848-100000@iabervon.org> <Pine.LNX.4.21.0504182152000.30848-100000@iabervon.org> <20050419021338.GX5554@pasky.ji.cz>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 04:30:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNiVg-0005kZ-HB
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 04:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVDSCel (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 22:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVDSCel
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 22:34:41 -0400
Received: from cujo.runbox.com ([193.71.199.138]:15274 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S261202AbVDSCej (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 22:34:39 -0400
Received: from [10.9.9.11] (helo=fifi.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DNiZQ-0000gn-Tt; Tue, 19 Apr 2005 04:34:36 +0200
Received: from [70.17.101.238] (helo=[192.168.2.73])
	by fifi.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DNiZQ-0008MU-IK; Tue, 19 Apr 2005 04:34:36 +0200
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050419021338.GX5554@pasky.ji.cz>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:
> [Re: Daniel Barkalow <barkalow@iabervon.org>'s patch] 
> Note that you are breaking gcc-2.95 compatibility when using declarator
> in the middle of a block. Not that it might be a necessarily bad thing
> ;-) (although I still use gcc-2.95 a lot), just to ring a bell so that
> it doesn't slip through unnoticed and we can decide on a policy
> regarding this.

I, at least, would REALLY like to see _highly_ portable C code;
I'm looking at git as a potential long-term useful SCM tool for
LOTS of projects, and if you're going to write C, it'd be nice
to just write it portably to start with. There's certainly
no crisis in using separate declarators.

In fact, in the LONG term I'd like to see the shell code
replaced with code that easily runs "everywhere" (Windows, etc.),
again, for portability's sake.  I think that would be unwise to
do that right now; the shell is an excellent prototyping tool.
But once things have settled down & there's been some experience
with the tools, the pieces could be slowly recoded.
(Yes, I know of & use Cygwin. And I prefer Python over Perl,
but I'm really uninterested in language wars.)

--- David A. Wheeler
