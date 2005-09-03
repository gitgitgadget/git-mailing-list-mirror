From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PROBLEM] Checkout from cloned repository does not work
Date: Sat, 03 Sep 2005 00:31:59 -0700
Message-ID: <7vmzmua9ow.fsf@assigned-by-dhcp.cox.net>
References: <84144f0205090204201f74e425@mail.gmail.com>
	<7vpsrrgwxb.fsf@assigned-by-dhcp.cox.net>
	<1125730179.29087.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 03 09:32:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBSVT-0007ja-CF
	for gcvg-git@gmane.org; Sat, 03 Sep 2005 09:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161183AbVICHcD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Sep 2005 03:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161190AbVICHcB
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Sep 2005 03:32:01 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:2546 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1161180AbVICHcA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Sep 2005 03:32:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050903073200.UGDM20473.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 3 Sep 2005 03:32:00 -0400
To: Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <1125730179.29087.3.camel@localhost> (Pekka Enberg's message of
	"Sat, 03 Sep 2005 09:49:38 +0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8037>

Pekka Enberg <penberg@cs.helsinki.fi> writes:

> I double checked that -- no, it does not print out an error. I copied
> the exact output in the original mail. 

Which ended with the error message "Somebody should define
smarter http server protocol".  That's from git-clone-script and
the echo to generate the output is followed by "exit 1".

>> +[NOTE]
>> +If you plan to publish this repository to be accessed over http,
>> +you should do `chmod +x my-git.git/hooks/post-update` at this
>> +point.
>
> How about "must do chmod before pushing anything to this repository"? I
> think I tried chmod at some point but always did it too late (i.e. after
> the initial push).

I think "at this point" in the flow of tutorial text would be
explicit enough, but I am not very good at writing
documentation, so rewording/clarifying patches are always
welcome.

You could always run git-update-server-info manually after
pushing if you forgot to enable the hook.  If you are paranoid
you could run it with '-f' flag to rebuild the info from
scratch.
