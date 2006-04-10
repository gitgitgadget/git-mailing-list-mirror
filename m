From: Junio C Hamano <junkio@cox.net>
Subject: Re: git commit broken ?
Date: Mon, 10 Apr 2006 01:15:05 -0700
Message-ID: <7vhd51alti.fsf@assigned-by-dhcp.cox.net>
References: <cda58cb80604100102p92e5258qf33a128f75f1b088@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 10 10:15:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSrYI-0005nq-L3
	for gcvg-git@gmane.org; Mon, 10 Apr 2006 10:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWDJIPI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Apr 2006 04:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbWDJIPH
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Apr 2006 04:15:07 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:29867 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751056AbWDJIPG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Apr 2006 04:15:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060410081506.IPWN17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Apr 2006 04:15:06 -0400
To: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
In-Reply-To: <cda58cb80604100102p92e5258qf33a128f75f1b088@mail.gmail.com>
	(Franck Bui-Huu's message of "Mon, 10 Apr 2006 10:02:44 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18585>

"Franck Bui-Huu" <vagabon.xyz@gmail.com> writes:

> It seems that "git commit -a -c ORIG_HEAD" command do not work as
> expected.
>
> 	$ git commit -a -c ORIG_HEAD
> 	$ git status
> 	nothing to commit
>
> So it seems that c has been commmited this time...Is it the expected
> behaviour ?

You said "git commit -a" to tell it to commit all your changes
in your working tree, using "-c ORIG_HEAD" which means "take the
commit log message and authorship information from that commit".

So I do not understand what else, other than both a and c
getting committed (hence subsequent "git status" to report
"nothing to commit'), you are expecting...
