From: Junio C Hamano <junkio@cox.net>
Subject: Re: "make test" fails with current HEAD
Date: Thu, 17 Nov 2005 23:30:18 -0800
Message-ID: <7v7jb6o1kl.fsf@assigned-by-dhcp.cox.net>
References: <pan.2005.11.17.15.31.56.755022@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 08:58:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ed0hT-0006ru-NA
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 08:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030363AbVKRHaU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 02:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030394AbVKRHaU
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 02:30:20 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:51435 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1030363AbVKRHaT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 02:30:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051118072924.QOJP17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 18 Nov 2005 02:29:24 -0500
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.11.17.15.31.56.755022@smurf.noris.de> (Matthias
	Urlichs's message of "Thu, 17 Nov 2005 16:31:56 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12209>

Matthias Urlichs <smurf@smurf.noris.de> writes:

> t4103.sh:
>
> fatal: patch with only garbage at line 30
> * FAIL 7: check binary diff with replacement.
>         git-checkout master
>                  git-apply --check --allow-binary-replacement BF.diff
>
> May I suggest to please run "make test" before pushing? Thanks! ;-)

Well, I do, but the thing is, I do not have an access to your
particular machine ;-).

I *think* this is the same problem as I fixed tonight with help
from LASCM and John Benes, and I'm hoping to push the fix out
before going to bed tonight.  If you are impatient the patch has
already been sent out.
