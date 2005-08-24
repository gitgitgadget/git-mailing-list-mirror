From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Introduce "reset type" flag to "git reset"
Date: Wed, 24 Aug 2005 11:35:50 -0700
Message-ID: <7vk6ibdvy1.fsf@assigned-by-dhcp.cox.net>
References: <7vu0hhzcj1.fsf@assigned-by-dhcp.cox.net>
	<20050823202637.GA8061@mars.ravnborg.org>
	<7vacj8nw5v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Aug 24 20:36:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E806S-0003CH-Va
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 20:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbVHXSfx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Aug 2005 14:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbVHXSfx
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Aug 2005 14:35:53 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:22980 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751365AbVHXSfw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2005 14:35:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050824183550.CZNZ16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 24 Aug 2005 14:35:50 -0400
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <7vacj8nw5v.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 23 Aug 2005 15:08:44 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7718>

Junio C Hamano <junkio@cox.net> writes:

> Sam Ravnborg <sam@ravnborg.org> writes:
>
>> But --soft, --hard looks rather confusing to me.
>>
>> Something like --force or --prune may be a bit more intuitive, and let
>> default behaviour be the one you name --soft for now.
>
> I do not have objections to removing --mixed, but I do not find
> --force/--prune any less confusing than --soft/--hard.  Its just
> a terminology so once people get used to it anything would do.
> But I agree that we need to come up with a good name for them.
> I do not think --force/--prune is it, though.

Names aside, I have a feeling that "git reset --hard HEAD" is
what "git checkout -f HEAD" should have done.  As it stands, the
latter leaves files not in HEAD but in the previous tree behind.

Comments?
