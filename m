From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-shell.
Date: Sun, 23 Oct 2005 18:36:55 -0700
Message-ID: <7vek6bu24o.fsf@assigned-by-dhcp.cox.net>
References: <435ABB99.5020908@op5.se>
	<7vll0l6pn7.fsf@assigned-by-dhcp.cox.net> <435B5AE0.1060400@op5.se>
	<7v1x2cyplw.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510231427230.10477@g5.osdl.org>
	<7vhdb7vk64.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510231751040.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 03:38:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETrGq-0001o7-Rs
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 03:37:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbVJXBg6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Oct 2005 21:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbVJXBg5
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Oct 2005 21:36:57 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:13469 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750903AbVJXBg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2005 21:36:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051024013628.DHED29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 23 Oct 2005 21:36:28 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10520>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 23 Oct 2005, Junio C Hamano wrote:
>>
>> This adds a very git specific restricted shell, that can be
>> added to /etc/shells and set to the pw_shell in the /etc/passwd
>> file, to give users ability to push into repositories over ssh
>> without giving them full interactive shell acount.
>
> Did you actually test that it works as somebody's login-shell and can be 
> used for pushing?

I made a temporary user on my notebook, set it as his login
shell, and run peek-remote against it (which means the git-shell
spawned upload-pack on the other end).  No, I did not try pushing
when I sent the patch

But I just did, and it seems to work, so this should hit the
master branch soon ;-).
