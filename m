From: Junio C Hamano <junkio@cox.net>
Subject: Re: git diff: support "-U" and "--unified" options properly
Date: Sun, 14 May 2006 18:51:28 -0700
Message-ID: <7v4pzsys0v.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605131317200.3866@g5.osdl.org>
	<7vzmhlsksm.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605131404391.3866@g5.osdl.org>
	<7vpsihsjq6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605131518390.3866@g5.osdl.org>
	<7vbqu0yvda.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605141745410.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 03:51:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfSFT-0004l8-7I
	for gcvg-git@gmane.org; Mon, 15 May 2006 03:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWEOBvd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 21:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWEOBvd
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 21:51:33 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:41205 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751373AbWEOBva (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 May 2006 21:51:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060515015129.WKOJ9215.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 14 May 2006 21:51:29 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605141745410.3866@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 14 May 2006 17:58:39 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20005>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 14 May 2006, Junio C Hamano wrote:
>> 
>> I am not either after seeing your numbers and trying them
>> myself.  I was going to look at it myself over the weekend, but
>> I ended up spending most of the time migrating my environment,
>> so no progress on that front yet.  Sorry.
>
> I was looking at it, and I just suspect that "grep" is very optimized.
>
> At the same time, the built-in one had many good features, notably that 
> you could grep the cached copy and from a specific version. So I think it 
> makes sense.
> 
> ... Except for testing, and fixing my stupid bugs, which 
> I'm too lazy to do.

The command line flags needs to be
unparsed before feeding the external grep.

> The whole "exec_grep()" should basically be the same as "spawn_prog()". 
> You get the idea.
>
> Anybody?

I think somebody wanted to have his own funky grep spawned off
from his PATH, so I'd leave that to him (or her I do not
remember which) ;-).
