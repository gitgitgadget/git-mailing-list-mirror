From: Junio C Hamano <junkio@cox.net>
Subject: Re: git pull on a branch semantics
Date: Sun, 22 Jan 2006 13:02:53 -0800
Message-ID: <7v7j8sc6wy.fsf@assigned-by-dhcp.cox.net>
References: <20060122205852.255.qmail@web31812.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 22 22:02:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0mMU-00087q-8a
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 22:02:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbWAVVCz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jan 2006 16:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWAVVCz
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jan 2006 16:02:55 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:47754 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751346AbWAVVCz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jan 2006 16:02:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060122210132.IYYO20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 22 Jan 2006 16:01:32 -0500
To: ltuikov@yahoo.com
In-Reply-To: <20060122205852.255.qmail@web31812.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Sun, 22 Jan 2006 12:58:51 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15064>

Luben Tuikov <ltuikov@yahoo.com> writes:

> URL:<url>
> Pull:projectC:projectC
> Push:projectC:projectC
>
> That is both here and remotely I've projectC being a branch
> here and remotely.
>
> I'd like to pull changes to projectC only, from the remote projectC to the local projectC, but my
> current branch is A.
>
> I blissfully do:
>
> git pull projectC

You wanted to "git fetch", not "git pull" which is "fetch
followed by merge into the current branch".
