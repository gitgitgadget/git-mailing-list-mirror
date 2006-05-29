From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Support for configurable git command aliases
Date: Sun, 28 May 2006 19:01:48 -0700
Message-ID: <7v7j45d1wz.fsf@assigned-by-dhcp.cox.net>
References: <torvalds@osdl.org> <Pine.LNX.4.64.0605262007230.5623@g5.osdl.org>
	<200605271252.k4RCqZhR003192@laptop11.inf.utfsm.cl>
	<20060528215945.GD10488@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 04:01:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkX4s-0005mU-Dc
	for gcvg-git@gmane.org; Mon, 29 May 2006 04:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWE2CBu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 22:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWE2CBu
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 22:01:50 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:7150 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751093AbWE2CBu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 May 2006 22:01:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060529020149.LKPE18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 28 May 2006 22:01:49 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20060528215945.GD10488@pasky.or.cz> (Petr Baudis's message of
	"Sun, 28 May 2006 23:59:45 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20914>

Petr Baudis <pasky@ucw.cz> writes:

>> I don't like this syntax. What other stuff (beside "cmd") would be under
>> "[alias "co"]? Why not simply:
>> 
>>         [alias]
>> 		co = commit -a
>> 		publish = push public.site.com:/pub/scm/my-public-repo
>
> Nice, I like this.

Sorry, I don't.  The left hand side of '=' does not allow
anything but alnum and squashes the case.  Please stick to
[alias "co"] syntax.
