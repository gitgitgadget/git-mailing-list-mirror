From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitk: Fix nextfile() and more
Date: Mon, 25 Sep 2006 22:24:01 -0700
Message-ID: <7vpsdjryj2.fsf@assigned-by-dhcp.cox.net>
References: <873bag12k3.fsf@duaron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Sep 26 07:24:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GS5QN-0001eV-LR
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 07:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWIZFYE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 01:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWIZFYE
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 01:24:04 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:7837 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751128AbWIZFYC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 01:24:02 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060926052401.JXTY16798.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Tue, 26 Sep 2006 01:24:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id StPz1V0021kojtg0000000
	Tue, 26 Sep 2006 01:23:59 -0400
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
In-Reply-To: <873bag12k3.fsf@duaron.myhome.or.jp> (OGAWA Hirofumi's message of
	"Mon, 25 Sep 2006 22:46:52 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27775>

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:

> The current nextfile() jumps to last hunk, but I think this is not
> intention, probably, it's forgetting to add "break;". Right?  And this
> patch also adds prevfile(), it jumps to previous hunk.
>
> The following part is just my favorite the key-binds, it doesn't matter.
>
> +    bind . <Control-p> "$ctext yview scroll -1 units"
> +    bind . <Control-n> "$ctext yview scroll 1 units"
> +    bind . <Alt-v> "$ctext yview scroll -1 pages"
> +    bind . <Control-v> "$ctext yview scroll 1 pages"
> +    bindkey P prevfile
> +    bindkey N nextfile
>
> What do you think of this?

. As a patch e-mail, the initial Hi and trailing Thanks add
  additional work for the person who applies patch.

. ACK on missing "break" and addition of prevfile for symmetry.

. I do not have preference on the extra bindings.  I do not
  speak for Paul, but I suspect he would have liked them in a
  separate patch.
