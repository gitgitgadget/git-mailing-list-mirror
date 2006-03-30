From: Junio C Hamano <junkio@cox.net>
Subject: Re: sending git-format-patch files with mailx.
Date: Thu, 30 Mar 2006 01:14:45 -0800
Message-ID: <7vodzo2t16.fsf@assigned-by-dhcp.cox.net>
References: <4dd15d180603291236j4ca4654fvbe5b6375e8623081@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 30 11:14:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOtEx-0006NR-HI
	for gcvg-git@gmane.org; Thu, 30 Mar 2006 11:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWC3JOs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Mar 2006 04:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWC3JOs
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Mar 2006 04:14:48 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:33761 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932125AbWC3JOr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Mar 2006 04:14:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060330091447.RUEC20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 30 Mar 2006 04:14:47 -0500
To: "David Ho" <davidkwho@gmail.com>
In-Reply-To: <4dd15d180603291236j4ca4654fvbe5b6375e8623081@mail.gmail.com>
	(David Ho's message of "Wed, 29 Mar 2006 15:36:17 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18192>

"David Ho" <davidkwho@gmail.com> writes:

> Very stupid question.
>
> I have patches created by git-format-patch.  However I suppose I can
> send it off directly using mailx, but I have a hard time figuring how
> this is done.
>
> Someone here can probably answer this in a second.

Perhaps:

	$ mailx -s 'my subject' upstream@maintainer.example.com
	~r 0001-my-patch.txt

(that's tilde r).

But I thought we had a command for that: git-send-email.  I
admit I haven't used it for anything real, though, since I do
not have an upstream maintainer anymore.
