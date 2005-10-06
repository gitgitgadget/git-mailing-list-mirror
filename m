From: Junio C Hamano <junkio@cox.net>
Subject: Re: Allow "-u" flag to tag signing
Date: Thu, 06 Oct 2005 13:17:57 -0700
Message-ID: <7vwtkq8kne.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0510060952410.31407@g5.osdl.org>
	<43455BBC.6020908@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 06 22:22:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENcBw-00076r-A8
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 22:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbVJFUSA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Oct 2005 16:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbVJFUSA
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Oct 2005 16:18:00 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:7595 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751344AbVJFUR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2005 16:17:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051006201752.HCYT9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 6 Oct 2005 16:17:52 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43455BBC.6020908@zytor.com> (H. Peter Anvin's message of "Thu,
	06 Oct 2005 10:15:40 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9783>

"H. Peter Anvin" <hpa@zytor.com> writes:

>> ... It implicitly enables signing, since it doesn't make any
>> sense without it. Thus:
>> 	git tag -u <gpg-key-name> <tag-name> [<tagged-object>]
>> will use the named gpg key for signing.
>
> This is important for another reason as well: a lot of people have 
> multiple keys.

Agreed.  Thanks both.  Will apply.
