From: Junio C Hamano <junkio@cox.net>
Subject: Re: quick bare clones taking longer?
Date: Thu, 10 May 2007 16:22:07 -0700
Message-ID: <7v3b24i7s0.fsf@assigned-by-dhcp.cox.net>
References: <7virb1sm6h.fsf@assigned-by-dhcp.cox.net>
	<20070509.150256.59469756.davem@davemloft.net>
	<7v3b25siwk.fsf@assigned-by-dhcp.cox.net>
	<20070509.162301.48802460.davem@davemloft.net>
	<7vy7jxr35a.fsf@assigned-by-dhcp.cox.net>
	<7vd519r10c.fsf@assigned-by-dhcp.cox.net>
	<vpqtzul3xzm.fsf@bauges.imag.fr> <4642DE52.F9F0A5B2@eudaptics.com>
	<loom.20070510T224750-851@post.gmane.org>
	<7vbqgsibrr.fsf@assigned-by-dhcp.cox.net>
	<91705d080705101508y26eabb37oaf90aa4d9a7e239a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Dan Nicholson" <dbn.lists@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 11 01:22:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmHxd-0001K2-Fn
	for gcvg-git@gmane.org; Fri, 11 May 2007 01:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754294AbXEJXWK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 19:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755656AbXEJXWK
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 19:22:10 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:34141 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754294AbXEJXWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 19:22:09 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070510232209.BQCM13903.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Thu, 10 May 2007 19:22:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xbN71W00k1kojtg0000000; Thu, 10 May 2007 19:22:08 -0400
In-Reply-To: <91705d080705101508y26eabb37oaf90aa4d9a7e239a@mail.gmail.com>
	(Dan Nicholson's message of "Thu, 10 May 2007 15:08:01 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46918>

"Dan Nicholson" <dbn.lists@gmail.com> writes:

> On 5/10/07, Junio C Hamano <junkio@cox.net> wrote:
> ...
>> We reject something whose portability is in question by saying
>> "It's not _even in_ POSIX".  We on the other hand try to refrain
>> from saying "POSIX says you are supposed to have it, so screw
>> people that are not fully POSIX".
>
> Yes, I suppose. At the same time, git already implicitly requires more
> than, say, a Bourne shell.

Yes, and the line is fuzzy and case by case.  I am playing it
safe as we are in pre-release freeze, also I condider /bin/pwd
much more universally available than "cd -P".
